from io import TextIOWrapper
import os
from templates import data
from importlib import import_module
from types import ModuleType
from copy import deepcopy
import pprint


def parse_ship_file(ship_file_path: str) -> dict:
    ship_file: TextIOWrapper = open(ship_file_path)
    ship_data: dict = {}
    file_lines: list[str] = ship_file.readlines()
    ship_var_name: str = "NewShipType"
    functions: list[str] = [
        "setSupplyValue",
        "setTacticsMults",
        "addShield",
        "setSpeedvsAccuracyApplied",
        "setTacticsMults",
        "addAbility",
        "setSpecialDieTime",
        "SpawnSalvageOnDeath",
        "LoadModel",
        "StartShipWeaponConfig",
        "StartShipHardPointConfig",
        "loadLatchPointList",
        "loadShipPatchList",
        "addShaderProp",
        "setShaderChannels",
        "setEngineBurn",
        "setEngineGlow",
        "setEngineTrail",
        "addCustomCode",
    ]

    def store_ship_data(ship_data: dict, code_data: dict, code_type: str) -> dict:
        section: str = data.SECTION_ASSIGNMENT[code_data["name"]]
        print(f"\tStoring {code_type}: {code_data} to section '{section}'")
        section_data = ship_data.get(section)
        if section_data == None:
            print(f"\tCreating new section: '{section}'")
            ship_data[str(section)] = {"variables": {}, "functions": []}
        section_data = ship_data[section]

        if code_type == "function":
            for n, a in enumerate(code_data["args"]):
                code_data["args"][n] = a.strip('"')
            section_data["functions"].append(code_data)
        if code_type == "variable":
            code_data["value"] = code_data["value"].strip("\t")
            section_data["variables"][code_data["name"]] = code_data["value"]
        return ship_data

    variable = {}
    function = {"name": "", "args": []}

    # filter out comment lines
    get_more_variable: bool = False
    get_more_function: bool = False
    key_open: bool = False
    for line in file_lines:
        line = line.strip("\n").strip("\t")
        if "--" not in line[:5]:
            print(line)
            if get_more_variable:
                variable["value"] += line
                get_more_variable = False
                print(f"\tObtained variable {variable['name']} data: {variable['value']}")
                store_ship_data(ship_data, variable, "variable")
                variable = {}
                continue
            elif get_more_function:
                parsed_subline = line.strip().strip(",")
                if parsed_subline != ship_var_name:
                    if "{" in parsed_subline and "}" not in parsed_subline:
                        key_open = True
                        function["args"].append(parsed_subline)
                        continue
                    elif key_open and "}" in parsed_subline:
                        function["args"][-1] += parsed_subline
                        key_open = False
                    elif key_open and "}" not in parsed_subline:
                        function["args"][-1] += parsed_subline
                    else:
                        function["args"].append(parsed_subline)
                    if ")" in parsed_subline:
                        get_more_function = False
                        function["args"][-1].strip(")")
                        store_ship_data(ship_data, function, "function")
                        function = {"name": "", "args": []}
                        continue
                else:
                    continue
            else:
                # Variable Check
                if f"{ship_var_name}." == line[: len(ship_var_name) + 1]:
                    # Found a Variable Definition
                    parsed_line: list[str] = line[len(ship_var_name) + 1 :].split("=")
                    variable["name"] = parsed_line[0].strip()
                    print(f"\tObtained variable {variable["name"]}")
                    variable["value"] = parsed_line[1].strip()
                    if len(parsed_line[1]) == 0:
                        print("\tNot enough data on line to store variable, reading next line...")
                        get_more_variable = True
                    else:
                        print(f"\tObtained variable {variable['name']} value: {variable['value']}")
                        store_ship_data(ship_data, variable, "variable")
                        variable = {}
                # Function check
                elif line.split("(")[0] in functions:
                    parsed_line: list[str] = line.split("(")
                    function["name"] = parsed_line[0].strip()
                    if len(parsed_line[1]):
                        function["args"] = [
                            a.strip() for a in parsed_line[1].split(",")[1:]
                        ]
                    else:
                        print("\tFound left open function, reading next line...")
                        get_more_function = True
                        continue
                    if ")" not in function["args"][-1]:
                        print("\tFound left open function, reading next line...")
                        get_more_function = True
                        continue
                    else:
                        function["args"][-1] = function["args"][-1].strip(")")
                        store_ship_data(ship_data, function, "function")
                        function = {"name": "", "args": []}
                        continue

    return ship_data


def format_ship_config(ship_config: dict, template_config: dict, non_negotiables: dict):
    """
    This should create a new ship_config dict in accordance to the template, based off an existing config dict
    """
    formatted_config: dict = deepcopy(template_config)

    # Populate the sections with existing data
    for section_name, section_value in formatted_config.items():
        if section_name not in non_negotiables["sections"]:
            ship_config_section: dict | None = ship_config.get(section_name)
            if ship_config_section:
                for variable, data in ship_config_section["variables"].items():
                    if (
                        variable in section_value["variables"].keys()
                        and variable not in non_negotiables["variables"]
                    ):
                        section_value["variables"][variable] = data
                if len(section_value["functions"]) == 0:
                    section_value["functions"] = ship_config_section["functions"]
                else:
                    for ship_function in ship_config_section["functions"]:
                        print(f"Ship Function: {ship_function}")
                        for i, format_function in enumerate(section_value["functions"]):
                            print(f"Format Function: {format_function}")
                            if (
                                ship_function["name"]
                                == format_function["name"]
                                and ship_function["name"] == "addAbility"
                            ):
                                if (
                                    ship_function["args"][0]
                                    == format_function["args"][0]
                                    and ship_function["args"][0]
                                    not in non_negotiables["addAbilityFunction"]
                                ):
                                    section_value["functions"][i] = ship_function
                                    print(f"Resulting Function: {section_value["functions"][i]}")
                            elif (
                                ship_function["name"] == format_function["name"]
                                and ship_function["name"]
                                not in non_negotiables["functions"]
                            ):
                                section_value["functions"][i] = ship_function
                                print(f"Resulting Function: {section_value["functions"][i]}")

    return formatted_config


def get_dict_variable(var_name: str, module: ModuleType) -> dict:
    try:
        variable: dict = getattr(module, var_name)
        return variable
    except ImportError:
        raise Exception(
            f"get_dict_variable Error: Module '{module.__str__()}_data' not found."
        )
    except AttributeError:
        raise Exception(
            f"get_dict_variable Error: Variable '{var_name}' not found in module '{module.__str__()}'."
        )


def format_parsed_ship_data(parsed_ship_data: dict, ship_type: str) -> dict:
    try:
        ship_type_template = import_module(f"templates.{ship_type}_data")
        template_config: dict = get_dict_variable("TEMPLATE", ship_type_template)
        non_negotiables: dict = get_dict_variable("NON_NEGOTIABLES", ship_type_template)
        ship_config: dict = format_ship_config(
            parsed_ship_data, template_config, non_negotiables
        )
        return ship_config
    except ModuleNotFoundError as e:
        raise Exception("format_parsed_ship_data Error: Template or Config not found!")


def get_ship_config(
    ship_name: str,
    ship_type: str,
) -> dict:
    try:
        ship_type_configs = import_module(f"templates.{ship_type}_configs")
        existing_config: dict = get_dict_variable(ship_name, ship_type_configs)
        return existing_config
    except ModuleNotFoundError as e:
        raise Exception("get_ship_config Error: Template or Config not found!")


def save_ship_config(
    ship_config: dict,
    ship_name: str,
    ship_type: str,
    config_dir: str,
    overwrite: bool = False,
):
    """
    Save Created Ship Config File
    """
    out_file = open(
        os.path.join(config_dir, ship_type + "_configs.py"), "w" if overwrite else "a"
    )
    out_file.write(f"{ship_name.upper()} = {ship_config}\n")
    out_file.close()


def load_ship_config(ship_name: str, ship_type: str) -> dict:
    try:
        ship_config_module = import_module(f"ship_configs.{ship_type}_configs")
        ship_config = get_dict_variable(ship_name.upper(), ship_config_module)
        return ship_config
    except ModuleNotFoundError as e:
        raise Exception("load_ship_config Error: Config not found!")


def save_ship_type_template(ship_config: dict, ship_type: str, template_dir: str):
    """
    Save Created Ship Config File
    """
    NON_NEGOTIABLES = {
        "sections": [],
        "variables": [],
        "functions": [],
        "addAbilityFunction": [],
    }
    out_file = open(os.path.join(template_dir, ship_type + "_data.py"), "w")
    out_file.write(f"NON_NEGOTIABLES = {NON_NEGOTIABLES}\n\n")
    out_file.write(f"TEMPLATE = {ship_config}\n")
    out_file.close()


def create_ship_file(ship_config: dict, output_dir: str):
    ship_file: TextIOWrapper = open(output_dir, "w")
    ship_variable: str = "NewShipType"

    ship_file.write(f"{ship_variable} = StartShipConfig()\n\n")

    def fix_value(value: str):
        output = value.strip('"')
        if output.isnumeric() or "{" in output:
            return output
        try:
            float(output)
            return output
        except ValueError:
            if (
                "getShipNum" in output
                or "getShipStr" in output
                or len(output.split("*")) > 1
            ):
                return output
            else:
                return f"'{output}'"

    for section in ship_config.keys():
        section_title: list[str] = [
            "--------------------------------------------------\n",
            f"--- {section}\n",
            "--------------------------------------------------\n\n",
        ]
        ship_file.writelines(section_title)
        for name, value in ship_config[section]["variables"].items():
            ship_file.write(f"{ship_variable}.{name} = {fix_value(value)}\n")
        for function in ship_config[section]["functions"]:
            ship_file.write(
                f"{function['name']}({ship_variable}, {', '.join([fix_value(a) for a in function['args']])})\n"
            )
        ship_file.write("\n")

    print(f"File {ship_file.name} created!")


def main() -> None:
    FSFC_DIR = "D:\\SteamLibrary\\steamapps\\common\\Homeworld\\GBXTools\\WorkshopTool\\uncompressed_bigs\\freespace_remastered\\ship"
    HWRM_DIR = "D:\\SteamLibrary\\steamapps\\common\\Homeworld\\GBXTools\\WorkshopTool\\uncompressed_bigs\\HWRM\\ship"

    TEMPLATE_DIR = "D:\\SteamLibrary\\steamapps\\common\\Homeworld\\GBXTools\\WorkshopTool\\HWRM_FSFC\\resources\\tools\\templates"
    CONFIG_DIR = "D:\\SteamLibrary\\steamapps\\common\\Homeworld\\GBXTools\\WorkshopTool\\HWRM_FSFC\\resources\\tools\\ship_configs"
    OUTPUT_DIR = "D:\\SteamLibrary\\steamapps\\common\\Homeworld\\GBXTools\\WorkshopTool\\HWRM_FSFC\\source\\ship"

    SHIP = "vas_imhotep"
    SHIP_TYPE = "research"

    PROCESSED_SHIPS: dict = {}

    PROCESSED_SHIPS['recon'] = data.RECON
    PROCESSED_SHIPS['srecon'] = data.STEALTH_RECON
    PROCESSED_SHIPS['sup'] = data.SUP_FIGHTER
    PROCESSED_SHIPS['int'] = data.INT_FIGHTER
    PROCESSED_SHIPS['ass'] = data.ASSAULT_FIGHTER
    PROCESSED_SHIPS['lbomb'] = data.LIGHT_BOMBER
    PROCESSED_SHIPS['mbomb'] = data.MEDIUM_BOMBER
    PROCESSED_SHIPS['hbomb'] = data.HEAVY_BOMBER
    PROCESSED_SHIPS['assbomb'] = data.ASSAULT_BOMBER
    PROCESSED_SHIPS['cruiser'] = data.CRUISER
    PROCESSED_SHIPS['hcruiser'] = data.HEAVY_CRUISER
    PROCESSED_SHIPS['acruiser'] = data.ADVANCED_CRUISER
    PROCESSED_SHIPS['corvette'] = data.CORVETTE
    PROCESSED_SHIPS['destroyer'] = data.DESTROYER
    PROCESSED_SHIPS['sdestroyer'] = data.SUPER_DESTROYER
    PROCESSED_SHIPS['juggernaut'] = data.JUGGERNAUT
    PROCESSED_SHIPS['platform'] = data.PLATFORM
    PROCESSED_SHIPS['probe'] = data.PROBE
    PROCESSED_SHIPS['installation'] = data.INSTALLATION
    PROCESSED_SHIPS['rcontroller'] = data.RESOURCE_CONTROLLER
    PROCESSED_SHIPS['rcollector'] = data.RESOURCE_COLLECTOR
    PROCESSED_SHIPS['deployer'] = data.DEPLOYER
    PROCESSED_SHIPS['repairfrigate'] = data.REPAIR_FRIGATE
    PROCESSED_SHIPS['support'] = data.SUPPORT_SHIP
    PROCESSED_SHIPS['awacs'] = data.AWACS
    PROCESSED_SHIPS['research'] = data.RESEARCH

    def create_template():
        ship_data: dict = parse_ship_file(os.path.join(HWRM_DIR, SHIP, f"{SHIP}.ship"))
        pprint.pprint(ship_data)
        save_ship_type_template(ship_data, SHIP_TYPE, TEMPLATE_DIR)

    def create_config():
        migrated_ship_data = parse_ship_file(
            os.path.join(FSFC_DIR, SHIP, f"{SHIP}.ship")
        )
        # pprint.pprint(migrated_ship_data)
        formatted_ship_config = format_parsed_ship_data(migrated_ship_data, SHIP_TYPE)
        save_ship_config(formatted_ship_config, SHIP, SHIP_TYPE, CONFIG_DIR, False)
        # pprint.pprint(formatted_ship_config)

    def create_ship():
        formatted_ship_config = load_ship_config(SHIP, SHIP_TYPE)
        create_ship_file(
            formatted_ship_config, os.path.join(OUTPUT_DIR, SHIP, f"{SHIP}.ship")
        )
    
    def recreate_ships():
        for k, v in PROCESSED_SHIPS.items():
            for s in v:
                print(f"Recreating {k} {s}")
                formatted_ship_config = load_ship_config(s, k)
                create_ship_file(
                    formatted_ship_config, os.path.join(OUTPUT_DIR, s, f"{s}.ship")
                )

    # create_template()
    # create_config()
    # create_ship()
    recreate_ships()


if __name__ == "__main__":
    main()

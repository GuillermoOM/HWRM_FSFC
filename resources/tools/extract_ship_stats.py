import os
import re

SHIP_DIR = "/run/media/system/Data/SteamLibrary/steamapps/common/Homeworld/HWRM_FSFC/source/ship"
WEAPON_DIR = "/run/media/system/Data/SteamLibrary/steamapps/common/Homeworld/HWRM_FSFC/source/weapon"
SUBSYSTEM_DIR = "/run/media/system/Data/SteamLibrary/steamapps/common/Homeworld/HWRM_FSFC/source/subsystem"
AB_SCRIPT = "/run/media/system/Data/SteamLibrary/steamapps/common/Homeworld/HWRM_FSFC/source/scripts/custom_scripts/afterburner.lua"
UNITCAP_DIR = "/run/media/system/Data/SteamLibrary/steamapps/common/Homeworld/HWRM_FSFC/source/scripts/rules/fs_deathmatch/unitcaps"

def parse_afterburners():
    mults = {}
    if os.path.exists(AB_SCRIPT):
        with open(AB_SCRIPT, 'r') as f:
            content = f.read()
            matches = re.findall(r'AfterburnerTable\[["\']([^"]+)["\']\]\s*=\s*{\s*([\d\.]+)', content)
            for name, mult in matches:
                mults[name.lower()] = float(mult)
    return mults

AB_MULTS = parse_afterburners()

def extract_value(content, key, default="0"):
    pattern = rf'NewShipType\.{key}\s*=\s*(.*)'
    match = re.search(pattern, content)
    if match:
        val = match.group(1).strip().split('--')[0].strip().strip("'").strip('"')
        if "getShipNum" in val:
            parts = val.split(',')
            if len(parts) >= 3: return parts[2].replace(')', '').strip()
        if "getShipStr" in val:
            parts = val.split(',')
            if len(parts) >= 3: return parts[2].replace(')', '').strip().strip("'").strip('"')
        return val
    return default

def extract_supply(content):
    matches = re.findall(r"setSupplyValue\(\s*NewShipType\s*,\s*['\"]([^']+)['\"]\s*,\s*([\d\.]+)", content)
    if matches:
        best_val = "0"
        for fam, val in matches:
            if fam not in ["Fighter", "Corvette", "Frigate", "SmallCapitalShip", "BigCapitalShip", "Mothership", "Resource", "ResourceLarge"]:
                best_val = val
            elif best_val == "0":
                best_val = val
        return best_val
    return "1.0"

def get_weapon_stats(weapon_name):
    actual_dir = None
    if os.path.exists(os.path.join(WEAPON_DIR, weapon_name)): actual_dir = weapon_name
    else:
        for d in os.listdir(WEAPON_DIR):
            if d.lower() == weapon_name.lower(): actual_dir = d; break
    if not actual_dir: return None
    wepn_path = os.path.join(WEAPON_DIR, actual_dir, f"{actual_dir}.wepn")
    if not os.path.exists(wepn_path):
        for f in os.listdir(os.path.join(WEAPON_DIR, actual_dir)):
            if f.endswith(".wepn"): wepn_path = os.path.join(WEAPON_DIR, actual_dir, f); break
    if not os.path.exists(wepn_path): return None
    with open(wepn_path, 'r') as f: content = f.read()
    
    dmg_match = re.search(r'AddWeaponResult\(.*?DamageHealth.*?,.*?,.*?(\d+)', content, re.DOTALL)
    if not dmg_match:
        dmg_match = re.search(r'AddWeaponResult\(.*?DamageHealth.*?,.*?(\d+)', content, re.DOTALL)
    damage = float(dmg_match.group(1)) if dmg_match else 0
    
    start_match = re.search(r'StartWeaponConfig\((.*?)\)', content, re.DOTALL)
    dps, range_val, vel, rof = 0, 0, 0, 0
    if start_match:
        params_str = start_match.group(1)
        params_str = re.sub(r'--.*', '', params_str)
        params = [p.strip().strip("'").strip('"').strip() for p in params_str.split(',')]
        
        fire_mult = 1.0
        dmg_mult = 1.0
        fm_match = re.search(r'setFireMultFactor\(.*?,(.*?)\)', content)
        if fm_match: fire_mult = float(fm_match.group(1).strip())
        dm_match = re.search(r'setDamageMultFactor\(.*?,(.*?)\)', content)
        if dm_match: dmg_mult = float(dm_match.group(1).strip())
        
        # RoF/DPS Logic
        if len(params) > 16:
            try:
                vel, range_val = float(params[5]), float(params[6])
                t_fire_time = float(params[14])
                t_burst_fire = float(params[15])
                t_burst_wait = float(params[16])
                
                if t_burst_fire > 0:
                    shots = max(1, int(t_burst_fire / t_fire_time)) if t_fire_time > 0 else 1
                    cycle = t_burst_fire + t_burst_wait
                    raw_rof = (shots / cycle) * fire_mult
                else:
                    raw_rof = (1.0 / t_fire_time if t_fire_time > 0 else 1.0) * fire_mult
                
                rof = round(raw_rof, 2)
                dps = round(damage * dmg_mult * raw_rof, 2)
            except:
                pass
    
    pen = {"Un": "1", "Lt": "1", "Md": "1", "Hv": "1"}
    for k, short in [("Unarmoured", "Un"), ("LightArmour", "Lt"), ("MediumArmour", "Md"), ("HeavyArmour", "Hv")]:
        match = re.search(rf'{k}\s*=\s*([\d\.]+)', content, re.IGNORECASE)
        if match: pen[short] = match.group(1)
        
    acc_base_match = re.search(r'setAccuracy\(.*?,.*?([\d\.]+)', content, re.DOTALL)
    base_acc = acc_base_match.group(1) if acc_base_match else "1"
    acc_map = {"F": base_acc, "C": base_acc, "Fr": base_acc, "Cap": base_acc}
    for k, short in [("Fighter", "F"), ("Corvette", "C"), ("Frigate", "Fr"), ("BigCapitalShip", "Cap")]:
        match = re.search(rf'{k}\s*=\s*([\d\.]+)', content, re.IGNORECASE)
        if match: acc_map[short] = match.group(1)

    return {"dps": round(dps, 2), "pen": pen, "name": weapon_name, "dmg": damage, "range": range_val, "vel": vel, "rof": rof, "acc": acc_map}

def get_subsystem_weapons(sub_name):
    if not sub_name: return []
    sub_path = os.path.join(SUBSYSTEM_DIR, sub_name, f"{sub_name}.subs")
    if not os.path.exists(sub_path): return []
    with open(sub_path, 'r') as f: content = f.read()
    # Support both single and double quotes
    matches = re.findall(r"StartSubSystemWeaponConfig\(\s*NewSubSystemType\s*,\s*['\"]([^'\"]+)['\"]", content)
    return matches

def parse_unit_caps():
    profiles = {}
    if not os.path.exists(UNITCAP_DIR): return profiles
    for filename in sorted(os.listdir(UNITCAP_DIR)):
        if not filename.endswith(".lua"): continue
        profile_name = filename.replace(".lua", "")
        profile_caps = {}
        with open(os.path.join(UNITCAP_DIR, filename), 'r') as f:
            content = f.read()
            matches = re.findall(r'supplyLimit\(\s*"([^"]+)"\s*,\s*(\d+)\s*\)', content)
            for fam, val in matches: 
                profile_caps[fam] = int(val)
        profiles[profile_name] = profile_caps
    return profiles

def process_ships():
    races = {"ter": [], "shi": [], "vas": []}
    weapons_used = {}
    
    abilities_to_track = [
        "MoveCommand", "CanDock", "ShipHold", "HyperSpaceCommand", "CanAttack", 
        "GuardCommand", "CanBuildShips", "CanBeCaptured", "CanBeRepaired", 
        "CloakAbility", "SpecialAttack", "RepairCommand", "SalvageCommand",
        "DefenseFieldAbility", "HyperspaceInhibitorAbility", "CaptureCommand"
    ]

    for entry in sorted(os.listdir(SHIP_DIR)):
        ship_path = os.path.join(SHIP_DIR, entry)
        if not os.path.isdir(ship_path): continue
        ship_file = os.path.join(ship_path, f"{entry}.ship")
        if not os.path.exists(ship_file): continue
        with open(ship_file, 'r') as f: content = f.read()
        prefix = entry[:3]
        
        weapons_dict = {}
        # Base Weapons - Support both quotes
        matches = re.findall(r"StartShipWeaponConfig\(\s*NewShipType\s*,\s*['\"]([^'\"]+)['\"]", content)
        for m in matches: weapons_dict[m] = weapons_dict.get(m, 0) + 1
        
        # Hardpoint Weapons (Subsystems) - Use DOTALL
        hp_matches = re.findall(r"StartShipHardPointConfig\((.*?)\)", content, re.DOTALL)
        for hp_str in hp_matches:
            hp_str = re.sub(r'--.*', '', hp_str)
            params = [p.strip().strip("'").strip('"') for p in hp_str.split(',')]
            if len(params) >= 7 and params[6]:
                sub_name = params[6]
                sub_weps = get_subsystem_weapons(sub_name)
                for sw in sub_weps:
                    weapons_dict[sw] = weapons_dict.get(sw, 0) + 1
        
        total_dps = 0
        wep_summary = []
        for w, count in weapons_dict.items():
            stats = get_weapon_stats(w)
            if stats: 
                total_dps += stats['dps'] * count
                wep_summary.append(f"{count}x {w.replace('gun_','').replace('ter_','').replace('vas_','').replace('shi_','')}")
                if w.lower() not in weapons_used: weapons_used[w.lower()] = stats
        
        abilities = {}
        b_match = re.search(r"addAbility\(NewShipType,\s*['\"]CanBuildShips['\"]\s*,\s*\d+,\s*['\"]([^'\"]*)['\"]\s*,\s*['\"]([^'\"]*)['\"]", content)
        if b_match: abilities["Build"] = f"Fams: {b_match.group(2)}"
        sh_match = re.search(r"addAbility\(NewShipType,\s*['\"]ShipHold['\"]\s*,\s*\d+,\s*(-?[\d\.]+),\s*(-?[\d\.]+),\s*['\"][^'\"]*['\"],\s*['\"]([^'\"]*)['\"](?:,\s*(-?[\d\.]+))?", content)
        if sh_match:
            abilities["Hangar"] = f"Size:{sh_match.group(2)} / Fams:{sh_match.group(3)}"
            if sh_match.group(4): abilities["Hangar"] += f" / Rep:{sh_match.group(4)}"
        elif "ShipHold" in content: abilities["Hangar"] = "Yes"
        hs_match = re.search(r"addAbility\(NewShipType,\s*['\"]HyperSpaceCommand['\"]\s*,\s*\d+,\s*(-?[\d\.]+),\s*(-?[\d\.]+),\s*(-?[\d\.]+),\s*(-?[\d\.]+),\s*(-?[\d\.]+)", content)
        if hs_match: abilities["Hyperspace"] = f"Min:{hs_match.group(2)} / Fact:{hs_match.group(1)} / Rec:{hs_match.group(4)}s"
        elif "HyperSpaceCommand" in content: abilities["Hyperspace"] = "Yes"
        rep_match = re.search(r"addAbility\(NewShipType,\s*['\"]RepairCommand['\"]\s*,\s*\d+,\s*(-?[\d\.]+),\s*(-?[\d\.]+)", content)
        if rep_match: abilities["Repair"] = f"Rate:{rep_match.group(1)} / Rad:{rep_match.group(2)}"
        elif "RepairCommand" in content: abilities["Repair"] = "Yes"
        harv_match = re.search(r"addAbility\(NewShipType,\s*['\"]Harvest['\"]\s*,\s*\d+,\s*(-?[\d\.]+),\s*(-?[\d\.]+)", content)
        if harv_match: abilities["Harvest"] = f"Rate:{harv_match.group(1)} / Cap:{harv_match.group(2)}"
        if "SalvageCommand" in content: abilities["Salvage"] = "Yes"
        if entry.lower() in AB_MULTS: abilities["Afterburner"] = f"x{AB_MULTS[entry.lower()]}"
        cl_match = re.search(r"addAbility\(NewShipType,\s*['\"]CloakAbility['\"]\s*,\s*\d+,\s*(-?[\d\.]+),\s*(-?[\d\.]+),\s*(-?[\d\.]+),\s*(-?[\d\.]+),\s*(-?[\d\.]+),\s*(-?[\d\.]+),\s*(-?[\d\.]+)", content)
        if cl_match: abilities["Cloak"] = f"Usage:{cl_match.group(4)} / Cost:{cl_match.group(5)} / Regen:{cl_match.group(6)}"
        if "CaptureCommand" in content: abilities["Capture"] = "Yes"
        if "CanBeCaptured" in content: abilities["Capturable"] = "Yes"
        sa_match = re.search(r"addAbility\(NewShipType,\s*['\"]SpecialAttack['\"]\s*,\s*\d+,\s*['\"]([^'\"]+)['\"]", content)
        
        # Track miscellaneous special abilities
        found_misc = []
        for ab in abilities_to_track:
            if ab in content:
                if ab not in ["MoveCommand", "CanDock", "CanAttack", "GuardCommand", "HyperSpaceCommand", "ShipHold", "CanBuildShips", "CanBeCaptured", "CanBeRepaired", "CloakAbility", "SpecialAttack", "RepairCommand", "SalvageCommand", "CaptureCommand"]:
                    found_misc.append(ab.replace("Ability", ""))
        
        spec_val = sa_match.group(1) if sa_match else ""
        if found_misc:
            spec_val = ", ".join([spec_val] + found_misc) if spec_val else ", ".join(found_misc)
        abilities["Special"] = spec_val if spec_val else "No"

        if "sub_research" in content or "Research" in content: abilities["Research"] = "Yes"

        ship_data = {
            "id": entry,
            "name": extract_value(content, "displayedName"),
            "hp": extract_value(content, "maxhealth"),
            "armor": extract_value(content, "ArmourFamily", "Default"),
            "attack_fam": extract_value(content, "AttackFamily", "Default"),
            "cost": extract_value(content, "buildCost"),
            "time": extract_value(content, "buildTime"),
            "dps": round(total_dps, 2),
            "guns": ", ".join(wep_summary) if wep_summary else "None",
            "sensors": f"{extract_value(content, 'prmSensorRange')}/{extract_value(content, 'secSensorRange')}",
            "speed": extract_value(content, 'mainEngineMaxSpeed'),
            "rot": extract_value(content, 'rotationMaxSpeed'),
            "accel": extract_value(content, 'mainEngineAccelTime'),
            "bank": extract_value(content, 'maxBankingAmount'),
            "fVal": extract_value(content, "fighterValue"), "afVal": extract_value(content, "antiFighterValue"),
            "cVal": extract_value(content, "corvetteValue"), "acVal": extract_value(content, "antiCorvetteValue"),
            "frVal": extract_value(content, "frigateValue"), "afrVal": extract_value(content, "antiFrigateValue"),
            "tVal": extract_value(content, "totalValue"),
            "supply": extract_supply(content),
            "squad": extract_value(content, "SquadronSize", "1"),
            "batch": extract_value(content, "buildBatch", "1"),
            "abilities": abilities
        }
        if prefix in races: races[prefix].append(ship_data)
    return races, weapons_used

def parse_research_costs():
    research_nodes = []
    research_files = [
        "source/scripts/races/terran/scripts/def_research.lua",
        "source/scripts/races/vasudan/scripts/def_research.lua",
        "source/scripts/races/shivan/scripts/def_research.lua"
    ]
    
    root_dir = "/run/media/system/Data/SteamLibrary/steamapps/common/Homeworld/HWRM_FSFC"
    
    for rel_path in research_files:
        abs_path = os.path.join(root_dir, rel_path)
        if not os.path.exists(abs_path): continue
        race = rel_path.split('/')[3]
        with open(abs_path, 'r') as f:
            content = f.read()
            # Split by nodes
            nodes = re.findall(r'{(.*?)}', content, re.DOTALL)
            for node in nodes:
                name_match = re.search(r'Name\s*=\s*["\']([^"\']+)["\']', node)
                cost_match = re.search(r'Cost\s*=\s*(\d+)', node)
                time_match = re.search(r'Time\s*=\s*(\d+)', node)
                req_match = re.search(r'RequiredResearch\s*=\s*["\']([^"\']*)["\']', node)
                
                if name_match and cost_match and time_match:
                    name = name_match.group(1)
                    cost = int(cost_match.group(1))
                    req = req_match.group(1) if req_match else "None"
                    
                    # Determine Tier
                    tier = "T0"
                    if cost >= 15000: tier = "T4"
                    elif cost >= 5000: tier = "T3"
                    elif cost >= 2000: tier = "T2"
                    elif cost >= 1000: tier = "T1"
                    
                    # Determine Era
                    era = "Universal"
                    if "FS1" in req or "FS1" in name: era = "FS1"
                    elif "FS2" in req or "FS2" in name: era = "FS2"

                    research_nodes.append({
                        "race": race.upper(),
                        "name": name,
                        "cost": cost,
                        "time": int(time_match.group(1)),
                        "req": req,
                        "tier": tier,
                        "era": era
                    })
    return research_nodes


def generate_markdown(races, weapons, unit_caps, research):
    output = "# FreeSpace: Fleet Command - Master Balance Sheet\n\n"
    output += "## [HOW TO READ THIS SHEET]\n"
    output += "This document is the **Universal Source of Truth** for mod balancing. It is auto-generated from source files.\n\n"
    output += "## Research Tree Cost Matrix\n"
    output += "| Race | Tier | Era | Node | Cost | Time | Prerequisites |\n"
    output += "| :--- | :--- | :--- | :--- | :--- | :--- | :--- |\n"
    for r in sorted(research, key=lambda x: (x['race'], x['cost'])):
        output += f"| {r['race']} | {r['tier']} | {r['era']} | {r['name']} | {r['cost']} | {r['time']}s | {r['req']} |\n"
    output += "\n---\n\n"

    output += "## Unit Capacity Profiles (Limits)\n"
    output += "Defines the total allowed points/ships per family for each match preset.\n\n"
    profiles = sorted(unit_caps.keys())
    all_fams = set()
    for p in unit_caps.values(): all_fams.update(p.keys())
    sorted_fams = sorted(list(all_fams))
    output += "| Family | " + " | ".join(profiles) + " |\n"
    output += "| :--- | " + " | ".join([":---" for _ in profiles]) + " |\n"
    fs_fams = ["Cruiser", "AdvancedCruiser", "Deimos", "Destroyer", "Hades", "Colossus", "Installation", "Iceni", "Ares", "Erinyes", "ArtemisDH", "AWACS", "Faustus", "Moloch", "Sobek", "Aeolus", "Lucifer", "Sathanas", "Imhotep"]
    other_fams = [f for f in sorted_fams if f not in fs_fams]
    for fam in fs_fams + other_fams:
        if fam not in sorted_fams: continue
        row = f"| **{fam}** |"
        for p in profiles:
            val = unit_caps[p].get(fam, "-")
            row += f" {val} |"
        output += row + "\n"
    output += "\n---\n\n"
    output += "### 1. The Weaponry Matrix\n"
    output += "- **DPS**: Calculated sum of damage over time.\n"
    output += "- **Acc: F/C/Fr/Cp**: Accuracy against **F**ighter, **C**orvette, **Fr**igate, **Cp** (Capital).\n"
    output += "- **Pen: Un/Lt/Md/Hv**: Damage multiplier against **Un**armoured, **Lt** (Light), **Md** (Medium), **Hv** (Heavy) armor families.\n\n"
    output += "### 2. The Detailed Ability Matrix\n"
    output += "- **Build**: Build capability and supported families.\n"
    output += "- **Res**: Research capability (Yes/No).\n"
    output += "- **Hangar**: Hangar capacity and supported weight/families.\n"
    output += "- **H-Space**: Min cost, multiplier factor, and recovery time.\n"
    output += "- **Rep**: HP/s repair rate and radius.\n"
    output += "- **Cap**: Can be captured by other ships (Yes/No).\n"
    output += "- **Special**: Includes Cloak, Harvest, Capture, Afterburners, and other unique abilities.\n\n"
    output += "### 3. The Ship Tables\n"
    output += "- **S/Sq/B**: Supply Cost / Squadron Size / Build Batch Size.\n"
    output += "- **T**: Total Value (AI evaluation rating).\n\n"
    output += "---\n\n"
    output += "## Weaponry Matrix (Accuracy & Penetration)\n"
    output += "| Weapon | Dmg | ROF | DPS | Range | Acc: F/C/Fr/Cp | Pen: Un/Lt/Md/Hv |\n"
    output += "| :--- | :--- | :--- | :--- | :--- | :--- | :--- |\n"
    for w_name in sorted(weapons.keys()):
        w = weapons[w_name]
        acc_str = f"{w['acc']['F']}/{w['acc']['C']}/{w['acc']['Fr']}/{w['acc']['Cap']}"
        pen_str = f"{w['pen']['Un']}/{w['pen']['Lt']}/{w['pen']['Md']}/{w['pen']['Hv']}"
        output += f"| {w['name']} | {w['dmg']} | {w['rof']} | **{w['dps']}** | {w['range']} | {acc_str} | {pen_str} |\n"
    output += "\n---\n\n"
    output += "## Detailed Ability Breakdown (Stats)\n\n"
    output += "| Ship | Build | Res | Hangar | H-Space | Rep | Cap | Special |\n"
    output += "| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |\n"
    all_ships = []
    for code in ["ter", "vas", "shi"]: all_ships.extend(races[code])
    all_ships.sort(key=lambda x: x['name'])
    for s in all_ships:
        a = s['abilities']
        # Consolidate special abilities
        specials = []
        if a.get("Special", "No") != "No": specials.append(a["Special"])
        if a.get("Harvest", "No") != "No": specials.append(f"Harvest({a['Harvest']})")
        if a.get("Cloak", "No") != "No": specials.append(f"Cloak({a['Cloak']})")
        if a.get("Capture", "No") != "No": specials.append("Capturer")
        if a.get("Salvage", "No") != "No": specials.append("Salvage")
        if a.get("Afterburner", "No") != "No": specials.append(f"Afterburner({a['Afterburner']})")
        
        special_str = " / ".join(specials) if specials else "No"
        
        output += "| {0} | {1} | {2} | {3} | {4} | {5} | {6} | {7} |\n".format(
            s['name'], a.get("Build", "No"), a.get("Research", "No"), a.get("Hangar", "No"), a.get("Hyperspace", "No"), a.get("Repair", "No"), a.get("Capturable", "No"), special_str
        )
    output += "\n---\n\n"
    race_names = {"ter": "TERRAN - GTA", "shi": "SHIVAN - Unknown", "vas": "VASUDAN - PVN"}
    for code, name in race_names.items():
        output += f"## [{name}]\n\n"
        output += "| Ship | HP | Armor / Attack Fam | Cost | Time | Guns | DPS | S/Sq/B | F/AF | C/AC | Fr/AFr | T | Spd/Rot/Acc/Bnk |\n"
        output += "| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |\n"
        ships = sorted(races[code], key=lambda x: int(x['cost']) if x['cost'].isdigit() else 0)
        for s in ships:
            fam_str = f"{s['armor']} / {s['attack_fam']}"
            ssb_str = f"{s['supply']}/{s['squad']}/{s['batch']}"
            output += f"| {s['name']} | {s['hp']} | {fam_str} | {s['cost']} | {s['time']}s | {s['guns']} | **{s['dps']}** | {ssb_str} | {s['fVal']}/{s['afVal']} | {s['cVal']}/{s['acVal']} | {s['frVal']}/{s['afrVal']} | {s['tVal']} | {s['speed']}/{s['rot']}/{s['accel']}/{s['bank']} |\n"
        output += "\n"
    return output

if __name__ == "__main__":
    r, w = process_ships()
    uc = parse_unit_caps()
    res = parse_research_costs()
    md = generate_markdown(r, w, uc, res)
    output_path = "/run/media/system/Data/SteamLibrary/steamapps/common/Homeworld/HWRM_FSFC/resources/fsfc-knowledge/fsfc_ship_balance_sheet.md"
    with open(output_path, 'w') as f:
        f.write(md)
    print(f"Master Balance Sheet updated at: {output_path}")


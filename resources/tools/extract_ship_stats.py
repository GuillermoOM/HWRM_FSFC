import os
import re

SHIP_DIR = "/run/media/system/Data/SteamLibrary/steamapps/common/Homeworld/HWRM_FSFC/source/ship"
WEAPON_DIR = "/run/media/system/Data/SteamLibrary/steamapps/common/Homeworld/HWRM_FSFC/source/weapon"

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
        params = [p.strip().strip("'").strip('"').strip() for p in start_match.group(1).split(',')]
        try:
            vel, range_val = float(params[5]), float(params[6])
            # HWRM mapping: waitTime=12, fireTime=13, burstWait=14 (0-indexed)
            t_wait, t_fire = float(params[12]), float(params[13])
            t_burst_wait = float(params[14]) if len(params) > 14 else 0
            if params[2] == "InstantHit":
                dps = (damage * t_fire) / (t_fire + t_wait) if (t_fire + t_wait) > 0 else 0
                rof = round(1.0 / (t_fire + t_wait), 2) if (t_fire + t_wait) > 0 else 0
            else:
                shots = max(1, int(t_fire / t_wait)) if t_wait > 0 else 1
                cycle = t_fire + t_burst_wait
                if cycle <= 0: cycle = t_wait
                dps = (damage * shots) / cycle if cycle > 0 else 0
                rof = round(shots / cycle, 2) if cycle > 0 else 0
        except: pass
    
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

def process_ships():
    races = {"ter": [], "shi": [], "vas": []}
    weapons_used = {}
    for entry in sorted(os.listdir(SHIP_DIR)):
        ship_path = os.path.join(SHIP_DIR, entry)
        if not os.path.isdir(ship_path): continue
        ship_file = os.path.join(ship_path, f"{entry}.ship")
        if not os.path.exists(ship_file): continue
        with open(ship_file, 'r') as f: content = f.read()
        prefix = entry[:3]
        weapons_dict = {}
        matches = re.findall(r"StartShipWeaponConfig\(\s*NewShipType\s*,\s*'([^']+)'", content)
        for m in matches: weapons_dict[m] = weapons_dict.get(m, 0) + 1
        total_dps = 0
        wep_summary = []
        for w, count in weapons_dict.items():
            stats = get_weapon_stats(w)
            if stats: 
                total_dps += stats['dps'] * count
                wep_summary.append(f"{count}x {w.replace('gun_','').replace('ter_','').replace('vas_','').replace('shi_','')}")
                if w.lower() not in weapons_used: weapons_used[w.lower()] = stats
        ship_data = {
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
            "econ": "Cap:{0} / Rate:{1}".format(re.search(r"Harvest',\s*\d+,\s*(\d+),\s*(\d+)", content).group(1), re.search(r"Harvest',\s*\d+,\s*(\d+),\s*(\d+)", content).group(2)) if "Harvest" in content else ("Proc:{0} / Speed:{1}".format(re.search(r"ShipHold',\s*\d+,\s*(\d+),\s*(\d+)", content).group(1), re.search(r"ShipHold',\s*\d+,\s*(\d+),\s*(\d+)", content).group(2)) if "ShipHold" in content else ""),
            "fVal": extract_value(content, "fighterValue"), "afVal": extract_value(content, "antiFighterValue"),
            "cVal": extract_value(content, "corvetteValue"), "acVal": extract_value(content, "antiCorvetteValue"),
            "frVal": extract_value(content, "frigateValue"), "afrVal": extract_value(content, "antiFrigateValue"),
            "tVal": extract_value(content, "totalValue")
        }
        if prefix in races: races[prefix].append(ship_data)
    return races, weapons_used

def generate_markdown(races, weapons):
    output = "# FreeSpace: Fleet Command - Master Balance Sheet\n\n"
    
    output += "## [HOW TO READ THIS SHEET]\n"
    output += "This document is the **Universal Source of Truth** for mod balancing. It is auto-generated from source files.\n\n"
    output += "### 1. The Weaponry Matrix\n"
    output += "- **DPS**: Calculated sum of damage over time. Highlighted in **bold**.\n"
    output += "- **Acc: F/C/Fr/Cp**: Accuracy against **F**ighter, **C**orvette, **Fr**igate, **Cp** (Capital). A value of `0` means the weapon cannot target that class.\n"
    output += "- **Pen: Un/Lt/Md/Hv**: Damage multiplier against **Un**armoured, **Lt** (Light), **Md** (Medium), **Hv** (Heavy) armor families.\n\n"
    output += "### 2. The Ship Tables\n"
    output += "- **Armor / Attack Fam**: The ship's 'Combat Signature'.\n"
    output += "  - **Armor Family** determines damage received (lookup in Weapon Pen column).\n"
    output += "  - **Attack Family** determines chance to be hit (lookup in Weapon Acc column).\n"
    output += "- **F/AF, C/AC, Fr/AFr**: AI Build Values. (e.g., `8/0` means high priority to build, but no anti-fighter capability).\n"
    output += "- **Spd/Rot/Acc/Bnk**: Agility Index. (Max Speed / Rotation / Accel Time / Banking Angle).\n\n"
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
    output += "## Logistics & Economic Statistics\n### [ECONOMIC UNITS]\n\n"
    output += "| Race | Ship | Speed | Econ Stats (Cap/Rate or Proc/Speed) |\n"
    output += "| :--- | :--- | :--- | :--- |\n"
    for code in ["ter", "vas", "shi"]:
        for s in races[code]:
            if s['econ']: output += f"| {code.upper()} | {s['name']} | {s['speed']} | {s['econ']} |\n"
    output += "\n---\n\n"
    race_names = {"ter": "TERRAN - GTA", "shi": "SHIVAN - Unknown", "vas": "VASUDAN - PVN"}
    for code, name in race_names.items():
        output += f"## [{name}]\n\n"
        output += "| Ship | HP | Armor / Attack Fam | Cost | Time | Guns | DPS | F/AF | C/AC | Fr/AFr | T | Sensors | Spd/Rot/Acc/Bnk |\n"
        output += "| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |\n"
        ships = sorted(races[code], key=lambda x: int(x['cost']) if x['cost'].isdigit() else 0)
        for s in ships:
            fam_str = f"{s['armor']} / {s['attack_fam']}"
            output += f"| {s['name']} | {s['hp']} | {fam_str} | {s['cost']} | {s['time']}s | {s['guns']} | **{s['dps']}** | {s['fVal']}/{s['afVal']} | {s['cVal']}/{s['acVal']} | {s['frVal']}/{s['afrVal']} | {s['tVal']} | {s['sensors']} | {s['speed']}/{s['rot']}/{s['accel']}/{s['bank']} |\n"
        output += "\n"
    return output

if __name__ == "__main__":
    r, w = process_ships()
    print(generate_markdown(r, w))

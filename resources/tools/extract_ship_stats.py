import os
import re

SHIP_DIR = "/run/media/system/Data/SteamLibrary/steamapps/common/Homeworld/HWRM_FSFC/source/ship"
WEAPON_DIR = "/run/media/system/Data/SteamLibrary/steamapps/common/Homeworld/HWRM_FSFC/source/weapon"
AB_SCRIPT = "/run/media/system/Data/SteamLibrary/steamapps/common/Homeworld/HWRM_FSFC/source/scripts/custom_scripts/afterburner.lua"

def parse_afterburners():
    mults = {}
    if os.path.exists(AB_SCRIPT):
        with open(AB_SCRIPT, 'r') as f:
            content = f.read()
            matches = re.findall(r'AfterburnerTable\["([^"]+)"\]\s*=\s*{\s*([\d\.]+)', content)
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
        
        # Weapons
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
        
        # Detailed Abilities
        abilities = {}
        
        # CanBuildShips
        b_match = re.search(r"addAbility\(NewShipType,\s*'CanBuildShips',\s*\d+,\s*'([^']*)',\s*'([^']*)'", content)
        if b_match:
            abilities["Build"] = f"Fams: {b_match.group(2)}"
            
        # ShipHold (Hangar)
        # signature: active, dropoffRate, holdSize, rallyEffect, dockFamilies, repairRate
        sh_match = re.search(r"addAbility\(NewShipType,\s*'ShipHold',\s*\d+,\s*(-?[\d\.]+),\s*(-?[\d\.]+),\s*'[^']*',\s*'([^']*)'(?:,\s*(-?[\d\.]+))?", content)
        if sh_match:
            abilities["Hangar"] = f"Size:{sh_match.group(2)} | Fams:{sh_match.group(3)}"
            if sh_match.group(4): abilities["Hangar"] += f" | Rep:{sh_match.group(4)}"
        elif "ShipHold" in content:
            abilities["Hangar"] = "Yes"
            
        # Hyperspace
        # signature: active, costFactor, costMin, costMax, recoveryTime, transitTime
        hs_match = re.search(r"addAbility\(NewShipType,\s*'HyperSpaceCommand',\s*\d+,\s*(-?[\d\.]+),\s*(-?[\d\.]+),\s*(-?[\d\.]+),\s*(-?[\d\.]+),\s*(-?[\d\.]+)", content)
        if hs_match:
            abilities["Hyperspace"] = f"Min:{hs_match.group(2)} | Fact:{hs_match.group(1)} | Rec:{hs_match.group(4)}s"
        elif "HyperSpaceCommand" in content:
            abilities["Hyperspace"] = "Yes"
            
        # Repair
        # signature: active, repairRate, radius
        rep_match = re.search(r"addAbility\(NewShipType,\s*'RepairCommand',\s*\d+,\s*(-?[\d\.]+),\s*(-?[\d\.]+)", content)
        if rep_match:
            abilities["Repair"] = f"Rate:{rep_match.group(1)} | Rad:{rep_match.group(2)}"
        elif "RepairCommand" in content:
            abilities["Repair"] = "Yes"
            
        # Harvest
        harv_match = re.search(r"addAbility\(NewShipType,\s*'Harvest',\s*\d+,\s*(-?[\d\.]+),\s*(-?[\d\.]+)", content)
        if harv_match:
            abilities["Harvest"] = f"Rate:{harv_match.group(1)} | Cap:{harv_match.group(2)}"
            
        # Salvage
        if "SalvageCommand" in content: abilities["Salvage"] = "Yes"
        
        # Afterburners
        if entry.lower() in AB_MULTS:
            abilities["Afterburner"] = f"x{AB_MULTS[entry.lower()]}"
        
        # Cloak
        cl_match = re.search(r"addAbility\(NewShipType,\s*'CloakAbility',\s*\d+,\s*(-?[\d\.]+),\s*(-?[\d\.]+),\s*(-?[\d\.]+),\s*(-?[\d\.]+),\s*(-?[\d\.]+),\s*(-?[\d\.]+),\s*(-?[\d\.]+)", content)
        if cl_match:
            abilities["Cloak"] = f"Usage:{cl_match.group(4)} | Cost:{cl_match.group(5)} | Regen:{cl_match.group(6)}"
        
        # Capture
        if "CaptureCommand" in content: abilities["Capture"] = "Yes"
        
        # Special Attack
        sa_match = re.search(r"addAbility\(NewShipType,\s*'SpecialAttack',\s*\d+,\s*'([^']+)'", content)
        if sa_match: abilities["Special"] = sa_match.group(1)
        
        # Research Injection
        if "sub_research" in content or "Research" in content:
            abilities["Research"] = "Yes"

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
            "abilities": abilities
        }
        if prefix in races: races[prefix].append(ship_data)
    return races, weapons_used

def generate_markdown(races, weapons):
    output = "# FreeSpace: Fleet Command - Master Balance Sheet\n\n"
    output += "## [HOW TO READ THIS SHEET]\n"
    output += "This document is the **Universal Source of Truth** for mod balancing. It is auto-generated from source files.\n\n"
    output += "### 1. The Weaponry Matrix\n"
    output += "- **DPS**: Calculated sum of damage over time.\n"
    output += "- **Acc: F/C/Fr/Cp**: Accuracy against **F**ighter, **C**orvette, **Fr**igate, **Cp** (Capital).\n"
    output += "- **Pen: Un/Lt/Md/Hv**: Damage multiplier against **Un**armoured, **Lt** (Light), **Md** (Medium), **Hv** (Heavy) armor families.\n\n"
    output += "### 2. The Detailed Ability Matrix (New)\n"
    output += "- **Hangar**: Hangar capacity and supported weight/families.\n"
    output += "- **Hyperspace**: Min cost, multiplier factor, and recovery time.\n"
    output += "- **Repair**: HP/s repair rate and radius.\n"
    output += "- **Harvest/Cloak**: Detailed capacity/rates for specialized systems.\n\n"
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
    
    # Detailed Fleet Ability Matrix
    output += "## Detailed Ability Breakdown (Stats)\n\n"
    output += "| Ship | Build | Hangar | Hyperspace | Repair | Harvest | Cloak | Special |\n"
    output += "| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |\n"
    all_ships = []
    for code in ["ter", "vas", "shi"]: all_ships.extend(races[code])
    all_ships.sort(key=lambda x: x['name'])
    for s in all_ships:
        a = s['abilities']
        output += "| {0} | {1} | {2} | {3} | {4} | {5} | {6} | {7} |\n".format(
            s['name'],
            a.get("Build", "No"),
            a.get("Hangar", "No"),
            a.get("Hyperspace", "No"),
            a.get("Repair", "No"),
            a.get("Harvest", "No"),
            a.get("Cloak", "No"),
            a.get("Special", "No")
        )
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

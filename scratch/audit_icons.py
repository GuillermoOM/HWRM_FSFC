#!/usr/bin/env python3
"""
audit_icons.py
Compares all ship and subsystem names in the FSFC source tree against the
entries defined in shipicons.lua. Reports which are missing icon registrations.

Handles two icon definition styles:
  1. Full table:  Vas_hatshepsut = { LargeIcon = { ... } }
  2. Alias:       Shi_cain_fs1 = Shi_Cain

Usage: python3 scratch/audit_icons.py
"""

import os
import re

SOURCE = "/run/media/system/Data/SteamLibrary/steamapps/common/Homeworld/HWRM_FSFC/source"
ICONS_LUA = os.path.join(SOURCE, "ship/icons/shipicons.lua")
SHIP_DIR   = os.path.join(SOURCE, "ship")
SUBS_DIR   = os.path.join(SOURCE, "subsystem")

# ---------------------------------------------------------------------------
# 1. Parse all icon keys from shipicons.lua
#    Matches BOTH:
#      Vas_hatshepsut = {          (full table definition)
#      Shi_cain_fs1 = Shi_Cain    (alias to another key)
# ---------------------------------------------------------------------------
re_icon_full  = re.compile(r"^([A-Za-z][A-Za-z0-9_]+)\s*=\s*\{")
re_icon_alias = re.compile(r"^([A-Za-z][A-Za-z0-9_]+)\s*=\s*([A-Za-z][A-Za-z0-9_]+)\s*$")
defined_icons = set()

with open(ICONS_LUA, encoding="utf-8", errors="ignore") as f:
    for line in f:
        stripped = line.strip()
        if stripped.startswith("--"):
            continue
        m = re_icon_full.match(stripped) or re_icon_alias.match(stripped)
        if m:
            defined_icons.add(m.group(1).lower())

# ---------------------------------------------------------------------------
# 2. Collect all ship names (each subdir of source/ship/ with matching .ship)
# ---------------------------------------------------------------------------
ships = set()
if os.path.isdir(SHIP_DIR):
    for entry in os.scandir(SHIP_DIR):
        if entry.is_dir() and entry.name != "icons":
            ship_file = os.path.join(entry.path, entry.name + ".ship")
            if os.path.isfile(ship_file):
                ships.add(entry.name.lower())

# ---------------------------------------------------------------------------
# 3. Collect all subsystem names (each subdir of source/subsystem/ with .subs)
# ---------------------------------------------------------------------------
subs = set()
if os.path.isdir(SUBS_DIR):
    for entry in os.scandir(SUBS_DIR):
        if entry.is_dir():
            subs_file = os.path.join(entry.path, entry.name + ".subs")
            if os.path.isfile(subs_file):
                subs.add(entry.name.lower())

# ---------------------------------------------------------------------------
# 4. Check for missing entries
# ---------------------------------------------------------------------------
missing_ships = sorted(s for s in ships if s not in defined_icons)
missing_subs  = sorted(s for s in subs  if s not in defined_icons)

# Bonus: icon keys that don't match any known ship/sub (orphaned - expected for vanilla)
all_known = ships | subs
orphaned_fsfc = sorted(
    k for k in defined_icons
    if k not in all_known
    and any(k.startswith(p) for p in ("ter_", "vas_", "shi_", "sub_"))
)

# ---------------------------------------------------------------------------
# 5. Report
# ---------------------------------------------------------------------------
print("=" * 60)
print("  FSFC Icon Audit Report")
print("=" * 60)
print(f"\n[Ships]  Defined in source/ship/: {len(ships)}")
print(f"[Subs]   Defined in source/subsystem/: {len(subs)}")
print(f"[Icons]  Keys in shipicons.lua (FSFC+vanilla): {len(defined_icons)}")

if missing_ships:
    print(f"\n❌ MISSING SHIP ICONS ({len(missing_ships)}):")
    for s in missing_ships:
        print(f"   {s}")
else:
    print("\n✅ All ships have icon entries.")

if missing_subs:
    print(f"\n❌ MISSING SUBSYSTEM ICONS ({len(missing_subs)}):")
    for s in missing_subs:
        print(f"   {s}")
else:
    print("\n✅ All subsystems have icon entries.")

if orphaned_fsfc:
    print(f"\n⚠️  FSFC ORPHANED ENTRIES ({len(orphaned_fsfc)}) — icon defined but no source dir:")
    for o in orphaned_fsfc:
        print(f"   {o}")

print("\n" + "=" * 60)

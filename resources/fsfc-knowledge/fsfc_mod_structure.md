# HWRM_FSFC: Mod Structure & Naming Conventions

This is a total conversion mod bringing the FreeSpace universe to Homeworld Remastered.

## 1. Naming Conventions

All assets created for this mod MUST adhere to the strict prefixing schema to prevent clashes with vanilla assets or other race assets:

### Races & Ship Prefixes

| Race                  | Prefix  | Description                                                              |
| --------------------- | ------- | ------------------------------------------------------------------------ |
| **Terran (GTA/GTVA)** | `ter_`  | Standard human ships. Heavily relies on sequential tech upgrades.        |
| **Vasudan (PVE)**     | `vas_`  | Alien allies/enemies. Ships generally feature energy-based loadouts.     |
| **Shivan**            | `shi_`  | Primary antagonists. Ships feature overwhelming firepower and shielding. |

### Component Prefixes

- **Weapons**: `gun_` (kinetic/plasma), `beam_` (capital beams), `miss_` (missiles).
- **Subsystems**: Keep descriptive names relevant to the function, but prefix them with the race (e.g., `ter_c_module_research`).
- **Research**: Prefix with the race (e.g., `TerranFighterDrive`).

## 2. Directory Layout

The mod's source files are strictly organized under the `source/` directory:

```text
source/
├── scripts/
│   ├── races/terran/scripts/
│   │   ├── def_build.lua          (Terran build menu)
│   │   ├── def_research.lua       (Terran research tree)
│   │   ├── ai_upgrades.lua        (Terran AI upgrade logic)
│   │   └── ai_build.lua           (Terran AI build priorities)
│   ├── races/vasudan/scripts/
│   ├── races/shivan/
│   ├── custom_scripts/            (Custom abilities like Afterburners)
│   ├── familylist.lua             (Global FSFC family definitions)
│   └── rules/fs_deathmatch/       (Custom game mode rules)
├── ship/                          (Contains .ship and .hod models)
├── weapon/                        (Contains .wepn definitions)
├── subsystem/                     (Contains .subs definitions)
└── missile/                       (Contains .miss definitions)
```

## 3. FreeSpace → Homeworld Class Mapping

FreeSpace and Homeworld use different terminology for ship classes. The HWRM engine requires all ships to be mapped to its built-in class system. This mapping is defined in `source/ai/default/classdef.lua` and drives ALL AI behavior.

| FreeSpace Class | HW Engine Class | Engine Enum | AI Role |
|---|---|---|---|
| **Fighters** (interceptors, space superiority) | Interceptors / Strike Craft | `eFighter` | Fast anti-fighter combat |
| **Bombers** (anti-capital strike craft) | Corvettes | `eCorvette` | Anti-capital strike runs |
| **Cruisers** (mid-tier warships) | Frigates | `eFrigate` | Line combat, fleet backbone |
| **Destroyers** (heavy warships, carriers) | Destroyers / Carriers | `eCapital`, `eDestroyer`, `eBuilder` | Heavy combat, fleet anchors |
| **Super Destroyers / Juggernauts** | Battlecruisers | `eBattleCruiser` | Endgame superweapons |

### Counter-Class Mapping
The AI uses counter-classes to decide what to build against enemy compositions:

| Enemy Has... | AI Builds From... | FS Equivalent |
|---|---|---|
| Fighters (`eFighter`) | `eAntiFighter` ships | Anti-fighter interceptors |
| Bombers (`eCorvette`) | `eAntiCorvette` ships | Anti-bomber fighters/cruisers |
| Cruisers (`eFrigate`) | `eAntiFrigate` ships | Bombers, destroyers |

### Key Implications
- FS Bombers demand uses `ShipDemandMaxByClass(eCorvette)` — not `eFighter`
- FS Cruiser demand uses `ShipDemandMaxByClass(eFrigate)` — not `eCapital`
- All ships in `classdef.lua` counter-classes must include FS ships for the AI to properly counter enemy fleets

## 4. General Rules for FSFC

- **Ship Classes**: If you create a new ship class for FreeSpace (e.g., "Destroyer"), it must be registered in `source/scripts/familylist.lua` before it is used.
- **Paths**: All cross-references must use the `data:` prefix (e.g., `data:scripts/custom_scripts/afterburner.lua`).

## 5. AI Architecture & Scripting

The mod uses a hybrid AI system that combines vanilla engine capabilities with custom overrides for Freespace-specific behavior.

### Custom Engine Overrides (`source/ai/default/`)
- **`cpubuild.lua`**: Overrides the default build logic. It removes the hard requirement for `FIGHTERDRIVE` research and adds a dynamic variable hook (`CpuBuild_UpdateRaceVariables`) that runs every cycle.
- **`cpuresource.lua`**: Overrides resource management. Includes `Util_PickBestShip` logic for era-aware collector fallback (e.g., building an FS1 collector if the FS2 one is restricted).

### Race Build Scripts (`source/scripts/races/[race]/scripts/ai_build.lua`)
- Each race defines `k*FS1` and `k*FS2` counterparts for all major roles.
- The `CpuBuild_UpdateRaceVariables()` function is implemented in each race script to dynamically assign the active `k*` targets based on what `CanBuild()` returns.

### Upgrade Scripts (`source/scripts/races/[race]/scripts/ai_upgrades.lua`)
- **Rule**: Use vanilla `Util_CheckResearch()` directly.
- **Nil Safety**: Always check `if (VARIABLE ~= nil)` before passing it to any engine research function, as the engine's internal `IsResearchDone` will crash on `nil` input.


# HWRM_FSFC: Mod Structure & Naming Conventions

This is a total conversion mod bringing the FreeSpace universe to Homeworld Remastered.

## 1. Naming Conventions

All assets created for this mod MUST adhere to the strict prefixing schema to prevent clashes with vanilla assets or other race assets:

### Races & Ship Prefixes

| Race                  | Prefix  | Description                                                              |
| --------------------- | ------- | ------------------------------------------------------------------------ |
| **Terran (GTA/GTVA)** | `ter_`  | Standard human ships. Heavily relies on sequential tech upgrades.        |
| **Vasudan (PVE)**     | `vas_`  | Alien allies/enemies. Ships generally feature energy-based loadouts.     |
| **Shivan**            | `shiv_` | Primary antagonists. Ships feature overwhelming firepower and shielding. |

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

## 3. General Rules for FSFC

- **Ship Classes**: If you create a new ship class for FreeSpace (e.g., "Destroyer"), it must be registered in `source/scripts/familylist.lua` before it is used.
- **Paths**: All cross-references must use the `data:` prefix (e.g., `data:scripts/custom_scripts/afterburner.lua`).

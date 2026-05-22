# FSFC Modding: Asset Sharing, Stability & Era Configuration

This document summarizes the best practices and architectural patterns established for the **FreeSpace: Fleet Command** mod.

## 1. Asset Sharing & Engine Stability

### `LoadSharedModel` vs `LoadModel`
*   **Core Rule**: When a ship or subsystem variant shares the same HOD mesh as another object (e.g., FS1 variants sharing FS2 meshes), you **MUST** use `LoadSharedModel(NewShipType, "source_folder")`.
*   **Reasoning**: HWRM engine stability is compromised when multiple distinct ship types attempt to load the same HOD file using the standard `LoadModel`. This often leads to memory instability and fatal crashes during unit production or at high unit counts.
*   **Subsystem Usage**: This rule also applies to `.subs` files. Turrets should share models from their base counterparts to save memory and prevent engine-level mesh collisions.

## 2. Integrity & Stability Checklist

### Weapon Definitions
*   **Fatal Exit Prevention**: Missing or misspelled weapon names in `.subs` or `.ship` files (e.g., `gun_shivhuge_turret`) will trigger an immediate **FATAL EXIT** during the engine's loading phase.
*   **Validation**: Always verify weapon names against the `weapon/` directory before assignment.

### Custom Script Safety
*   **Nil Checks**: Custom ability scripts (like `afterburner.lua`) that use ship types as keys in a lookup table must implement nil-checks.
*   **Default Behavior**: If a ship type is not found in a table, the script should fall back to a safe default (e.g., multiplier of 1) instead of indexing a nil value and crashing the execution thread.

## 3. Era-Specific Mechanics

### Starting Fleets
*   **Dynamic Suffixes**: Use `SetStartFleetSuffix(suffix)` in `OnInit()` of the game rules (e.g., `fs_deathmatch.lua`) to dynamically switch starting fleet compositions based on lobby settings (e.g., `fs1` vs `fs2`).
*   **Variant Selection**: Ensure `startingfleet_<suffix>.lua` files reference the correct era variants (e.g., `ter_orion_fs1` for Great War mode).

### UI Icons
*   **Aliasing**: New variants must be manually registered in `shipicons.lua`. To maintain visual consistency without duplicating texture assets, alias the new ship type to the base ship's existing icon entry.

## 4. Ship-Specific Design Patterns

### Orion Layout Logic
*   **Joint/Model Mapping**: On the Orion, certain joints share specific models:
    *   `Weapon_Laser2` shares the **Huge Turret** HOD.
    *   Non-turret joints (`Weapon_B#`) use **Gimble** or **Slash** HODs.
*   **FS1 Implementation**: When creating FS1 variants for ships like the Orion, create new generic subsystems (e.g., `ter_orion_mediumturret`) that share the FS2 HODs but swap the internal weapons for period-accurate blob weaponry. Avoid using beam-specific names like "slash" or "bgreen" in these generic variants.

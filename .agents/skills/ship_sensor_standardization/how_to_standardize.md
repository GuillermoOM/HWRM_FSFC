# Skill: Ship Sensor Standardization

## Overview
To ensure consistent reconnaissance gameplay and maintain parity with Homeworld Remastered (HWRM) vanilla balance, all FSFC ships must have their sensor ranges synchronized with their HWRM class equivalents.

## 1. Sensor Range Standards
FSFC ships are balanced against HWRM vanilla units based on their tactical role:

| FSFC Role | HWRM Equivalent | Primary Range | Secondary Range |
| :--- | :--- | :--- | :--- |
| **Fighters / Interceptors** | Hiigaran Interceptor | 3000 | 4000 |
| **Bombers** | Hiigaran Corvette | 4000 | 5000 |
| **Scouts** | Hiigaran Scout | 9000 | 11000 |
| **Cruisers / Frigates** | Hiigaran Frigate | 5000 | 6000 |
| **Capitals / Destroyers** | Hiigaran Destroyer | 6500 | 7500 |
| **Super Capitals** | Hiigaran BattleCruiser | 8000 | 10000 |
| **AWACS** | Hiigaran Sensor Array | 12000 | 17000 |
| **Utility / Support** | Hiigaran Resource Unit | 3500 | 4500 |
| **Installations** | Hiigaran Mothership | 10000 | 18000 |

> [!NOTE]
> Some "Elite" or specialized ships (e.g., AWACS, Stealth Fighters) may have ranges that deviate from these standards to reflect their unique tactical utility.

## 2. Configuration in .ship Files
Sensor ranges are defined in the `Sensors` section of the `.ship` file using two variables:

```lua
-- Example: GTF Apollo (Fighter Standard)
NewShipType.prmSensorRange = 3000
NewShipType.secSensorRange = 4000
```

> [!IMPORTANT]
> The order of variables in `.ship` files is critical. Always place sensor range definitions after Construction parameters and before Tactical Overlay settings.

## 3. Auditing and Enforcement
Use the automated extraction tools to verify that all ships adhere to these standards.

1.  **Extract Current Stats**: Run `python3 resources/tools/extract_ship_stats.py`.
2.  **Verify Balance Sheet**: Check the "Sensors" column in `resources/fsfc-knowledge/fsfc_ship_balance_sheet.md`.
3.  **Cross-Reference Vanilla**: Compare against `resources/fsfc-knowledge/hwrm_vanilla_balance_sheet.md` to ensure relative parity is maintained.

## Verification
- **Log Check**: Check `HwRM.log` for any "Property not found" errors related to sensors.
- **Visual Check**: Select a ship in-game and verify its sensor bubble radius on the Sensors Manager (Spacebar).

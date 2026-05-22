# FSFC Unit Capacity Management

This document outlines the unit capacity (supply) system for the Freespace: Fleet Command mod.

## Core Principles

1.  **Strict Freespace Gating**: Custom game modes (`fs1_deathmatch`, `fs2_deathmatch`) enforce Freespace-specific caps to prevent vanilla HWRM ships from interfering with mod balance.
2.  **Hierarchical Supply**: We use the engine's `setSupplyValue` to map ships to multiple categories (e.g., a GTF Loki is both a `Fighter` and a `Scout`).
3.  **Global Synchronization**: All unit cap files (Small, Normal, Large, Huge, and Default) are kept synchronized with identical Freespace-relevant limits to ensure consistent balance across lobby settings.

## Unit Cap Families

| Family Name | Default Limit | Description |
| :--- | :--- | :--- |
| **Fighter** | 135 | Primary strike craft cap. |
| **Bomber** | 135 | Dedicated bomber cap (indented under Fighter). |
| **Scout** | 135 | Stealth/Recon craft cap (indented under Fighter). |
| **Cruiser** | 25 | Standard Freespace cruiser hulls (Fenris, Leviathan). |
| **AdvancedCruiser** | 5 | Heavy cruisers (Aeolus, Deimos). |
| **Destroyer** | 2 | Primary carrier/destroyer hulls (Hecate, Orion). |
| **Utility** | 44 | Support ships (Argo, Poseidon). |
| **Resource** | 26 | Resource gathering ships (Elysium). |

## Implementation Checklist

- [ ] **.ship File**: Check `setSupplyValue` families match entries in `familylist.lua`.
- [ ] **Game Mode Caps**: Verify families are defined in `scripts/rules/[mode]/unitcaps/`.
- [ ] **Race Caps**: Sync definitions to `scripts/races/[race]/deathmatch/unitcaps/`.
- [ ] **UI Visibility**: Use `supplyShow("Family", "Always"|"Never"|"NotEmpty")` to control build menu clutter.
- [ ] **UI Hierarchy**: Use `supplyIndent("Family", 1)` to group sub-classes under primary roles.

## Troubleshooting

- **Ship not buildable (0/0)**: Check if **all** families assigned to the ship in its `.ship` file have a limit > 0 in the unit cap files.
- **Ship counts twice**: Normal behavior for indented families; the ship occupies a slot in both the sub-category and the parent category.
- **Missing Indent**: The ship will appear in a separate category at the bottom of the list.

# Skill: Unit Capacity Configuration

## Goal
Ensure all custom ships in the Freespace mod are buildable by correctly defining their unit capacity (supply) limits across all relevant game mode and race configurations.

## Steps

### 1. Identify All Supply Families
Search the ship's `.ship` file for all `setSupplyValue` calls. A ship can belong to multiple families simultaneously.
```lua
-- Example: GTF Loki
setSupplyValue(NewShipType, 'Fighter', 4.0)
setSupplyValue(NewShipType, 'Scout', 4.0)
```

### 2. Define Limits in Game Mode Rules
Open the `unitcaps/` folder for the active game mode (e.g., `source/scripts/rules/fs1_deathmatch/unitcaps/`).
You MUST update **all five files**: `default.lua`, `small.lua`, `normal.lua`, `large.lua`, and `huge.lua`.

```lua
-- Add limits for all identified families
supplyLimit("Fighter", 135)
supplyLimit("Scout", 135) -- Crucial: Missing families result in 0 capacity
```

### 3. Configure UI Visibility and Hierarchy
- **`supplyShow`**: Control if the family appears in the unit cap menu.
    - `"Always"`: Always visible.
    - `"NotEmpty"`: Visible only if you own ships in this family.
    - `"Never"`: Hidden (useful for internal layout caps or redundant vanilla categories).
- **`supplyIndent`**: Nest sub-families under a parent category.
```lua
supplyShow("Scout", "Never") -- Hidden but still functional
supplyIndent("Bomber", 1)    -- Indents Bomber under Fighter
```

### 4. Sync Race-Specific Caps
Some game modes or engine behaviors may fallback to the race's own unit cap definitions. Ensure the same limits are applied to:
`source/scripts/races/[race_name]/deathmatch/unitcaps/`

### 5. Registering Specific Ship Families
If a ship needs a unique cap (e.g., GTF Erinyes), you must register it as a `unitcapsFamily`.

1.  **Open `source/scripts/familylist.lua`**:
    *   Find the `unitcapsFamily` table.
    *   Add a new entry:
        ```lua
        {
            name = "Erinyes",
            numParam = 11, -- Priority
            stringParam = "GTF Erinyes", -- Display Name
        },
        ```
2.  **Update the `.ship` file**:
    *   Add `setSupplyValue(NewShipType, 'Erinyes', 4.0)`.
3.  **Update `unitcaps/*.lua`**:
    *   Add `supplyLimit("Erinyes", 12)`.

## Pattern: Backbone vs Elite Capacity Split
Large mods often suffer from "Fighter Swarms" where low-tier units consume all unitcap slots, preventing the AI from building heavy support. This pattern uses tiered families to differentiate capacity pools.

### 1. Backbone Units (Mass Produced)
Assign these to general families with high caps.
- **Example**: GTC Fenris (Standard Cruiser)
- **Family**: `Cruiser`
- **Limit**: 25-40 (depending on map size)

### 2. Elite Units (Specialists)
Assign these to specialized sub-families with strict, low caps.
- **Example**: GTCv Deimos (Elite Corvette/Cruiser)
- **Families**: `Cruiser` AND `EliteCruiser`
- **Limit**: 4-6
- **Result**: The AI can build up to 25 cruisers total, but only 4 can be Deimos class.

### Configuration in `unitcaps/*.lua`
```lua
-- Standard Backbone
supplyLimit("Cruiser", 25)

-- Elite Sub-Category (Hard Restricted)
supplyLimit("EliteCruiser", 4)
supplyIndent("EliteCruiser", 1) -- Nest under Cruiser for UI clarity
```

## Critical Rules

- **Total Coverage**: If a ship has 3 family tags, ALL 3 must have a limit > 0 defined in the active `.lua` cap file, or the ship will be locked out (0/0 capacity).
- **Consistency**: Always use the same limits across Small/Normal/Large/Huge files unless a specific balance scaling is desired.
- **Engine Priority**: `unitcaps` are hard limits. If the AI script demands a ship but the `unitcap` is reached, the build order will fail silently in the background.

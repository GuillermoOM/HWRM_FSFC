# AI & Research Scripting

> A guide to integrating custom ships and technologies into the Homeworld Remastered CPU player logic, and constructing research tech trees.

---

## 1. Defining Research Trees (`research.lua`)

Research items in HWRM unlock ships, provide stat buffs, or enable new abilities. The tech tree logic is defined in `Data/Scripts/Building And Research/<RaceName>/research.lua`.

### Creating a Prerequisite Chain
To enforce sequential progression (e.g., unlocking Lasers requires Energy Systems), define the `RequiredResearch` parameter:

```lua
{
    Name = "EnergySystems",
    RequiredResearch = "",
    Cost = 500,
    Time = 30,
    UpgradeType = Ability,
    TargetType = AllShips,
    UpgradeName = "UnlockEnergy",
},
{
    Name = "HeavyLasers",
    RequiredResearch = "EnergySystems", -- Prerequisite!
    Cost = 1000,
    Time = 60,
    TargetType = Family,
    TargetName = "Corvette",
    UpgradeType = Modifier,
    UpgradeName = "WEAPONDAMAGE",
    UpgradeValue = 1.25, -- Grants a 25% damage boost to all Corvettes
}
```

### Complex Prerequisites
You can use logical operators `&` (AND) and `|` (OR) to create complex unlock conditions. Parentheses can also be used for grouping:
```lua
RequiredResearch = "EnergySystems & (BasicLasers | PlasmaTech)"
```

## 2. Integrating with the AI Engine

If you create a new ship or a new research item, the CPU player will not automatically know it exists. You must explicitly tell the AI to prioritize and build it using the CPU scripts located in `Data/Scripts/AI/`.

### The Demand System
The HWRM AI operates on a "Demand" economy. It evaluates its current strategic needs (e.g., "I am under attack by fighters") and increases the numerical demand for ships that counter that threat.

You influence this by editing `classdef.lua` and specific logic scripts like `production.lua` or custom faction scripts.

### Ship Upgrade IDs
The AI engine references ships and research strictly via integer hashes, not strings. The engine automatically generates an `upgrade_ids.lua` map. 

Whenever writing AI logic for your custom unit, use its engine hash constant:
```lua
-- Incorrect:
Build("hgn_superscout")

-- Correct:
Build(HGN_SUPERSCOUT)
```

### Adding AI Ship Demand
To make the AI build your new ship, use `ShipDemandAddByClass` or `ShipDemandAdd`:

```lua
-- In a custom AI update loop:
if (UnderAttackBy("Fighter") > 0) then
    -- We need anti-fighter units!
    ShipDemandAddByClass(eAntiFighter, 50)
    -- Specifically demand our custom ship
    ShipDemandAdd(HGN_SUPERSCOUT, 20)
end
```

### Adding AI Research Demand
To make the AI research your custom technology, use `ResearchDemandAdd`:

```lua
-- If we have enough RU, prioritize the Heavy Lasers upgrade
if (GetRU() > 1500) then
    ResearchDemandAdd(HEAVYLASERS, 75)
end
```

## 3. Critical AI Scripting Rules (Lua 4.0)

When modifying the `Data/Scripts/AI/` files, you must operate within strict engine limits:

1. **Restricted Standard Library**: The AI environment removes standard Lua functions to enforce determinism.
   - You cannot use `math.random()`. You must use `sg_random()`.
   - You cannot use `print()`. You must use `aitrace()`.
2. **No Modern Lua Syntax**: The HWRM engine runs Lua 4.0.
   - Do NOT use `#table` to get array length. Use `getn(table)`.
   - Do NOT use `table.insert()`. Use `tinsert()`.
3. **Variable Mismatches**: Passing a string when the engine expects an integer (like passing `"Hgn_SuperScout"` instead of `HGN_SUPERSCOUT` to an AI demand function) will cause a fatal runtime crash. Always use the predefined constants from `UpgradeIDs`.

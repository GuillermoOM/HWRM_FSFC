# Skill: Ship-Dependent Tech Tree Progression

This skill describes how to implement a granular, ship-by-ship research progression system in HWRM_FSFC where both the player and the AI must follow a strict "Build to Unlock" pattern.

## 1. Research Definition (`def_research.lua`)
Structure research nodes so that each ship is its own research item.
- Use `TargetType = Ship` and `TargetName = "ship_id"` to link nodes directly to ships.
- Chain `RequiredResearch` so that ship B requires research A.

```lua
-- Example
{
    Name = "Apollo",
    RequiredResearch = "FighterDesign",
    TargetType = Ship,
    TargetName = "ter_apollo",
    -- ...
},
{
    Name = "Valkyrie",
    RequiredResearch = "Apollo",
    TargetType = Ship,
    TargetName = "ter_valkyrie",
    -- ...
}
```

## 2. Build Requirements (`def_build.lua`)
Update the `RequiredResearch` field for each ship to point to its specific new research node.
Also, update the `Description` string's `<b>Prerequisites:</b>` section to reflect the change.

## 3. AI Research Logic (`ai_upgrades.lua`)
Implement the "Built-Ship Dependency" logic in `DoResearchTechDemand_[Race]()`.
- The AI should only demand research for the NEXT ship if it has successfully fielded the CURRENT ship.
- Use `NumSquadrons(VARIABLE)` or `numActiveOfClass` to check for presence.
- Weight demand by class need using `ShipDemandMaxByClass`.

```lua
function DoResearchTechDemand_Terran()
    local fighterdemand = ShipDemandMaxByClass(eFighter) * 2
    if fighterdemand > 0 then
        -- Tier 1
        if Util_CheckResearch("Apollo") then
            ResearchDemandSet("Apollo", fighterdemand + 1.0)
        end
        -- Tier 2: Only research if Tier 1 is built
        if NumSquadrons(TER_APOLLO) > 0 then
            if Util_CheckResearch("Valkyrie") then
                ResearchDemandSet("Valkyrie", fighterdemand + 1.0)
            end
        end
    end
end
```

## Key Benefits
- **Player Pacing**: Prevents "skipping" tiers by requiring investment in current tech.
- **AI Behavior**: Prevents the AI from researching everything at once; forces the AI to field a fleet and then iterate on it.
- **UI Clarity**: Using `TargetType = Ship` allows the engine to show exactly what is being unlocked in the Research window.

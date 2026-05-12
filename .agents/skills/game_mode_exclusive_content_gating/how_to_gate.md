# Skill: Game Mode Exclusive Content Gating

## Goal
Enforce era-specific content (Freespace 1 vs. Freespace 2) by restricting build and research options based on the active game mode.

## Implementation Pattern

### 1. Identify the Mode
In your main rule script (e.g., `fs1_deathmatch.lua`), identify the era you want to enforce.

### 2. Define Restriction Lists
Create tables of ships and research items that should be HIDDEN for that specific mode.
```lua
-- Ships to hide in FS1 mode (FS2-only ships)
local fs2_ships = {
    "ter_ares",
    "ter_erinyes",
    "vas_tauret",
}

-- Research to hide in FS1 mode
local fs2_research = {
    "FS2_Era_Tech",
    "Advanced_Beam_Weaponry",
}
```

### 3. Apply Restrictions on Start
Use the `Rule_AddInterval` system to apply restrictions shortly after the game starts. This ensures that the engine's default initialization (which might grant items) has finished.

```lua
function OnInit()
    Rule_AddInterval("ApplyEraRestrictions", 1.0)
end

function ApplyEraRestrictions()
    for i = 0, Universe_PlayerCount() - 1 do
        -- Restrict Ships
        for _, ship in fs2_ships do
            Player_RestrictBuildOption(i, ship)
        end
        
        -- Restrict Research
        for _, tech in fs2_research do
            Player_RestrictResearchOption(i, tech)
        end
    end
    Rule_Remove("ApplyEraRestrictions")
end
```

### 4. Handling "Research: On" Lobby Setting
If the player selects "Research: All On" in the lobby, the engine will attempt to grant all nodes. Your restriction rule must run **after** this granting process to ensure the gated content remains hidden.

## Critical Rules
- **No Empty Strings**: Never call `Player_RestrictBuildOption(i, "")`. This will lock the UI.
- **Single String API**: `Player_RestrictBuildOption` only accepts ONE ship name at a time. Always use a loop to restrict multiple items.
- **Race Validation**: Before restricting, check the player's race prefix to avoid errors if a player is playing a vanilla race (if supported).

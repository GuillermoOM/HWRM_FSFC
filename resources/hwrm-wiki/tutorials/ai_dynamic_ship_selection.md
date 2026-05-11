# Tutorial: Implementing Dynamic AI Ship Selection

This tutorial explains how to implement a "Best Available" selection system for the HWRM AI, allowing it to automatically switch between different tiers or versions of ships based on current match restrictions.

## 1. The Core Concept
By default, AI scripts use static variables (e.g., `kInterceptor = HGN_INTERCEPTOR`). However, if a mod uses different ship "Tiers" or "Eras" that restrict certain ships, the AI can become stuck demanding ships it cannot build.

## 2. Setting up Multi-Tier Pairs
In your race's `ai_build.lua`, define the different tiers of a ship role using suffixes:

```lua
-- Define the tier-based counterparts
kInterceptor_Tier2 = HGN_INTERCEPTOR_ADV
kInterceptor_Tier1 = HGN_INTERCEPTOR
```

## 3. Implementing the Dynamic Hook
To make the AI adapt in real-time, you can implement a custom hook that runs every build cycle.

```lua
-- Helper function (usually placed in ai/default/cpubuild.lua)
function Util_PickBestShip(primary, fallback)
    if (primary ~= nil and CanBuild(primary) == 1) then
        return primary
    end
    if (fallback ~= nil and CanBuild(fallback) == 1) then
        return fallback
    end
    return primary or fallback
end

-- Hook in your race's ai_build.lua
function CpuBuild_UpdateRaceVariables()
    -- Dynamically assign the "Best Available" ship to the primary AI slot
    kInterceptor = Util_PickBestShip(kInterceptor_Tier2, kInterceptor_Tier1)
end
```

## 4. Why Use This?
- **Robustness**: The AI will never waste demand on a ship that is currently restricted by research or game rules.
- **Flexibility**: Useful for mods with "Evolutions," "Eras," or game modes that disable specific units.
- **Simplicity**: Your main AI demand code only needs to refer to `kInterceptor`.

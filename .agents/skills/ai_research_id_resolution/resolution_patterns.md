# Skill: AI Research ID Resolution & Stance Management

## 1. Engine-Provided Tactical Nodes
In HWRM, certain research nodes are provided by the engine rather than the mod's `def_research.lua`. These include:
- `cpuplayers_aggressive`
- `cpuplayers_dynamic`
- `cpuplayers_defensive`

These nodes represent the AI's internal tactical stance. Unlike ship technology, these nodes are persistent and may be re-demanded by the engine to maintain AI behavior.

## 2. The "nil" Resolution Bug
When using these variables in `ai_upgrades.lua`, they may resolve to `nil` if the Lua scope hasn't initialized them yet, leading to a `parameter:` crash in `ResearchDemandSet`.

### The Safe Resolution Pattern
Use `getglobal()` to resolve these engine constants dynamically. This ensures that even if the engine defines them in a different case or at a different time, the script can safely map them.

```lua
-- Standard initialization at the top of ai_upgrades.lua
CPUPLAYERS_AGGRESSIVE = getglobal("cpuplayers_aggressive") or -1
CPUPLAYERS_DYNAMIC = getglobal("cpuplayers_dynamic") or -1
CPUPLAYERS_DEFENSIVE = getglobal("cpuplayers_defensive") or -1

-- Use a fallback to -1 to prevent engine crashes
```

## 3. Treating Stances as "Transient" Tasks
Because the engine frequently toggles these nodes, they can "flicker" in telemetry and logs. To stabilize AI reporting:
1. **Dedicated Tracking**: Track "Stance" separately from "Technology" in dashboards.
2. **Noise Suppression**: Filter out "Tactics" or "cpuplayers" keywords from the strategic tech history.
3. **Log Filtering**: Only log these nodes when they *first* become the highest priority, rather than periodically re-emitting them.

## 4. Telemetry Best Practices
When reporting research to external tools, differentiate between **Stance Nodes** (Tactical) and **Tech Nodes** (Strategic).
- **Tech Nodes**: Should be added to a persistent history chain (e.g., `Astaroth ➔ Gorgon`).
- **Stance Nodes**: Should update a single "Current Stance" field without affecting the technology chain.

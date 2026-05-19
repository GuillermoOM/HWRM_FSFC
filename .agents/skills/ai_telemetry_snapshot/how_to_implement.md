# Skill: AI Telemetry Snapshot System

Describes how to implement and extend the direct log-based AI telemetry system used by the FSFC telemetry pipeline.

## Architectural Constraints

> [!IMPORTANT]
> **Lua Scope Isolation**: In Homeworld Remastered, the AI execution environment (run inside the `ai_upgrades.lua`, `ai_build.lua`, etc.) and the SCAR level scripting environment (run inside `telemetry.lua`) exist in completely separate, isolated Lua states.
>
> Globals set in the AI environment are NOT visible to the SCAR environment, and vice versa. Attempting to share tables via globals will result in silent lookup failures or nils.

Therefore, the FSFC telemetry system uses a **Log-as-IPC (Inter-Process Communication)** model. The AI context emits structured print statements directly to standard output, which the HWRM engine captures in `HwRM.log`. External python tools like `realtime_telemetry.py` and `timeline_analysis.py` tail the log file to parse, analyze, and visualize match data.

```
+------------------------------------+
|             AI Thread              |
+------------------------------------+
  - DetermineSpecialDemand() 
      ↳ calls FSFC_WriteDemandSnapshot()
  - DoUpgradeDemand()
      ↳ calls FSFC_WriteResearchSnapshot()
                 │
                 ▼
          print() outputs
                 │
                 ▼
+------------------------------------+
|             HwRM.log               |
+------------------------------------+
                 │
                 ▼ tail / read
+------------------------------------+
|       Python Telemetry Tools       |
+------------------------------------+
  - realtime_telemetry.py (dashboard)
  - timeline_analysis.py  (milestones)
```

---

## Part 1: Ship Demand Snapshot

**Written by**: `FSFC_WriteDemandSnapshot()` in `ai_telemetry.lua`  
**Called from**: End of `DetermineSpecialDemand_*` in each race's `ai_build.lua`  
**Reads**: `ShipDemandMaxByClass()` and `ShipDemandGet()` for key ship roles  
**Prints format**:
```
[<time>s] [AI_DIAG] P<player> DEMAND | F:<val> B:<val> Fr:<val> De:<val> Ca:<val> Cv:<val> Bc:<val> Co:<val> Re:<val>
```

### Implementing for a new custom race's ai_build.lua:
Ensure `ai_telemetry.lua` is loaded, then call `FSFC_WriteDemandSnapshot()` at the very end of the `DetermineSpecialDemand` function:
```lua
function DetermineSpecialDemand_MyRace()
    -- ... build demand logic ...
    
    FSFC_WriteDemandSnapshot()
end
```

---

## Part 2: Research Demand Snapshot

**Written by**: `FSFC_WriteResearchSnapshot()` in `ai_telemetry.lua`  
**Called from**: End of `DoResearchTechDemand_*` / `DoUpgradeDemand_*` cycle in `ai_upgrades.lua`  
**Reads**: Accumulator `FSFC_ResearchAccum` filled by `FSFC_Log_Research()` calls  
**Prints format**:
```
[<time>s] [AI_DIAG] P<player> RESEARCH_DEMAND | <NodeA>:<val> <NodeB>:<val> ...
```

### Accumulation & Serialization Gotchas:
1. Every call to `FSFC_Log_Research("NodeName", demand)` automatically updates `FSFC_ResearchAccum[nodeName]` with the highest demand value seen in the current cycle.
2. The accumulator is cleared automatically at the end of each print cycle.

> [!CAUTION]
> **No closures in Lua 4.0**: The sorting and iteration inside `FSFC_WriteResearchSnapshot()` uses a `next()`-based table loop.
> Do NOT rewrite it using `foreach` with anonymous functions, as HWRM's Lua 4.0 engine does not support lexical closures (upvalue capture) and will crash the engine on load.
> See: `.agents/skills/lua_40_closure_restriction/no_upvalue_capture.md`

### Implementing for a new custom race's ai_upgrades.lua:
```lua
-- 1. Feed the research demand accumulator during the upgrades loop:
function DoResearchTechDemand_MyRace()
    if (FSFC_CheckResearch(MY_TECH)) then
        local d = 5.0
        ResearchDemandSet(MY_TECH, d)
        FSFC_Log_Research("MyTech", d)  -- Feeds the telemetry accumulator
    end
    
    -- ... more research demands ...
    
    -- 2. Emit the snapshot at the very end of the research loop:
    FSFC_WriteResearchSnapshot()
end
```

---

## Part 3: Python Parser & Visualization

### Parsing Regex Patterns

To read these lines in Python toolchains, use the following regex definitions:

```python
# Match general build demand
# Group 1 = Player ID, Group 2-10 = class values
re_demand = re.compile(
    r"\[AI_DIAG\] P(\d) DEMAND \| F:([\d\.-]+) B:([\d\.-]+) Fr:([\d\.-]+) "
    r"De:([\d\.-]+) Ca:([\d\.-]+) Cv:([\d\.-]+) Bc:([\d\.-]+) Co:([\d\.-]+) Re:([\d\.-]+)"
)

# Match research demand list
# Group 1 = Player ID, Group 2 = Space-separated list of Node:Value pairs
re_res_demand = re.compile(
    r"\[AI_DIAG\] P(\d) RESEARCH_DEMAND \| (.+)"
)
```

> [!TIP]
> Always check for `RESEARCH_DEMAND` before general `DEMAND` in line matchers, or filter out lines containing `RESEARCH_DEMAND` first, to avoid false positive matches on build demands.

---

## Validation & Verification

1. Start HWRM in windowed mode.
2. Open a terminal and run `python3 realtime_telemetry.py`.
3. Check that player panels successfully show detailed build demands (suppressing negative values under `-7.0` to filter out inactive components) and show all active research demands ranked by priority.
4. Verify that `timeline_analysis.py` parses `DEMAND` and `RESEARCH_DEMAND` lines to construct a clear picture of chronological upgrades and strategic transitions.

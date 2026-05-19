# Skill: Lua 4.0 Closure Restriction & Table Iteration

## The Problem

Lua 4.0 **does not support closures**. Any anonymous function (used in `foreach`,
`foreachi`, or assigned to a variable) **cannot read or write `local` variables
declared in the enclosing scope** (upvalues).

### Symptom

```
parameter: cannot access a variable in outer scope;
  last token read: `sorted' at line 164 in string ""
```

This crash appears at **load time** (inside `CpuBuild_Init` or `CpuResearch_Init`)
and causes all `FSFC_*` functions defined after the crash point to be nil,
producing a cascade of secondary errors like:

```
parameter: attempt to call global `FSFC_PickBestShip' (a nil value)
```

### Triggering Pattern (BROKEN)

```lua
-- ❌ CRASH in Lua 4.0 — 'sorted' is an outer-scope local, cannot be captured
local sorted = {}
foreach(myTable, function(key, value)
    -- 'sorted' is captured as an upvalue — ILLEGAL in Lua 4.0
    tinsert(sorted, {name=key, demand=value})
end)
```

---

## The Fix: Use `next()` for Upvalue-Free Iteration

Replace any `foreach`/`foreachi` call that needs to **build or modify an outer
variable** with a `next()`-based `while` loop. `next()` iterates a hash table
without any anonymous function and therefore has no upvalue requirements.

### Pattern: Insertion Sort with `next()`

```lua
-- ✅ CORRECT — no closures, no upvalue capture
local sorted = {}
local rname = next(myTable)
while (rname ~= nil) do
    local demand = myTable[rname]
    -- Insertion sort (descending by demand)
    local inserted = 0
    local n = getn(sorted)
    for i = 1, n do
        if (demand > sorted[i].demand) then
            tinsert(sorted, i, {name=rname, demand=demand})
            inserted = 1
            break
        end
    end
    if (inserted == 0) then
        tinsert(sorted, {name=rname, demand=demand})
    end
    rname = next(myTable, rname)   -- advance to next key
end
```

### `next()` API (Lua 4.0)

| Call | Result |
|---|---|
| `next(t)` | Returns the first (key, value) pair, or `nil` if empty |
| `next(t, key)` | Returns the (key, value) pair **after** `key`, or `nil` at end |

> [!IMPORTANT]
> `next()` iteration order is undefined (hash table). If order matters, build a
> sorted copy first using the pattern above, then iterate the sorted array with a
> numeric `for` loop.

---

## When Is `foreach` Safe?

`foreach` / `foreachi` are safe **only** when the callback does not need to touch
any outer-scope `local` variable:

```lua
-- ✅ SAFE — callback only uses its own parameters, no outer locals touched
foreach(myTable, function(k, v)
    print(k .. " = " .. tostring(v))
end)
```

If you need to accumulate results, always use `next()` instead.

---

## Real-World Example: `FSFC_WriteResearchSnapshot`

This function was the source of the crash. The `foreach` callback captured `sorted`:

```lua
-- ORIGINAL (crashed)
local sorted = {}
foreach(FSFC_ResearchAccum, function(name, demand)
    tinsert(sorted, ...)   -- ← upvalue capture: CRASH
end)
```

Fixed to:

```lua
-- FIXED (next-based, no closures)
local sorted = {}
local rname = next(FSFC_ResearchAccum)
while (rname ~= nil) do
    local demand = FSFC_ResearchAccum[rname]
    -- ... insertion sort into sorted ...
    rname = next(FSFC_ResearchAccum, rname)
end
```

---

## Validation

In `HwRM.log`, confirm the errors are gone:

- ✅ Should NOT see: `cannot access a variable in outer scope`
- ✅ Should NOT see: `attempt to call global 'FSFC_PickBestShip' (a nil value)`
- ✅ Should see: `[AI_DIAG] Initialized for Player 1/2/3`

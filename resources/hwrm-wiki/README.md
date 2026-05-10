# Homeworld Remastered Modding Reference

Welcome to the consolidated and refactored Homeworld Remastered (HWRM) Modding Reference. This repository is the spiritual successor to the community-driven KarosGraveyard Wiki.

Over the years, the KarosGraveyard grew to over 1,300 pages of raw, unstructured data. While invaluable, it became difficult to navigate, and much of the Lua 4.0 engine documentation was scattered across obsolete HW2-era posts.

This repository condenses that massive knowledge base into ~35 structured, highly organized Markdown files, grouped logically by scope, engine system, and task.

## Directory Structure

* **`functions/`** - API references for all engine-exposed Lua 4.0 functions, grouped by scope (AI, Player, SobGroup, Level, etc.)
* **`variables/`** - Lists of engine variables and properties for `.ship`, `.wepn`, `.subs`, `.miss`, and UI/FX systems.
* **`reference/`** - Structural rules, such as `.ship` file parsing order, error codes, and global enumerations.
* **`tutorials/`** - Step-by-step guides for basic to advanced modding tasks, updated for the HWRM engine.

## Note on Lua 4.0

Homeworld Remastered uses **Lua 4.0**. Many modern Lua features are explicitly unsupported and will crash the game:
- **No `#table` syntax**: Use `getn(table)` to get array length.
- **No `table.insert`**: Use `tinsert(table, value)`.
- **String indexing**: `string.len()` and `string.sub()` are available, but many other modern string libraries are not.
- **AI Environment**: In `Data/Scripts/AI/`, `math.random` and `print` are disabled. Use `sg_random` and `aitrace`.

## Getting Started

If you are completely new to HWRM modding, start with our [Getting Started](tutorials/getting_started.md) guide to learn how to extract the game's `.big` files and test your modifications locally.

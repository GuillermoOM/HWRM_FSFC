# Contributing to the HWRM Modding Reference

Thank you for your interest in improving the Homeworld Remastered (HWRM) modding knowledge base!

This repository serves as a highly structured, verified replacement for the sprawling KarosGraveyard wiki. To maintain its usefulness, we adhere to strict organization and formatting standards.

## How to Contribute

1. **Fork the Repository:** Create your own branch to work on.
2. **Make Changes:** Add new findings, correct errors, or expand tutorials.
3. **Submit a Pull Request (PR):** Open a PR with a clear summary of what you changed.

## Documentation Standards

If you discover a new engine function, variable, or behavior, please follow these guidelines when adding it to the documentation:

### 1. Maintain Scope Separation
The HWRM engine runs in several isolated environments (e.g., `GameType`, `AI`, `UI`). When adding a function, ensure it goes in the correct markdown file.
- If it manages unit production, it belongs in `functions/player_rule_functions.md`.
- If it dictates UI layout, it belongs in `functions/ui_camera_functions.md`.

### 2. Standardized Formatting
When documenting a function, use the following Markdown template:

```markdown
### FunctionName
> Short, 1-2 sentence description of what the function does.

**Syntax:**
`FunctionName(arg1, arg2)`

**Arguments:**
- `arg1` (Type): Description.
- `arg2` (Type): Description.

**Returns:** (Type) - Description of return value, or `nil` if void.
```

### 3. Verify Against Vanilla
Before asserting that a function behaves a certain way, cross-reference it with the vanilla HWRM `.big` files. The original developers' usage of a function is the most reliable source of truth.

### 4. No Deprecated HW2 Information
While HWRM is based on the HW2 engine, many things changed. If a feature from Homeworld 2 Classic no longer works in HWRM (such as `.peo` particle effects, or the old `Tactics` system which is now split into ROE and Stance), do not document it as active. If relevant for context, label it clearly with a `> [!WARNING]` block noting it is deprecated in HWRM.

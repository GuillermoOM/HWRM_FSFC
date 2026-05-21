---
description: Recollect any new knowledge and make necessary skills adjustments
---

# Workflow: Collect Knowledge & Save Skills

Use this workflow at the end of a complex task or debugging session to codify new patterns, engine quirks, and tactical solutions into the project's permanent knowledge base.

## 1. Identify New Knowledge

Review the conversation and identified solutions. Look for:

- Engine-specific bugs and their fixes.
- New Lua 4.0 constraints or functional wrappers.
- Architectural patterns (e.g., how to handle AI stances).
- Telemetry or dashboard refinements.

## 2. Check Existing Skills

Before creating a new skill, list the contents of `.agents/skills/` to see if a relevant category exists.

// turbo
run_command(CommandLine="ls -R .agents/skills/", Cwd="/run/media/system/Data/SteamLibrary/steamapps/common/Homeworld/HWRM_FSFC")

## 3. Create or Update Skills

- **If the knowledge is new**: Create a new directory under `.agents/skills/[skill_name]/` and add a descriptive `.md` file.
- **If the knowledge refines an existing skill**: Update the existing `.md` file, combining the new patterns with the old ones. Use GitHub alerts (NOTE/TIP/IMPORTANT) to highlight critical warnings.

### Format Requirements

- **Skill Title**: `# Skill: [Name]`
- **Gotchas**: Explicitly list crash-causing patterns and their fixes.
- **Code Examples**: Provide complete, working Lua 4.0 examples.
- **Validation**: Explain how to verify the skill is working (e.g., check `HwRM.log`).

## 4. Register in AGENTS.md

Update the `Skills & Automation` section of `AGENTS.md` to include a reference to the new skill.

## 5. Update Knowledge Items

If the new knowledge affects the core mod architecture, update the relevant KI in `resources/fsfc-knowledge/`.

- `fsfc_ai_architecture.md`: For AI logic and wrappers.
- `fsfc_mod_structure.md`: For directory and naming conventions.

## 6. Handoff

Run the `/handoff` workflow to ensure the next agent is aware of the newly codified skills.

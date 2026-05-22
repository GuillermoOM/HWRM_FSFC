---
description: Generate a compact handoff prompt for the next agent or stage. Output the prompt only.
---

# Handoff Prompt

Generate a **minimal sufficient prompt** for the next agent.

This skill is for **handoff and stage transition**. It is not a summarisation skill.

Its goal is to produce a prompt that lets the next agent start the correct work immediately, without needless background, duplicated documentation, user-side clarification, or avoidable rework.

## Use this skill when

Use this skill when the user wants a prompt to pass work to another agent, another role, or another stage.

Typical cases:

- continuing work in a fresh coding-agent context
- passing a completed plan or spec to an orchestrator
- passing research results to an implementation agent
- passing implementation state to a reviewer or debugger
- splitting work across multiple agents

## Core rule

Do **not** transfer everything.

Transfer only what the next agent needs in order to act correctly and efficiently.

The output must prioritise:

1. the immediate task
2. the correct starting references
3. decisions already fixed
4. non-obvious constraints or context
5. unresolved points that materially affect the next step
6. the required output

## Mandatory requirements

### 1. Output only the prompt

Return the transfer prompt and nothing else.

Do not add any preface, explanation, note, or follow-up text.

### 2. Required positive structure

Every handoff prompt MUST contain:

1. **Workflow anchor** — at least one `/workflow-name` reference identifying which skill the next agent should invoke (e.g. `/github-driven-workflow`, `/lite-spec`).
2. **Concrete anchor** — at least one of: GitHub issue/PR number (`#N`), commit SHA, file path, session log path.
3. **Bounded length** — keep the prompt under ~1000 characters. Excessive length is a sign that acceptance criteria are leaking into the prompt body.

Once these positive elements are present, **decision boundaries are structurally deferred to the skill the next agent invokes**. Verbal acceptance phrasings such as `merge after CI is green`, `proceed when ready`, or `Go Ahead` are **not prohibited** — they read naturally, and the skill anchor ensures they do not trap the next agent in an unresolvable gate.

### 3. Hard-fail anti-patterns (minimal set)

Reject only well-defined, unambiguous structural violations:

- **Self-authorization preamble** — phrases that grant the next agent permissions inline, such as `explicit authorization granted` or `you are authorized to ...`. Permission grants belong in environment configuration, not in the prompt body.
- **Permission-downgrade directives** — instructions to pass `--dangerously-skip-permissions` or equivalent flags to the next agent's CLI invocation.

Do not enumerate verbal acceptance phrases (e.g. `complete when`, `after review`, `once green`) as forbidden. The expression space is unbounded; enumeration is trivially bypassed and causes false positives on legitimate phrasings.

### 4. Why verbal criteria are not enumerated

Phrases like `merge after sufficient review`, `proceed when ready`, and `完了したら` are **not** added to a forbidden list because:

- The expression space is unbounded; any list is trivially bypassed by rephrasing.
- Most natural usages are legitimate (e.g. `implement #42 following /github-driven-workflow until complete` is structurally fine — the skill defines the gates).
- Broad bans cause false positives and push agents toward different bad expressions rather than better prompts.

Structural guarantees (the skill anchor) defuse these expressions at the next-agent level: the next agent reads the skill, which provides the authoritative gate definitions.

### 5. Keep it compact

Use the shortest prompt that still enables correct action.

If the prompt becomes long, compress harder. Excessive length is a warning sign that too much low-value context has been preserved.

### 6. Do not duplicate existing documentation

Do not restate content already documented in places such as:

- `AGENTS.md`
- specification documents
- implementation plans
- architecture documents
- repository workflow instructions

Refer to those sources briefly instead of copying them.

### 7. Preserve only non-obvious context

Include only context that the next agent is unlikely to recover reliably from the repository or existing documents.

Examples of valid carry-over:

- decisions already made
- options explicitly rejected
- hidden constraints
- important user preferences that affect execution
- known traps, weak spots, or misleading artefacts
- priority ordering that is not obvious from the files alone

### 8. Remove history that does not change action

Do not include:

- narrative history
- abandoned detours that no longer matter
- motivational explanation
- general background that does not affect the next action
- obvious operational instructions already documented elsewhere

### 9. Optimise for autonomous execution

The generated prompt must help the next agent proceed **without**:

- asking the user for avoidable clarification
- stalling because of ambiguous wording
- re-opening settled decisions
- causing avoidable rework

Write the prompt so that the next agent can determine what to do, what not to do, what to read first, and what to produce.

## Examples

```
# Good — skill anchor + concrete anchor + bounded length
Implement t-uda/example#42 following /github-driven-workflow.
Report when complete.

# Bad — no skill anchor, criteria leaking into prompt body
Implement the example issue. Wait until CI is green and review is sufficient,
then merge with squash, delete the branch, clean up the worktree, report ...
(800+ characters)

# Bad → Good — verbal "until complete" is fine when structure is right
Implement t-uda/example#42 following /github-driven-workflow until complete.
Report to channel ABC.
```

## Role-specific requirements

### Coding agent

Emphasise:

- the concrete implementation task
- the files or documents to inspect first
- design decisions already fixed
- implementation constraints
- expected code, test, and document outputs

### Orchestrator

Emphasise:

- the current task to be coordinated
- the complexity of the task
- the required decomposition into sub-agents if needed
- the need to choose appropriate models for the sub-agents based on task complexity
- decisions already fixed and not to be reopened
- the required final deliverable and coordination objective

An orchestrator handoff must explicitly guide the orchestrator to judge task complexity and assign suitable sub-agents and model levels accordingly.

### Reviewer or debugger

Emphasise:

- the review or debugging target
- intended behaviour
- likely failure points
- specific areas requiring scrutiny
- the required review output

### Research agent

Emphasise:

- the concrete research question
- scope boundaries
- assumptions already fixed
- the form of findings needed
- what lines of investigation are out of scope

## Preferred content structure

Include only the elements that are necessary for the specific handoff, chosen from:

1. target role
2. immediate task
3. read first
4. fixed decisions
5. non-obvious context
6. open issues that affect the next step
7. constraints and prohibitions
8. required output

Do not force a full template when fewer elements are sufficient.

## Writing rules

The generated prompt must be:

- specific
- operational
- compact
- unambiguous
- easy to copy

Avoid wording that is broad, vague, interpretive, or compatible with too many possible meanings.

Prefer direct instructions over abstract guidance.

## Quality test

Before finalising the transfer prompt, verify:

- [ ] At least one `/skill-name` anchor is present.
- [ ] At least one concrete anchor (`#N`, SHA, file path) is present.
- [ ] Total length is under ~1000 characters.
- [ ] No self-authorization preamble is present.
- [ ] No `--dangerously-skip-permissions` directive is present.
- [ ] The next agent will know exactly what to do next.
- [ ] The next agent will know what to read first.
- [ ] The next agent will not needlessly re-read duplicated material.
- [ ] The next agent will not ask the user for clarification unless a truly missing input remains.
- [ ] The next agent will not reopen settled choices.
- [ ] The prompt contains no filler outside the operational handoff.

## Final instruction

When invoked, output the transfer prompt immediately.

Return the prompt only.

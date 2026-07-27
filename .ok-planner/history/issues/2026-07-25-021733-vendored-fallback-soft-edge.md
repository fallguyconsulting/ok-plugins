---
issue: vendored-fallback-soft-edge
kind: discover
category: inconsistent
artifacts:
  - decision:per-project-pinning
status: promoted
opened: 2026-07-25T02:17:33Z
sprint: 2026-07-26-vendored-suite-conduct-split.md
---

# Four advisory skills silently fall back to the plugin-root binary the pinning decision forbids

`decision:per-project-pinning` says only the lifecycle verb's entry point and pre-estate bootstrap verbs legitimately execute from the plugin root — everything else runs the project's vendored copy, so what lints is what the owner converged to. But four ok-plumbline skills (`explain`, `suggest`, `patterns`, `slug`) carry a silent fallback: prefer the vendored binary, and when it's absent or non-executable, run the installed plugin's copy with no notice and no consent. Read literally, the decision forbids this — these are neither true-up nor bootstrap verbs.

What keeps this from being a mechanical repair is that the decision's rationale doesn't obviously reach these verbs. Its Rationale guards *enforcement reproducibility* — and the blocking path honors it perfectly: the PostToolUse hook has no fallback at all and no-ops without an estate. The four fallback carriers are read-only and advisory; their worst case is describing the installed plugin's rules rather than the project's pinned ones, in tools arguably meant to be explorable before adoption. The letter says one thing; the reason behind it plausibly exempts exactly these four. Nothing in the corpus says which reading governs.

## Options

- **Sanction the class, surface the fallback** — amend the decision's Choice: read-only advisory verbs may fall back to the plugin-root copy, and must say so in output (one echo line: "using installed-plugin copy (project has no vendored binary)"). Matches shipped behavior and the rationale's real scope; the silence — the genuinely bad part — goes away.
- **Enforce the letter** — the four skills hard-stop (or ask) without a vendored binary. Consistent, but makes exploratory tools unusable pre-true-up, which is when explain/suggest are most useful.
- **Leave it** — the letter and the code keep disagreeing, silently.

The ruling decides: widen the decision's stated exceptions to advisory verbs (with the fallback surfaced), or tighten the code to the letter.

## Ruling

> Recommended ruling (/verify-issues): sanction and surface — a sprint delta amends `decision:per-project-pinning`'s Choice to name read-only advisory verbs as a third legitimate plugin-root class *with the fallback announced in output*, and a work item adds the notice line to the four skills.
>
> Rationale: the decision's rationale is about what enforces, and the enforcement path already complies without exception; forcing exploration tools through the pinning gate serves the letter against the reason. The defect worth fixing is the silence — an announced fallback preserves both the tools' pre-adoption usefulness and the owner's ability to notice they're not reading pinned rules.

<!-- Owner: this is a recommendation, not your decision. Leave it
as-is to accept — the next /plan-sprint carries it, naming the
generated/recommended batches at sign-off. Edit the text to
redirect, empty the section to discuss live, or delete this note
to adopt the ruling as your own. -->

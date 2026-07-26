---
issue: audit-verb-overload
kind: discover
category: overloaded
artifacts:
  - concept:skill
  - story:corpus-audit
  - story:rules-compliance-report
status: verified
opened: 2026-07-25T02:16:44Z
---

# Three unrelated verbs named audit across the suite

## Problem

The planner's corpus audit, the lint plugin's violation audit, and the workspaces discipline audit are unrelated behaviors sharing one verb name; 'run /audit' is ambiguous in a project integrating more than one plugin and no prose addresses the collision.

## Candidates

- Amend concept:skill Boundaries with a verb-namespacing rule for same-named verbs across plugins
- Add a decision recording per-plugin verb naming and rename one or more audit verbs

## Discussion

**The question.** Three plugins in the suite — ok-planner, ok-plumbline, ok-workspaces — each ship a skill literally named `audit`, and each skill's own description text tells the user to invoke it as `/audit`. In a project that has integrated more than one of these plugins (the suite's own repo integrates all three), what does typing `/audit` actually run, and should the corpus say anything about it? Does the collision need a corpus rule, a rename, or is it already handled by mechanism the corpus doesn't need to restate?

**Where this comes from.** The issue's Problem and Candidates are copied verbatim from the Observations note at the bottom of `.ok-planner/design/_discover/audit-verb.md:34` (scaffolding from the `discover-design` pass, out-of-context by convention but consulted here as the issue's origin). That note is itself dated relative to a legacy `issues.jsonl` layout — the intake has since moved to one-file-per-issue and gained `/verify-issues` — but the substance is stack-independent and I re-verified it directly against current code rather than trusting the note:

- `plugins/ok-planner/skills/audit/SKILL.md` — frontmatter `name: audit`, description: "ONLY activated by explicit `/audit` slash command or by whoever is executing a sprint's completion contract." Whole-corpus design audit; judgment findings go to `.ok-planner/issues/`.
- `plugins/ok-plumbline/skills/audit/SKILL.md` — frontmatter `name: audit`, description: "Audit the current project against the Plumbline lint... Read-only — proposes fixes; does not apply them." No "ONLY activated by /audit" phrasing at all — unlike the other two, it doesn't even declare itself slash-only (see the code-vs-corpus note below).
- `plugins/ok-workspaces/skills/audit/SKILL.md` — frontmatter `name: audit`, description: "ONLY activated by explicit `/audit` slash command." Read-only sweep for worktree-naming, runtime-isolation, and mutable-tag residue.

All three are still live, still separately named `audit`, still unrelated in behavior, and none of the three SKILL.md files or any prose file in the repo qualifies its own name with its plugin (e.g. neither says "invoke as `/ok-planner:audit`"). None of plumbline, planner, or workspaces defines a `commands/` directory either — each plugin's only route to `/audit` is the bare skill name. So the collision the issue describes is current, not rotted; if anything it's slightly sharper than the filer's note suggests, since ok-plumbline's audit doesn't even carry the same slash-only activation guard the other two do (a second, narrower discrepancy the filer didn't flag — noted here, not folded into this issue's Problem).

One point of genuine drift worth flagging: this transcript's own tool listing shows skills addressed as `ok-planner:audit`, `ok-plumbline:audit`, `ok-workspaces:audit` — plugin-qualified — when routed through the Skill-invocation tool that machinery (not a human typing a slash command) uses. Whether the *human-facing* `/audit` slash command resolves the same way — silent pick, disambiguation prompt, or genuine error — is a harness behavior outside this repo; nothing in the suite's own text asserts or documents which.

**What the corpus says.** Searched all three catalogs (`concepts.md`, `stories.md`, `decisions.md`) for anything addressing verb-name collision across plugins; nothing does.

- `concept:skill` (cited by the issue) defines skills as "the suite's verbs" and splits them into user-facing (slash-command-only) and plumbing classes, but its Boundaries and Invariants say nothing about two plugins choosing the same verb name — the closest text, "Skills do not chain into pipelines; each is terminal at its own artifact," is about composition, not naming.
- `concept:integration-contract` (not cited by the issue, found while checking for a squarely-answering artifact) states the invariant "Every integrable plugin exposes the lifecycle verb; plugins with rules to check also expose a read-only compliance verb" — this is *why* three plugins converged on the same name (`audit` is the conventional name for the compliance verb across the contract), but it prescribes the convention that produces the collision, not a resolution to it.
- `story:corpus-audit` and `story:rules-compliance-report` (both cited) each describe one plugin's own audit verb's behavior in isolation — correctly, and confirming the three are indeed substantively unrelated (whole-corpus design review vs. lint-violation report vs. workspace-discipline sweep) — but neither story's text, Acceptance, or Falsifier mentions any other plugin's verb or the shared name.
- `story:isolated-parallel-workspaces` and `concept:workspace` (read for this verification but not cited by the issue) are the substance behind ok-workspaces' `/audit` — they explain *what* that particular audit checks (worktree naming, runtime namespacing) but likewise say nothing about the verb's name colliding with another plugin's.
- `decision:lockstep-suite-version` (read for this verification, not cited) is a structurally similar case, not a governing one: another cross-plugin coordination question ("do plugin versions agree with each other") that the corpus has already recorded as a decision with no enforcing check, "filed to the intake queue for owner calibration." It shows the suite's established pattern for this shape of problem — record a choice, accept it's unenforced, let the release procedure or a convention carry it — but it decides plugin-version identity, not verb-name identity, so it doesn't answer this question by extension.

No artifact — decision, concept, or story — takes a position on same-named verbs across plugins one way or the other. The corpus is silent, not conflicted.

**What the code does today.** Each plugin registers its `audit` skill independently, unaware of the other two (per `concept:plugin`'s boundary: "A plugin that would need the front door to special-case it has integrated wrong" — plugins are deliberately ignorant of each other). `plugins/ok/skills/ok/SKILL.md`, the suite's only cross-plugin dispatcher, explicitly disclaims driving any of them ("`/ok` never invokes work-driving verbs (`audit`, `prove`, `open`, …)"), so there is no suite-level component that could arbitrate the name even if the corpus wanted one to. Nothing in the repository — hook, manifest, shared definitions file — renames, prefixes, or aliases any of the three.

**Candidates.**

1. *(filed)* Amend `concept:skill`'s Boundaries with a verb-namespacing rule for same-named verbs across plugins — e.g. mandate that a user-facing skill's slash-command name always be understood as (or literally documented as) plugin-qualified. This resolves the ambiguity by corpus assertion alone, costs no renames, but only helps if it's actually true of the harness's resolution behavior — if bare `/audit` genuinely does resolve ambiguously or arbitrarily today, asserting it's qualified would be describing a fiction, not the current state (design docs are current-state only, not aspirational).
2. *(filed)* Add a decision recording per-plugin verb naming and rename one or more of the three `audit` skills to distinct names (e.g. `lint-audit`, `workspace-audit`, keeping `audit` for one plugin — or renaming all three to make the split legible). This removes the collision at the source, independent of any harness behavior, but costs a rename across SKILL.md, cheatsheet references, and any doc that tells users to type `/audit` for a specific plugin, and changes user muscle memory for existing projects.
3. *(new)* Decide the corpus doesn't need to say anything at all — record no artifact, and instead fix only the narrower, concretely broken thing this verification surfaced: ok-plumbline's `audit` skill is missing the "ONLY activated by explicit `/audit` slash command" guard the other two carry, which is a `decision:slash-only-activation` compliance gap regardless of how the naming question resolves. This candidate treats the three-way name collision as accepted, load-bearing convention (per `integration-contract`'s "compliance verb" invariant) rather than a defect, and confines corpus action to the one thing that's unambiguously off.

**What the ruling must decide.** Whether the suite's convention of naming every plugin's read-only compliance verb `audit` needs a corpus-recorded resolution for cross-plugin name collision (and if so, whether that resolution is a namespacing rule, a rename, or something else) — or whether the collision is accepted as-is and only the ok-plumbline activation-guard gap gets addressed.

## Ruling

<!-- Owner: write your decision here in your own words.
The next /plan-sprint picks it up. Leave empty to discuss
it live in a planning session instead. -->

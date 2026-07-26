---
issue: planner-tooling-constraint-vs-python
kind: discover
category: conflicting
artifacts:
  - concept:plugin
status: verified
opened: 2026-07-25T02:17:33Z
---

# Planner contributor constraint contradicts its own script surface

## Problem

The planner's contributor doc states 'No Node tooling; skills are markdown, hooks are bash' while the plugin ships a Python 3 ceremony helper — neither node, markdown, nor bash; the constraint's letter and the tree disagree.

## Candidates

- Amend concept:plugin Invariants to state the actual per-plugin tooling constraint including sanctioned script languages

## Discussion

**The question.** `plugins/ok-planner/CLAUDE.md`'s Constraints section states "No Node tooling; skills are markdown, hooks are bash" — but the plugin ships a Python 3 script. Should the stated constraint be corrected to name the actual sanctioned languages, and does that belong in `concept:plugin`, or is this purely a contributor-doc wording fix outside the design corpus's scope?

**Evidence, re-verified — confirmed live, and the surface grew.** `plugins/ok-planner/CLAUDE.md`'s Constraints section still reads verbatim "No Node tooling; skills are markdown, hooks are bash." `plugins/ok-planner/scripts/surface-corpus` is confirmed Python: `file` reports "Python script text executable," its shebang is `#!/usr/bin/env python3`, and its own docstring describes it as a corpus-bearing-artifact surfacer for issue verification. It was recently extended (per the batch's briefing note) to accept two input modes — an issue markdown file path via argv, or a legacy issue-queue JSON row via stdin — but it remains one Python script, not two; the "second mode" is an input-handling branch inside the same file, not a second script surface. `plugins/ok-planner/scripts/true-up` is confirmed bash (`file`: "Bourne-Again shell script text"). So the tree has exactly one script outside the bash/markdown set the constraint names, and the constraint's literal wording still doesn't account for it.

**What the corpus says.** `concept:plugin`'s What-it-is section states generally: "The suite ships no application runtime — the executable substance is prompt text, small scripts, and one lint binary" — "small scripts" is unqualified by language, which is *compatible* with a Python script existing, but doesn't resolve the narrower contradiction inside the planner's own `CLAUDE.md` (a project-level contributor doc, not itself a corpus artifact). `concept:plugin`'s Invariants ("every plugin carries the same suite version," "a plugin that would need the front door to special-case it has integrated wrong," "nothing in any plugin may assume a specific consumer project") say nothing about per-plugin sanctioned script languages at all — there is no existing invariant this issue could be said to already satisfy or violate. `decision:content-addressed-src-tag` (bearing, from `ok-workspaces`) records that plugin's script constraint explicitly — "the script stays POSIX shell with no dependency beyond git... so it can run in build and CI environments where node is absent" — demonstrating the corpus *does* have a place to record a tooling constraint with its rationale when one is a real decision, but that's a different plugin's decision about a different script's environment requirements, not evidence about what `ok-planner` should record. `concept:skill` and `concept:stack-profile` are silent on this question.

**What the code does today.** `plugins/ok-planner/CLAUDE.md` is a contributor-facing doc (Claude Code's own `CLAUDE.md` mechanism), not a `.ok-planner/design/` artifact — it sits outside the design corpus the planner's own rules govern, which is itself worth noting: this issue's evidence lives in a file the corpus's self-containment and current-state-only rules don't directly reach, since those rules bind `concepts/`, `stories/`, `decisions/` bodies, not arbitrary project docs.

**Candidates, and what each means.** The one filed candidate (amend `concept:plugin` Invariants to state the actual per-plugin tooling constraint including sanctioned script languages) would add a new invariant — something like "each plugin's script surface is constrained to the languages its `CLAUDE.md` names, kept current" — which fixes the corpus's *general* silence on the topic but doesn't by itself correct the specific wrong sentence in `plugins/ok-planner/CLAUDE.md`; that would still need its own edit ("No Node tooling; skills are markdown, hooks are bash, one script is Python 3" or similar). A shape not filed: treat this as a pure documentation fix scoped entirely to `plugins/ok-planner/CLAUDE.md`'s Constraints line, with no corpus delta at all, on the theory that a contributor doc's accuracy doesn't rise to a concept-level invariant — cheaper, and avoids extending `concept:plugin` (which the self-containment rule would require to stay implementation-enumeration-free — a list of "sanctioned script languages" risks reading as exactly the "enumerate current implementations" pattern the concept-specific tightening rule forbids).

**What the ruling must decide.** Whether the fix is a corpus change (a new `concept:plugin` invariant naming that per-plugin tooling constraints must stay accurate, or naming the constraint category generally) or a documentation-only correction to `plugins/ok-planner/CLAUDE.md`'s Constraints line — and, if corpus-level, whether naming "sanctioned script languages" in a concept body would itself violate the concept-altitude rule against enumerating implementations.

## Ruling

<!-- Owner: write your decision here in your own words.
The next /plan-sprint picks it up. Leave empty to discuss
it live in a planning session instead. -->

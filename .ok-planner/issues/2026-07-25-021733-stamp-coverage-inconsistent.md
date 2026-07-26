---
issue: stamp-coverage-inconsistent
kind: discover
category: inconsistent
artifacts:
  - concept:materialized-artifact
  - decision:per-project-pinning
status: verified
opened: 2026-07-25T02:17:33Z
---

# Version-stamp coverage and the no-content-comparison claim do not match practice

## Problem

The contract says drift is checkable 'without content comparison', yet the tag script check is byte-identity and the lint cheatsheet check is a byte compare of an unstamped file; stamp-based checking is fully realized for only some artifacts, and the stamping convention has three concrete shapes (prose line, template placeholder, code constant).

## Candidates

- Amend concept:materialized-artifact Invariants to state the actual mixed stamp/byte-identity checking model
- Standardize stamping across all materialized artifacts via a sprint and align the contract text

## Discussion

**The question.** Does the corpus's claim that materialized-artifact drift is checkable "without content comparison" match what the checking machinery actually does, and should stamping be standardized across every materialized artifact and shape?

**Where it comes from — a rot note.** The exact phrase "without content comparison" is not in any live design artifact; it is quoted `_discover/version-stamping.md` scaffolding text (point-in-time, exempt from the durable rules) paraphrasing an earlier read of the contract. The *promoted* decision, `decision:per-project-pinning`, already states the mixed reality plainly in its own Proof field: "Each plugin's diagnose phase fails on divergence between project copies and the installed plugin's canonicals — **stamp comparison and byte-identity checks**." So the specific tension the Problem describes — corpus claims stamp-only, practice does byte comparison — is *not* live at the decision level; it's a gap between an already-superseded `_discover` note and the current decision text, which already tells the truth.

**What remains genuinely open, re-verified against current code.** Independent of that rot note, three things the Problem raises are still real and unresolved:
- **Stamp coverage is uneven.** `plugins/ok-plumbline/skills/true-up/SKILL.md` materializes `.claude/rules/plumbline-cheatsheet.md` via `cmp -s "$canonical" "$target"` (line ~63) — a pure byte compare against a cheatsheet that carries no version stamp at all. Contrast `plugins/ok-workspaces/scripts/*.js`, whose `stamp()` writes `{{OK_WORKSPACES_VERSION}}` into materialized files for later stamp-based diagnosis, and ok-planner's `scripts/true-up`, which sed-stamps `{{OK_PLANNER_VERSION}}`.
- **The src-tag script's own proof is explicitly byte-identity, not stamp comparison.** `decision:content-addressed-src-tag`'s Proof states: "the plugin's diagnose phase compares the materialized script byte-for-byte against the version-substituted canonical" — a legitimate, deliberate design (the script's derivation must never silently vary), but it is a second, different checking model living beside the stamp model, with no artifact naming that two models coexist by design.
- **The stamping convention itself has at least three concrete shapes**: a prose stamp line (ok-planner's materialized `CLAUDE.md`, e.g. "Materialized by ok-planner vX.Y.Z"), a template placeholder substituted at materialization time (`{{OK_PLANNER_VERSION}}`, `{{OK_WORKSPACES_VERSION}}`, `{{OK_PLUMBLINE_VERSION}}`), and a rewritten code constant (`const VERSION = '0.0.0-unvendored'` rewritten to the real version during plumbline binary vendoring). Nothing in the corpus names these as the sanctioned three shapes or explains why they differ by artifact type.

**What the corpus says.** `concept:materialized-artifact`'s Invariants state only the general properties — "every materialized artifact records the version of the plugin that wrote it" and "diagnosis verifies fidelity against the canonical copy for the installed version" — true in spirit but silent on *how* fidelity is verified (stamp comparison vs. byte-identity) and silent on the cheatsheet gap. `decision:per-project-pinning` already names the mixed model in its Proof field (see above) but doesn't explain *why* some artifacts get byte-identity checks and others get stamp checks, nor does it flag the unstamped cheatsheet as an outlier. `concept:content-addressed-tag` is a distinct concern — artifact identity for verification paths (src-tag), not plugin-version stamping — and doesn't bear on cheatsheet or hook stamping. `concept:integration-contract` names "version stamps" as one of its layers but at the taxonomy level, without committing to one checking mechanism.

**Candidates and their tradeoffs, undecided:**
- *Amend `concept:materialized-artifact` Invariants to state the actual mixed model explicitly* (some artifacts stamp-checked, some byte-identity-checked, and why). Costs nothing but honesty — it doesn't change any code, and leaves the plumbline cheatsheet's total absence of a stamp as a named, accepted gap rather than a silent one.
- *Standardize stamping across all materialized artifacts via a sprint*, giving the plumbline cheatsheet a stamp line and picking one canonical shape (or explicitly naming the three shapes as the sanctioned set, one per artifact type). Real work across three plugins' true-up skills, and forces a decision on whether byte-identity checks (src-tag, currently deliberately strict) should be loosened to stamp-based once a stamp exists, which would be a second, separate tradeoff (looser check, easier partial edits going undetected) folded into what looks like a purely mechanical cleanup.

**What the ruling must decide.** Whether the corpus should simply describe the mixed stamp/byte-identity checking model as it already exists (a documentation-only fix), or whether a sprint should first standardize stamp coverage and shape across every materialized artifact — including giving the plumbline cheatsheet a stamp — before the corpus describes the (then-uniform) result.

## Ruling

<!-- Owner: write your decision here in your own words.
The next /plan-sprint picks it up. Leave empty to discuss
it live in a planning session instead. -->

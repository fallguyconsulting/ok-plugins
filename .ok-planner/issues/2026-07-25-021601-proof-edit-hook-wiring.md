---
issue: proof-edit-hook-wiring
kind: discover
category: proof
artifacts:
  - decision:edit-hook-blocks-in-turn
status: verified
opened: 2026-07-25T02:16:01Z
---

# Edit-hook wiring (change-scoping, fail-open) is untested

## Problem

The lint binary's exit codes are fixture-tested, but the hook's changed-line scoping and fail-open degradation paths have no automated check; a regression there would surface only as user-visible behavior.

## Candidates

- Amend decision:edit-hook-blocks-in-turn Proof to include hook-level checks once they exist
- Accept binary-level testing as sufficient and record the wiring as unchecked

## Discussion

**The question.** Should `decision:edit-hook-blocks-in-turn`'s proof obligation be widened to require an automated check on the hook wiring itself — the changed-line scoping and the fail-open degradation paths — or is exercising the lint binary alone (the status quo) sufficient corpus-level proof, with the wiring left permanently, explicitly unchecked?

**Evidence, re-verified against current code.** The filed Problem holds up and, on inspection, understates the gap slightly. Enforcement is split per `decision:hook-shims` into a plugin-root shim (`plugins/ok-plumbline/hooks/post-edit.js`, resolves the project root and execs) and the materialized logic (`plugins/ok-plumbline/scripts/hooks/post-edit.js`, the template for a consumer project's `.ok-plumbline/hooks/post-edit.js`) — this split already existed when the issue was filed, so it isn't rot. The materialized hook reads the `PostToolUse` event JSON off stdin, walks up from the edited file to find `.git`, computes changed-line ranges by parsing `git diff -U0 HEAD -- <file>` hunk headers for tracked files (untracked files get no `--lines` flag and are checked whole), locates the vendored `bin/plumbline`, and spawns it. Every fail-open branch the decision's Choice names is present: malformed/missing stdin JSON, a missing target file, no `.git` root found, no vendored binary, and a `spawnSync` error — each exits `0` (pass) rather than propagating failure. The plugin's only test suite, `plugins/ok-plumbline/test/run.sh`, invokes `bin/plumbline` directly against 12 fixture directories (clean, license-header, machine-directives, docstring-opted-in/not-opted-in, citation-file/glob-resolved/unresolved, regex-literals, disallowed-comment, comment-after-regex) — it never runs either `post-edit.js`, never builds a `PostToolUse` event, never sets up a git repo with a diff to exercise the hunk-parsing, and never simulates a missing binary or spawn failure. So none of the wiring code is touched by any automated check today, not just the two paths the issue names.

**What the corpus says.** `decision:edit-hook-blocks-in-turn`'s own Proof field already states the gap in these words: "The hook wiring itself (change-scoping, fail-open paths) has no automated check; that gap is filed to the intake queue" — the decision names the hole and points at this issue; it does not resolve it. `decision:falsifier-exhibition` sets the bar any new check would have to clear to count as real proof: non-vacuous only when its declared falsifier is actually exhibited (mutation applied, red confirmed, reverted, green confirmed) — so if the decision is amended to claim hook-level proof, whatever backs it needs a producible falsifier (e.g. a violation planted inside vs. outside a changed range, or a binary deliberately removed), not a shape-only assertion. `story:edit-time-lint-enforcement` — not cited in this issue's `artifacts:` but the same surface from the user side — carries the identical, equally unautomated gap in its own Proof field: "Demo — ... a clean edit to a file with old violations passes, and disabling the vendored binary shows the session degrade to silence rather than error." Nothing promotes this issue for that story, so a ruling here does not by itself change it, but the owner may want to weigh them together. `decision:comments-forbidden-by-default`, a sibling decision, states its Proof as "asserted by the plugin's fixture test suite" at the binary level only, with no wiring claim and no gap called out — the corpus already treats binary-only proof as sufficient for at least one decision without flagging it, which bears on whether binary-only proof is this project's working convention or an oversight specific to this decision. `decision:hook-shims` carries a structurally identical, one-level-up gap (shim-shape conformance rather than enforcement behavior), tracked in its own sibling issue (`proof-hook-shims`, out of scope here) — there are at least two open "the wiring around the binary is unchecked" gaps in the project, which may bear on whether the owner wants one wiring-harness investment to close both or wants them ruled independently. `concept:story-artifact`, `decision:ratchet-over-soft-start`, and `story:incremental-lint-adoption` do not bear on this question — they govern proof-intent generality and the backlog-ratchet mechanism respectively, neither speaks to whether hook wiring itself needs automated coverage.

**Candidates.**

- *Filed — amend the decision's Proof to include hook-level checks once they exist.* Requires a harness that actually invokes the hook with a crafted `PostToolUse` JSON event against a real or fixture git repo, asserting: a violation inside a changed range blocks (exit 2), a violation outside a changed range on a tracked file passes, an untracked file is checked whole, and each fail-open path (bad JSON, missing file, no `.git`, no binary, spawn failure) exits 0. Once built and wired into `test/run.sh` (or a sibling), the Proof field is rewritten to name it — closing the gap the decision currently self-reports. Real but bounded work: a small git-fixture harness plus a handful of new cases.
- *Filed — accept binary-level testing as sufficient, record the wiring as unchecked.* Rewrite the Proof field to state the wiring is not mechanically proven, as a permanent boundary rather than an open gap, dropping the "filed to the intake queue" language. Consistent with `decision:comments-forbidden-by-default`'s binary-only proof scope. Tradeoff: the decision's Choice makes three guarantees (blocks in-turn, scoped to changed lines, fails open) but only the first is proven at all — the other two, which the decision's own Rationale singles out as the ones that make strict enforcement livable and safe ("failing open ... means the check can only ever block on genuine findings, never break a session"), would stay permanently unproven by design rather than by current gap.
- *A shape not filed, surfaced by this reading — split the gap instead of ruling it as one lump.* The changed-line-range parsing (`git diff -U0` hunk-header parsing) is a pure function of diff text and could be unit-tested cheaply without any hook-invocation harness at all. The fail-open paths, by contrast, are properties of the surrounding environment (missing stdin, missing binary, spawn failure) and need the fuller harness to exhibit. This would let the owner accept binary-only proof for the blocking behavior while still mechanically closing the cheaper, more tractable half (scoping) now — a middle option the two filed candidates don't distinguish between, since both treat "hook wiring" as a single thing to prove or not.

**What the ruling needs to decide.** (1) Does the decision's Proof field stay as a self-acknowledged gap pending a future hook-level harness (first candidate), get rewritten to formally accept binary-only proof as the permanent boundary (second candidate), or get split so scoping is proven now and fail-open is decided separately (third candidate)? (2) If any hook-level proof work is authorized, should the same pass also close the identically-shaped gap on `story:edit-time-lint-enforcement`'s Proof field and/or the sibling `decision:hook-shims` gap (issue `proof-hook-shims`), or should those be ruled and worked independently?

## Ruling

<!-- Owner: write your decision here in your own words.
The next /plan-sprint picks it up. Leave empty to discuss
it live in a planning session instead. -->

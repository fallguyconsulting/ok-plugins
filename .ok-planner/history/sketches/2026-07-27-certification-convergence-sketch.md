# Certification Convergence Hardening — Design Sketch

**Date:** 2026-07-27
**Status:** Sketch (not a sprint; not authorization to build)

## Idea

The plumbline ESM sprint's certification ran three fix cycles for a
four-file change. The post-mortem found the cascade was scoping, not
substance: the change itself produced two genuine findings, both caught
in cycle one; everything else was pre-existing corpus debt dragged in
because `certify-work` derives its touched-artifact set at file
granularity — any annotation anywhere in a changed file counts as
touched. Eight of the ten artifacts swept were incidental. Five
remedies came out of the post-mortem; this sketch gives them enough
shape to plan from. The goals in tension: keep thorough coverage and
automatic drift correction, without the failure mode of agents
oscillating over interpretable minutiae across closes.

## Shape

**1. Hunk-granular touched-set derivation (the root-cause fix).**
`certify-work`'s Scope section currently defines touched artifacts as
"every `@concept:` / `@story:` / `@decision:` slug annotated in a
changed file". Replace the file-granular sweep with a segment model:

- Enumerate changed line ranges per changed file from the diff
  (`git diff -U0` over the subject — staged, unstaged, or range),
  the same mechanism the plumbline edit hook already uses to lint
  only changed lines.
- Enumerate annotation sites with `rg -n`. Each annotation owns the
  segment from its own line down to the next annotation line in the
  file (or EOF). A top-of-file annotation block above any code
  therefore still covers everything to the next annotation — header
  annotations keep their file-labeling role without making every
  edit touch them all.
- An artifact is touched when a changed hunk overlaps its segment
  (or its design file changed directly, or the sprint names it —
  those two clauses stand unchanged).

Downstream scopes (compliance review, prove, the re-audit union,
scoped consistency) all derive from the touched set and need no
change of their own. Applied to this run, the incidental sweep drops
from 8 artifacts to 0: the new ESM test case sits under its own
annotations, so only `materialized-artifact` and
`integration-contract` would have been touched.

**2. One deliberate whole-corpus close.** After remedy 1 lands, run
`/certify-all` once, on purpose, to pay down the remaining latent
compliance debt corpus-wide (the historical clauses and TOC drift this
run absorbed were exactly such debt — the v11.0.0 close reconciled
audits but no whole-corpus compliance sweep is in evidence). With the
scoping fix in first, change-scoped closes stop being the first gate
old defects meet, and the one big sweep happens when attention is
budgeted for it, not mid-sprint.

**3. Binding audit precedent.** The implementation-auditor prompt
(`skills/_shared/implementation-auditor.md`) already has auditors read
the prior audit file for navigation. Add one obligation: an uncharged
observation recorded in the prior audit's Determination is precedent —
a re-audit departs from it only when the cited reality changed, and
says what changed. This run showed the mechanism working by luck (two
independent auditors declined to charge the unstamped module marker,
both writing the reasoning); the prompt line makes it discipline
instead of temperament, closing the seam where a determination could
flip across closes with no change in the code.

**4. The unstamped-marker ruling.** Already in the intake, ruled:
`materialized-artifact-stamp-fixed-content` — amend the
`materialized-artifact` invariant so a fixed-content artifact (bytes
invariant across suite versions) is verified by exact content rather
than a version stamp. The sprint pulls the ruled issue and drafts the
corpus delta; nothing further to design here. It is the concrete
instance of the seam remedy 3 closes in general.

**5. Oscillation detector.** A small deterministic check over git
history that flags the two tells the post-mortem named:

- An audit file whose `determination:` flipped between two commits
  while its `artifact-hash:` and citation lines did not change —
  opinion drift, not reality drift.
- The same region of a design file edited in consecutive sprint-close
  commits (`closed:`-stamped archives give the commit list) —
  agents re-wording the same lines close after close.

Simplest home: a new script under the repo-root `checks/` (maintenance
material, runs in `checks/run`), reading history only — no estate
writes, no distribution question. Promotion into the planner family
for consumers can wait until the detector proves useful here.

## Open questions

- Segment model edge: a file's header annotation block (e.g. the test
  harness's three `@story:` lines) covers only down to the next
  annotation. Editing an unannotated region *below* a later annotation
  never touches the header stories — correct for scoping cost, but it
  means a proof edit only re-proves the story whose segment it falls
  in. Is that acceptable, or should proof files (files whose header
  carries `@story:`) keep file-granular touch for the prove producer
  specifically?
- Does remedy 1 apply to `certify-all` too? Its producers are
  whole-corpus by definition, so likely no change — confirm the shared
  core text doesn't restate the touched-set rule anywhere else.
- Remedy 5's "same region" needs a concrete definition — line-range
  overlap between the diffs of consecutive close commits is the
  obvious one; hunk headers may be enough.
- Remedy 3's precedent rule needs a boundary: precedent binds
  re-audits of the *same* claim, but must not stop a new claim (from
  an amended artifact) from being charged fresh.

## Risks / unknowns

- Under-scoping is the mirror risk of the cascade: a hunk-granular
  touched-set that misses a genuinely implicated artifact trades noisy
  thoroughness for silent gaps. The segment model leans on annotation
  placement discipline ("annotation at the most-specific load-bearing
  site"), which is only as good as rollout so far.
- The `cite-file` population pins stay deliberately coarse; edits to
  hot pinned files (the converge script, the test harness,
  `checks/text-presence`) will still fan out re-audits. That cost is
  by design (quantified claims must re-audit), but it means remedy 1
  shrinks only the annotation-driven half of the cascade, not the
  pin-driven half.
- The oscillation detector can false-positive on legitimate rapid
  iteration (two sprints genuinely reshaping the same artifact).
  It should report, not block.

## What this is not

- Not a change to the fix loop's no-discretion discipline, the veto
  test, or the architect gate — those held up well this run (findings
  8 → 2 → 0, zero kickbacks, no reverts).
- Not a proposal to soften `cite-file` pins or the adversarial bias of
  audits.
- Not the corpus delta for the invariant amendment — that is the ruled
  issue's business, drafted by `/plan-sprint`.

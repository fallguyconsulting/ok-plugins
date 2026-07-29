---
name: certify-work
description: "ONLY activated by explicit /certify-work slash command, or as the terminal step named in the sprint document's execution boilerplate. Never auto-triggered by conversation content. Change-scoped certification: certifies the work just done — the uncommitted tree by default, a commit range on request — running the sprint-alignment judge, prove, the implementation audits (the re-audit set from citation staleness plus adjudicated change-inspection nominations, coverage included), and the code review over the diff, a no-discretion review-fix loop (fixer, then an architect on kickbacks), and the presentation — reconciliation ledger included — with archival/commit offered as owner acts. Whole-corpus certification is /certify-all."
---

# Certify the Work (the change-scoped gate)

The "am I done?" gate for an implementation goal, **scoped to the change**. Where `/certify-all` pays for the whole corpus on every run, certify-work's cost is proportional to the work being certified: it proves only the stories the change touched, checks only the artifacts and annotations the change reached, and reviews only the diff. This is the everyday close — the one the sprint boilerplate names — and it discharges the sprint's completion contract, which is itself stated in touched-scope terms. Corpus-wide drift that predates the change is `/certify-all`'s business (run it on a cadence), not every close's.

Everything that is not scope is shared verbatim with `/certify-all` and defined once in `skills/_shared/certification-core.md`: the review-fix loop and its veto test, the fixer and architect subagents, the code-review prompt, the presentation. The two gates differ only in what they look at.

## Scope

**Default — the uncommitted working tree.** `git status` and `git diff` (and `--staged`): new, modified, and deleted files, staged or not.

**On request — a commit range.** If the invocation carries an argument that parses as a git range or ref (`main..HEAD`, `v8.0.0..`, `abc123..def456`), the subject is that range's diff (`git diff <range>` + `git log <range>` for the story of the work) **plus** the uncommitted tree, so nothing in flight is skipped. Use this to certify work that was committed along the way.

**The touched set**, derived once and used by every stage below:

- **Changed files** — from the diff.
- **Touched artifacts** — design files changed directly, plus every artifact a sprint-in-scope's deltas and work items name. Code annotations play no part in this derivation or in any invalidation below (per `decision:two-layer-invalidation` in consumer corpora authored against this suite): annotations keep proof registration (`@story:` on proof artifacts) and navigation, nothing else — what a change puts in question is computed from citations and the change itself.
- **Touched stories and decisions** — the story/decision subset of the touched artifacts. The stories are the prove scope; both kinds seed the implementation-audit producer's re-audit set.

## Process

1. **Ensure the layout.** Run `mkdir -p .ok-planner/issues .ok-planner/history/issues` — and, where `.ok-planner/design/` exists, `mkdir -p .ok-planner/audits/stories .ok-planner/audits/decisions .ok-planner/history/audits` — so the intake and the audit corpus buckets exist. Estate convergence is the front door's administration (`/ok`), not this gate's.

2. **Resolve scope** per the Scope section: subject (tree or range+tree), then the touched set. If a sprint is named as an argument, that is the alignment target; else if exactly one sprint is in flight under `.ok-planner/sprints/`, use it; else there is no sprint and the alignment producer is skipped.

3. **The review-fix loop.** Run `{{CERTIFY-REVIEW-FIX-LOOP}}` from `skills/_shared/certification-core.md` — initial review by every producer, then fixer → architect → re-review cycles to clean or the cap. On each re-review, the implementation-audit producer's scope is recomputed in both layers: the graph is regenerated and `audit-check --list-stale` names every audit the fixer's edits disturbed (the fixes move the hashes of cited nodes and anchors, so the mechanical set after a fix cycle is deterministic, and may include artifacts no earlier cycle audited), and the change inspector re-runs over the then-current diff to nominate what citations cannot see. This gate's producers, each at change scope:

   - **Sprint alignment** (only with a sprint in scope) — the corpus-change judge. Dispatch `{{SPRINT-ALIGNMENT-PROMPT}}` from `skills/_shared/certification-core.md` with `[SPRINT PATH]` filled: deltas applied verbatim, every work item's outcome realized (an undershoot is a **blocking** finding), and the changed corpus coherent with the live corpus — consistency lives here because contradictions arise exactly when deltas land, and mid-cycle corpus edits by the fixer or architect are checked here too. (Delta compliance was already reviewed at `/plan-sprint` sign-off; whole-corpus hygiene is `/certify-all`'s.)
   - **Prove, touched scope.** Invoke `ok-planner:prove` scoped to the touched stories (its caller-scoping is built in). Every non-pass verdict — `missing` / `failing` / `unrunnable` — is a finding for the loop. If the touched set has no stories, this producer passes empty.
   - **Implementation audit, two layers.** Where the project carries a committed source graph, regenerate it first — `.ok-planner/bin/source-graph build` — so citations are judged against the tree as it stands (the graph is generated state; regenerating is always safe), and treat a non-zero `source-graph check` before the rebuild as expected when the change touched sources. **Mechanical layer:** run the vendored `.ok-planner/bin/audit-check --list-stale` repo-wide (it is cheap and deterministic). **Judgment layer:** dispatch `{{CHANGE-INSPECTOR-PROMPT}}` from `skills/_shared/certification-core.md` with `[CHANGE SCOPE]` filled with this gate's subject; it records nominations as provisional notes on the audits they implicate and dispositions every hunk into the reconciliation ledger. The **re-audit set** is the union of: the touched stories and decisions, every ref the checker lists (stale, missing — including audits *outside* the delta whose cited code or population sources this change happened to touch), and every audit the inspector nominated — and nothing else; code annotations play no part in it. Dispatch `{{IMPLEMENTATION-AUDITOR-PROMPT}}` from `skills/_shared/implementation-auditor.md` over that set, split by triage class per its own consumer rules — full-pass batches for refs whose artifact hash moved, which carry nominations, or which have no audit yet; sonnet refresh batches for citation-only staleness, with every `escalate:` line re-dispatched into a full-pass batch and every `needs-demonstration:` line satisfied by the gate running the named demonstration itself (via `prove` where it is a story proof) and re-dispatching the ref with the result recorded — auditors never execute; the auditor adjudicates every open note on the audits it touches and reports per-artifact determinations with each ref's outcome (refreshed / amended / rewritten). Every `violated` line is a finding for the loop, and `audit-check`'s own findings (malformed, orphaned, dangling links, graph-missing, graph-stale) are findings too. This producer's clean bar: `audit-check --inspection` exits 0 (citations current AND every changed node dispositioned — the mechanical proof the judgment pass ran against the change as it stands), invoked as `--inspection=<base>` with the range's base ref where this run's subject is a commit range, so the floor judges the committed half of its own subject too; `source-graph check` exits 0 where a graph exists, no in-scope determination is `violated` without an issue link, no provisional note is left `open` on an audited file, and no ledger hunk is without a disposition.
   - **The mechanical floor** (inline, no subagent): **annotation integrity** — `rg -n '@(concept|story|decision):\s*\S+'` over the changed files, every (kind, slug) pair resolving to a live artifact — and **proof existence** — each touched story has at least one annotated proof artifact in code (whether the proofs *span* the story's decidable claims is the auditor's coverage charter). Consistency of the changed corpus rides the alignment producer above; delta compliance was paid at `/plan-sprint` sign-off; all-pairs consistency and whole-corpus compliance are `/certify-all`'s job.
   - **Code review, scoped to the diff.** Dispatch `{{CERTIFY-CODE-REVIEW-PROMPT}}` from `skills/_shared/certification-core.md` with `[REVIEW SCOPE]` filled as:

   ```
   The change under certification: [the uncommitted working-tree
   change | the diff of <range> plus the uncommitted tree]. Enumerate
   it with git status/diff before forming findings; code deleted in
   the change is gone — do not form findings about it. Read changed
   files in full for context.

   Findings are confined to the change and what it directly breaks:
   a defect in changed code, a caller the change breaks, a
   load-bearing property the change trades away. A pre-existing
   defect is in scope only where the change touches or depends on
   it — do not sweep unrelated files, and do not follow trails out
   of the change's footprint. Corpus-wide and repo-wide sweeps
   belong to /certify-all.
   ```

   One scope rule for the fixer and architect: a fix may of course edit any file the correct fix requires, but findings stay change-scoped — the loop is not a license to re-audit the repository.

4. **Verify the promoted issues** — if the architect promoted any or the cap escalation filed any. Invoke `ok-planner:verify-issues`; it makes everything filed this run ruling-ready (and skips the already-verified intake). Zero filings → skip, silently.

5. **Present.** Compose and deliver `{{CERTIFY-PRESENTATION}}` from `skills/_shared/certification-core.md`. The per-producer "Findings fixed" lines for this gate: alignment (the corpus-change judge), prove (touched), implementation audit (re-audit set, with flipped determinations, adjudication outcomes, and coverage findings counted), the mechanical floor, code review. The Reconciliation ledger section reports the final inspection's dispositions and enumerates the residue.

6. **Offer the close-out.** If a sprint was in scope and everything certified clean, end the presentation with the standing offer: archive the sprint (move it to `.ok-planner/history/sprints/`, together with its completion report and with every issue file under `.ok-planner/issues/` whose frontmatter `sprint:` names this sprint — `status: promoted` receipts that move to `.ok-planner/history/issues/` when the implementation closes) and commit the work. Perform either only when the owner says so; never move the sprint or commit uninvited. On the owner's yes, after the archive commit lands, stamp the archived sprint with the closing commit — a YAML frontmatter block prepended at the very top of the file (`---`, `closed: <sha of the archive commit>`, `---`), or a `closed:` line added to its existing frontmatter — and make one small follow-on commit for the stamp. That stamp is the baseline `/plan-sprint`'s out-of-band reconciliation phase reads; a close without it leaves the next ceremony blind to what landed after this one. Leaving the sprint at its `sprints/` path until the owner accepts is what lets a `/goal` keyed to that path verify completion. The cap changes none of this: remainders the owner chose to escalate — the choice is always theirs — are verified issues like any others, and the presentation and close-out offer proceed normally.

## When to reach for /certify-all instead

- Before a release, or after several sprints have closed through this gate.
- When the change touches the canonical rules the corpus checks enforce (e.g. `skills/_shared/artifact-definitions.md` in this repo's case) — a change-scoped check cannot see the corpus-wide fallout of a rule change.
- Whenever drift is suspected that no recent change explains.

## What this skill does NOT do

- Does not run whole-corpus `/prove` or `/audit` — that is `/certify-all`, on the owner's cadence, and this gate's presentation may recommend one when the corpus checks keep finding drift the change didn't cause.
- Does not widen scope mid-run. A finding outside the change's footprint that isn't caused or depended on by the change is not this gate's finding; if it matters, a human files it to the intake — it is not a fix to chase.
- Does not triage or defer findings. Every finding enters the review-fix loop; the orchestrator holds no "acceptable" bucket, and the intake is reached only by the two gated paths — the architect's confirmed forks, and the remainders escalated at the cap.
- Does not ask the owner questions mid-cycle. A genuine fork is promoted by the architect, made ruling-ready by `/verify-issues`, and listed in the presentation; every other finding is fixed. The one sanctioned touchpoint is the cap, and what it puts to the owner is not a question about a finding but a choice reserved to them — another cycle, or escalate the remainders as issues. Every run stops there and waits for their word, however long that takes, attended or not; the gate never takes either cap step itself.
- Does not archive or commit on its own initiative. Certification ends at a clean, presented working tree with the sprint still at its `sprints/` path; the presentation closes by offering both, and only the owner's word triggers either. An uncertified sprint gets no offer at all.
- Does not plan or build new scope. It certifies what the goal produced; a gap it cannot fix by driving findings to clean is surfaced, not filled with net-new work the sprint never promised.

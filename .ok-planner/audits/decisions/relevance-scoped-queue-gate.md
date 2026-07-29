---
audit: relevance-scoped-queue-gate
artifact: decision:relevance-scoped-queue-gate
determination: satisfied
audited: 2026-07-29T07:15:00Z
artifact-hash: sha256:3a4799b8ddc2
---

# Does the planning ceremony draft first, split the unruled open issues by relevance, walk only the bearing ones one at a time with corpus surfaced first, treat the count as information, tiebreak toward bearing, and invert for intake-drain sessions?

## Claims

**Why this is a re-audit, and what moved.** The design artifact is unchanged (hash identical)
and `audit-check` reports no finding against this file — every `cite:` anchor resolves and both
`cite-span`s re-derive to their recorded hashes. The audit is open because certification's
change inspector nominated it: the ceremony section this decision's Choice is about
(`4-the-issue-intake.relevance-pass-feature-work-sprints`) changed content at HEAD while no
citation here could see it. I confirmed the drift independently rather than taking it on
report: the committed graph's node hash for that section is `272733f60d7c` where the graph
committed at HEAD recorded `dbe77461acbd`, and `git show 53f6718` on the ceremony shows what
moved — the release added `{{READ-ONLY-REVIEWER-RULE}} (same source)` to *both* reviewer
dispatches, this decision's relevance reviewer included, plus unrelated edits in §2 and the
execution boilerplate. Every claim below was re-read from the ceremony in full.

Refreshed. The one stale citation is the whole-file pin on `checks/text-presence`,
which moved because a sibling decision's needles (`no-execution-engine`'s) were
repointed elsewhere in the same file; the three sentences this decision's own
`cite-span` asserts are untouched (that span did not go stale). Citation
regenerated; nothing else touched.

**Title — "The intake gates planning by relevance, not at the door."** The ceremony's ordering
is the check. §1 reads the intake only to split ruled from unruled and pull the ruled in, and
says in the same paragraph "Do **not** present the unruled ones yet"; the relevance treatment
is §4, after the §3 draft exists. Nothing between §0 and §3 blocks on the intake. Honored.

**Choice clause 1 — "A feature-work planning session drafts the sprint first."** The
session-shape fork sends a feature-work sprint to §2 → §3 and states the intake is *not* the
agenda beyond the ruled sweep; §4's feature-work branch names the pass as running "over the §3
draft and the unruled open issues only", and the dispatch's Inputs block requires a
`Draft sprint: [path]`. The draft is an input the pass cannot run without. Adversarial check,
re-run against the drifted file: §1b's out-of-band reconciliation *does* run before §2/§3 and
can file a new issue, but that is a git-window walk over changes, not the intake relevance
pass, and an issue it files simply joins the unruled population §4 later reads. Its reviewer's
population is the git window, not `.ok-planner/issues/`. No inversion of the clause. Honored.

**Choice clause 2 — "a dedicated relevance reviewer then splits the unruled open issues into
bearing and independent."** §4 dispatches a separate agent whose stated job is deciding
bearing-vs-independent, with "it never resolves anything" in the same sentence and an
Anti-padding block that forbids proposing resolutions, candidates, or corpus deltas. Its
Inputs name the population exactly as the artifact's wording does — "files under
`.ok-planner/issues/` with status open or verified and an empty Ruling section" — i.e. the
unruled set, ruled issues already having been carried in at §1 and explicitly never
re-entering discussion. Output is a per-issue `BEARS | INDEPENDENT` line behind a
`Status: N bearing | M independent` line. (A different reviewer, §1b's out-of-band one, uses a
similar-looking status line — `Status: N bearing | ambient remainder` — over a git window; it
is not this pass and does not read the intake.) **The drift the nomination flags strengthens
this clause rather than weakening it**: the dispatch now also transcludes
`{{READ-ONLY-REVIEWER-RULE}}`, which I read at its source — it confines the reviewer to
reads, searches and git inspection, forbids running anything, and directs it to report a
needed demonstration rather than perform one. That is the "it never resolves anything"
constraint reinforced at the execution layer. Honored.

**Choice clause 3 — "and only the bearing ones are walked with the owner — one at a time, with
the corpus artifacts relevant to each surfaced first."** The feature-work branch says to "walk
only the issues it returns as bearing". The walk section opens with the mandatory surfacing
step — run the surfacer on the issue file and read each surfaced artifact in full, with an
explicit instruction to flag rather than proceed blind when it prints nothing — and only then
walks the in-scope issues "**one at a time** (never as a wall)". Order and granularity both
match; issues left out of scope get no stamps and no prose. Adversarial check: the ceremony
adds "The owner may pull an independent one into scope; they never have to." That is not the
ceremony walking an independent issue on its own initiative — it is owner authority, and it is
the same authority clause 4 grants explicitly. It does not weaken the default. Honored.

**Choice clause 4 — "The open count is information, not a gate."** §1 directs telling the owner
the counts and states in the same sentence that the count is information, not a gate, and that
the owner may always widen scope to the whole intake. Nothing downstream conditions proceeding
on the count; §4 closes with "An empty intake, or a relevance pass that returns nothing bearing,
passes silently." Honored.

**Choice clause 5 — "the reviewer's tiebreak is fixed: when it cannot tell, it answers that the
issue bears."** The dispatch carries "When you cannot tell, answer BEARS." verbatim, followed by
the artifact's own justification for it (a needless conversation costs a minute; a silently
decided question costs a rewrite). Honored.

**Choice clause 6 — "Intake-drain sessions invert this: there the intake is the agenda."** Both
forks say so: §1's session-shape entry states an intake-drain sprint's purpose *is* working the
issue intake, that the intake is the agenda, and that §4 runs *now*, before §2 and §3, with the
sprint drafted from what the resolutions imply; §4's own scoping states an intake-drain sprint's
scope is every unruled open issue (or the named batch) with no relevance pass, going straight to
the walk. Honored.

**Rationale capability claim — "building over a bearing issue decides it silently, while an
independent issue costs the sprint nothing by staying open."** §4's opening states the first half
as the single reason unruled issues matter to a sprint ("building over an open issue decides it
silently") and the second half as the rule for leaving independent issues untouched in the
intake; the closing paragraph enforces it — issues left out of scope are left strictly alone, no
stamps, no editorializing, no summary prose. The reviewer's BEARS test is written from the same
premise, with "the implementer would have to pick, and the pick would stand as the project's
answer" marked as the central case. Honored.

**The maintenance check that holds three of the governing sentences in place — a correction to
the previous determination.** `checks/text-presence` asserts this decision's three sentences
(the feature-work relevance-pass sentence, the reviewer-dispatch sentence, the BEARS tiebreak)
in the block carrying its `@decision:` annotation. All three are present, verbatim and exactly
once each, verified by fixed-string search this cycle, and the `cite-span` over that block
re-derives unchanged. The previous determination's statement that "that check is green" is,
however, no longer true of the check *as a whole*: run on this tree it exits 1, on the
`no-execution-engine` block — two governing lines it asserts against the same ceremony file
("It is never rewritten into a plan document", "Staging lives in the executor's working
state") were reworded by the v11.2.0 execution-boilerplate edit. That is a finding against a
different decision, reported to the gate as such, and it does not touch any claim here; but it
is why this audit no longer rests on the check's exit code and rests on the three assertions
themselves.

## Determination

**satisfied.** The ceremony implements the gate as the Choice states it: draft first, a
dedicated reviewer over the unruled set only with no resolution authority, the walk restricted
to the bearing return, corpus surfaced before each issue is put to the owner, one issue at a
time, the count reported as information, the tiebreak fixed at BEARS, and the intake-drain
inversion spelled out on both forks. The one content change inside the nominated section since
the last pass — the read-only reviewer rule now transcluded into the relevance dispatch —
reinforces the clause it lands on. The two places the ceremony goes beyond the Choice (§1b's
out-of-band walk ahead of the draft, and the owner's option to pull an independent issue into
scope) were re-tested against the clause text and neither contradicts it.

This stops holding if: the relevance pass moves ahead of the §3 draft or is made to read the
ruled set as well as the unruled; the reviewer is given resolution authority or merged into the
walk; the surfacing step is dropped or demoted below the presentation; the walk stops being
one-at-a-time; the count becomes a precondition for proceeding; the BEARS tiebreak is removed
or inverted; or the intake-drain branch stops taking the intake as its agenda. Mechanically:
the `cite-node` pins now placed on §4 and its two subsections break on any edit inside the
claimed territory — including one no text anchor would notice — and the `cite-span` on the
checked block in `checks/text-presence` breaks if any of the three asserted sentences changes.

## Citations

- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "Read the intake: every file under"
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "the owner's purpose *is* working the issue intake"
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "The count is information, not a gate"
- cite-node: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md#sprint-planning.process.1-frame-the-session @ sha256:253bb51b8d56
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "Unruled open issues matter to this sprint for exactly one reason"
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "Intake-drain sprint** — scope is every unruled open issue"
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "run the relevance pass below over the §3 draft"
- cite-node: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md#sprint-planning.process.4-the-issue-intake @ sha256:37d5a4e25e3c
- cite-span: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "Dispatch a dedicated reviewer. It decides bearing-vs-independent" +3 sha256:2e568270f1c7
- cite-node: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md#sprint-planning.process.4-the-issue-intake.relevance-pass-feature-work-sprints @ sha256:272733f60d7c
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "Unruled open issues (files under"
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "When you cannot tell, answer BEARS."
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "Status line first: `Status: N bearing | M independent`."
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "Report the split to the owner in one line"
- cite-node: plugins/ok/families/ok-planner/skills/_shared/dispatch-discipline.md @ sha256:acb7a2417dd3
- cite: plugins/ok/families/ok-planner/skills/_shared/dispatch-discipline.md :: "### {{READ-ONLY-REVIEWER-RULE}}"
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "Before presenting each issue, surface the design corpus that likely bears on it"
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "Only then walk the in-scope issues with the owner"
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "Issues left out of scope are left strictly alone"
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "An empty intake, or a relevance pass that returns nothing bearing, passes silently."
- cite-node: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md#sprint-planning.process.4-the-issue-intake.the-issue-walk @ sha256:0f44a8fef2d8
- cite-span: checks/text-presence :: "# @decision: relevance-scoped-queue-gate" +16 sha256:4f40e97b72b0
- cite-node: checks/text-presence @ sha256:3f0942864be5

## Notes

- note: `plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md` moved substantially in the source-graph-certification sprint — the `4-the-issue-intake.relevance-pass-feature-work-sprints` node this decision's claim is about changed hash, plus new sibling sections landed nearby (`1b. Reconcile out-of-band work`, a rewritten mechanically-verifiable completion contract, a new "keep the completion report current" step) — and every citation here is a `cite:` text-presence match or a `cite-span` pinned elsewhere in the file, never a node hash on the relevance-pass section itself, so the section's own drift could not trip staleness.
  adjudication: promoted — the nomination is right on the mechanism and right on this cycle's facts. I confirmed the drift independently (committed graph node `dbe77461acbd` → `272733f60d7c`; `git show 53f6718` shows `{{READ-ONLY-REVIEWER-RULE}} (same source)` added to the relevance dispatch), so a content change did land inside this claim's own territory with no citation able to see it. The claimed territory is now pinned by node — `#sprint-planning.process.4-the-issue-intake @ sha256:37d5a4e25e3c`, `#…4-the-issue-intake.relevance-pass-feature-work-sprints @ sha256:272733f60d7c`, `#…4-the-issue-intake.the-issue-walk @ sha256:0f44a8fef2d8`, plus `#sprint-planning.process.1-frame-the-session @ sha256:253bb51b8d56` for the session-shape fork and counts sentence that clauses 1, 4 and 6 rest on — and the newly transcluded rule's source is pinned too (`cite-node: plugins/ok/families/ok-planner/skills/_shared/dispatch-discipline.md @ sha256:acb7a2417dd3`). Finding on the drifted reality: no violation, and the drift is favourable — the added rule confines the relevance reviewer to reads and forbids it from running anything, reinforcing clause 2's "it never resolves anything". Separately recorded because it emerged from the same re-read: `checks/text-presence` as a whole now exits 1 on the `no-execution-engine` block (two of its asserted ceremony lines were reworded by the same release), so this determination no longer leans on that check's exit code; this decision's own three assertions are present verbatim and exactly once each.

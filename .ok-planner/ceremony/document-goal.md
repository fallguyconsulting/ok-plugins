# The documentation run's goal file

Two readers, two sections. The **brief** is for the agent driving a
documentation run under the native `goal` mechanism; the **goal
rule** is for whatever checker verifies the goal condition. The owner
sets the goal with:

```
/goal the documentation run described in .ok-planner/ceremony/document-goal.md is complete — every term of its goal rule verifies against this repository
```

## The brief

**You are the orchestrator of a documentation run.** The run
constructs; it measures nothing and files nothing — the audit is its
entire measurement front, and the audit's judge and surface extractor
hold the only filing paths. Everything you would otherwise stop to tell
the owner rides to the wrap-up, which reads the audit's run report as
an input.

**Guard clause.** This file governs the run only once its owner
conversations are over: the audit's interactive intent stage (where
this run invoked the audit) and the documentation walk that settles
the document types — inside the composed audit right after its
extractor returns, or as this run's Walk step against a reused
audit's extraction. If either has not landed when the goal is set,
the goal was set too early — say exactly that and stop. Never settle
an intent question or a document type alone; both walks are the
owner's, and no autonomous stage writes a type.

The course is written where it always was — follow it there, never
from a restatement:

- The vendored document ceremony at
  `.claude/skills/document/SKILL.md` — the spine: ensure a current
  audit (the path-scoped currency rule), the walk (already run),
  project the catalog, construct the assessments and traps, generate
  and place one document per declared type, present, commit.
- Each estate's ceremony contribution at
  `<estate>/ceremony/document.md` — the corpus home, layer split,
  record shapes, the writer's brief and placement rule, and gates
  for that estate.

End with the wrap-up composed from this run's construction counts and
the audit's run report — covering both ceremonies when this run
invoked the audit — and then the close-out commit, which is the run's
last act. **Close on a receipt and stop:** the documentation corpus is
complete and committed, naming the corpus commit's sha, the corpus
path, the targets the documents were placed at, and the release it
documents. Offer to archive or commit nothing further, offer to publish
nothing, propose no follow-on work, and ask nothing about what comes
next. Placement in the tree is this run's act; publishing outside the
repository is a separate act this run never performs. The issues in
the intake are the audit's filings, for the owner to rule on and a
planning ceremony to close.

## The goal rule

The goal is met when all of the following verify against the
repository as it stands:

1. A current audit exists for the documented release, per the
   path-scoped currency rule — run by this ceremony where the stamp
   was behind.
2. The documentation corpus is present at
   `.ok-planner/documentation/`: a catalog file per kind the
   extraction records, an assessment or trap record for every
   assumption the audit synthesized, an evidence set beside every
   trap.
3. One document per declared document type is present at that
   type's target in the tree, each opening with its provenance stamp
   naming the release commit; `docs/CLAUDE.md` is present when any
   type targets a path under `docs/` — `docs/` itself as a folder
   target included — and absent otherwise. A type
   the walk left out for the run has an intake issue and no document,
   and counts as accounted for.
4. Every record and document carries the release stamp, and the
   corpus commit has landed.

**Met despite** — none of the following counts against the goal:
traps recorded; items standing `unverified`; unsupported stories
excluded from the catalog; issues sitting in the intake from the
audit's filings or the walk's unsettled types; a document
that a later commit has already left behind; a document the run
revised in part, where the rest of its text still holds.

**Not met**: any record or document missing its release stamp; the
corpus absent or uncommitted; an assumption of the audit's with no
assessment or trap record; a declared type (not left out by the walk)
with no document at its target; a document at a path no type
targets.

**Too early**: the surface intent or the document types are not yet
landed with the owner. That is not a failure of the run — the brief's
guard clause says what to do.

<!-- Materialized by ok-planner v19.0.0 — suite-owned; overwritten on converge; do not hand-edit. -->

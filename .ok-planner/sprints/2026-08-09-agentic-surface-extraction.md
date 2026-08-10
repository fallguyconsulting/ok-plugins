# Sprint: Agentic surface extraction

## Intent

Extend the public-surface machinery for kinds whose populations no
mechanical source can produce: the declaration marks such kinds as
agentically derived, their committed member lists give the reconciler
a mechanical face, the audit's opening walk identifies them when the
owner settles what is public and re-derives them each run — diffing
against the committed list and walking drift — and the marked set is
reported as a standing inventory the owner can inspect and retire by
adopting practices that make the populations mechanical.

No issues are promoted into this sprint; the intake is empty.

## Corpus deltas

### Amend concept: surface-declaration

```markdown
---
concept: surface-declaration
---

# Surface declaration

## What it is

A surface declaration is a project's owner-declared list of its
user-facing surface kinds, each paired with a mechanical enumeration
source that produces the kind's full candidate population. It is the
committed answer to "what kinds of things does this product expose,
and how is the complete list obtained" — judgment exercised once by
the owner, then mechanical ever after. Where the project's own
conventions give a kind no mechanical source, its population is
derived agentically and committed as a member list the enumeration
source reads; the declaration marks such a kind as agentically
derived and names what the derivation reads. The declaration is the
enumerating layer of a three-part surface structure: the declaration
enumerates, the surface guidance rules each element public or private,
and the surface ruling records the resulting partition.

## Purpose

The declaration defines the domain of the total partition that makes
absence answerable: every enumerated element must be ruled public or
private, and the public side drives the documentation catalog
unconditionally — every public element is cataloged whether or not any
story claims it, so a reader can trust that what is not in the catalog
does not exist. Completeness is checkable against the enumerators,
never aspirational.

## Boundaries

The declaration names kinds and their enumeration sources; how
elements are ruled belongs to the surface guidance, the recorded
partition to the surface ruling, and the catalog rows to the
documentation corpus. It is patterned on the owner-declared shape of
`stack-profile` but is its own artifact: the profile describes the
stack the project is built on, the declaration describes the surface
the product exposes. Candidate kinds detected but not declared are
reported to the owner, never auto-added. The marked agentic kinds are
a standing optimization worklist, not a steady state anyone defends:
each is retired by adopting a coding practice that makes its
population mechanically enumerable — ordinary sprint work. See also:
`stack-profile`, `surface-guidance`, `surface-ruling`,
`documentation-corpus`.

## Invariants

- Every declared kind carries a mechanical enumeration source the
  reconciler runs unmodified; populations are never maintained by
  hand.
- A kind whose population no mechanical source produces is marked
  agentically derived and names what the derivation reads; its
  enumeration source reads the committed member list the derivation
  maintains, the members are re-derived and diffed against that list
  at each audit run's opening, and drift reaches the owner — never
  the list silently.
- Enumeration produces candidates, not publics: kinds whose medium has
  no native public/private notion contribute their whole population,
  and the guidance decides each member.
- An enumeration that errors or returns zero members fails loudly
  unless the kind is explicitly marked expected-empty.
- The declaration is owner-owned: detection may propose, only the
  owner declares.
```

### Amend decision: owner-guided-surface-partition

```markdown
---
decision: owner-guided-surface-partition
---

# The public surface is a total, owner-guided partition

## Choice

The public surface is a total partition ruled by owner guidance: the
declared enumerators produce the complete candidate population, every
element is classified public or private by applying the guidance
prose, and no default exists — an element the guidance cannot settle
stops the mechanical pass and reaches the owner, whose answer returns
as guidance. The audit opens with this determination, and it is the
run's one interactive moment: unratified guidance changes and
unsettled elements are walked with the owner up front, then the run
proceeds autonomously on a settled partition; a settled partition
passes the opening silently. Extraction itself is agentic exactly
where it must be: the opening walk identifies, as the owner settles
what is public and how it is obtained, which kinds no mechanical
source can enumerate; each is marked agentically derived in the
declaration, its members are derived by the run and committed as the
member list its enumerator reads, and every later run re-derives the
marked kinds, diffs against the committed lists, and walks drift like
any unsettled element. The reconciler and the run's report both name
the marked set — a standing inventory the owner inspects and retires
by adopting practices that make those populations mechanical.
Planning participates predictively: work that would introduce surface
the guidance cannot classify is settled during sprint planning, and
the answer rides the sprint as a guidance edit.

## Rationale

"Private unless declared public" makes invisibility the default
outcome of forgetting: an element nobody declared is an element nobody
documents, checks, or answers absence about. The total partition
inverts that — forgetting is a loud gap the run cannot proceed past.
Guidance prose is the classification form an owner will actually
maintain, rules at the altitude they think at with exceptions where
the rules run out, and deriving every classification from it keeps
judgment exercised once and applied mechanically ever after. The
interactive moment sits at the audit's opening because the partition
is the first thing every downstream determination depends on, and it
is the one question that cannot be answered without the owner when
something is unsettled; planning's predictive gate moves the same
question earlier, to when the owner is already deciding the work. The
committed member list is the same shape applied to extraction: an
implicit contract — a hand-parsed format, a population living only in
code — gets its judgment exercised in one agentic derivation,
recorded as an inspectable artifact with a mechanical face the tool
reads, and re-checked by diff on the audit's cadence instead of
re-trusted; marking the kinds keeps the cost of that judgment
visible, with each kind's derivation source named — the pointer to
what a retiring practice would formalize.

## Alternatives

- Public-only declaration with inferred private: the previous shape;
  new elements land invisible by default, which is the failure this
  decision exists to remove.
- Language-native visibility as the classification: many surface kinds
  have no such notion, and where one exists it encodes the compiler's
  boundary, not the owner's.
- A per-member registry: total, but unmaintainable — every addition is
  a manual entry, and the rationale for the boundary lives nowhere.
- Member lists inline in the declaration: fewer files, but every
  re-derivation churns the owner's own declaration, and the derived
  content blurs into the declared.
- Agentic kinds by unmarked convention (an enumerator that happens to
  read a committed list): zero schema, but nothing can identify,
  report, or retire the agentic set — the inventory was the point.
- Agentic enumeration at run time, no committed list: always fresh,
  but the partition's domain becomes nondeterministic between runs and
  nothing records what the judgment was.
```

## Work items

- **Extend surface-reconcile for agentic kinds**
  (`plugins/ok/families/ok-planner/scripts/surface-reconcile`, harness
  `test/surface-reconcile.sh`). Makes true: `owner-guided-surface-partition`,
  `rule-the-public-surface`. Outcome: the tool parses the two new
  declaration fields — `"derivation": "agentic"` and `"reads":
  "<one line>"` — validating that a marked kind carries `reads` and
  that an unmarked kind carries neither; the enumeration contract is
  unchanged (a marked kind's `enumerate` is an ordinary command,
  conventionally `cat .ok-planner/surface/members/<kind>`, and its
  errors stay loud). The report gains the agentic inventory: one line
  naming the marked kinds and their count out of all kinds
  ("agentic kinds: 2 of 6 — config-keys (reads the config parser),
  ..."), printed on every run including settled ones. Harness
  fixtures cover a marked kind reading its members file, the
  missing-`reads` and unmarked-with-`reads` validation errors, and
  the inventory line's presence.

- **Amend the ok-planner audit ceremony surface for agentic
  derivation** (`plugins/ok/families/ok-planner/ceremony/audit.md`).
  Makes true: `owner-guided-surface-partition`. Outcome: the surface
  pins the members-file home
  (`.ok-planner/surface/members/<kind>`, one member per line) and the
  two declaration fields, and the Surface phase gains the agentic
  steps: when the opening walk settles a new or changed kind, the run
  identifies whether any mechanical source can enumerate it — none
  means the kind is marked agentically derived (`reads` naming the
  source read) and the run derives its members and commits the list;
  on every run, each marked kind's members are re-derived from what
  `reads` names, diffed against the committed list, and drift is
  walked with the owner exactly as unclaimed elements are, the list
  updated only from that walk. The Present section's Surface block
  reports the agentic inventory beside the partition counts.

- **Teach the marker where the surface structure is taught**
  (`plugins/ok/families/ok-planner/scripts/ok-planner-cheatsheet.md`,
  `scripts/ok-planner-CLAUDE.md`,
  `plugins/ok/families/ok-planner/CLAUDE.md`). Makes true:
  `owner-guided-surface-partition`. Outcome: the cheatsheet's public
  surface section, the estate template's surface section, and the
  family CLAUDE.md's surface-reconcile layout row each carry the
  agentic-derivation shape in a sentence or two — marked kinds, the
  committed member list as the mechanical face, re-derivation and
  diff at the audit's opening, the inventory as the owner's
  optimization worklist.

Dependencies, stated as such: the ceremony-surface item pins the
members-file home and field names; the tool item consumes both —
whoever executes should settle the surface item's shapes before or
together with the tool work.

## How to execute this sprint

This sprint is self-sufficient. Whoever executes it — an inline
working session, an agent this file is handed to via the native
`goal` mechanism, or an orchestrator that does its own planning —
proceeds the same way.

1. Read the sprint whole first — intent, deltas, work items,
   completion contract — before touching anything. Do not go looking
   for context behind it (not in the issue intake under
   `.ok-planner/issues/`, not in `history/`). The sprint is
   self-sufficient by construction; a genuine gap is raised with the
   owner, never filled by inference.

2. Stage the work into a task list. The items above are a flat,
   unordered list; group them by theme, file surface, or dependency,
   order the groups so nothing is built on something not yet there,
   and build the list in your own working state — the harness's task
   tracking where available, one entry per stage; an orchestrator
   uses its own graph. Seed the closing entries up front — finish
   the completion report, run `/certify-work` with this sprint's
   path as its argument, clear this task list just before the
   presentation (complete or remove every remaining entry, so a
   stale list does not linger past the run), walk the presentation,
   offer archive-and-commit — so the ceremony is a
   standing unchecked item from the first minute, not a memory to
   retain past a long run. Staging is never rewritten into a plan
   document: this sprint is the whole brief.

3. Apply each corpus delta as part of the work that realizes it —
   copy the final-form body into `.ok-planner/design/` verbatim
   (from the sidecar where the heading points there), or delete the
   file for a retirement. A delta no work item implements (a
   clarification, a retirement) is applied on its own.

4. Build stage by stage. Every new or amended story whose substance
   is implemented in code is exercised end-to-end by a test in the
   project's ordinary suites, carrying the `@story:` annotation for
   navigation — that annotation is also how the periodic audit finds
   the test later. No test ever checks the existence of static text,
   code, or prose: a commitment realized in prose carries no test.
   Write the tests with the work, not at the end.

5. Completeness is the floor. Never stub, defer, narrow, no-op, or
   leave a `TODO` in place of a promised outcome. A capability the
   deltas or work items promise is delivered in full, or the blocker
   that prevents it is surfaced — never silently dropped.

6. Never destroy uncommitted work. Stage progress as each stage
   finishes (`git add -A`) so a stray revert cannot reach it. Do not
   run `git checkout`/`restore`/`reset`/`stash`/`clean` on your own
   initiative; fix a bad edit forward by editing again.

7. Work unsupervised to a defensible done — no pausing for approval,
   confirmation, or progress checks. Stop only on a genuine blocker:
   a credential or access that cannot be obtained, a step literally
   impossible in the current state, a destructive/irreversible
   action not clearly authorized — or the closing `/certify-work`
   step being unrunnable for you (e.g. its subagent dispatches are
   unavailable): surface that and stop; never skip the ceremony and
   call the work done. Ambiguity is not a blocker — pick the most
   plausible reading and continue, surfacing the choice at the end.
   (An orchestrator that supervises its own executors folds this into
   its own control.)

8. Keep the completion report current. Beside this sprint file lives
   its report — same filename with `-completion` before the
   extension — and you write it as you go: as each stage lands,
   record what was done, every divergence, and every call you made
   where the sprint was silent. It is the durable record the closing
   ceremony finishes and walks with the owner, the artifact a goal
   checker requires, and it is archived together with this sprint.
   It is a record of this execution, never a plan document.

9. Close by running `/certify-work` with this sprint's path as its
   argument — the argument is what puts the sprint in the gate's
   scope; the gate never adopts one on its own. It brings the work into
   alignment with this sprint and discharges the completion contract
   below at the change's own scope, across every estate this project
   has: the project's own test suites over the touched work,
   change-scoped corpus checks over the touched artifacts and
   annotations, code review over the diff —
   all producers feeding a no-discretion review-fix loop (a fixer
   fixes everything a reasonable owner would wave through; an
   architect adversarially checks its kickbacks, fixing the refuted
   and promoting only genuine intent forks to the issue intake),
   and the outcomes and divergences are presented to the owner.
   (Whether the corpus's claims still hold is the periodic `/audit`
   run, on the owner's cadence, never this close.) The goal is to
   finish the work: this file stays in `sprints/` through the
   presentation (so a stop
   condition keyed to its path can verify completion against it),
   and `/certify-work` ends the run as the ceremony: it writes its
   composed presentation into the completion report (finishing the
   record kept in step 8), walks it with the owner, and offers the
   close-out — archiving this sprint together with its completion
   report and the issue files it resolved to `history/`, and
   committing the work — performed only on the owner's word. The
   close-out then stamps the archived sprint's frontmatter with
   the closing commit (`closed: <sha>`, one small follow-on
   commit): the baseline the next planning ceremony uses to
   detect work done out of band.

## Completion contract

The work is not done until all of the following hold, each
verifiable from the repository as it stands:

1. The design corpus matches every delta above (applied verbatim,
   from the sidecar where a heading points there).
2. The project's own test suites pass, and every new or touched
   story implemented in code is exercised end-to-end by a test the
   suites run.
3. The completion report beside this sprint (same filename with
   `-completion`) is finished: it records the work done and the
   divergences, and carries `/certify-work`'s presentation — the
   review-fix loop run last and come back clean, every finding
   fixed or promoted-and-verified.

**The goal rule, for any checker verifying this contract.** The goal
is met in exactly two ways: this sprint file has moved to
`.ok-planner/history/sprints/` bearing a `closed:` stamp — the owner
accepted and closed the work; terminal, stop checking — or this file
is still at its `sprints/` path and items 1–3 all verify against the
repository. A missing completion report means NOT done, however
green the rest looks; an archived, stamped sprint means DONE,
whatever else seems unfinished. A run parked at the review-fix
loop's cycle cap awaiting the owner's direction is a legal in-flight
state — not done, not failed, and never grounds for the run to take
either cap step itself. Nothing else counts either way.

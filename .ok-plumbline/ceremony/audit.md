# ok-plumbline — audit ceremony contribution

What the suite's periodic audit does about this family's estate.
Materialized into consumer projects at `.ok-plumbline/ceremony/audit.md`;
the ceremony reads it there when `.ok-plumbline/` exists.

## Requires

`.ok-plumbline/` at the project root, and `.ok-plumbline/subjects/`
carrying at least one subject. A project that has authored none has no
coverage to report: say so in one line, run the lint below, and
contribute no determinations.

## Enumerate

Every file under `.ok-plumbline/subjects/` is in scope — there is no
subset. One audit file per subject, at
`.ok-plumbline/audits/subjects/<slug>.md`.

Practices get no audit file of their own. A practice's claim is that
the members its condition covers actually follow it, and that claim is
answered inside its subject's coverage audit — where the population it
is measured against is the one thing that makes the answer refutable.
Auditing practices separately would ask the same question against a set
nobody enumerated.

Order the feed by subject, grouping subjects whose populations live in
the same part of the codebase so that code is read once — through the
ceremony's worker pool where the harness supports it, in batches of
three to five otherwise. Say how many subjects ride the instrument
before dispatching.

## Determine

The determination is **coverage-shaped**, per `{{AUDIT-FILE-FORMAT}}`:
the count checked, the population it was enumerated from, and the
members nothing accounts for. Dispatch one auditor per batch:

```
Agent (general-purpose, model: opus):
  ## Practice-coverage audit

  {{LEAF-AGENT-RULE}}

  You may read anything and run read-only commands — searches (`rg`),
  git inspection, the project's own vendored lint. Do not run the
  project's test suites, build it, or execute its stack. Write nothing
  outside `.ok-plumbline/audits/`.

  ### Your job

  For each subject below, enumerate its population FROM REALITY and
  report how far its practices reached. Write the audit file per
  {{AUDIT-FILE-FORMAT}} (transcluded below) to
  `.ok-plumbline/audits/subjects/<slug>.md`, overwriting any prior
  audit whole. Then report one line per subject.

  The authoring rules for both kinds are in
  `.ok-plumbline/practice-definitions.md` — read it first. The
  compliance axis is a reading of the artifact's own body against
  those rules; the support axis is the coverage count below. They are
  independent: a badly written subject may be fully covered, and a
  beautifully written one may be covered nowhere.

  ### Method

  1. Read the subject's **How to find them** section and follow it to
     enumerate the population. Enumerate from the codebase, never from
     the subject's own examples and never from what the practices
     happen to mention. That count is `checked:`, and it is the one
     number a reader can refute in seconds.
  2. Read every practice whose frontmatter names this subject. For
     each member, decide which practice's condition covers it. Where
     more than one matches, the more specific condition governs.
  3. Classify every member into exactly one of four states:
     - **accounted for** — one practice covers it and the construct
       does what that practice says.
     - **violating** — a practice covers it and the construct departs
       from what the practice says. This is WORK, not a question:
       list it under `## Remediation` and never file it.
     - **gap** — no practice's condition covers it.
     - **collision** — two practices with equally specific,
       conflicting conditions cover it.
  4. A fourth state joins the three above, and it is keyed to
     determination cost rather than fix size: a member whose governing
     practice you could establish only by **tracing** beyond the point
     of use is a site whose intent is not legible from the code.
     Illegibility is the owner's to settle, and no amount of tracing by
     the next reader changes that.
  5. `unaccounted:` is the count of gaps, collisions, and traced
     members — every state but accounted-for and violating. Name each
     one under `## Unaccounted`, saying which of the three it is.
     `unaccounted: 0` and `implementation: supported` mean the same
     thing and must agree.
  6. Settle the `text:` axis by reading the subject's own body against
     the authoring rules: is the population defined without policy,
     and is the enumeration something a reader can actually follow? A
     subject whose members cannot be enumerated is noncompliant, and
     say so in `## Compliance`.
  7. A subject you could not enumerate at all has no coverage to
     report: record `implementation: unsupported` with `checked: 0`
     and `unaccounted: 0`, and say in the paragraph what defeated the
     enumeration — the subject's text does not settle what a
     supporting run would even count. The judge decides whether the
     subject's text is what needs settling.

  {{AUDIT-FILE-FORMAT}}

  {{DECIDABILITY-BOUNDARY}}

  ### Subjects to audit

  [AUDIT SET]

  ### Rules

  - Never soften a count because the remediation looks large. Size is
    not this pass's business.
  - Never invent a practice to close a gap, never edit a subject or a
    practice, never edit code, and never file an issue. You are a
    determiner, not a fixer.
  - An audit you write carries no `issue:` link — filing is the
    judge's act.
  - Never run git checkout/restore/reset/stash/clean; never commit.

  ### Report

  One line per subject: `subject:<slug> — supported | compliant —
  checked N, unaccounted 0`, or the same shape naming the
  determination, the compliance axis, and both counts. Everything not
  `supported` goes to the judge.
```

### Lint

The lint over the whole project — run with the Determine stage — is
the other thing this estate knows how to say: the run for the
findings, and the binary's own clustering for the grouping:

```bash
node .ok-plumbline/bin/plumbline .
node .ok-plumbline/bin/plumbline patterns .
```

Exit 0 clean, 2 violations, 1 internal error. The clustering is the
binary's, not this run's: grouping violations by shape is a derivation
with one home, and re-deriving it here would give the project two
answers to the same question. If the project has not converged, fall
back to the payload's `bin/plumbline` and **record the fallback
verbatim in the run report**, on its own line, before the findings:
`note: no vendored binary — using the payload's copy; /ok pins one to
this project`. An unpinned verdict is never delivered silently.

Split the clustered violations the way the caller has to act on them:

- **mechanical** — the fix is fully determined and changes no decision:
  residue, restatement, dividers, commented-out code, TODO markers
  (delete), and citations whose slug is a typo or a rename away from
  resolving (repoint).
- **judgment** — the fix would decide something: a comment naming a
  real constraint that should become an assertion, test, type, or name;
  a docstring block on a public-API surface that may warrant the
  file-level opt-in marker; an unresolved citation whose artifact may
  need creating or whose link may no longer be load-bearing.

Fix nothing. The mechanical class is recorded in the run report; each
judgment-class finding joins the orchestrator's escalations to the
ceremony's judge, which files what it confirms.

## Judge

The escalations join every other estate's in the ceremony's single
judge pass. What the judge confirms is a **gap**, a **collision**, or a
**traced member**, and each confirmed one becomes an intake issue: for
the first two the corpus asserts a population it does not account for
and only the owner can say which practice should; for the third the
site's intent is not legible from the code, and illegibility is the
owner's to settle. A judge that overturns writes the audit back as
`supported` with its own counts.

Remediation lists never reach the judge. They are work.

## Report

What this estate contributes to the run report:

```
## ok-plumbline

Coverage: <N subjects, M members checked, K unaccounted>
Compliance: all compliant | N noncompliant
Lint: clean | N violations

### Coverage
<One line per subject: the slug, checked/unaccounted counts, and the
determination. Then, for each subject with unaccounted members, the
gaps, collisions, and traced members by name with their issue slugs.>

### Remediation
<Every violating member every audit listed, grouped by subject. These
are work for a future sprint, never questions — a practice that has
been ruled poses none. Omit when there are none.>

### Compliance
<One line per noncompliant subject: the rule its body breaks and the
compliant text. Mechanical, for a future pass to fix. "All compliant"
when there are none.>

### Lint
<The totals and category breakdown, then the mechanical/judgment split
with each judgment finding's outcome at the judge. Omit the split when
the lint is clean.>
```

## Boundaries

- Fixes nothing — not a lint violation, not a practice violation, not a
  malformed subject. The caller fixes; the run records and reports.
- Files only through the ceremony's judge, and only gaps, collisions,
  and sites whose governing practice could not be established at the
  point of use.
- Never authors a subject or a practice. Which policies this codebase
  follows is the planning ceremony's business and the owner's.
- Never edits `.ok-plumbline/config.json`.

<!-- Materialized by ok-plumbline v18.6.2 — suite-owned; overwritten on converge; do not hand-edit. -->

---
closed: e6664833153358f628d65e9a45f546c39fabc8cd
---

# Sprint: Drain the intake

## Intent

This sprint drains the issue intake. It has no single theme: it settles which files a `/converge` run may fix, routes harms in parts the project does not own to the intake, guards drivers off the project root, removes retired state files on converge, generates every catalog table of contents, settles five contradicting suite texts, tells agents to claim once, and fixes five defects. It also authorizes, after the fact, the two decisions the v24.0.0 release edited outside a sprint.

Promoted issues:

- `drivers-ran-the-converge-core-on-the-live-repository`
- `converge-removes-hand-edited-workspaces-profile`
- `design-catalog-tocs-have-no-generator`
- `suite-texts-contradict-each-other`
- `repeated-claim-takes-a-second-task`
- `upstream-issues-stay-in-the-intake`
- `conduct-session-start-carries-prose-comment`
- `administration-doc-omits-converge-refusals-and-offer-scope`
- `lint-patterns-labels-a-comment-by-its-neighbour`
- `lint-merges-adjacent-comments-into-one-report`
- `tasks-item-add-accepts-a-task-the-run-lacks`

## Corpus deltas

### Amend decision: skill-text-is-reviewed-as-code

```markdown
---
decision: skill-text-is-reviewed-as-code
---

# A review treats skill text as code and other prose as in scope only where the sprint changed it

## Choice

`/converge` reviews and fixes skill text as it reviews and fixes code. Skill text is a prompt an agent session runs in the project, whether the product ships it or the project keeps it for its own work: a skill, a rule, or an agent profile, with the prompts and shared blocks it reads and the scripts and tools it calls. A fixer edits skill text under the code fix rules: it picks the wording, builds the reading it judges best and records a question where the code and the corpus do not decide the fix, and declines a fix that changes what a user across a release boundary observes. Other prose, such as documentation, is in review only where the sprint the run certifies added or changed it, and is then fixed the same way; elsewhere no agent files a finding on it or edits it. No configuration lists skill text: the agent that meets a file judges whether it is. Which files a run may edit at all follows ownership (see also: runs-fix-what-the-project-owns). The analysis hunt reads code alone, so skill text reaches a run through a drive, a sprint's change, or a defect issue that names it.

## Rationale

In a product made of skills, the skill text is the executable product, and a review that may not fix it can only send its defects to the owner, late, after spending fix rounds. The code fix rules already route a fix that changes intent to the owner, so skill text needs no stricter rule of its own. Documentation a sprint did not touch is not the sprint's work, and reviewing it widens every run without a standard to judge it by. Leaving skill text unconfigured keeps the review working the same way in every project, whether its product is mostly skills or mostly code.

## Alternatives

- Bar every prose file from fixers — keeps "code only", and in a product of skills sends most defects to the owner unfixed.
- Let a fixer edit prose only where the defect's class leaves exactly one compliant fix — stricter than the rule for code, and most skill defects have more than one compliant wording.
- A configuration key naming the prose paths that are product — one more setting to keep, and the driver that finds a skill surface already knows which files it read.
- An inline execution path for skill projects, chosen by an owner flag — a second shape to keep, and the drive already reviews a skill surface.
```

### Amend decision: drive-tries-each-story-as-a-user

```markdown
---
decision: drive-tries-each-story-as-a-user
---

# A drive tries each story as a user, with no written plan

## Choice

`/converge` in drive mode gives every story its own driver once per
run, and sprint certification does the same for the stories a sprint
adds or amends. The driver reads the story's role, capability, and
benefit, and works out from the running product how to get the benefit
on every surface the story is offered through. It uses only what a user
in that role has: the public surface and what the product tells a user,
never the source or the database. A driver changes nothing in the
project's tree: a command that may write runs against a scratch copy or
a scratch project, never at the project root. A surface that is a
skill, a prompt the product ships for an agent session to run, is the
one exception to the source rule: a driver cannot run a session's
skill, so it reviews the skill's text and the scripts and tools the
skill calls against the story's intent, and files each divergence as a
failure. A project whose product has no stack declares so in its review
facts, and its drivers run with no stack to start. Nothing about a
drive is written down between runs. A merge agent sorts each failure as
a defect the story or a decision owes, as something the corpus does not
promise, or as a failure of the environment.

## Rationale

A written drive plan breaks whenever the product changes, and keeping
one current is work that grows with the product. A driver that works
from the story derives its path again on every run, so a change that
keeps the story met keeps the drive passing. Driving as a user finds
what a reader of the code misses: a path that works in the code and
that no user can find, or a message that does not say what went wrong.
The cost is that every run pays to drive every story; drive mode is
where a run spends its tokens. Reviewing a skill surface keeps the
drive's frame, the story's promise, for a product whose surface no
driver can operate, so a product of skills is certified by the same
loop as a product of code. A driver that writes at the project root
rewrites the tree the run certifies; a scratch copy gives it the same
product to use with nothing of the run's at stake.

## Alternatives

- A maintained drive script per story, replayed each run — cheap per
  run and repeatable, and each script breaks on any change that keeps
  the story met, so the run fixes scripts instead of the product.
- A separate execution path for products made of skill text, where
  the session builds and reviews in rounds with no drive — a second
  shape to keep, and a project that gains a code surface would have to
  leave it.
- Drivers run their commands at the project root — no copy to make, and
  a writing command rewrites the tree the run certifies.
- Reuse the audit's experiments as the drive — one instrument for two
  jobs, and an experiment is the audit's measurement of a named commit,
  kept by the audit; a fix loop that runs or edits it mixes the
  measurement with the fix.
```

### Amend decision: defects-outside-scope-become-defect-issues

```markdown
---
decision: defects-outside-scope-become-defect-issues
---

# A defect outside a run's scope becomes a defect issue for the next run

## Choice

A real defect a `/converge` run meets outside its scope goes to the
intake as a `category: defect` issue: a defect sprint certification
finds in code the sprint neither changed nor reaches, a defect a fixer
notices outside its brief, and a defect the run did not finish. The
issue names the site, the accept-list entry, the trigger, the harm, and
the evidence, and its one candidate is to fix the site. It asks the
owner for no judgment. `/triage-issues` checks it against the accept
list, and the next `/converge` in drive, analysis, or defects mode
takes it up as a report; defects mode takes up nothing else. A defect
whose fix lies in a file no agent of a run edits goes where the rule
on what a run fixes sends it (see also: runs-fix-what-the-project-owns),
never to this route.

## Rationale

A defect outside the run's scope is still decided by the rules. Sending
it to the owner as a question would ask them to rule on something
nobody needs to judge, and the judgment queue would stop meaning what
it means. Dropping it loses a defect a merge agent confirmed. Widening
the run to fix it breaks the scope that keeps sprint certification
about the sprint's change and keeps a run's diff readable. A defect
issue keeps the defect, keeps the run's scope, and keeps the owner out.

## Alternatives

- File it as a judgment issue for the next `/plan-sprint` — durable,
  and it spends owner attention on a fix the rules already decide.
- Drop it — keeps the run's output small, and loses a confirmed
  defect.
- Widen the run to fix it — fixes it soonest, and makes sprint
  certification's change reach code the sprint never touched.
```

### New decision: runs-fix-what-the-project-owns

```markdown
---
decision: runs-fix-what-the-project-owns
---

# A run leaves five kinds of file alone and fixes every other file the project owns

## Choice

A `/converge` run's agents fix a clear defect in every file the project
owns, wherever the file sits: its code, and its own scripts, skills,
rules, and other tooling, with prose other than skill text in review
only as the skill-text rule allows (see also:
skill-text-is-reviewed-as-code). They leave five kinds of file alone:
the design corpus and the coding standards, which change only through a
sprint's deltas; a file the suite owns; the owner's declarations
(configuration, harness settings, review facts, release boundaries,
surface intent, and document types); a record, such as a sprint, an issue, an audit, an
experiment, or anything archived, which keeps what it said when it was
written and changes only by the act that owns it; and a document the
release regenerates. A defect whose fix lies in the
corpus, the coding standards, or an owner's declaration goes to the
intake as a judgment issue. A harm in a file the suite owns goes to the
intake as an upstream issue (see also:
foreign-harms-become-upstream-issues). A record changes only through
the act that owns it, and a run files nothing about it. A document the release
regenerates is left to the documentation run (see also:
placed-documents-are-records).

## Rationale

The line follows ownership, not location. A file the suite owns is
maintained upstream, and the next converge overwrites a local edit. A
project's own tooling has no maintainer but the project, so a run that
skips it leaves its defects with nobody. The corpus and the coding
standards move only through an approved sprint, and an owner's
declaration says what the project commits to, so changing either is
the owner's act. A record is worth keeping only as it was written.

## Alternatives

- Leave every file in the suite's estates alone — a simple line, and a
  project's own skills and rules kept there get no fixer.
- Fix a suite-owned file in place — fixes the harm soonest, and the
  next converge overwrites the fix.
- Send every defect outside code to the owner — keeps a run narrow, and
  spends the owner's attention on fixes the rules already decide.
```

### New decision: foreign-harms-become-upstream-issues

```markdown
---
decision: foreign-harms-become-upstream-issues
---

# A harm in a part the project does not own becomes an upstream issue in the intake

## Choice

A harm whose fix lies in a part the project does not own becomes a
judgment issue in the intake marked as upstream, filed by whichever run
meets it: `/converge`, `/audit`, or a sprint's build. `/triage-issues`
marks an issue already in the intake as upstream and leaves it open.
A part the project does not own is a file the suite owns, a library the
project depends on, an outside tool or service, or the suite's accept
list itself, for a harm the list does not name. The issue names the
foreign part as the project sees it (the package and its version, the
tool, or the file as it sits in the project), the site, the harm, and
the evidence, and carries a draft ready to file with the part's
maintainers. No run closes it on its own authority while the project
still shows the harm, and no run hands it to the owner as a step at the
end of its work;
`/triage-issues` closes it as answered once the project no longer
shows the harm, as after an update of the foreign part. The planning session walks it with the
owner, who resolves it one of three ways: a workaround in the project,
which becomes sprint work; a filing upstream, after which the planning
session closes the issue on the owner's resolution, naming where it was
filed; or both.

## Rationale

A harm the project cannot fix in place still costs the project until
someone acts on it. Closing it at triage and handing the owner a step
at the end of a run depends on the owner acting in that moment, and an
issue the owner passes over then is lost. The intake is where the owner
keeps what needs later attention, and planning is where the owner
decides; a workaround is project work, so it belongs in a sprint.
Naming the foreign part as the project sees it keeps the issue true on
any machine, where a path to one person's checkout is not.

## Alternatives

- Triage closes the issue with a ready-to-file draft and the run's
  return asks the owner to file it — no intake entry to keep, and an
  issue the owner does not file at that moment is gone.
- Fix the foreign part in place — fixes the project soonest, and the
  next update of the part overwrites the fix or forks the project from
  its upstream.
- Drop the harm — keeps the intake small, and the harm stays in the
  project unrecorded.
```

### Amend decision: accept-list-decides-defects

```markdown
---
decision: accept-list-decides-defects
---

# One harm-keyed accept list decides what every review counts as a defect

## Choice

One accept list decides what every review in the suite counts as a
defect: an enumerated set of harms, each entry naming one harm and the
sites that can cause it, with a section naming what the list leaves
standing. One entry counts a breach of a rule the project states, where
the rule leaves one compliant form, and it names the rule's sources:
the coding rules, the code-rule files the project lists, the
commitments of the live design corpus, the events standard, and the
project's ruled practices. The agents that hunt, merge, fix, and
verify read the list; a driver reports each failure it meets, and the
merge sorts those failures against the list. A site the list does not
cover stands. An agent that sees a harm the list does not name records a
proposal; the list itself is suite-owned, so the proposal reaches the
intake as an upstream issue, and an adopted entry changes the list
upstream (see also: foreign-harms-become-upstream-issues).

## Rationale

Open reviewer judgment makes what a run fixes depend on who read the
code: one reviewer's preference becomes another's defect, and a loop
that fixes everything a reviewer can name runs to its cap filing
defects against its own fixes. A list keyed to harm, not to the shape
of code, gives every agent the same test and lets a run end once its
list is fixed. Naming rule sources in one entry lets the project's own
rules count without the list restating them. That entry counts only a
rule that leaves one compliant form, because a rule that leaves two is
a question for the owner, not a fix. The events standard and the ruled
practices are sources because the review pastes the standards the
project lists — by default the events standard and the practices —
into its hunt, fix, and verify prompts, and without the entry a reviewer reads a rule it cannot enforce. Keeping
the list suite-owned keeps every project's runs on one definition, and
a proposal records the harm a project meets so the suite can judge it.

## Alternatives

- Open reviewer judgment — no list to keep, and what counts as a
  defect changes with the reviewer, so runs disagree and never settle.
- Grade each report by severity and fix above a threshold — keeps
  every observation, and moves the decision to a threshold someone
  must set and argue again each run.
- One entry per rule, restating each rule — one place to read, and two
  copies of every rule to keep in agreement.
```

### Amend concept: issue

```markdown
---
concept: issue
---

# Issue

## What it is

An issue is one entry in the intake, and it is one of two kinds. A
judgment issue is anything that requires human judgment to resolve,
such as sloppy, unspecified, unclear, overloaded, conflicting, or vestigial
design, a question about the project's own tooling, or a question
deferred during planning. A defect issue is a defect waiting for a run,
not a question: the rules already decide its fix (see also: defect).

## Purpose

The issue separates judgment from work: a judgment issue asks for the
owner's judgment, and a defect issue asks only for a worker. The intake turns
scattered design muddiness into one owner-facing agenda, and it holds
each defect found outside a run's scope until a later run fixes it.

## Boundaries

An issue waits: the intake is a holding area, not a work tracker, and
nothing is worked to completion in it (see also: task-tracker,
sprint, accept-list, defect;
defects-outside-scope-become-defect-issues,
foreign-harms-become-upstream-issues, audit-audience-split under
decisions; plan-a-sprint under stories).
```

### Amend decision: team-execution-cold-gate

body: in the sidecar

### Amend decision: audit-audience-split

body: in the sidecar

### Amend decision: whole-file-ownership

```markdown
---
decision: whole-file-ownership
---

# The suite owns whole files and never edits human-edited files, save a retired family's unread state file

## Choice

The suite's machinery — the front door's administration and ok-planner's converge core — owns whole files only: version-stamped — save for a fixed-content file, whose bytes never vary across suite versions and which carries no stamp to verify by — deterministically regenerable, overwritten wholesale. It never edits a file a human also edits, save the one removal of a retired family's unread state file below; the consumer's own rules file and memory file are categorically untouchable. Records are where the ownership rule stops. The estate preserves them indefinitely, a migration moves them and never rewrites their bodies, and an archived record keeps the wording it closed with. Ownership decides consent: suite-owned files converge silently, and the suite's own retired-layout content is suite territory, migrated mechanically under the administration's own authorization. A retired family's state file, such as its profile or its baseline, is part of that content once nothing reads it after the converge, even where the owner edited it; removing it is the one removal of a human-edited file the converge makes without the owner's word. Converge removes a committed one whole, recoverable from version history, and names each removed file in its report; an uncommitted or symlinked one goes to the owner like any other estate edit, and a state file a kept script still reads stays. Anything else at a path the suite cares about — hand-written overlaps, preexisting guidance the suite would now govern, or a genuine collision between an earlier layout and the current one — is presented for the owner's decision, and owner-declared configuration, hook wiring in the project's committed harness settings included, is written only as transcription of explicit answers.

## Rationale

Whole-file ownership is what makes silent convergence safe and drift correction trivial — overwrite, never merge. The moment the machinery edits shared files it needs merge logic, risks destroying human work, and loses the ability to regenerate its layer deterministically; the consent boundary keeps the owner sovereign over everything that is theirs, while the suite's own retired layouts stay converge-territory because a half-migrated estate misbehaves under every current skill. A retired family's state file configured a family that no longer runs, so nothing the owner relies on reads it, and version history keeps whatever the owner added. A record states what was true when it was written, so rewriting one to match a current layout destroys the only thing it is for.

## Alternatives

- Managed sections inside shared files — merge logic, marker rot, and inevitable collisions with human edits.
- Silent adoption of overlapping preexisting files — the machinery destroys or shadows guidance the project chose deliberately.
- Consent-gating the suite's own layout migration — stalls every legacy project's first converge on a question with one sensible answer.
- Offer each retired state file before removing it — protects a hand-added key, and puts one more question on the first converge of every project that used the retired family.
```

### Amend decision: generated-catalog-tocs

```markdown
---
decision: generated-catalog-tocs
---

# Catalog tables of contents are generated, never authored

## Choice

Every durable catalog in an estate carries a table of contents beside
it, and one generator script writes every one of those files from its
catalog's own artifacts, the design catalogs and the coding-standard
catalogs alike, and the same script checks every one for staleness.
Nobody edits a table of contents by hand; the next
generation overwrites any hand edit. Whoever applies a corpus delta
that touches a catalog regenerates that catalog's table of contents in
the same act, never as a later chore, and the completion contract names
the regeneration as part of applying the delta.

## Rationale

A table of contents is a projection of the catalog, so a second
authored copy of the same content drifts from the first. Generating it
turns staleness into a defect of the last delta rather than a standing
risk. One script for every catalog means one summary rule and one check,
and no catalog whose index rests on an agent's care. Regenerating inside
the delta's own act closes the window: a refresh deferred to a later
step leaves the index wrong for as long as the corpus has moved, and
every session between two deltas reads an index the corpus contradicts.

## Alternatives

- Hand-authored tables of contents — an author tunes each summary, at
  the cost of a second place the same fact lives with nothing to notice
  when the two diverge.
- An agent following a fixed procedure writes the design tables of
  contents — no script to extend, and the index drifts with only a
  periodic reader to notice.
- Regeneration only at a periodic run — cheaper per delta, and every
  session between a delta and the next run reads an index missing the
  artifact just added.
- No table of contents, with every consumer listing the catalog
  directory — always current, and it costs each reader the full body of
  every artifact to learn what exists.
```

## Work items

### Draw the run's fix line at ownership

Makes true: decision:runs-fix-what-the-project-owns, decision:skill-text-is-reviewed-as-code, decision:defects-outside-scope-become-defect-issues, decision:team-execution-cold-gate, decision:audit-audience-split.

A `/converge` run's agents leave five kinds of file alone and fix clear defects in every other file the project owns:

- the design corpus under `.ok-planner/design/` (and the coding-standard collections), which changes only through a sprint's deltas;
- suite-owned files, as the ok-planner cheatsheet's Defect issues section defines them (a `Materialized by ok-` stamp on the last line or one of the first five, anything under `.ok-planner/review/catalog/`, a `LICENSE` whose first line says `materialized by the ok-* suite`, `.ok-planner/package.json`, `.claude/rules/ok-concepts.md`), whose harm goes upstream per the upstream work item;
- the owner's declarations: `.ok-planner/config.json`, `.ok-planner/review/config.json`, `.ok-planner/review/project.md`, `.ok-planner/release-boundaries.md`, everything under `.ok-planner/surface/` (the surface intent and the document types), and the project's harness settings `.claude/settings.json`; a defect there is a judgment issue;
- records: `.ok-planner/sprints/`, `.ok-planner/issues/`, `.ok-planner/history/`, `.ok-planner/audits/`, `.ok-planner/experiments/`, `.ok-planner/sketches/`, `.ok-planner/documentation/`, the run ledgers under `.ok-planner/review/runs/` and `.ok-planner/tasks/`, and the task tracker's cache; a record changes only through the act that owns it, and a run files nothing about it (a gap in the sprint under execution is a builder's call or fork, which certification's alignment pass reads; an experiment or audit record is `/audit`'s to repair or retire);
- documents the release regenerates (the release documents rule already names them).

A project's own files under `.claude/` (its own skills, rules, agents, hooks) and anywhere else are in the run's population and get fixed like code: its own skills, rules, and agent profiles are skill text, and other prose, such as documentation, stays under the prose scope rule. The prose scope rule's definition of skill text in `skills/_converge/coding-rules.md` widens to match. Bring every site that states the old line into agreement: the prose scope rule in `skills/_converge/coding-rules.md` (today "No agent of this run edits the design corpus, an estate (`.claude/`, `.ok-planner/`), ..."), the fix, verify, merge, and backout prompts, the converge skill's Scope section and its sprint-mode merge step (which today sets a defect whose fix lies in `.claude/`, `.ok-planner/review/`, `.ok-planner/bin/`, `.ok-plumbline/`, or `.ok-workspaces/` to `judgment`), and `review files` with its exclude list in `review/seed/config.json`, so the population takes project-owned files under the estates and leaves suite-owned files and the owner's declarations out. A defect whose fix lies in a suite-owned file routes as an upstream issue, not `judgment`.

### Route harms in parts the project does not own to the intake as upstream issues

Makes true: decision:foreign-harms-become-upstream-issues, decision:accept-list-decides-defects, decision:audit-audience-split, decision:team-execution-cold-gate, concept:issue.

A harm whose fix lies in a part the project does not own (a suite-owned file, a dependency library, an outside tool or service, or a harm the accept list does not name) becomes a judgment issue with `category: upstream`, filed by whichever run meets it. The issue names the foreign part as the project sees it (package and version, tool, or the file's path in the project; never a path to a local checkout of the suite or of any other part, and the suite is called "the ok suite"), the site, the harm, the evidence, and a `## Upstream issue` section ready to file.

- `/triage-issues` no longer closes such an issue as `answered` while the project still shows the harm; it closes it as `answered` only once the harm is gone. Otherwise it leaves it in the intake (`status: verified`, `triage: upstream`) with the ready-to-file section and a recommended ruling, and its report lists it under `to /plan-sprint`, not as a step for the owner. Change the skill's description, its routes paragraph and table, its report, and its triage prompt (the proposed-entry paragraph, step 2, and the "`answered`, upstream" paragraph).
- `/converge`'s owner list files such a harm as an upstream issue; its return carries no upstream list and asks the owner nothing about it. Change the skill's "intent is to fix" paragraph, the paragraph that runs `/triage-issues` before the return, and the `proposal` and `session-note` rows of its item table, and the owner-list prompt.
- `/audit`'s judge and a sprint's build tasks file the same issue where they meet such a harm. The payload's `scripts/ok-planner-CLAUDE.md` today says "The build task never files an issue"; it names this exception. Its issue-intake paragraph (triage writes a proposed entry or a suite-owned change "as a ready-to-file issue against the ok-plugins suite, which you file upstream") and `review/CLAUDE.md` ("`/triage-issues` writes a proposed entry as a ready-to-file issue for the owner to file there") describe the new route instead, and the sprint build prompt in `skills/_sprint/shared.md` tells a builder how to file one.
- `/plan-sprint` walks each upstream issue at Resolve like any judgment issue, offering three answers: a workaround (sprint work; the issue is promoted), a filing upstream (the owner files the draft; the issue closes, `status: answered`, naming where it was filed), or both.
- Add the `upstream` category to the issue categories in `skills/_shared/artifact-definitions.md`, and rewrite the `tooling` category so it no longer sends a suite-owned change through triage's close. Update the ok-planner cheatsheet's Defect issues section (judgment issue, Verifying, Routing) to match.

### Keep drivers off the project root

Makes true: decision:drive-tries-each-story-as-a-user.

The drive prompt (`skills/converge/prompts/drive.md`) says that "edit nothing" covers every write a driver's commands make in the project tree, so a driver runs any command that may write against a scratch copy or a scratch project and never at the project root. The confirm-drive rules say the same. In this repository, `.ok-planner/review/project.md` names the converge core at `plugins/ok/families/ok-planner/admin/converge`, run at the project root, under "What no agent of this loop ever runs".

### Remove a retired family's state files on converge

Makes true: decision:whole-file-ownership.

Where nothing reads a retired family's state file after converge, the converge core removes it whole on its own authority (`git rm` where git tracks it, so it stays recoverable from version history) and names each removed file in its report. The retired workspaces profile `.ok-workspaces/config.json` already takes this path in `workspaces_plan`; it keeps its exceptions (the profile stays while a kept old `port-block` reads it or it names a `run-tag` path outside the estate). The retired `/budget` baseline, `budget.json` in the retired plumbline estate, today gets a `retired-file` cleanup offer; it takes the same silent removal instead, so both retired state files follow one path, and the `retired-file` offer goes where nothing else uses it. An uncommitted or symlinked state file keeps its existing `estate-edits` refusal. Update `admin/ADMINISTRATION.md` to describe both removals.

### Generate every catalog's table of contents with one script

Makes true: decision:generated-catalog-tocs.

`scripts/catalog-toc` (materialized as `.ok-planner/bin/catalog-toc`) writes `concepts.md`, `stories.md`, and `decisions.md` under the design corpus as it writes `subjects.md` and `practices.md`, with the same leading-line rule: the first sentence of a concept's What it is, the `As … I want …` line of a story, the first sentence of a decision's Choice, each cut to about 117 characters, listed alphabetically by slug. The design tables of contents keep their layout (concepts list aliases after the slug), and their header names the script as the generator, as `subjects.md` does ("Regenerated whenever a corpus delta touches this collection"), in place of "Generated by `discover-design`". Its `--check` mode covers all five. The discover-design skill's step 7 runs the script in place of writing the files, and the sprint build steps run it after every design delta as well as after subject and practice deltas: the build prompt in `skills/_sprint/shared.md`, step 4 of the execution boilerplate in `skills/plan-sprint/sprint-document.md`, the corpus delta form in `skills/_shared/artifact-definitions.md`, the plan-sprint skill, and the ok-planner cheatsheet. Regenerate this repository's three design tables of contents with the script as part of applying this sprint's deltas.

### Settle five contradicting suite texts

Makes true: story:see-governing-versions.

1. In `review/catalog/failure-paths.md`, narrow row F2's "never widen a catch to a library's whole family" to a catch added for a library error that escapes to its owner frame, and point to rule 4.3 of `docs/plumbline-coding.md` for a catch that stands and acts on a family (that rule says to catch the whole family).
2. `/ok-version` (`skills/ok-version/SKILL.md`) drops "no disk read, no comparison" from its description and body. It shows the version governing the session, the installed plugin version, and the stamp on the project's vendored layer side by side, and still gives no verdict.
3. In `admin/ADMINISTRATION.md`, narrow the closing "Does not validate the contents of existing artifacts" to design-corpus artifacts, and name the issue-intake integrity check over issue frontmatter as the one exception.
4. In `plugins/ok-web/skills/setup-dom-picker/SKILL.md`, scope "Copy it in and wire the gated import; only adapt (e.g. to `.js`) when the frontend has no TypeScript pipeline" to a frontend with no picker. An existing picker that meets the contract stays as it is.
5. In `skills/_shared/design-doc-compliance-reviewer.md`, keep both rules. The claim-grounding paragraph ("A Rationale records why the owner decided and needs no verification to be legal") names the Rationale capability rule above it as the one shape rule on Rationale.

### Tell every agent to claim once

Each vendored profile under `agents/` (`ok-opus.md`, `ok-haiku.md`, `ok-audit.md`, `ok-review.md`) says to run the claim verb once: the task it prints is the agent's one task, and the agent never runs the claim verb again. The tracker, the drain loop, and the first message stay as they are.

### Delete the prose comment in the conduct's session-start hook

Defect issue `conduct-session-start-carries-prose-comment`, entry A8. `plugins/ok-conduct/hooks/session-start` opens with nine prose comment lines (lines 2–10) below the shebang, from `# Direct plugin hook — ok-conduct is user-scoped, so machine-global execution` to `# user's choice in the harness; the announcement only names what is installed.` The comment rule leaves one compliant form: delete them and keep the shebang. `node .ok-planner/bin/plumbline plugins/ok-conduct/hooks/session-start` exits 0 after.

### Bring the administration document and the /ok report template up to the converge core

Defect issue `administration-doc-omits-converge-refusals-and-offer-scope`, entry A8 under rule 1 of the coding rules. `admin/ADMINISTRATION.md` and the report template in `plugins/ok/skills/ok/SKILL.md` ("7. Report") state what the converge core applies, in four places:

1. Mode refusal: the core prints usage for `-h`, `--help`, and `help`, and refuses any other first argument that names no mode with "names no mode; nothing written". The document names only the bare `wire-hooks` refusal.
2. Worktrees refusal: the core refuses unless every worktree is clean, unlocked, and free of populated submodules, and every branch is merged into `HEAD` and checked out in no other worktree. The document says only "unless every worktree is clean and every branch is merged into `HEAD`", in two places.
3. Retired-verb offers: at the names in `RETIRED_WHERE_STAMPED` (`slug`, `ci`, `budget`, `events`, `explain`, `patterns`, `port`, `starter`, `suggest`, `version`, `open`, `close`, `ok-workspaces`, `ok-planner`, `execute-tasks`) the core removes the suite-stamped files and offers nothing. The document says every retired verb's project files get a `retired-verb:` cleanup offer.
4. The lint-rules line: diagnose and converge print `lint rules: ... turn a lint check off by setting it to false under lint_checks in .ok-planner/config.json`; the report template names it.

### Label a comment by its own lines in `plumbline patterns`

Defect issue `lint-patterns-labels-a-comment-by-its-neighbour`, entry A9. `scripts/plumbline::commentHygieneShape` reads a comment's shape from a fixed five-line window starting at the violation's line (`lines.slice(v.line - 1, Math.min(v.line + 4, lines.length))`), so a comment within four lines above a TODO, a license line, or a divider takes that label. It reads the shape from the comment's own lines. In a scratch project, a file holding `x = 1`, `# validate the order first`, `y = 2`, `z = 3`, `# TODO: persist` no longer labels line 2 `todo-marker`.

### Judge each comment line at its own line in the lint

Defect issue `lint-merges-adjacent-comments-into-one-report`, entry A9 (and A3 for the shebang case). `scripts/plumbline::mergeConsecutiveLineComments` folds every run of adjacent line comments into one, reported at its first offending line, and a trailing comment on the next code line and a shebang on line 1 join the run. Two harms follow: the edit hook, which filters violations to the changed lines (`lineInRanges(v.line, opts.lines)` in `lintCmd`), passes a new prose comment added directly below an unchanged one; and a slug-only citation on line 2 below a shebang is refused with `citation comment must be slug-only`. After the fix, each comment line is judged and reported at its own line, and a shebang never joins a citation block. In a scratch project: a committed file with `    # say hello` on line 2, edited to add a prose comment on line 3, fails `plumbline --lines 3`; a file with `    # first note` then `    y = x  # second note` reports both lines; a file with a shebang and `# @story: greet` exits 0.

### Refuse an item filed against a task the run lacks

Defect issue `tasks-item-add-accepts-a-task-the-run-lacks`, entry A3. `scripts/tasks::add_item`, reached from `cmd_item`, stores the `--task` value as given and exits 0. It looks the id up first, the way `cmd_close` does through `Run.task`, and refuses an id the run does not hold with `no task <id>` and a nonzero exit, recording nothing. In a scratch run, `tasks item add --pool divergences --key x --body y --task t99` fails and `tasks render` lists no item.

## Implementation notes

Planned against commit `e32d4523520633f24cfc9659cf791d4450d7c514`.

Paths: `P/` stands for `plugins/ok/families/ok-planner/`. Every change lands in the product source under `plugins/`; the copies under `.claude/` and `.ok-planner/` are vendored, and only the owner's `/ok` rewrites them. Files several work items edit, whose stages chain with `--after`: `P/skills/converge/SKILL.md`, `P/skills/converge/prompts/merge.md`, `P/skills/converge/prompts/owner-list.md` (fix line, upstream); `P/scripts/ok-planner-cheatsheet.md`, `P/scripts/ok-planner-CLAUDE.md`, `P/skills/_shared/artifact-definitions.md`, `P/skills/plan-sprint/SKILL.md`, `P/skills/_sprint/shared.md` (upstream, catalog TOCs); `P/admin/ADMINISTRATION.md` (state files, catalog TOCs, administration document, suite texts part 3); `P/admin/converge` (fix line, state files, catalog TOCs); `plugins/ok/skills/ok/SKILL.md` (state files, administration document); `P/scripts/plumbline` (the two lint items: land "Judge each comment line at its own line" first). Certification's lint check runs the materialized `.ok-planner/bin/plumbline`, which changes only at `/ok`; drive the lint scenarios with `node P/scripts/plumbline`.

### Draw the run's fix line at ownership

**Calls**
- `review` decides by code which files a run leaves alone: a suite-owned file by the cheatsheet's rule, or a file in one of the five kinds by path. Corpus: `design/`, `subjects/`, `practices/`, `subjects.md`, `practices.md`. Declarations: `config.json`, `review/config.json`, `review/project.md`, `release-boundaries.md`, `surface/`, and the project's harness settings (every `.claude/settings*.json` and `.mcp.json`). Records: `sprints/`, `issues/`, `history/`, `audits/`, `experiments/`, `sketches/`, `documentation/`, `review/runs/`, `tasks/`, `.cache/`, `review/rotation.json`. The `exclude` list keeps only the project's own paths. Decided by: the work item; the seeded config is never overwritten, so the seed alone cannot carry the rule.
- The harness settings (every `.claude/settings*.json`, and `.mcp.json`, which `/setup-web` merges into) count as owner's declarations: their hook wiring, permissions, and server config are written only as transcription of the owner's answers. Decided by: decision:whole-file-ownership ("owner-declared configuration, hook wiring in the project's committed harness settings included, is written only as transcription of explicit answers").
- `review/rotation.json` is a record: run state `review rotate` writes. Decided by: decision:runs-fix-what-the-project-owns.
- `review` does not parse document types to find release documents; they are prose, which `review files` already leaves out, and the release documents rule keeps covering `review changed`. Merge step 3a applies the release-document clause of `{{FIX-LINE-RULE}}` itself: it rejects a report on a release document as left to `/document` and files no fix task. Decided by: the work item; decision:runs-fix-what-the-project-owns.
- Build notes from the notes review: bring the `review changed` population sentences in `P/skills/converge/SKILL.md` step 1, `prompts/sprint-review.md`, and `prompts/sprint-pass.md` in line with the ownership filter; add `{{FIX-LINE-RULE}}` to `sprint-review.md` and `sprint-pass.md` too, which lose the leave-alone sentence when it leaves `{{PROSE-SCOPE-RULE}}`; give `review-exclude` a branch in the converge core's resolve kinds, writing the owner's `review/config.json` inside the region `checks/owned-paths` allows; add `review owner` to `P/scripts/review`'s verb table and parser. In this repository, `.claude/skills/release/` enters `review files` only once the owner accepts `review-exclude` at `/ok`. Decided by: the implementation notes review.
- Build notes from the notes re-review: add `rejected` to the `failures` pool's `item_states` in `P/skills/converge/SKILL.md` setup step 5, and name it in the return's failure sorts and the merge's Close counts, since `tasks` refuses a state the pool does not list; the owner list classifies a fixer's `noticed` call's `file` through `review owner` before filing, as merge step 3a does, so nothing is filed for a record and a suite-owned or corpus defect takes its own route; `review backlog` settles an issue that names only left-alone files per issue instead of aborting the step; the owner list closes a backlog issue rejected as a record or release-document fix `answered`, naming the act that owns it; `left_alone` classifies a deleted path by its path or its blob at the base; merge step 3a says how the agent recognizes a release document (a declared document type's target, or the provenance stamp); the `review changed` population sentences note that a changed declaration leaves the checked files. Decided by: the implementation notes review.
- `changed_files` applies the same filter as `scoped_files`, so sprint records and corpus files never list as the sprint's change. Decided by: decision:skill-text-is-reviewed-as-code.
- The suite-owned stamp test is copied into `P/scripts/review`, not imported: `checks/materialized-standalone` requires every materialized script to stand alone. Decided by: coding rule 6.2.
- The ownership step runs in the merge of every mode, not only sprint mode. Decided by: decision:runs-fix-what-the-project-owns.
- Routing: a corpus fix files `category: design` and a declaration fix `category: tooling`; a report whose fix lies in a record is rejected, filing nothing; a suite-owned fix sets the item to the new state `upstream`, which the upstream work item files. Decided by: the work item and the category list.
- `review backlog` stops dropping prose paths, because a defect issue is the way the project's own skill text reaches a run outside a drive or a sprint, and no configuration lists skill text, so the merge agent judges it. Decided by: the owner's ruling that skill text covers the project's own skills and rules; decision:skill-text-is-reviewed-as-code.
- Skill text widens to every prompt an agent session runs in the project, shipped or the project's own (skills, rules, agent profiles); the prose scope rule's definition changes to match. Decided by: the owner's ruling at Resolve (decision:skill-text-is-reviewed-as-code delta).
- This repository's `.ok-planner/review/project.md` "root and what is out of scope" sentence narrows from whole folders under `.claude/` to the suite-owned files there, so the project's own `.claude/skills/release/` enters the run. Decided by: decision:runs-fix-what-the-project-owns.
- Existing projects get the narrower `exclude` through a cleanup offer, not a silent rewrite. Decided by: decision:whole-file-ownership.

**Changes**
- `P/skills/_converge/coding-rules.md::{{PROSE-SCOPE-RULE}}`: changed. Skill text is defined as every prompt an agent session runs in the project, shipped or the project's own. The closing sentence moves into the new `{{FIX-LINE-RULE}}` block (I2).
- `P/skills/_converge/coding-rules.md::{{FIX-LINE-RULE}}`: new. Names the five kinds a run leaves alone and where each defect goes: corpus, coding standards, or declaration to a judgment issue; suite-owned to an upstream issue; a record left to the act that owns it, filing nothing; a release document left to `/document`. Every other project-owned file, under `.claude/` or `.ok-planner/` too, is fixed like code.
- `P/skills/converge/prompts/merge.md`: changed. Step 3a and the drive-failure paragraph classify the file a fix lies in through `review owner` (I1), in every mode: `judgment` for corpus or declaration; `upstream` for suite-owned; `rejected` for a record or a release document; merge otherwise. The Count item gains `upstream=`. The Rules line transcludes `{{FIX-LINE-RULE}}`.
- `P/skills/converge/prompts/fix.md`, `verify.md`, `backout.md`: changed. Each transcludes `{{FIX-LINE-RULE}}` in place of "Leave `.claude/` and `.ok-planner/` untouched", "an estate", and "Edit no estate".
- `P/skills/converge/prompts/owner-list.md`: changed. "A defect no sprint agent may edit" becomes the corpus and declaration cases with the categories above; reads add `--state upstream` for reports and failures.
- `P/skills/converge/SKILL.md`: changed. Scope describes the `review files` population by ownership; sprint step 5 matches merge step 3a; setup step 5's `item_states` adds `upstream` to `reports` and `failures`; the return lists `upstream`; "What stays outside this skill" names the five kinds.
- `P/scripts/review::scoped_files`, `::changed_files`, `::cmd_backlog`: changed. Each drops the files a run leaves alone through `left_alone` (I1) before `exclude` and `test_patterns`. `cmd_backlog` also keeps a prose path an issue names, so a defect issue that names only skill text becomes a report; the merge agent judges whether the file is skill text and rejects one that is other prose outside the sprint's change.
- `P/review/seed/config.json::exclude`: changed to `["*.lock"]`.
- `P/admin/converge::stale_review_settings`: changed. Dropping `.ok-review/` no longer appends `.ok-planner/` to `exclude`; `REVIEW_ESTATE_PROBE` goes if nothing else uses it.
- `P/admin/converge` offers: new `review-exclude:.ok-planner/review/config.json` offer, shown where `exclude` lists `.claude/` or `.ok-planner/`; the fix removes those two entries and nothing else. `P/admin/ADMINISTRATION.md` gains its table row, and its seeded-config bullet says the seed excludes no estate.
- `.ok-planner/review/project.md` (this repository): the out-of-scope sentence narrows per the call above.

**Improvements**
- **I1** `P/scripts/review::left_alone` (new) and a verb `review owner <path>...` printing `project | suite | corpus | declaration | record` per path: the leave-alone list is restated today in `merge.md` (twice), `owner-list.md`, `SKILL.md`, and the population code, so a new estate folder means five edits. Afterward the code and the prompts ask one predicate.
- **I2** `P/skills/_converge/coding-rules.md::{{FIX-LINE-RULE}}`: one rule spelled today in seven prompts. Afterward each prompt transcludes the block through `block_sources`, which already lists `coding-rules.md`.

**Behavior changes**
- **B1** `P/scripts/review::scoped_files` (`review files`, `review areas`). Before: every non-prose file not matched by `exclude`. After: also drops suite-owned files and the five kinds; with a seed-shaped `exclude` it takes project-owned scripts under the estates. Users: in the release: the converge skill's analysis steps, `review rotate`. Across converged projects: each project's `review/config.json`, whose `exclude` lists `.claude/` and `.ok-planner/`. Ruling: migrate: the old `exclude` keeps working with a narrower population, and converge offers `review-exclude` on the owner's yes (call).
- **B2** `P/scripts/review::changed_files` (`review changed`, `review checks`, `review snapshot`). Before: estate files dropped only through `exclude`. After: the five kinds and suite files dropped by code; project-owned estate files listed. Users: in the release: sprint-review, sprint-pass, setup step 1, fix rounds. Across converged projects: as B1. Ruling: migrate: as B1 (call).
- **B3** `P/scripts/review::cmd_backlog`. Before: path tokens filtered by `exclude` and the prose suffixes, so an issue naming only a `.md` file was refused "names no code file". After: filtered by `left_alone` plus `exclude`; an issue naming skill text becomes a report, and one naming only left-alone files is settled per issue. Users: in the release: the converge backlog step. Ruling: rewrite.
- **B4** `P/review/seed/config.json`. Before: new projects seeded with `.claude/` and `.ok-planner/` excluded. After: `*.lock` only. Users: in the release: `seed_review_config`. Across converged projects: none; a seeded config is never overwritten. Ruling: preserve (call).
- **B5** `P/admin/converge::stale_review_settings`. Before: migrating `.ok-review/` added `.ok-planner/` to `exclude`. After: adds nothing. Users: across converged projects: those still holding `.ok-review/`. Ruling: migrate: the code filter keeps records, declarations, and suite files out (call).
- **B6** `P/skills/converge/prompts/merge.md` step 3a and the drive sort. Before: every defect under `.claude/` or `.ok-planner/{review,bin,hooks,docs,scripts}/`, or in the corpus, went to `judgment`, in sprint mode only. After: project-owned files merge and get fixed, suite-owned go to `upstream`, corpus and declaration go to `judgment`, and a record is rejected, in every mode. Users: in the release: owner-list, the skill's vocabulary and return. Ruling: rewrite.
- **B7** `fix.md`, `verify.md`, `backout.md` Rules. Before: no edits under `.claude/` or `.ok-planner/`. After: project-owned files there are editable; only the five kinds are refused. Users: in the release: the fix loop. Ruling: rewrite.
- **B8** `owner-list.md` judgment section. Before: skill and tooling files became `tooling`, corpus `design`. After: corpus `design`, declaration `tooling`; nothing is filed for a record. Users: in the release: `/triage-issues`. Ruling: rewrite.
- **B9** `coding-rules.md::{{PROSE-SCOPE-RULE}}`. Before: skill text was a prompt the product ships, and no agent edited an estate. After: skill text includes the project's own skills, rules, and agent profiles, and the five kinds replace "an estate". Users: in the release: merge, fix, verify, sprint-review, sprint-pass prompts. Ruling: rewrite.
- **B10** `.ok-planner/review/project.md` (this repository). Before: no agent edits `.claude/skills/` and the rest. After: no agent edits the suite-owned files there. Users: in the release: every converge prompt's `[PROJECT]` here. Ruling: rewrite.

### Route harms in parts the project does not own to the intake as upstream issues

**Calls**
- The `## Upstream issue` section's shape is defined once, in `{{ISSUE-FILE-FORMAT}}`: a plain title; the foreign part as the project sees it (package and version, tool, or the file's path in the project, never a local checkout path; the suite is "the ok suite"); each site with its trigger and harm; the evidence; and for an accept-list proposal the entry wording. Every filer and triage point to it. Decided by: coding rule 6.
- `/triage-issues` gets a sixth route, `upstream`: `category: upstream`, `status: verified`, `triage: upstream`, a narrative, the upstream section, `## Options` (workaround, filing, both), and a recommended ruling. The triage agent files a brief with `route=upstream`; the author writes the file, as for `question`. Decided by: the work item.
- Triage's scope adds every intake file with `triage: upstream` whose Ruling holds only marked text; for each it checks only whether the project still shows the harm, routing it `answered` and moving it once the harm is gone. Decided by: decision:foreign-harms-become-upstream-issues.
- A `tooling` issue triage meets whose change lies in a suite-owned file gets `category: upstream`. Decided by: the work item.
- `/plan-sprint` sets `category: upstream` issues apart at Frame (unless the owner wrote an unmarked ruling) and walks them at Resolve with the three answers. A filing closes the issue at once: `status: answered`, the Ruling names where it was filed, and the file moves to `history/issues/`. "Both" is promoted at Terminal with the Ruling naming the filing. Decided by: the work item and the decision's three resolutions.
- A new upstream issue's `kind:` is `audit` from the owner list and the judge, `sprint` from a build task; each files with `status: open`. Decided by: the existing filer conventions.
- Every text this item rewrites calls the suite "the ok suite". Decided by: the work item.

**Changes**
- `P/skills/triage-issues/SKILL.md`: description, routes paragraph (six routes), table (the upstream case leaves the `answered` row for its own `upstream` row), scope paragraph, phase 2 (upstream briefs), report (`to upstream` goes; upstream slugs list under `to /plan-sprint`).
- `P/skills/triage-issues/prompts/triage.md`: an uncovered proposal and a suite-owned or other foreign change route `upstream`; the "`answered`, upstream" paragraph becomes the `upstream` brief plus the harm-gone check; the close result counts `upstream`.
- `P/skills/triage-issues/prompts/author.md`: writes the `upstream` route.
- `P/skills/converge/SKILL.md`: the "intent is to fix" paragraph routes foreign harms to upstream issues; the triage-before-return paragraph drops "for the owner to file upstream"; the `proposal` row files `category: upstream` with `## Proposed entry`; `session-note` is `upstream` for a suite-owned file and `tooling` for the project's own.
- `P/skills/converge/prompts/owner-list.md`: a third destination, upstream issues, for `upstream` reports and failures, `proposal` calls, and suite-owned `session-note` calls; its judgment paragraph drops "triage routes it upstream".
- `P/skills/_shared/implementation-auditor.md::{{AUDIT-JUDGE-PROMPT}}` and `P/skills/audit/SKILL.md` (judge outcomes; "a suspicion about the suite"): a confirmed observation whose fix lies in a foreign part files as an upstream issue.
- `P/skills/_sprint/shared.md::{{SPRINT-BUILD-PROMPT}}`: a build task files an upstream issue per `{{ISSUE-FILE-FORMAT}}` for a harm in a part the project does not own, searching the intake first and staging the file; this write is the one exception to the task's files.
- `P/scripts/ok-planner-CLAUDE.md`: "The build task never files an issue" names the exception; the issue-intake paragraph and "The filers" describe the new route; "Intake, not a work tracker" adds the upstream closure.
- `P/review/CLAUDE.md` line 5: a proposed entry becomes an upstream issue in the intake.
- `P/skills/_shared/artifact-definitions.md`: adds `upstream` to the categories, narrows `tooling` to the project's own tooling, adds the `## Upstream issue` shape to `{{ISSUE-FILE-FORMAT}}`, and updates the lifecycle: the planner stamps `answered` for a filing; the verifier closes an upstream issue only once the harm is gone.
- `P/scripts/ok-planner-cheatsheet.md` Defect issues section: the judgment-issue bullet, Verifying (`upstream` replaces "`answered`, upstream"), Routing.
- `P/skills/plan-sprint/SKILL.md`: Frame sets upstream issues apart; Resolve offers the three answers, and "the only place a judgment issue closes" adds `answered` for a filing; Terminal adds the "both" stamp.
- `P/admin/ADMINISTRATION.md` line 267: "an upstream issue in the intake".

**Improvements**
- **I3** `P/skills/triage-issues/prompts/triage.md`: drop its verbatim copy of the suite-owned definition and cite the cheatsheet's Defect issues section: two copies of one definition (coding rule 6.3). Afterward one definition stands.

**Behavior changes**
- **B11** triage route. Before: a suite-owned change or uncovered proposal closed `answered`, moved to history, and the report handed it to the owner. After: it stays open (`verified`, `triage: upstream`) under `to /plan-sprint`. Users: in the release: the converge return, plan-sprint, the cheatsheet, ok-planner-CLAUDE. Across converged projects: answered-upstream records under `history/issues/`. Ruling: rewrite in the release; the closed records preserve (call): nothing reopens them.
- **B12** triage scope. Before: files without a `triage:` stamp. After: also open `triage: upstream` files, for the harm-gone check. Users: in the release: the converge and audit triage steps. Ruling: rewrite.
- **B13** `owner-list.md` and the skill's calls table. Before: proposals and session notes became `category: tooling`. After: `category: upstream` where the change is foreign. Users: in the release: triage. Ruling: rewrite.
- **B14** `plan-sprint/SKILL.md` Frame and Resolve. Before: an upstream issue with a recommended ruling would be pulled in as ruled. After: set apart and walked with three answers; a filing closes `answered`. Users: in the release: the artifact-definitions lifecycle and the converge core's `intake-closed` offer (it already treats `answered` as closed). Ruling: rewrite.
- **B15** `{{AUDIT-JUDGE-PROMPT}}`. Before: a confirmed foreign observation became an issue in another category. After: an upstream issue. Users: in the release: the audit Verify step. Ruling: rewrite.
- **B16** `{{SPRINT-BUILD-PROMPT}}`. Before: the build never filed an issue. After: it files upstream issues. Users: in the release: the execution boilerplate's archive step and certification's alignment pass. Ruling: rewrite.
- **B17** `artifact-definitions.md` categories. Before: `tooling` covered suite-owned changes. After: `upstream` covers them. Users: in the release: every filer and triage. Across converged projects: open untriaged `tooling` issues. Ruling: migrate: triage sets `category: upstream` on a suite-owned `tooling` issue when it routes it (call).

### Keep drivers off the project root

**Calls**
- The rule lives in the drive prompt's Rules, its skill-surface paragraph, and its Confirm section; `review/seed/project.md` is unchanged. Decided by: the work item.

**Changes**
- `P/skills/converge/prompts/drive.md`: Rules: "edit nothing" covers every write a driver's commands make in the project tree; a command that may write runs against a scratch copy or a scratch project, never at the project root. Confirm says the same.
- `.ok-planner/review/project.md` (this repository): "What no agent of this loop ever runs" adds the converge core at `plugins/ok/families/ok-planner/admin/converge`, run at the project root.

**Behavior changes**
- **B18** `drive.md`. Before: a driver could run a writing command at the project root. After: only in a scratch copy or scratch project. Users: in the release: drive mode, the sprint drive, confirm drives. Ruling: rewrite.
- **B19** `.ok-planner/review/project.md` (this repository). Before: the converge core was not on the never-run list. After: listed at the root. Users: in the release: every converge prompt's `[PROJECT]` here. Ruling: rewrite.

### Remove a retired family's state files on converge

**Calls**
- Converge removes a state file silently only when git tracks it and it is clean; an untracked, uncommitted, or symlinked one gets the `estate-edits` offer. This applies to the workspaces profile too, which `workspaces_plan` removes plainly today when untracked. Decided by: decision:whole-file-ownership delta ("removes a committed one whole, recoverable from version history").
- The budget baseline has no kept-script exception: only the retired `budget` verb of the old lint read it, and that lint is removed or offered in the same converge. Decided by: decision:whole-file-ownership.
- Build note: word the `estate-edits` offer text for a retired budget baseline (including a root `.plumbline-budget.json` outside any estate) and for an untracked workspaces profile, since "a suite file … carries no suite stamp" is wrong for both. Decided by: entry A9.
- Diagnose names each state file it will remove by path, apart from the suite-owned file count; the `/ok` report relays each `removed:` line for a state file. Decided by: decision:whole-file-ownership ("names each removed file in its report"); entry A9.

**Changes**
- `P/admin/converge::plumbline_plan`: each existing `BUDGET_FILES` entry that is tracked, clean, and not behind a link goes to `plan["removes"]`; otherwise `estate_edits_offer`. The `retired-file:` offer goes. `migrate_plumbline` already removes with `git rm` and prints `removed: <path> (git rm; staged)`.
- `P/admin/converge::workspaces_plan`: an untracked `WS_PROFILE` goes to `estate_edits_offer` instead of `removes`.
- `P/admin/converge` resolve kinds: `"retired-file"` removed.
- `P/admin/converge` diagnose: the plumbline finding counts suite files apart from state files, and names each state file ("retired layout: <path> — the retired /budget baseline, which nothing reads; converge removes it").
- `P/admin/ADMINISTRATION.md`: the `retired-file` row goes; plumbline step 4 describes the silent removal and the `estate-edits` exception; workspaces step 3 names the tracked-only rule; the `estate-edits` row adds "or a retired family's state file"; the "Does not write outside the owned set" and "exceptions edit owner files" bullets name this one removal.
- `plugins/ok/skills/ok/SKILL.md` "7. Report": a line for each retired state file removed.

**Behavior changes**
- **B20** `P/admin/converge::plumbline_plan`. Before: the budget baseline got a `retired-file` offer. After: a committed clean baseline is removed with `git rm` and no question; any other gets `estate-edits`. Users: in the release: diagnose, `/ok`'s offer presentation, ADMINISTRATION. Across converged projects: those holding `.ok-plumbline/budget.json` or `.plumbline-budget.json`. Ruling: migrate: the removal is staged and recoverable from history, and an uncommitted, untracked, or linked baseline stays until the owner accepts the offer (call).
- **B21** converge resolve kinds. Before: `resolve retired-file:...` applied. After: refused as an unknown offer. Users: in the release: `/ok`, which resolves only ids the same pass printed. Ruling: rewrite.
- **B22** `P/admin/converge::workspaces_plan`. Before: an untracked profile was removed plainly. After: offered as `estate-edits`. Users: across converged projects: those with an untracked `.ok-workspaces/config.json`. Ruling: migrate: the file stays until the owner accepts the offer (call).
- **B23** converge diagnose plumbline line. Before: "removes N suite-owned file(s)", baseline uncounted. After: suite files counted, each state file named. Users: in the release: `/ok`. Ruling: rewrite.

### Generate every catalog's table of contents with one script

**Calls**
- Summary rule, checked against this repository: it reproduces all 35 concept, 23 story, and 51 decision lines in the current tables of contents exactly. A concept takes the first sentence of the first paragraph under `## What it is`; a story the first paragraph under `## Story`; a decision the first sentence of the first paragraph under `## Choice`. A sentence ends at the first `.`, `!`, or `?` followed by whitespace. A summary over 120 characters is cut to 117 plus `...` (`SUMMARY_CHARS`). Concept aliases come from the frontmatter `aliases:` list and render as ` (aliases: a, b)`. Decided by: the work item and discover-design step 7's format.
- Subjects and practices keep their first-paragraph rule. Decided by: the work item.
- All five headers use one template naming the generator, such as "Generated by `.ok-planner/bin/catalog-toc` and regenerated whenever a corpus delta touches this collection. Do not edit by hand …", the design headers keeping the annotation grep line; this changes the subjects and practices headers too. Decided by: the work item; one template is the uniform reading.
- Build notes: an artifact with no `## What it is`, `## Story`, or `## Choice` section falls back to its first paragraph. In this repository, regenerate the design tables of contents with `python3 plugins/ok/families/ok-planner/scripts/catalog-toc .`, since `.ok-planner/bin/catalog-toc` is the old copy until `/ok`; that run also rewrites the `subjects.md` and `practices.md` headers, which the old materialized `--check` then calls stale, so record it as a divergence. `P/admin/converge::strip_story_sections`'s hand edit of `design/concepts.md` is redundant once converge regenerates it, and goes (coding rule 1.4). Decided by: the implementation notes review.
- A missing `design/<kind>/` folder is skipped; an empty one writes "(none yet — this project has authored no concepts)". Decided by: the existing `main` loop.
- The table of contents destination stays `os.path.join(estate, directory + ".md")` and the write stays `open(target, "w")`, as `checks/owned-paths` requires. Decided by: that check.

**Changes**
- `P/scripts/catalog-toc`: `CATALOGS` gains the three design rows; new helpers read a section's first paragraph, first sentence, and aliases; `render` takes per-catalog header fields; `USAGE` names all five; `--check` covers all five.
- `P/skills/discover-design/SKILL.md` step 7: runs `python3 .ok-planner/bin/catalog-toc` in place of writing the three files; the format block goes.
- `P/skills/_sprint/shared.md::{{SPRINT-BUILD-PROMPT}}`: "After a subject or practice delta" becomes "After every corpus delta".
- `P/skills/plan-sprint/sprint-document.md` step 4 and `P/skills/plan-sprint/SKILL.md`: name the script for every table of contents.
- `P/skills/_shared/artifact-definitions.md::{{CORPUS-DELTA-FORM}}`: applying any delta includes running the script.
- `P/scripts/ok-planner-cheatsheet.md`, `P/scripts/ok-planner-CLAUDE.md`, `P/CLAUDE.md`: describe the generated design tables of contents.
- `P/admin/ADMINISTRATION.md` (layout and owned set): name the design tables of contents, which converge regenerates where `design/` exists.
- `.ok-planner/design/concepts.md`, `stories.md`, `decisions.md` (this repository): regenerated by the script when the stage applies this sprint's deltas.

**Behavior changes**
- **B24** `P/scripts/catalog-toc::main`. Before: wrote only subjects.md and practices.md. After: also the three design tables of contents. Users: in the release: the converge core (runs `catalog-toc` on every converge), sprint builds, discover-design. Across converged projects: each project's agent-written design tables of contents. Ruling: migrate: the first converge after the update regenerates each one whole in the same layout, so its readers read it unchanged; a hand-tuned summary is replaced, as decision:generated-catalog-tocs says (call).
- **B25** `P/scripts/catalog-toc::render` header. Before: subjects and practices said "Regenerated whenever …". After: the shared header naming the script. Users: across converged projects: every subjects.md and practices.md. Ruling: migrate: converge regenerates them (call).
- **B26** `catalog-toc --check`, used by converge diagnose. Before: two tables of contents. After: five, so diagnose reports a stale design table of contents until the next converge. Users: in the release: `/ok`. Ruling: rewrite.
- **B27** `P/skills/discover-design/SKILL.md` step 7. Before: an agent wrote the tables of contents. After: the script writes them. Users: in the release: the discover-design report. Ruling: rewrite.
- **B28** `P/skills/_sprint/shared.md` build prompt and `{{CORPUS-DELTA-FORM}}`. Before: a builder regenerated only subject and practice tables of contents. After: every delta regenerates its own. Users: in the release: sprint builds and certification's alignment pass. Ruling: rewrite.

### Settle five contradicting suite texts

**Calls**
- Part 1 cites the rule as row F1 does ("coding rule 4.3"). Decided by: coding rule 2; row F1.
- Part 2 gets the installed plugin version from `claude plugin list --json` (the `ok` entry), which `/ok` step 1 already uses; `list` is read-only, and `.ok-planner/review/project.md` bans only update, install, and marketplace update. Decided by: coding rule 2; project.md.
- Part 2 reads the vendored-layer stamp from the `Materialized by ok-planner v<X>` line of `.ok-planner/CLAUDE.md`, reporting `—` where the file is absent, as `/ok`'s report does. Decided by: the `/ok` report template; the stamp rule in ADMINISTRATION.md.
- Part 2 keeps both session lines (the governing plugin from the ok-planner `SessionStart` line or `unknown`; the governing conduct from the active output style or `unstamped`) and adds the installed conduct version from the ok-conduct `SessionStart` line, or `unknown`. Decided by: story:see-governing-versions ("alongside what is installed").
- Part 2 labels each line by what it reads: the governing plugin line comes from the vendored hook, so it equals the vendored stamp until an `/ok` run in mid-session. Decided by: the implementation notes review.
- Part 2 prints five lines in a fixed order (plugin governing, plugin installed, vendored stamp, conduct governing, conduct installed), no verdict, and keeps the "investigate from there" sentence. Decided by: the work item.
- `.ok-planner/design/_discover/*` describes the old `/ok-version`; it is discovery scaffolding and stays. Decided by: the record discipline.

**Changes**
- `P/review/catalog/failure-paths.md::F2`: changed. "A library's error that escapes a function to its owner frame is not a defect: never add a catch, a conversion, or a family tuple for it, and never widen a catch added for such an error to the library's whole family. A catch that stands and acts on a family catches the whole family (coding rule 4.3)." The rest of the row is unchanged.
- `P/skills/ok-version/SKILL.md`: changed. The description keeps the slash-only sentence (`checks/ceremony-surfaces` requires it), drops "no disk read", and says the skill shows the governing versions beside the installed plugin version and the vendored stamp, with no drift verdict. The body drops "No disk read, no comparison" and "never reads from disk", adds the steps for the installed version and the stamp, lists the five lines, and keeps "never edits files, never chains, no verdict".
- `P/admin/ADMINISTRATION.md` (what the administration does not do): "Does not validate the contents of existing design-corpus artifacts — the periodic `/audit` run's job. The one exception is the issue-intake integrity check over issue frontmatter (see Issue-intake integrity)."
- `plugins/ok-web/skills/setup-dom-picker/SKILL.md` (the reference-implementation paragraph): "For a frontend with no picker, copy it in and wire the gated import; only adapt (e.g. to `.js`) when that frontend has no TypeScript pipeline. An existing picker that meets the contract stays as it is." Step 2's bullets already agree and stay.
- `P/skills/_shared/design-doc-compliance-reviewer.md::Claim grounding`: "A Rationale records why the owner decided and needs no verification to be legal; its one shape rule is the capability rule under Decision form above (a Rationale sentence claiming a capability no Choice clause commits to). The same holds for an Alternatives bullet's account of why an option lost. Never flag reasoning because it cannot be verified."

**Behavior changes**
- **B100** `P/review/catalog/failure-paths.md::F2`. Before: a fixer leaves a standing catch that acts on one subclass of a family. After: it widens that catch to the whole family under rule 4.3, and still never adds a catch for an escaping library error. Users: in the release: `/converge`'s hunt, fix, and verify agents. Across converged projects: the catalog and its readers are overwritten together at `/ok`. Ruling: rewrite.
- **B101** `P/skills/ok-version/SKILL.md`. Before: two lines, no disk read. After: five lines, reading `.ok-planner/CLAUDE.md` and running `claude plugin list --json`. Users: in the release: the human reader; no program parses it. Across converged projects: vendored, changes at `/ok` with the hook line it reads. Ruling: rewrite.
- **B102** `plugins/ok-web/skills/setup-dom-picker/SKILL.md`. Before: readable as "copy the reference in" even where a compliant picker exists. After: copies only for a frontend with no picker. Users: in the release: the `/setup-dom-picker` session. Across installed plugins: the skill and its reference ship in one plugin. Ruling: rewrite.
- **B103** `P/skills/_shared/design-doc-compliance-reviewer.md::Claim grounding`. Before: "needs no verification to be legal" readable as exempting Rationale from the capability rule. After: the capability rule is the one shape rule on Rationale. Users: in the release: the reviewers `/plan-sprint` dispatches. Across converged projects: vendored with its readers. Ruling: rewrite.

### Tell every agent to claim once

**Calls**
- A fork's claim by id counts as its one claim; a forking root claims once, closes its task, forks, and never claims again. Decided by: the work item; `dispatch-discipline.md`.
- The tracker's docstring, `skills/_tasks/drain.md`, and the cheatsheet stay. Decided by: the work item.

**Changes**
- `P/agents/ok-opus.md`, `P/agents/ok-haiku.md`: after the claim sentence, add "Run it once. The task it prints is your one task: after you close it you stop, and you never run `tasks claim` again."
- `P/agents/ok-audit.md`, `P/agents/ok-review.md`: after "Either prints the task you own…", add "Run the claim once, in whichever form applies. The task it prints is your one task: you never run `tasks claim` again, and a root that forks claims nothing after it closes its own task."

**Behavior changes**
- **B104** `P/agents/ok-*.md`. Before: an agent could run `claim --agent` again and take a second issued task. After: every agent works one task. Users: in the release: the drain loop, whose per-agent counts become exact. Across converged projects: the profiles change with the drain loop at `/ok`. Ruling: rewrite.

### Delete the prose comment in the conduct's session-start hook

**Calls**
- Delete lines 2–10, keeping line 1 (`#!/usr/bin/env bash`) and `set -euo pipefail`. Decided by: the comment rule; entry A8.
- The other comment violations `plumbline plugins checks` reports today (`plugins/ok-web/skills/setup-dom-picker/reference/dom-picker.ts:1`, `checks/oscillation:2,49,104`) lie in definitions this sprint does not change and belong to the next `/converge`. Decided by: the code planner's scope rule.

**Changes**
- `plugins/ok-conduct/hooks/session-start`: the nine prose comment lines go. `node .ok-planner/bin/plumbline plugins/ok-conduct/hooks/session-start` exits 0 afterward.

**Behavior changes**
None. Every change is new code no existing user reaches.

### Bring the administration document and the /ok report template up to the converge core

**Calls**
- Each statement is worded from the core's source: the mode case, the worktrees refusal, `retirements()` with `RETIRED_VENDORED` and `RETIRED_WHERE_STAMPED`, and `lint_rules_notice` as diagnose and converge print it. Decided by: coding rule 1; entry A8.
- The `lint rules:` line also goes into ADMINISTRATION.md's "Lint checks" paragraph, so the document describes what the template relays. Decided by: coding rule 1.

**Changes**
- `P/admin/ADMINISTRATION.md` (the core's modes): the core prints its usage for `-h`, `--help`, and `help` and exits 0; any other first argument that names no mode is refused with `converge: <arg> names no mode; nothing written` and the usage line, exit 1; a bare `wire-hooks` is refused with a usage line naming the groups.
- `P/admin/ADMINISTRATION.md` (the worktrees row and the ok-workspaces retirement step 1): the fix is refused, changing nothing, unless every worktree is clean, unlocked, and free of populated submodules, and every branch is merged into `HEAD` and checked out in no other worktree.
- `P/admin/ADMINISTRATION.md` (retired vendored verbs and the `retired-verb` row): at `true-up`, `prove`, `browse`, `certify-all`, `verify-issues`, `plan-sprint-code`, `converge-local`, `converge-cascade`, `ok-planner-audit`, `ok-plumbline-audit`, `ok-workspaces-audit`, `verify-corpus`, and `certify-work`, the project's files get the `retired-verb:` offer, and an unstamped folder is offered whole; at `slug`, `ci`, `budget`, `events`, `explain`, `patterns`, `port`, `starter`, `suggest`, `version`, `open`, `close`, `ok-workspaces`, `ok-planner`, and `execute-tasks`, converge removes the suite-stamped files and offers nothing, and an unstamped folder there is left alone.
- `P/admin/ADMINISTRATION.md` ("Lint checks"): diagnose prints a `lint rules:` line when either rules file is missing, and converge when it writes them; the line names the files and says to turn a check off with `false` under `lint_checks` in `.ok-planner/config.json`.
- `plugins/ok/skills/ok/SKILL.md` "7. Report": a slot for the `lint rules:` line, relayed verbatim when the core prints it.

**Behavior changes**
- **B105** `plugins/ok/skills/ok/SKILL.md` "7. Report". Before: the report leaves out the core's `lint rules:` line. After: it relays it. Users: in the release: the owner reading the report. Across installed plugins: the skill and the core ship in one plugin. Ruling: rewrite.
- **B106** `P/admin/ADMINISTRATION.md`. Before: `/ok` tells the owner only the `wire-hooks` refusal exists, that a worktrees fix needs only clean and merged, and that every retired verb gets an offer. After: what the core actually refuses and offers. Users: in the release: the `/ok` session. Across installed plugins: same payload as the core. Ruling: rewrite.

### Label a comment by its own lines in `plumbline patterns`

**Calls**
- `checkCommentHygiene` attaches the judged comment text to each violation as `text` (the offending line's comment text, marker stripped); `formatViolation` does not print it. Decided by: the work item; coding rule 6 (one extraction, no second parse).
- The divider, license, TODO, and commented-out-code tests read `v.text`. The divider length threshold drops from 8 to 6, since `v.text` no longer holds the marker. A trailing comment is labelled by its own text. The doc-residue lookahead still reads the file below for the next declaration. Decided by: the work item; entry A9.

**Changes**
- `P/scripts/plumbline::checkCommentHygiene`: each violation carries `text`.
- `P/scripts/plumbline::commentHygieneShape`: the five-line `blockText` window goes; `startLine` and `stripped` come from `v.text`; the file is read only for the doc-residue lookahead. In the scratch scenario, line 2 is labelled `disallowed-prose` and line 5 `todo-marker`.

**Behavior changes**
- **B107** `P/scripts/plumbline::commentHygieneShape`. Before: a comment within four lines above a TODO, license, or copyright line takes that label, and a trailing comment can be labelled by its code. After: each violation is labelled from its own text, so `plumbline patterns` cluster labels and counts change. Users: in the release: `/audit`'s lint sweep. Across converged projects: the lint is overwritten at `/ok` together with the audit skill. Ruling: rewrite.

### Judge each comment line at its own line in the lint

**Calls**
- Grouping stays as context, so a license header's continuation lines and a multi-line Go doc comment pass as one unit; reporting becomes per line: every significant failing line is its own violation at its own line. Decided by: the work item; the license-continuation exemption.
- A line-1 shebang never merges with the line below; a trailing comment never merges with any run. Decided by: the work item.
- Per line: a directive passes; a license-continuation line passes only in a run that opens with a license header; a clean citation line (`isCleanCitationLine`) passes on its own; a docstring-style comment with the opt-in passes whole. Decided by: the comment rules.
- A failing line that starts with a citation tag, or sits in a run opened by a citation line, gets the slug-only message; every other gets "comment is not permitted…". Decided by: the existing messages.
- Block comments are judged per line too: a new prose line inside an existing block comment has the same `--lines` blind spot. Decided by: coding rule 8.1; entry A9.
- The shebang scenario's scratch project declares `@story:` in `.ok-planner/config.json` and holds `.ok-planner/design/stories/greet.md`, or turns `citation-resolution` off. Decided by: how `checkCitationResolution` works.

**Changes**
- `P/scripts/plumbline::extractRawComments`, `::extractShellRawComments`: each line comment record carries `trailing: true` when code precedes it on its line.
- `P/scripts/plumbline::mergeConsecutiveLineComments`: joins two line comments only when both stand on their own lines and the earlier is not a line-1 shebang.
- `P/scripts/plumbline::machineDirectiveViolation`: renamed `machineDirectiveViolations`; returns every failing significant line.
- `P/scripts/plumbline::checkCommentHygiene`: skips docstring-style comments whole; skips clean citation lines; pushes one violation per failing line with the message per the calls. `isPureCitationBlock` becomes unused and is deleted (coding rule 1.4).

**Behavior changes**
- **B108** `P/scripts/plumbline::checkCommentHygiene` (line comments). Before: a run of adjacent prose line comments gives one violation at its first offending line, so `--lines` and the edit hook pass a prose line added below an unchanged one. After: one violation per offending line; the hook blocks the new line, and counts rise for comments that already fail. Users: in the release: the edit hook, the `review checks` lint entry, `/audit`'s sweep, `patterns`. Across converged projects: the lint and hook are overwritten together at `/ok`; code that passes today still passes. Ruling: rewrite.
- **B109** `P/scripts/plumbline::mergeConsecutiveLineComments`. Before: a shebang and a trailing comment on the next code line join the run, so a shebang followed by a slug-only citation is refused. After: the citation passes; a trailing comment is judged alone. Users: as B108. Ruling: rewrite.
- **B110** `P/scripts/plumbline::checkCommentHygiene` (block comments). Before: one violation per failing block. After: one per failing line. Users: as B108. Ruling: rewrite.
- **B111** `P/scripts/plumbline::checkCommentHygiene` (citation runs). Before: a citation line followed by prose is reported once, at the citation line. After: the citation passes and each prose line is reported with the slug-only message. Users: as B108. Ruling: rewrite.

### Refuse an item filed against a task the run lacks

**Calls**
- The lookup sits in `add_item` before `check_state`, through `run.task(task)` when `task` is set, the sibling `cmd_close` uses; the store holds the run's lock for the whole process, so check and write share one lock. Decided by: coding rules 2 and 3.2.
- An item filed without `--task` stays accepted (the audit session files escalations without one). A closed task is still a task the run holds. Decided by: the existing callers; the work item.

**Changes**
- `P/scripts/tasks::add_item`: refuses an unknown `--task` id with `no task <id>` and exit 2 before writing any record or event.

**Behavior changes**
- **B112** `P/scripts/tasks::add_item`. Before: `item add --task t99` stores the item and exits 0. After: prints `tasks: no task t99`, exits 2, stores nothing. Users: in the release: every prompt that files with `--task <task>` (18 sites), each passing the agent's own claimed task. Across converged projects: a run log earlier releases wrote is only read, never re-validated, so it keeps loading. Ruling: rewrite.

## How to execute this sprint

This sprint is self-sufficient. Every executor — an inline session,
an agent handed this file via `/goal`, an orchestrator with its own
planning — runs the same shape: record the base commit, plan the work
into the task tracker as small build tasks cut from the
implementation notes, drain them, then run sprint certification once.
No review runs during the build.

1. Read the sprint whole first: intent, deltas, work items,
   implementation notes, completion contract. The sprint is the whole
   brief: context from the intake (`.ok-planner/issues/`) or
   `history/` may disagree with what the owner approved. Raise a gap
   with the owner.

2. Record the base. Sprint certification reads the change from this
   commit, so the tree holds nothing but this sprint's work from here
   on. The planning session leaves its own files uncommitted: this
   file, its delta sidecar, `.ok-planner/release-boundaries.md`, the
   issue files it stamped, and the sketches it archived. Where `git
   status --porcelain` lists a path outside `.ok-planner/`, name those
   paths to the owner and stop, because certification would count
   them as this sprint's work. Otherwise write the output of `git
   rev-parse HEAD` to the file beside this sprint with the same
   filename, `-base` before the extension and `.txt` as the
   extension.

3. Open the run. The task tracker at `.ok-planner/bin/tasks` and the
   profiles under `.claude/agents/` are required; a missing one is
   the front door's administration (`/ok`) to materialize: say so and
   stop. `tasks init <sprint-name> --file
   .ok-planner/sprints/<sprint-name>-run.jsonl`, `tasks agent
   register ok-opus`, and register the `build` prompt: write
   `{{SPRINT-BUILD-PROMPT}}` from `.claude/skills/_sprint/shared.md`,
   its transclusions resolved and `[SPRINT PATH]` filled, to
   `.ok-planner/sprints/<sprint-name>-build.md`, then `tasks prompt
   register build <that path>`. Declare the roles whose close carries
   a sweep: `tasks config set swept_roles '["build", "fix"]'`, so a
   build task closes `done` only with the sites its searches
   returned, each one staged.

4. Plan the work into stages from the implementation notes. Read the
   code each work item's notes name, in the tree as it stands now,
   before you file anything. Where the tree has moved since the
   notes' commit and a named site no longer matches, plan from the
   outcome the notes state and record the difference as a divergence
   call. Cut the sprint into stages, each **the smallest change that
   makes progress toward the completion contract and leaves the tree
   runnable**: it builds, nothing is half-wired, and the work after it
   can build on it. A stage lands one work item or a part of one. A
   work item that needs more than one agent's reading set becomes
   several stages in sequence. A taken improvement lands in the same
   stage as the change to its definition. Per stage, file one build
   task: `tasks file --role build --prompt build --agent ok-opus
   --key <stage> --files <the paths it may edit> --cites <the work
   items and slugs> --after <the build tasks of the stages it builds
   on, omitted where it builds on none> --brief "<the work items it
   lands, the improvements and deltas it applies, the behavior
   changes it carries by id with their rulings, and where the code
   is and what to reuse>"`. Two stages whose files overlap are
   chained with `--after`; a stage that applies a delta reaches its
   collection's catalog TOC too (under `.ok-planner/design/`, or
   `.ok-planner/subjects.md` or `.ok-planner/practices.md`, which
   `python3 .ok-planner/bin/catalog-toc` regenerates), so two
   delta-bearing stages overlap. Stages with disjoint files run together. Apply a
   delta no work item implements in a stage of its own.

5. Render the completion report with the staged list before the first
   drain: write the output of `tasks render --title "<this sprint's
   title>" --sprint <this sprint's path>` to the report file (step
   10).

6. Keep the progress checklist. Where the harness task tools are
   available, mirror the stages as a live checklist, one entry per
   stage, created when the build tasks are filed, and add one entry
   for sprint certification when the drain ends. The run file is the
   record and the checklist is display.

7. Drain with the loop at `.claude/skills/_tasks/drain.md`.
   A build that closes `partial` is refiled for its remainder with
   `tasks refile <task>`; one that closes `partial` with a result
   starting `outside files:` is refiled with that path added to its
   files. A build that closes `blocked` is refiled once. The session
   builds nothing and reviews nothing itself, and edits no file a
   running task owns.

8. Every stage applies its corpus deltas as part of the work that
   realizes them, and every new or amended story implemented in code
   carries the `@story:` annotation at the site that realizes it. The
   build prompt carries both rules. `.ok-planner/audits/` and
   `.ok-planner/experiments/` belong to `/audit`.

9. Uncommitted work is the only record of the run. Every task stages
   the paths it touched as it closes (`git add <paths>`), and the run
   records them. Never run `git checkout`/`restore`/`reset`/`stash`/
   `clean` on your own initiative. Fix a bad edit forward by editing
   again.

10. The completion report lives beside this sprint file, same
    filename with `-completion` before the extension. The session
    re-renders it whole from the run before every dispatch: `##
    Stages` from the build tasks and `## Divergences` from the run's
    `divergences` pool. Build tasks record calls, forks, and what
    they noticed as items; the report is rendered, never
    hand-edited.

11. Work unsupervised to a defensible done. Do not pause for
    approval, confirmation, or progress checks. Stop only on a genuine
    blocker: a credential or access you cannot obtain, a step
    impossible in the current state, a destructive or irreversible
    action not clearly authorized, a task closed `blocked` twice, or
    sprint certification being unrunnable for you. Surface that and
    stop. Ambiguity is not a blocker: the builder makes the most
    plausible call and records it, or records a fork and builds the
    reading it judges best. Sprint certification reads both.

12. Code complete means every stage's latest build task closed
    `done`. Then run sprint certification, immediately after:
    `/converge sprint <this sprint's path>`. It judges the change
    from the commit in the `-base.txt` file to the working tree,
    once, against this sprint: every outcome and taken improvement
    works, a user gets what each story the sprint adds or amends
    promises when a driver uses the running product, every delta
    landed, every ruling holds, no unlisted behavior change breaks a
    user, and the project's checks pass. It fixes each defect in the
    sprint's scope and verifies each fix on its own diff. A defect
    outside the sprint's scope goes to the intake as a `category:
    defect` issue for the next `/converge`, and a question only the
    owner can decide goes to the intake for the next `/plan-sprint`.
    It ends by presenting its return block.

13. Write the return block into the completion report, after its
    rendered sections, under a `# Sprint certification` heading, with
    the `/converge` run's ledger path. Nothing renders the report
    after this. Then present the completion report and offer the
    archive and the commit below as one owner act. Ask the owner
    nothing else: every defect the run could not fix and every
    question it raised is already in the intake, for the next
    `/converge` or `/plan-sprint`.

**The archive and the commit.** The owner archives this sprint and
commits the work; offer both as one owner act, and wait. "Finish the
sprint" and "follow the boilerplate" are not a yes; both ask for the
presentation. On the owner's yes:

1. Stamp each issue file this sprint promoted (`status: promoted`,
   `sprint: <this file's name>`) and move it to
   `.ok-planner/history/issues/`.
2. Move this file, its completion report, its run file, its
   `-base.txt` file, its `-build.md` prompt, and its delta sidecar to
   `.ok-planner/history/sprints/`: `git mv` for a tracked file, `mv`
   for an untracked one.
3. Stage by name every path the sprint's change touched, every moved
   file at its new path, the `/converge` run's ledger and folder, and
   every issue file the run wrote or moved. Commit those paths alone
   with `git commit -- <paths>`, naming only paths that exist or that
   `git mv` removed, so nothing else standing in the index rides
   along.
4. Add `closed: <the commit's sha>` to the archived sprint as YAML
   frontmatter, and commit that edit alone. The next planning
   session reads that stamp to detect work done out of band.

The owner publishes; the run never pushes.

## Completion contract

The work is done when all of the following hold, each verifiable
from the repository as it stands:

1. Every corpus matches every delta above, applied verbatim (from
   the sidecar where a heading points there): `.ok-planner/design/`
   for a concept, story, or decision, and `.ok-planner/subjects/` or
   `.ok-planner/practices/` for a subject or practice, with its
   catalog TOC regenerated.
2. The project builds, and the checks `.ok-planner/review/config.json`
   lists under `checks` pass on every file the change touched.
3. The completion report beside this sprint (same filename with
   `-completion`) carries the return block of sprint certification
   (`/converge sprint`) run on this sprint, under `# Sprint certification`: the run's find
   loop ran once, and every defect stands `verified`, `declined`,
   `duplicate`, or `stuck`, with every `stuck` defect listed for the
   owner.

**The goal rule, for any checker verifying this contract.** The goal
is met when items 1–3 verify against the repository as it stands.
Decide from the repository, never from the session transcript: an
earlier session may have done the work, and a term the transcript
does not show may hold on disk. A `stuck` defect listed in the
return is the owner's to take up, and does not hold the goal open.
Presenting the report, archiving, committing, and the
`closed:` stamp all follow completion; a pending archive-and-commit
offer is evidence the goal is met. `sprints/` and
`.ok-planner/history/sprints/` satisfy the rule alike, and a sprint
already archived with a `closed:` stamp is terminal. A missing
completion report, or one without the return block,
means not done. Nothing else counts either way.

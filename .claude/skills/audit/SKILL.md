---
name: audit
description: "ONLY activated by explicit /audit slash command, or run by /document as its measurement front. Never auto-triggered by conversation content. ok-planner's periodic audit: opens with a short interactive intent stage in which the owner and the run co-author the surface intent at the class level (the reason the ceremony is interactive at all), then autonomously dispatches a surface extractor subagent that reads the just-landed intent and writes the run's surface extraction (filing intake issues where the intent still does not settle an element, and defaulting those elements internal for the run) — followed, only when /document invoked the run, by the documentation walk that settles the declared document types against that extraction — then measures story support from the user's side through the extraction's public elements on the maintained experiments, synthesizes user assumptions cold and measures them on the same instrument, re-reads decisions and concepts against the codebase, enumerates each subject's population and counts how far its practices reached, sweeps the lint over the project, hands every escalation to one terminal judge (which files each confirmed practice violation as a defect issue), writes the run report, then commits the audit corpus and stamps the commit. Two determination stages, no loop; run on the owner's cadence, never per sprint."
---

# Audit (the periodic run)

**You are the orchestrator of this run.** You resolve scope, drive the stages, file the tasks, and drain the run; you determine nothing yourself, and **you file nothing of your own motion** — the judge and the surface extractor's residual-ambiguity issues are the run's only filing paths, beside the documentation walk's in a run `/document` invoked. Anything you would otherwise stop to tell the owner — a defect noticed while driving, an instrument repaired, a suspicion about the suite — is an escalation for the judge where it needs a ruling, and a line in the run report either way; the autonomous portion does not pause to say it. **You walk the owner in the interactive intent stage at the top of the run** — a short class-level conversation that produces or updates the surface intent — and, only when `/document` invoked the run, once more in the documentation walk right after the extractor returns. After that the run drives itself.

The audit runs on the owner's cadence, never at a close. Sprint certification (`/converge sprint`) reviews one sprint's change, and says nothing about whether the corpus's claims still hold; this verb asks that question, of the design corpus and of the coding standards — the concepts, stories, and decisions under `.ok-planner/design/`, and the subjects and practices beside them. It is also the documentation ceremony's entire measurement front: `/document` opens by ensuring a current audit and constructs from this run's records, measuring nothing itself.

The run makes five determinations:

1. **The surface** — two sub-stages: the interactive intent stage with the owner (read the current intent and ask what changed, or author it from zero, top-down at the class level, landing the document the owner approves), then the autonomous extractor dispatch (a subagent reads the just-landed intent, walks the code and deployment configuration, writes the run's surface extraction, files intake issues for elements the intent does not settle, and defaults those internal for the run). When `/document` invoked the run, the **documentation walk** runs immediately after the extractor returns; an à la carte run does not run it. Run à la carte, hand the owner the `/goal` line **after the interactive stage lands the intent**, so everything after is driven hands-free.
2. **Story support, from the user's side** — each story verified by driving the released product through the public surface the extraction records, on the maintained experiments.
3. **Assumptions, formed cold and measured the same way** — once the story determinations land, one boxed synthesizer forms the user-vantage priors from user-visible material alone, and the run measures each on the same instrument. The claim is presumed rather than promised, and that difference governs what a contradiction means.
4. **Decision and concept support, from the technical side** — a decision by an adversarial reading of each claim against the code, a concept by the vocabulary reading: one live name, and the citing sites and the code around them agree with What it is and Boundaries. The reading track runs in parallel with the measurement track.
5. **Practice coverage, from the codebase** — each subject's population enumerated from the code, and every member placed: accounted for by a practice, violating the practice that governs it, or unaccounted. The coverage reading runs with the reading track, and the lint sweeps the project beside it.

Then one **judge** over every escalation — the determinations nothing could call `supported`, the practice violations the coverage reading found, the assumption contradictions, the corpus contradictions the extraction surfaced, and the orchestrator's driving observations, the lint's judgment-class violations among them — and the run ends. No fix loop, no re-audit, no third determination stage; the judge is terminal. The run leaves behind a corpus of current determinations, the assumption records with their dispositions, the surface intent and extraction (and, composed, the document types the walk landed), the maintained experiments, a run report in the archive, a commit that names itself, and — where gaps are real, practices are breached, or the intent did not settle an element — issues in the intake.

## The two axes

Every audit over a corpus artifact answers two independent questions on two frontmatter axes: **`text:`** — does the body comply with its authoring rules? — and **`implementation:`** — does the codebase support the claim at this commit? Both are recorded; they come apart. Only `implementation:` escalates to the judge: a `text:` defect is mechanical and is recorded in the audit file. The audit corpus and the intake are independent: the judge files intake issues by the ordinary conventions, and no audit carries an `issue:` field.

The instrument differs by what the artifact claims. A story promises a user outcome, so its instrument is measurement through the public surface — never a reading. A decision or concept describes internals no user-vantage run can see, so the run reads both rather than measuring them. A decision is read adversarially against the code. A concept is read as vocabulary: it has one live name, and the citing sites and the code around them agree with its What it is and its Boundaries. A concept's Purpose carries no determination. A subject claims a population, so its support is coverage-shaped: the count checked, enumerated from the code, and the members nothing accounts for. An **assumption** is not a corpus artifact — the run synthesized it — so it carries no `text:` axis and no verdict; its record carries a **disposition** (`held` | `trap` | `unverified`), and a contradicted assumption is documentation, not work: the judge confirms the trap and files nothing, unless its diagnosis shows a story is also violated — a story defect on the story's own track.

The canonical shape is `{{AUDIT-DEFINITION}}` and `{{AUDIT-FILE-FORMAT}}` in `../_shared/artifact-definitions.md`. No citations, no hashes, no line numbers; every universal comes back as a count plus its population; whether an audit still holds is a git question — how far HEAD has moved since the commit it names.

## Requires

The project root is the nearest ancestor of the working directory (itself included) holding `.ok-planner/`, never derived from `.git`. No `.ok-planner/` → say so and stop; there is nothing to audit.

The audit definition and file format this body transcludes, the auditor, coverage auditor, and judge prompts, the issue-file format the judge files by, the goal files the stages hand off, the intake module at `.ok-planner/bin/issues` every filing goes through, the task tracker at `.ok-planner/bin/tasks`, the lint at `.ok-planner/bin/plumbline`, and the profiles `ok-audit` and `ok-opus` under `.claude/agents/` are all vendored or materialized by ok-planner's converge. Missing any of them, say so and stop. Run `.ok-planner/bin/issues list`. It writes a note on stderr for each markdown issue file or stray line it skips; pass those notes to the owner, and go on. A run that cannot record a verdict, file a confirmed gap, or dispatch an auditor is not an audit. Materialization is the front door's administration (`/ok`).

`.ok-planner/design/` at the project root. Without a design corpus there is no concept, story, or decision to audit: say so, point at `/discover-design`, and run the coverage reading and the lint sweep alone, skipping the surface, the story and assumption tracks, and the reading of decisions and concepts.

`.ok-planner/subjects/` carrying at least one subject. A project that has authored none has no coverage to report: say so in one line, and file no coverage task. The lint sweep runs either way.

`.ok-planner/surface/surface.md` — the **surface intent**: one prose document naming which classes of element are public by default and which specific elements depart. The interactive intent stage below produces and maintains it; the owner may also edit the file between audits. Where it does not exist, the interactive stage authors it from zero.

Tell the owner how many concepts, stories, decisions, and subjects are in scope before dispatching anything.

## The spine

1. **Layout** — ensure the run's directories exist, per Layout below. Estate convergence is the front door's administration (`/ok`), never this run's.
2. **Resolve the tree.** The run audits the project as it stands. Read `git status`; a dirty tree gets one line saying so, and the run audits the working tree as it is — the audits name the commit they are recorded in.
3. **Surface** — the interactive intent stage with the owner, then the autonomous extractor dispatch, per Surface below. When `/document` invoked the run, the **documentation walk** follows immediately, before Enumerate, against the extraction just written; an à la carte run skips it. Everything downstream of the surface stage is autonomous — no reconciler tool, no committed member lists, no guidance hash, no stamped ruling. Run à la carte, hand the owner the `/goal` handoff line naming the vendored goal file at `.claude/skills/audit/goal.md` **once the interactive stage lands the intent**; the run proceeds hands-free whether or not the owner sets the goal.
4. **Enumerate** — the handoff gates this step: before enumerating anything, show the owner the `/goal` handoff line for this run — the audit's own (`.claude/skills/audit/goal.md`) when run à la carte, `/document`'s (`.claude/skills/document/goal.md`) when `/document` invoked it. The line has often been read hundreds of turns earlier; check that it was actually shown, and show it now if not. Then name the live artifacts and the feed order, by instrument: measurement items grouped by the surface elements they drive, reading items by code locality, subjects by where their populations live, so each task's items share one reading.
5. **Determine** — two tracks in parallel, each a set of tasks in the task run below: the **measurement track** (story determinations; then the cold-boxed assumption synthesis; then the assumption measurements on the same instrument) and the **reading track** (decisions adversarially read, concepts read as vocabulary, subjects read for coverage). The lint sweeps the project beside them. Auditors write their audit files as they finish each item. No subagent inside an auditor but the reading auditor's forks.
6. **Judge** — collect every escalation — each determination no instrument could call `supported`, each practice's violations, each assumption contradiction, each corpus contradiction, and your own driving observations — in the run's `escalations` pool, and file **one** judge task that consumes the pool.
7. **Verify** — if the judge or the surface extractor filed any issues, make them ruling-ready, per Verify below. Zero filings → skip, silently.
8. **Report** — write the run report to `.ok-planner/history/audits/<date>-<sha>-report.md`, in the shape Report below defines: the receipt facts (the scope's counts and dispositions, issues filed by id, the two shas) and the run narrative (the tasks filed and their usage, judge outcomes, diagnoses, every accumulated observation). The report is a record, never a channel: nothing lives only there, and nobody reads it to understand the project.
9. **Close-out** — commit, then stamp.
10. **Present, then stop** — only when the run was invoked à la carte: compose the owner's wrap-up **from the run report**, in the shape Present below defines, so a long run presents from what it wrote while fresh. The wrap-up closes on a receipt — complete and committed, the two shas, the report's archive path — and the turn ends there. Nothing is offered after it: the close-out already committed and stamped. Invoked by `/document`, the run ends silently at the stamp and `/document`'s own wrap-up covers both, reading the same report.

## The task run

Every auditor is a task in one run of the task tracker at `.ok-planner/bin/tasks`, and so is the judge. The run files the tasks. The drain loop at `.claude/skills/_tasks/drain.md` drains the run and dispatches them. The reason is the prompt cache. Every agent of one profile starts from the profile's system prompt and one identical message that names no task, so the whole first request is one cached prefix per profile for the whole run; the agent takes the oldest issued task filed for its profile with `tasks claim --agent <profile>`, and the task's id, prompt, and brief arrive as a tool result after the prefix. Determine below gives the run's shape — the run file, the prompt files, the profiles, the brief format, the pools. This section says how the run is driven:

- **Open the run before Enumerate.** Initialize it, write and register the five prompt files, register the profiles, and select it. One run per audit.
- **File a group per task, never a task per artifact.** A reading task groups decisions and concepts by code locality; its auditor reads the group's shared code once, files one ref task per ref forked from its own, closes its task, and forks one auditor per ref task, under `ok-audit`, the audit's forking profile. A coverage task groups three to five subjects whose populations live in the same part of the codebase; its auditor reads that code once and runs the subjects serially, forking nothing. A measurement task groups stories or assumptions by the surface elements they drive; its auditor runs the items serially, because their experiments share one deployment. Chain two tasks whose experiments reset the deployment with `--after`, so they never run at once.
- **Drain by the drain loop at `.claude/skills/_tasks/drain.md`.** `next` issues every ready task and prints one `run` line per profile with the count waiting; the loop starts that many agents of the profile, up to its concurrency cap, all under one identical message, stamps each task's usage as its agent returns, and calls `next` again only after every agent has returned. A `waiting` line names tasks still running or waiting on a dependency: let their agents return. A `waiting` line that lists a ref task under `fork-of` when no dispatched agent is still running names an orphan: `tasks retry <task>`, then `next` again. A task still issued and unclaimed after as many agents as tasks returned was claimed by nobody: retry it once with `tasks retry`, and file a second miss into the `escalations` pool with key `observation`.
- **Escalations ride a pool.** Every auditor files what it cannot call `supported`, and every practice violation it finds, into the `escalations` pool; the extractor's corpus contradictions, the lint's judgment-class violations, and your own driving observations go into the same pool from the session. The judge is one task that consumes the pool.
- **The run file is a record.** It is committed with the run's other output at close-out, and the report's narrative reads each task's usage from it.

## Layout

`mkdir -p .ok-planner/audits/concepts .ok-planner/audits/stories .ok-planner/audits/decisions .ok-planner/audits/subjects .ok-planner/audits/assumptions .ok-planner/audits/surface .ok-planner/surface/documents .ok-planner/experiments .ok-planner/history/audits`. Estate convergence is the front door's administration (`/ok`), never this run's.

## Surface

Two sub-stages: an **interactive intent stage** with the owner, then the **autonomous extractor dispatch**. A run `/document` invoked adds a third, the **documentation walk**, against the extraction just written. The interactive stage is the one place an à la carte `/audit` walks the owner; everything after the surface stage is autonomous against documents the run has just committed to.

### Interactive intent

You and the owner produce or update `.ok-planner/surface/surface.md` — the source of truth for what the project's user-facing surface is meant to be. The conversation runs top-down and stops when the intent is landed; nothing dispatches until it is.

- **Read the current document if it exists.** Summarize it back in a few lines — the general rules and the specific exceptions — and ask what has changed. A short "still current" passes the stage; transcribe edits and additions as you go.
- **Author from zero if it does not.** Open with the class question: "What is user-facing at all — which modules, services, or entry points?" Then, per class named user-facing: "is every one of these public, or are there specific exceptions?"
- **Work at classes first, elements only as exceptions.** "Every CLI verb under `plugins/*/skills/` is public except the `_shared/` bodies" is intent; a bullet listing 47 verb names is not, and it drifts the moment a verb is added. Only exceptions worth naming get named.
- **Get more specific only where a class has no clean rule.** Flag an element the owner cannot cover with a rule or exception in a one-line note; it becomes an intake issue after the extractor finds it. Keep the stage out of element-by-element walking.
- **Land the document.** Write the final text to `.ok-planner/surface/surface.md`, show the owner the diff, and confirm approval. This is the moment the intent is landed for the run.

The interactive stage is an à la carte run's only owner conversation, and a composed run's first of two. Open no other topics here — driving observations, prior defects, sprint plans belong in the run's report or, where they warrant a ruling, in the judge's escalations.

### The goal handoff

Once the intent is landed, hand the owner one line to paste; the run proceeds hands-free from there. In a run `/document` invoked, the handoff is `/document`'s own and comes after the documentation walk below; this line is for the à la carte run:

```
/goal the audit run described in .claude/skills/audit/goal.md is complete — every term of its goal rule verifies against this repository
```

The vendored goal file carries the driving brief and the goal rule; the run proceeds identically whether or not the owner sets the goal.

### Autonomous extraction

Dispatch the **surface extractor subagent** as `Agent (general-purpose, model: opus)` — a leaf agent (`{{LEAF-AGENT-RULE}}` from `.claude/skills/_shared/dispatch-discipline.md`); classification is an analytical job, so it rides opus, named here so no orchestrator inherits its session model by omission. The subagent reads `.ok-planner/surface/surface.md` (the intent the interactive stage just landed, or the file as the owner last edited it), walks the code and the deployment configuration under the project root and under each folder `.ok-planner/config.json` declares under `folders`, purpose-bound to classification, and writes `.ok-planner/audits/surface/extraction.json` — one entry per element the walk found. Each entry names the element's kind (discovered by the walk, never pre-declared: CLI verbs, HTTP routes, environment variables, config keys, ports, published files, protocol schemas, whatever the codebase exposes), its identifier, its location, whether the intent placed it public or internal, and — for a defaulted element — that the classification was defaulted. The extraction is a per-run artifact; nothing carries between runs.

The subagent's rules:

- **Read the intent, walk the tree, join the two.** The walk goes no deeper than classification requires. The intent's general rules cover most elements; its named exceptions cover the rest.
- **Residual ambiguity is asymmetric.** Where the intent does not clearly settle an element the walk suspects may be public, default it to internal for this run, mark the entry as defaulted, and file one intake issue per genuinely ambiguous element (kind `audit`, category `unclear`) asking the owner to amend the intent. File it through `.ok-planner/bin/issues file --from -`, one JSON object per `{{ISSUE-FILE-FORMAT}}` from `.claude/skills/_shared/artifact-definitions.md`. First run `.ok-planner/bin/issues list --category unclear`; where an open issue already asks about that element, file nothing. Do not page the owner and do not stall; the interactive stage already spent that attention.
- **Escalate corpus contradictions, never walk them.** An artifact asserting a posture the observed element violates — an "every surface authenticates" Choice beside an unauthenticated published port — is an escalation for the judge, quoting the claim and the evidence.

The orchestrator dispatches the subagent, consumes what it returned, and moves on. No mid-run walk with the owner beyond the interactive stage — except the composed run's documentation walk below. No reconciler tool, no committed member lists, no guidance hash, no stamped ruling. The extraction file is the record; the intent file is the source of truth; both are stamped with the closing commit at close-out.

Nothing in the surface phase files of its own motion beyond the extractor's residual-ambiguity issues. Contradictions go to the judge; everything else goes in the run report.

### The documentation walk (composed runs only)

When `/document` invoked this run, immediately after the extractor returns and before Enumerate, run the **documentation walk** defined under Walk in `.claude/skills/document/SKILL.md` — the one body, called here against the extraction just written. It reads the extraction's public side against the document types declared under `.ok-planner/surface/documents/`, raises only the deltas with the owner, and lands the types they approve; a type left unsettled is left out for the run and filed as an intake issue by the walk's own rule. An à la carte run does not run it: the walk belongs to the documentation ceremony, and this hook exists so a composed run keeps the owner's attention in one stretch — intent, extraction, documentation — before the hands-free portion. The walk's last act, by its own rule, is handing the owner `/document`'s goal line (naming `.claude/skills/document/goal.md`); Enumerate does not begin until that line has been shown. Everything after the walk is autonomous.

## Enumerate

Every file under `.ok-planner/design/concepts/`, `.ok-planner/design/stories/`, and `.ok-planner/design/decisions/` is in scope — no subset. **Concepts are audited like decisions**: the compliance axis reads any artifact against its own authoring rules, and a concept has rules of its own — the concept form, the altitude bar, self-containment, the no-implementation tightening. Its support axis is the vocabulary reading: the concept has one live name, and the sites that cite it and the code around them agree with its What it is and its Boundaries. A concept's Purpose carries no determination.

Every file under `.ok-planner/subjects/` is in scope too — no subset — one audit file per subject at `.ok-planner/audits/subjects/<slug>.md`. Practices get no audit file of their own. A practice claims that the members its condition covers follow it, and its subject's coverage audit answers that claim against the one population that makes the answer refutable; auditing practices apart would ask the same question against a set nobody enumerated.

**Stories are enumerated apart**, on their own instrument: story support is measured from the user's side, through the public surface the extraction records, never settled by reading. Group the stories by the surface elements their ways drive, the decisions and concepts by code locality, and the subjects by where their populations live in the codebase, three to five per group, so each task's items share one reading. Say how many artifacts ride each instrument, and in how many tasks, before filing. Assumptions are not enumerated here — the synthesis below creates this run's set after the story verdicts land.

## Determine

Three instruments, one collection, the same two words. Every track runs as tasks in the run's task run, under the vendored `ok-audit` profile, drained by the drain loop at `.claude/skills/_tasks/drain.md`.

### The run

Open the run before Enumerate:

1. `tasks init audit-<date>` — the run file at `.ok-planner/tasks/audit-<date>.jsonl`, committed at close-out. A second run on the same day passes `--force` and starts the file over.
2. Resolve each task prompt's transclusions — `{{IMPLEMENTATION-AUDITOR-PROMPT}}`, `{{STORY-AUDITOR-PROMPT}}`, `{{ASSUMPTION-AUDITOR-PROMPT}}`, `{{COVERAGE-AUDITOR-PROMPT}}`, and `{{AUDIT-JUDGE-PROMPT}}` from `.claude/skills/_shared/implementation-auditor.md` — then `mkdir -p .ok-planner/.cache/audit` and write each body to `.ok-planner/.cache/audit/<name>.md`, named `reading`, `story`, `assumption`, `subjects`, and `judge`. The directory is derived and ignored; every run rewrites it.
3. `tasks agent register ok-audit`, `tasks agent register ok-opus`, then `tasks prompt register <name> <path>` for each of the five.

A brief is two lists. The line `refs:` comes first, then one ref per line. For a measurement task, the line `surface:` follows, then the public elements the run's extraction records for the kinds the task's items drive, one per line as `<kind>: <identifier>`. Nothing else goes in a brief; the prompt carries everything shared, so the brief is the only thing that varies between tasks of one prompt.

**Decisions and concepts — the reading track.** A decision is read adversarially against the code; a concept is read as vocabulary. File one task per code-locality group: `tasks file --role reading --prompt reading --agent ok-audit --key reading --brief "<the brief>"`. The auditor reads the group's shared code once, files one ref task per ref forked from its own task (`--fork-of`), closes its task, and forks one auditor per ref task; each fork claims its ref task, writes its audit file to `.ok-planner/audits/<bucket>/<slug>.md`, files its `unsupported` line into the `escalations` pool, and closes its task with its report line. A ref task still listed under `waiting` with `fork-of` once the auditor's agent has returned is an orphan: `tasks retry <task>`, and the drain issues it to a fresh `ok-audit` agent that reads the code itself.

**Subjects — the coverage reading.** File one task per subject group: `tasks file --role subjects --prompt subjects --agent ok-audit --key subjects --brief "<the brief>"`, the brief listing `subject:<slug>` refs under `refs:`. The determination is coverage-shaped, per `{{AUDIT-FILE-FORMAT}}`: the count checked, the population it was enumerated from, and the members nothing accounts for — a gap, a collision, or a member whose governing practice only tracing beyond the point of use established. A member that departs from the practice governing it is a defect, not an unaccounted member: the auditor files each practice's violating members as one `violation` escalation, the practice slug as its fingerprint and every breaking site as `path:symbol` in its body. A violation does not count toward `unaccounted:`, so `unaccounted: 0` and `supported` still agree.

**Stories — user-vantage measurement.** File one task per surface-element group: `tasks file --role story --prompt story --agent ok-audit --key story --brief "<the brief>"`. The auditor runs its stories serially; chain any two tasks whose experiments reset the deployment with `--after`. The instrument is the experiments at `.ok-planner/experiments/` (one per directory: the runnable files plus a `record.md` — frontmatter `experiment:`, `commit:`; body: what it ran against, what was observed, quantities named):

- an archived experiment covering a claim is **read first, then run** at this tree — the auditor satisfies itself the instrument still drives the way before its run counts;
- one that no longer drives what it claims — a stale selector, a renamed element, an emptied population — is **repaired** first;
- a claim no archived experiment covers gets a **new** experiment;
- one whose surface elements are gone from the extraction is **retired**.

File the reading, coverage, and story tasks, then drain the run with the drain loop at `.claude/skills/_tasks/drain.md`. They run together; the assumption stage below begins when every story task is closed.

A story is `supported` only when passing runs driven through elements the extraction records public demonstrate the capability and the benefit. A passing run proves what the run drove and no more: the auditor names the elements exercised and the size of every population swept. A run over an empty population proves nothing. A failing run is never a defect; it dispatches diagnosis — stale probe, wrong probe, or wrong claim. Conclusions never carry: a prior run warrants nothing until re-run at this tree, and a `record.md`'s prior observation tells the auditor where to look, never standing as proof.

Each audit records the two independent axes per `{{AUDIT-DEFINITION}}`. The run files one task per group, never one per artifact, and no subagent runs inside an auditor but the reading auditor's forks.

### Synthesize, then measure the assumptions

After the story verdicts land, the run forms this run's **assumptions** — user-vantage priors — and measures them on the same instrument. Synthesis is cold and boxed:

1. **Build the box.** Export into a scratch directory outside the project tree — never a checkout — exactly the user-visible material: every story body and the story TOC, each annotated with this run's implementation verdict; every concept body and the concept TOC; the **rendered public surface** — the extraction's public entries per kind, rendered as plain member lists, never the extraction file itself; and the prior release's published documentation corpus (publishable layer only), where one exists. Nothing else enters: decisions, subjects, and practices are developer material, and audits, the extraction file, the experiments, sprints, issues, sketches, history, code, and tests stay out.
2. **Dispatch one synthesizer** with the fixed brief below, the box as its world: no repository path, no shell, no network, read-only file tools. Interpolate the box path and nothing else.
3. **Gate the output.** Scan the synthesizer's transcript for any access resolving outside the box; an out-of-box access voids the output, and the synthesis re-runs in a fresh box.
4. **Record the set.** Write each assumption as a story-shaped record to `.ok-planner/audits/assumptions/<slug>.md` — frontmatter `assumption:`, `commit:` (stamped at close-out), `disposition: unverified`; body: the prior as the user would hold it, and its source (a name's promise, sibling symmetry, a convention of the craft, a published concept, an ecosystem prior). The set is re-derived whole every run; no standing registry.

Then file the records as story tasks are filed — `tasks file --role assumption --prompt assumption --agent ok-audit --key assumption --brief "<the brief>"`, one task per surface-element group, the brief listing assumption slugs under `refs:` — and drain: experiments through the public surface, affirmative-only warrants, conclusions never carrying. A measured record closes with `disposition: held` (passing runs demonstrate the prior), `disposition: trap` pending the judge (a run demonstrates the product contradicting it), or `disposition: unverified` (no run could be taken). Every synthesized assumption ends the run carrying one of the three.

### The synthesizer brief

```
Agent (general-purpose, model: opus):
  ## Assumption synthesis — user vantage only

  You are working inside a closed box of user-visible material:
  [BOX PATH]. It is your entire world. You have no repository, no
  shell, and no network; do not attempt to read outside the box.

  ### Your job

  From this material alone, write down what a reasonable user would
  take to be true about this product before checking — the priors
  the material invites. You are not verifying anything: expectations
  only, written before measurement, so they cannot be softened to
  match what is found.

  ### Where assumptions come from

  Work the enumerable sources, in order, over the whole surface:
  - Names that promise observable behavior.
  - Symmetry between sibling elements: what exists for one, a user
    assumes for its siblings.
  - Conventions of the craft the product's shape invokes.
  - Expectations the published concepts license.
  - Ecosystem priors: what products of this kind normally honor.

  ### Output

  One assumption per record, story-shaped: the user role, the prior
  they would hold, and why they would hold it (its source above).
  Concrete enough that a run through the public surface could
  demonstrate or contradict it. Skip what no run could ever observe.
  Return the records as your final output; you write no files.
```

### Lint

Sweep the lint over the project with the Determine stage, from the project root — the run for the violations, and the binary's own clustering for the grouping. Given the project root as its target, the lint covers the root and each folder `.ok-planner/config.json` declares under `folders`:

```bash
node .ok-planner/bin/plumbline .
node .ok-planner/bin/plumbline patterns .
```

Exit 0 clean, 2 violations, 1 internal error; on exit 1, the report's Lint line carries the lint's message in place of the counts. The clustering is the binary's, not this run's: grouping violations by shape is a derivation with one home, and re-deriving it here would give the project two answers to the same question.

Split the clustered violations the way the owner has to act on them:

- **mechanical** — the fix is fully determined and changes no decision: residue, restatement, dividers, commented-out code, TODO markers (delete), a test file added or edited in flight (revert), and citations whose slug is a typo or a rename away from resolving (repoint).
- **judgment** — the fix would decide something: a comment naming a real constraint that should become an assertion, type, or name; a docstring block on a public-API surface that may warrant the file-level opt-in marker; an unresolved citation whose artifact may need creating or whose link may no longer be load-bearing.

Fix nothing. The mechanical class is recorded in the run report; each judgment-class violation is filed from the session into the `escalations` pool with key `observation`, for the judge, which files what it confirms.

## Judge

The `escalations` pool holds every escalation. The auditors filed theirs as they closed: key `unsupported` for a ref no instrument could support, `violation` for a practice's violating members, `trap` for a measured assumption contradiction, `blocked` for a precondition a measurement could not meet. The session files the rest before the judge. Each corpus contradiction the extractor returned goes in as `tasks item add --pool escalations --key contradiction --body "<the claim and the evidence>"`. Each of the orchestrator's own driving observations — defects noticed in the project, the estate, the suite, or the run's instruments — and each judgment-class lint violation goes in the same way with key `observation`. Then test the pool: `tasks item count --pool escalations --state open` exits 1 when nothing is open, and the run skips this stage and says so in the report. Otherwise file one task: `tasks file --role judge --prompt judge --agent ok-opus --key judge --consumes 'escalations:open:*'`, the consumes spec quoted so the shell leaves the `*` alone. Drain it. The claim hands the judge every open item. Each item carries its kind as its key, and its instrument and one-line reason in its body.

The judge is terminal, and its outcomes are asymmetric by what was escalated:

- **A story, decision, concept, or subject gap** — confirmed: `unsupported` stands, and the judge files an intake issue by the ordinary conventions (nothing stamped back into the audit). For a subject, the gap is a gap, a collision, or a traced member: the corpus asserts a population it does not account for, or a site's intent is not legible from the code, and only the owner can settle either. Overturned: rewritten `supported`, with the judge's own counts for a subject. An unmet promise is work, so it reaches the intake.
- **A practice violation** — confirmed: the judge files one `category: defect` issue per practice, kind `audit`, naming accept-list entry A8, every breaking site it confirmed, and the harm. Before filing, it lists the open defect issues on that practice with `.ok-planner/bin/issues list --artifact practice:<slug> --category defect`, and files nothing where one stands. Refuted: dropped, recorded in the run report. A ruled practice poses no question, so a violation never becomes a judgment issue.
- **An assumption contradiction** — confirmed: the disposition becomes `trap`, and nothing is filed — nothing was promised; a trap is documentation, not work. Overturned: `held`. Where the judge's diagnosis shows a story is also violated, that is a story defect on the story's own track.
- **An extraction contradiction or driving observation** — confirmed: intake issue filed (category `conflicting` for a posture contradiction). Refuted: dropped, recorded in the run report.
- **A harm in a part the project does not own** — a confirmed gap, contradiction, observation, or blocker whose fix lies in a file the suite owns, a library the project depends on, or an outside tool or service, a suspicion about the suite among them: the judge files it as an upstream issue, `category: upstream`, kind `audit`, with a draft ready to file, unless an open issue on the same harm already stands.

The compliance axis never escalates: a form defect is mechanical, recorded in the audit file, and a future sprint's work.

## Verify

If the judge or the surface extractor filed any, invoke `triage-issues`; it routes each one. Zero filings → skip, silently.

## Report

Write the run report to `.ok-planner/history/audits/<date>-<sha>-report.md` (`<sha>` stamped with the close-out commit). It is a record, never a channel: nothing lives only there, and nobody reads it to understand the project. Its one job is to let the run's ending be composed from what was written while fresh. Shape:

```
# Audit run — <project> at <short sha or "working tree">

## Receipt
Scope: <concepts, stories, decisions, and subjects: the count of each>
Stories: <supported / unsupported out of N>
Decisions and concepts: <the same split out of N>
Subjects: <the same split out of N; M members checked, K unaccounted>
Practice violations: <P practices, S sites; the defect issues filed by
id, and each practice whose open defect issue already stood>
Assumptions: <held / trap / unverified out of N synthesized>
Text: <all compliant | the noncompliant refs, one line each>
Surface: <N elements over K kinds discovered by the extractor, P
public / Q internal; D of Q defaulted internal because the intent did
not settle them (each such element filed as an intake issue)>
Experiments: <re-run / repaired / built / retired counts, each from
`tasks item count --pool experiments --key <re-run|repaired|built|retired>`;
the count prints on stdout, and its exit code 1 means zero, not failure>
Lint: <clean | N violations by category, then the mechanical /
judgment split with each judgment violation's outcome at the judge |
the lint's message on exit 1>
Issues filed: <every issue, by id, with the verify pass's outcome —
or "none">
Commits: <the two shas>

## Narrative
<The run as it went: the tasks filed, their groups, and each task's
usage as `tasks report` prints it, judge outcomes with the overturns
called out (the run's own error rate), diagnoses behind failing runs,
instruments repaired, and every driving observation — escalated ones
with the judge's verdict, the rest as the record of what was
noticed.>
```

## Close-out

The run commits its own output — what makes an audit a statement about a commit rather than a moment. Two commits, both this run's act:

1. Commit the audit corpus, this run's assumption records, the surface extraction, the document types a composed run's walk landed, the experiments' changes, the task run's file, the run report, and the intake's two files, `.ok-planner/issues.jsonl` and `.ok-planner/history/issues.jsonl`, wherever the run's filings or its verify pass changed them, with a message naming the run and its counts.
2. Stamp that commit's short sha into every audit's `commit:` field, every assumption record's, the extraction's `commit` field, and the run report's `<sha>` name segment and body; make one small follow-on commit. Each record then names the commit whose tree holds both the code it describes and the record itself — the same shape as the sprint close-out's `closed:` stamp.

**The staleness rule consumers key on:** this run's output paths are `.ok-planner/audits/` (the subject audits, the assumption records, and the extraction included), `.ok-planner/surface/` (the intent, and the document types a composed run's walk landed), `.ok-planner/experiments/`, `.ok-planner/tasks/`, `.ok-planner/issues.jsonl`, and `.ok-planner/history/audits/`. The audit is current for a later tree exactly when the diff from its stamped commit touches only those paths — a path-scoped diff, no tracked state. An owner edit to `surface.md` between audits moves the tree and warrants a fresh extraction like any other output-path edit. This is how `/document` avoids paying the measurement twice: the audit's committed outputs move the tree, and the diff shows nothing the audit measured changed.

Archive nothing else and offer nothing else: this run has no sprint, and the issues it filed stay in the intake until a planning ceremony or a `/converge` run closes them. Both commits land before the presentation, so the owner is never asked to authorize either — the presentation's receipt reports them.

## Present

Only when the run was invoked à la carte: compose the owner's wrap-up from the run report — never from summarized context — and deliver it as conversation rather than by pasting the report. Sections:

```
# Audit — <project> at <close-out sha>

Status: complete and committed

## What was determined
<The receipt's counts, a line each: the scope, stories, decisions and
concepts, subjects, practice violations, assumptions, surface,
experiments, lint.>

## What deserves your eyes
<The issues filed, by id, with the verify pass's outcome per
issue; the defect issues filed for practice violations; the traps
recorded; the judge's overturns; the driving observations that
survived. "None" per empty category.>

## Receipt
<The two close-out shas, and the run report's archive path.>
```

**The wrap-up is the run's last act.** It ends on the receipt and the turn ends there. There is nothing to archive — the report was written straight to the archive — and nothing to commit: the close-out made both commits. Offer neither, propose no follow-on work, name no next step, and ask no closing question. Every gap the run found is already an issue in the intake, a planning ceremony's business, and every confirmed practice violation a defect issue, the next `/converge`'s.

Invoked by `/document`, the run presents nothing — it ends silently at the stamp, and `/document`'s own wrap-up reads the same report.

## Boundaries

- Does not fix anything — not a corpus gap, a practice violation, a lint violation, or a malformed artifact. A real gap becomes an issue, a confirmed practice violation a defect issue, and a form defect is recorded in the audit file. No fixer, no architect, no cycle cap — there is no loop.
- **Files nothing of its own motion.** The judge, the extractor's residual-ambiguity issues, and, in a composed run, the documentation walk's unsettled-type issues are the run's only filing paths. A defect the run notices while driving is an escalation for the judge and a line in the report, never filed into the intake directly; an issue filed on your own motion pre-empts the owner under the appearance of bookkeeping.
- Dispatches no auditor and no judge directly. Each is a task in the run, dispatched by the drain under its profile; the surface extractor and the assumption synthesizer are the run's only direct dispatches.
- Does not build the project. The measurement instrument does execute the released product — through elements the extraction records public and nothing else.
- The experiments are the audit's instruments and stay in the collection, re-run every run. The run never proposes adopting one into the project.
- Does not compute staleness, maintain a re-audit set, or track what changed. Every artifact is read every run, every experiment re-runs, the assumption set and the extraction are re-derived whole. The currency rule is a question a consumer asks of git, not state this run maintains.
- Does not edit `.ok-planner/design/`, a subject, or a practice. The corpus's claims are the subject under audit, never edited to make an audit pass. Never authors a subject or a practice: which policies the codebase follows is the planning ceremony's business and the owner's. Never edits `.ok-planner/config.json`.
- **Writes the surface intent only through the interactive intent stage.** The owner is the intent's authority: the interactive stage co-authors it in-session, the extractor only reads it, and between audits the owner edits the file directly.
- Does not read `.ok-planner/sprints/`, `sketches/`, or `history/`. Project records are out of context; the run report is append-only output into the archive, not a license to read what lives there.
- **Asks the owner only in the surface stage, and does not stall the autonomous portion.** The interactive intent stage is an à la carte run's only owner walk, and a composed run's documentation walk is its last; once those land, residual ambiguities become defaulted-internal entries and intake issues, and the run finishes hands-free. Presentation happens once, at the end, from the report, and only à la carte.
- **Does not roll into follow-on work.** The presentation ends on the receipt and stops. Proposing a sprint, offering to fix a gap or close an issue, offering further archives or commits, and asking what to do next all re-open a finished run.
- Does not converge an estate, materialize a file, or repair the vendored layer. That is `/ok`, always a user action.

<!-- Materialized by ok-planner v25.0.0 — suite-owned; overwritten on converge; do not hand-edit. -->

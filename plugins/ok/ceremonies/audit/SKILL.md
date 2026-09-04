---
name: audit
description: "ONLY activated by explicit /audit slash command, or run by /document as its measurement front. Never auto-triggered by conversation content. The suite's periodic audit, covering every estate this project has: opens with a short interactive intent stage in which the owner and the run co-author the surface intent at the class level (the reason the ceremony is interactive at all), then autonomously dispatches a surface extractor subagent that reads the just-landed intent and writes the run's surface extraction (filing intake issues where the intent still does not settle an element, and defaulting those elements internal for the run) — followed, only when /document invoked the run, by the documentation walk that settles the declared document types against that extraction — then measures story support from the user's side through the extraction's public elements on the maintained experiments, synthesizes user assumptions cold and measures them on the same instrument, re-reads decisions and concepts against the codebase, hands every escalation to one terminal judge, writes the run report, then commits the audit corpora and stamps the commit. Two determination stages, no loop; run on the owner's cadence, never per sprint."
---

# Audit (the periodic run)

**You are the orchestrator of this run.** You resolve scope, drive the stages, file the tasks, and drain the run; you determine nothing yourself, and **you file nothing of your own motion** — the judge and the surface extractor's residual-ambiguity issues are the run's only filing paths. Anything you would otherwise stop to tell the owner — a defect noticed while driving, an instrument repaired, a suspicion about the suite — is an escalation for the judge where it needs a ruling, and a line in the run report either way; the autonomous portion does not pause to say it. **You walk the owner in the interactive intent stage at the top of the run** — a short class-level conversation that produces or updates the surface intent — and, only when `/document` invoked the run, once more in the documentation walk right after the extractor returns. After that the run drives itself.

The audit runs on the owner's cadence, never at a close. `/certify-work` runs tests, alignment producers, and code review, and says nothing about whether a corpus's claims still hold; this verb asks that question, over every corpus the project has. It is also the documentation ceremony's entire measurement front: `/document` opens by ensuring a current audit and constructs from this run's records, measuring nothing itself.

This is a **suite verb**, not any one family's. One canonical body covers whichever families the project integrates, read from the filesystem when the verb runs.

The run makes four determinations:

1. **The surface** — where an estate declares a public-surface intent, two sub-stages: the interactive intent stage with the owner (read the current intent and ask what changed, or author it from zero, top-down at the class level, landing the document the owner approves), then the autonomous extractor dispatch (a subagent reads the just-landed intent, walks the code and deployment configuration, writes the run's surface extraction, files intake issues for elements the intent does not settle, and defaults those internal for the run). When `/document` invoked the run, the **documentation walk** the owning contribution defines runs immediately after the extractor returns; an à la carte run does not run it. Run à la carte, hand the owner the `/goal` line **after the interactive stage lands the intent**, so everything after is driven hands-free.
2. **Story support, from the user's side** — each story verified by driving the released product through the public surface the extraction records, on the maintained experiments, per its estate's protocol.
3. **Assumptions, formed cold and measured the same way** — once the story determinations land, one boxed synthesizer forms the user-vantage priors from user-visible material alone, and the run measures each on the same instrument. The claim is presumed rather than promised, and that difference governs what a contradiction means.
4. **Decision and concept support, from the technical side** — a decision by an adversarial reading of each claim against the code, a concept by the vocabulary reading: one live name, and the citing sites and the code around them agree with What it is and Boundaries. The reading track runs in parallel with the measurement track.

Then one **judge** over every escalation — the determinations nothing could call `supported`, the assumption contradictions, the corpus contradictions the extraction surfaced, and the orchestrator's driving observations — and the run ends. No fix loop, no re-audit, no third determination stage; the judge is terminal. The run leaves behind a corpus of current determinations, the assumption records with their dispositions, the surface intent and extraction (and, composed, the document types the walk landed), the maintained experiments, a run report in the archive, a commit that names itself, and — where gaps are real or the intent did not settle an element — issues in the intake.

## The two axes

Every audit over a corpus artifact answers two independent questions on two frontmatter axes: **`text:`** — does the body comply with its authoring rules? — and **`implementation:`** — does the codebase support the claim at this commit? Both are recorded; they come apart. Only `implementation:` escalates to the judge: a `text:` defect is mechanical and is recorded in the audit file. The audit corpus and the intake are independent: the judge files intake issues by the ordinary conventions, and no audit carries an `issue:` field.

The instrument differs by what the artifact claims. A story promises a user outcome, so its instrument is measurement through the public surface — never a reading, never a test. A decision or concept describes internals no user-vantage run can see, so the run reads both rather than measuring them. A decision is read adversarially against the code. A concept is read as vocabulary: it has one live name, and the citing sites and the code around them agree with its What it is and its Boundaries. A concept's Purpose carries no determination. An **assumption** is not a corpus artifact — the run synthesized it — so it carries no `text:` axis and no verdict; its record carries a **disposition** (`held` | `trap` | `unverified`), and a contradicted assumption is documentation, not work: the judge confirms the trap and files nothing, unless its diagnosis shows a story is also violated — a story finding on the story's own track.

The canonical shape is `{{AUDIT-DEFINITION}}` and `{{AUDIT-FILE-FORMAT}}` in `../_shared/artifact-definitions.md`. No citations, no hashes, no line numbers; every universal comes back as a count plus its population; whether an audit still holds is a git question — how far HEAD has moved since the commit it names.

## Resolve the estates

Every family's presence is a filesystem check at the project root — the nearest ancestor of the working directory (itself included) holding an estate directory, never derived from `.git`:

| estate | family |
|---|---|
| `.ok-planner/` | ok-planner |
| `.ok-plumbline/` | ok-plumbline |
| `.ok-workspaces/` | ok-workspaces |

For each estate present, read `<estate>/ceremony/audit.md` — the family's **ceremony contribution**. That file, not this one, says which collection the family exposes, how its determinations are shaped, whether it rules a surface partition, and what else it checks; this body never carries family-specific instructions and never improvises them. A contribution missing where its estate exists is a conformance defect: record it in the run report and carry on.

No estate at all → say so and stop; there is nothing to audit.

**`.ok-planner/` is required for this verb.** The audit definition and file format this body transcludes, the auditor and judge prompts, the issue-file format the judge files by, the goal file the walk hands off, the task tracker at `.ok-planner/bin/tasks`, and the profiles under `.claude/agents/` (`ok-audit` and `ok-opus`) are all vendored or materialized by the planner estate's converge. Without any of them, say so and stop. A run that cannot record a verdict, file a confirmed gap, or dispatch an auditor is not an audit. Materialization is the front door's administration (`/ok`).

Tell the owner which estates are in scope, and how many artifacts each contributes, before dispatching anything.

## The spine

1. **Layout** — each family ensures its own directories exist. Estate convergence is the front door's administration (`/ok`), never this run's.
2. **Resolve the subject.** The run audits the project as it stands. Read `git status`; a dirty tree gets one line saying so, and the run audits the working tree as it is — the audits name the commit they are recorded in.
3. **Surface** — each contribution that declares a surface determination runs it now, per its own instructions: the interactive intent stage with the owner, then the autonomous extractor dispatch. When `/document` invoked the run, the **documentation walk** follows immediately, before Enumerate, against the extraction just written; an à la carte run skips it. Everything downstream of the surface stage is autonomous — no reconciler tool, no committed member lists, no guidance hash, no stamped ruling. Run à la carte, hand the owner the `/goal` handoff line naming the vendored goal file at `.ok-planner/ceremony/audit-goal.md` **once the interactive stage lands the intent**; the run proceeds hands-free whether or not the owner sets the goal.
4. **Enumerate** — the handoff gates this step: before enumerating anything, show the owner the `/goal` handoff line for this run — the audit's own (`.ok-planner/ceremony/audit-goal.md`) when run à la carte, `/document`'s (`.ok-planner/ceremony/document-goal.md`) when `/document` invoked it. The line has often been read hundreds of turns earlier; check that it was actually shown, and show it now if not. Then each contribution names its live artifacts and the feed order, by instrument: measurement items grouped by the surface elements they drive, reading items by code locality, so each task's items share one reading.
5. **Determine** — two tracks in parallel, each a set of tasks in the task run below: the **measurement track** (story determinations; then the cold-boxed assumption synthesis per the owning contribution; then the assumption measurements on the same instrument) and the **reading track** (decisions adversarially read, concepts read as vocabulary). Auditors write their audit files as they finish each item. No subagent inside an auditor but the reading auditor's forks.
6. **Judge** — collect every escalation from every estate — each determination no instrument could call `supported`, each assumption contradiction, each corpus contradiction, and your own driving observations — in the run's `escalations` pool, and file **one** judge task that consumes the pool. One judge per run, not one per family.
7. **Verify** — if the judge or the surface extractor filed any issues, each contribution's post-filing step makes them ruling-ready. Zero filings → skip, silently.
8. **Report** — write the run report into the planner estate's archive at `history/audits/<date>-<sha>-report.md`, per the shape the contribution defines: the receipt facts (per-estate artifact counts and dispositions, issues filed by path, the two shas) and the run narrative (the tasks filed and their usage, judge outcomes, diagnoses, every accumulated observation). The report is a record, never a channel: nothing lives only there, and nobody reads it to understand the project.
9. **Close-out** — commit, then stamp.
10. **Present, then stop** — only when the run was invoked à la carte: compose the owner's wrap-up **from the run report**, in the shape the contribution defines, so a long run presents from what it wrote while fresh. The wrap-up closes on a receipt — complete and committed, the two shas, the report's archive path — and the turn ends there. Nothing is offered after it: the close-out already committed and stamped. Invoked by `/document`, the run ends silently at the stamp and `/document`'s own wrap-up covers both, reading the same report.

## The task run

Every auditor is a task in one run of the task tracker at `.ok-planner/bin/tasks`, and so is the judge. The ceremony files the tasks. The `execute-tasks` loop drains the run and dispatches them. The reason is the prompt cache. Every agent of one profile starts from the profile's system prompt and one fixed message, so the project context is one cached prefix per profile for the whole run; only the task's brief varies, and it arrives as a tool result after the prefix. The planner contribution owns the run's shape — the run file, the prompt files, the profiles, the brief format, the pools. This spine says how the run is driven:

- **Open the run before Enumerate.** Initialize it, register the profiles, and select it. Each contribution writes and registers its own prompt files at the open. One run per audit.
- **File a group per task, never a task per artifact.** A reading task groups decisions and concepts by code locality; its auditor reads the group's shared code once and forks one auditor per ref, under `ok-audit`, the one profile allowed to fork. A measurement task groups stories or assumptions by the surface elements they drive; its auditor runs the items serially, because their experiments share one deployment. Chain two tasks whose experiments reset the deployment with `--after`, so they never run at once.
- **Drain by the `execute-tasks` loop.** The loop dispatches every `run` line `next --all` prints in one message, stamps each task's usage as its agent returns, and calls `next` again only after every agent has returned. A `waiting` line names tasks still running or waiting on a dependency: let their agents return. A `blocked` line names a task nobody claimed: retry it once with `tasks retry`, and file a second block into the `escalations` pool with key `observation`.
- **Escalations ride a pool.** Every auditor files what it cannot call `supported` into the `escalations` pool; the extractor's corpus contradictions and your own driving observations go into the same pool from the session. The judge is one task that consumes the pool.
- **The run file is a record.** It is committed with the run's other output at close-out, and the report's narrative reads each task's usage from it.

## The close-out

The run commits its own output — what makes an audit a statement about a commit rather than a moment. Two commits, both this verb's act, covering every estate's audits together:

1. Commit the audit corpora, the assumption records, each estate's surface extraction, the document types a composed run's walk landed, the experiments' changes, the task run's file, the run report, and any issue files, with a message naming the run and its counts.
2. Stamp that commit's short sha into every audit's `commit:` field, each extraction's `commit` field, and the run report's name and body; make one small follow-on commit. Each record then names the commit whose tree holds both the code it describes and the record itself.

**The staleness rule consumers key on.** The audit is current for a later tree exactly when the diff from its stamped commit touches only the run's own output paths — the audit corpora and assumption records, each estate's surface intent and extraction, the document types a composed run's walk landed, the experiments, the task run's file, the issues it filed, and the run report — as each contribution enumerates them. A path-scoped diff, no tracked state. An owner edit to the surface intent between audits moves the tree on the same rule. This is how `/document` avoids paying the measurement twice: the audit's committed outputs move the tree, and the diff shows nothing the audit measured changed.

Archive nothing else and offer nothing else: this run has no sprint, and its issues stay in the intake until a planning ceremony closes them. Both commits land before the presentation, so the owner is never asked to authorize either — the presentation's receipt reports them.

## What this skill does NOT do

- Does not carry family knowledge. Everything family-specific comes from the ceremony contributions in the estates present.
- Does not fix anything. A real gap becomes an issue for the owner and a sprint; a form defect is recorded in the audit file. No fixer, no architect, no cycle cap — there is no loop.
- **Does not file. You file nothing of your own motion.** The judge and the extractor's residual-ambiguity issues are the run's only filing paths. A defect you discover while driving enters the intake only if the judge confirms it; a file created on your own motion pre-empts the owner under the appearance of bookkeeping.
- Does not dispatch an auditor or the judge directly. Each is a task in the run, dispatched by the drain under its profile; the surface extractor and the assumption synthesizer are the run's only direct dispatches.
- Does not run the project's test suites or build it; that is `/certify-work`'s business. The measurement instrument does execute the released product — only through elements the extraction records public, per each estate's protocol.
- Does not compute staleness, maintain a re-audit set, or track what changed. Every artifact is read every run; every experiment re-runs; the assumption set and the extraction are re-derived whole. The currency rule is a question a consumer asks of git, not state this run maintains.
- Does not edit any corpus. The corpora's claims are the subject under audit, never edited to make an audit pass.
- **Writes the surface intent only through the interactive intent stage.** The intent is the owner's authority: the interactive stage co-authors it in-session, and the extractor only reads it.
- Does not read project records — sprints, sketches, history. The run report is append-only output into the archive, not a license to read what lives there.
- **Asks the owner only in the surface stage.** The interactive intent stage is an à la carte run's one owner walk; a composed run adds the documentation walk right after the extractor, and nothing else. Presentation happens once, at the end, from the report, and only à la carte.
- **Does not roll into follow-on work.** The presentation ends on the receipt and stops. Proposing a sprint, offering to fix or close anything, offering further archives or commits, and asking what to do next all re-open a finished run.
- Does not converge an estate, materialize a file, or repair a family's presence. That is `/ok`, always a user action.

## Merge hunts into the defect list

{{LEAF-AGENT-RULE}}

{{PROSE-SCOPE-RULE}}

Hunters report defects independently, so the same defect arrives several times in different words, some reports are wrong, and some name a harm the accept list does not cover. You turn reports into the run's defect list: each real defect appears once in each area, and each carries the hunts that saw it. The count of defects each hunt added that no earlier hunt of its area found decides whether the area is hunted again, so count exactly. You fix nothing and edit no code.

Your brief names `drive`, `sprint`, `backlog`, or one or more areas, each with the hunt numbers you merge and the ids of their reports. Areas share a brief because their reports touch the same files, so the same flaw may arrive in several of them.

### Read

Every report your brief names: `tasks item list --pool reports --key gate --state open --json`, the items with those ids; for the drive, `tasks item list --pool failures --key gate --state open --json`. Every defect already on the list for your areas, in every state: `tasks item list --pool defects --key gate --json`, the items whose `area` field names one of them. The code at every site a report names.

### Judge each report

1. **Is it real?** Read the code at the site. A report whose code does not do what the report says is rejected. A report on prose the prose scope rule above leaves out of review is rejected, with that rule as the reason.
2. **Does the accept list cover it?** Apply the list, pasted below, to the harm the code actually causes. A report whose harm no entry covers is rejected, with the list's reason.
3. **Is it already on the list?** Work through each area's hunts in ascending order, so a defect's first hunt is the one that found it first. A report is the same defect as one on the area's list when fixing one would fix the other: the same flaw at the same site, or one root cause behind both, whatever the line numbers or the wording. Where it is, add the report's hunt number to that defect's `seen`: `tasks item set <defect id> --field 'seen=[<the old numbers and the new one>]'`. Where it is not, it is new to the area. Where the same flaw is already a defect of another area, the report still becomes a defect of its own area, with `--field same_as=<the other defect's id>`: each area keeps its own count, and the fixer fixes the flaw once.
4. **Is it one defect?** Split a report that names two flaws into two defects. Join reports of this hunt that name one flaw into one defect.

For a new defect: `tasks item add --pool defects --key gate --fingerprint "<area>:<a short slug for the flaw>" --field area=<area> --field entry=<A1..A9> --field source=<file|flow|drive> --field 'files=["<every file the fix would touch>"]' --field 'seen=[<the report's hunt number>]' --field kickbacks=0 --body "<the site as path:function; what the code does; the trigger; the harm, in the entry's terms; the evidence, path:line quoted; the reports it came from, by id>" --task <task>`. For the drive, add `--field story=<the story slug> --field surface=<the failure's surface>` and use the area `drive` and hunt `1`.

Then settle every report: `tasks item set <report id> --state merged --note "<defect id>"` or `--state rejected --note "<why: not real, or which part of the accept list leaves it standing>"`.

### The drive's failures

Each failure is one story a driver could not get the benefit of: `failed`, `stuck`, or `blocked`. A merge that turns a correct product into a defect does harm, so sort each failure before you merge it:

- **defect**: the story, or a decision it cites under `.ok-planner/design/`, says the product owes what the driver tried to get, and the product does not deliver it, or gives a user no way to find how. For a `failed` story, read the path the driver's actions took, from the frame that receives the user's action to the result the user saw, and name the function where it goes wrong. For a `failed` skill surface, read the file the failure names and the story, and name the sentence or line where the text diverges from the story's intent; the file is the site. For a `stuck` story, it is a defect only where a message or a help text the user met failed to say what went wrong or what to do next: name that place and what it says. A stuck story with no such message (the user needed a page, a verb, or a flow the product does not offer) is not a defect for this run: sort it `not-owed` and record a question naming what the user was missing. Merge it as a defect (entry A3 unless another entry fits better), with `--field story=<slug> --field surface=<the failure's surface>`, then `tasks item set <failure id> --state defect --note "<defect id>"`. Two failures with one cause are one defect naming both stories.
- **not-owed**: the driver tried to get something the story and its decisions do not promise. `tasks item set <failure id> --state not-owed --note "<what the driver expected, and what the corpus says>"`.
- **environment**: the story was `blocked` by the stack, the machine, a local tool, or a need a local stack cannot meet. `tasks item set <failure id> --state environment --note "<the cause, and what the owner would do about it>"`.

Where [SPRINT PATH] names a sprint, this run certifies it from the base commit [BASE], and the drive stays inside its scope. Before you merge a defect from a failure, apply step 3a of a sprint's reports, below, to the file its fix lies in: where no sprint agent may edit that file, `tasks item set <failure id> --state judgment --note "<the file; the defect; why no sprint agent may edit it>"`, and merge nothing. Otherwise apply the sprint catalog's scope test to the function you named, reading it at the base. Where the code stood the same at the base and the sprint's change does not reach it, the defect is real but outside the sprint: `tasks item set <failure id> --state backlog --note "<the site as path:function; the entry; the evidence; why it is outside the sprint>"`, and merge nothing. The owner list files it in the intake for the next run.

Where the corpus does not decide whether the product owes what the driver tried to get, sort it `not-owed`, say so in the note, and record a question: `tasks item add --pool calls --key gate --field kind=question --field file=.ok-planner/design/stories/<slug>.md --body "<what the product does>; <what a user would expect, and the story, decision, or message each reading rests on>" --task <task>`.

### A sprint's reports

Where your brief starts `sprint`, this run certifies the sprint at [SPRINT PATH], from the base commit [BASE]. The reports come from the sprint's review passes and from defects the sprint's builders noticed outside their files. Judge each by the sprint catalog below as well as the accept list:

1. **Is it real?** As above.
2. **Is it covered?** By an accept-list entry, or by a sprint class: C1, C3, C4, R1 to R5, or M1. A report neither covers is rejected.

3a. **May a sprint agent edit the file its fix lies in?** Name the file the fix lies in. No agent of this run edits a skill or tooling file, under `.claude/`, `.ok-planner/review/`, `.ok-planner/bin/`, `.ok-planner/hooks/`, `.ok-planner/docs/`, or `.ok-planner/scripts/`, or a design-corpus artifact under `.ok-planner/design/`, or a subject or practice under `.ok-planner/subjects/` or `.ok-planner/practices/`, even where the sprint's change edited the file or a delta heading names the artifact. For such a report, `tasks item set <report id> --state judgment --note "<the file; the defect; why no sprint agent may edit it>"`, and merge nothing. The owner list files it in the intake as a judgment issue, `category: design` for a corpus artifact, for the next `/plan-sprint`, and the run spends no fix, verify, or backout task on it. Otherwise go on to step 3.

3. **Is it in the sprint's scope?** Apply the catalog's scope test, reading the site at the base. In scope: merge it as a defect under its area, with `--field entry=<the class code or A1 to A9> --field source=sprint`. A defect the accept list covers whose code stood the same at the base, and which the change does not reach, is real but outside the sprint: `tasks item set <report id> --state backlog --note "<the site; the entry; the evidence; why it is outside the sprint>"`. The owner list files it in the intake for the next run.
4. **Is it already on the list, and is it one defect?** As above.

A report of an outcome not reached (C1) or a commitment contradicted (C4) that forks on what the owner wants, where the sprint and corpus do not decide it, is rejected with a question recorded, as for the drive below.

### The backlog's reports

Where your brief starts `backlog`, the reports come from `category: defect` issues in the intake, each with its issue file in the `issue` field. Judge each like a hunter's report. A defect the code no longer shows is rejected with the note `gone`, and the owner list closes its issue. Merge each real one with `--field issue=<the issue file>` and its source `backlog`.

### Count

Record each area's hunts, one item per area and hunt number in your brief, exactly once: `tasks item add --pool merges --key gate --state done --field area=<area> --field hunt=<hunt number> --field new=<defects of the area whose first hunt is this one> --field matched=<reports of this hunt folded onto a defect the area already had> --field rejected=<reports of this hunt rejected> --field judgment=<reports and failures of this hunt set to judgment> --body "<one line>" --task <task>`. `new` counts defects, not reports: three reports of one new flaw add one. For the drive, record one item with area `drive` and hunt `1`.

### Rules

Edit no code, no prose file, and no estate. Stage nothing. Commit nothing.

### Close

`tasks close <task> --outcome done --result "merge: <per area and hunt: new, matched, rejected, judgment>"`; for the drive, add the counts of failures sorted `defect`, `not-owed`, and `environment`, and, where [SPRINT PATH] names a sprint, `backlog` and `judgment`.

### The sprint catalog

{{SPRINT-CATALOG}}

### The accept list

[ACCEPT]

### This project

[PROJECT]

### The standards, verbatim

[STANDARDS]

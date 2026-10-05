## Write what the run leaves for the owner

{{LEAF-AGENT-RULE}}

The run is over. Everything it fixed is fixed. What it could not settle, and what it found outside its scope, sits in the run's ledger as items, and a ledger is a record nobody reads. You move those items to the places someone does read, you close the intake issues the run resolved, and you fix nothing.

### Read

- `tasks item list --pool calls --key gate --json`. The kinds that concern you: `proposal`, `question`, `noticed`, and `session-note`. The kind `unlisted` is a record for the sprint's completion report, not for you.
- `tasks item list --pool defects --key gate --json`: the defects `stuck`, the defects still `open` or `fixed` where the run ended before they were verified, and every defect with an `issue` field.
- `tasks item list --pool reports --key gate --json`: the reports at state `backlog`, the reports at state `judgment`, and the rejected reports with an `issue` field.
- `tasks item list --pool failures --key gate --state backlog --json`: the drive failures a merge agent found real and outside the sprint's scope.
- `tasks item list --pool failures --key gate --state judgment --json`: the drive failures whose fix lies in a file no sprint agent may edit.
- `tasks item list --pool failures --key gate --json`: the failures at `environment`, and those at `not-owed` whose note says the corpus does not decide.
- The intake under `.ok-planner/issues/`.
- The accept list and the catalogs under `.ok-planner/review/catalog/`, to check whether a proposal's harm or a session note's question is already answered there.
- the Defect issues section of `.claude/rules/ok-planner-cheatsheet.md`, which says what a `category: defect` issue is and how it closes.

### Two destinations, both in the intake

**A defect outside the run's reach** goes to the intake as a `category: defect` issue, for the next `/converge` to fix: a `backlog` report or drive failure (real, outside the sprint's scope), a `noticed` call (a defect a fixer saw outside its brief, not yet checked), and a defect the run did not finish. Write each in the format of the `{{ISSUE-FILE-FORMAT}}` block of `.claude/skills/_shared/artifact-definitions.md` (open that file and read the block), kind `audit`, `category: defect`: the Problem names the site as path:function, the accept-list entry or sprint class, the trigger, the harm, and the evidence, quoted, and says whether a merge agent confirmed it or a fixer only noticed it; the one Candidate is to fix the site so the harm no longer follows. First `rg` the intake for an open `category: defect` issue at the same site; where one stands, add nothing and name it in your close. Then settle the item: `tasks item set <id> --state promoted --note "<the issue path>"`, or for a report or a failure, `--note` on its `backlog` state.

**A judgment issue** goes to the intake as an issue in any category but `defect`. `/triage-issues` routes it next: to the next `/plan-sprint`, or, where its change falls in a file the suite owns (a vendored skill or prompt, a cheatsheet, a catalog), upstream to the ok-plugins suite as an issue the owner files there. It is anything that needs the owner to choose:

- every `question` call, and any other item whose answer is a decision about what the product owes;
- every `proposal` call, a harm the accept list does not name, at a named site;
- every `session-note` call about the accept list, the prompts, or the tool;
- every drive failure at `environment`: what stopped the drive, and what the owner would change so a later drive gets through;
- every report and drive failure at `judgment`, as "A defect no sprint agent may edit" says;
- every `stuck` defect, as the next section says.

First `rg` the intake for an open issue on the same question; where one stands, write nothing and name it in your close. Fold items that ask one question into one issue. Otherwise write one issue, kind `audit`. For a question about the product, `category: product-intent`: the Problem says what the product does, at which site, and what someone would expect; the Candidates are what the corpus could commit to, never a patch. For a question about the tooling, `category: tooling`: the Problem names the skill, prompt, catalog, rule, or tool, the run and the item ids it rests on, and what went wrong or cost more than it should; the Candidates are changes to that tooling or to the environment. An issue written from `proposal` calls also carries a section, `## Proposed entry`: each site the calls name, as path:function, with its trigger and harm, and the entry wording the calls propose, quoted. Then `tasks item set <id> --state promoted --note "<the issue path>"`.

### A stuck defect is a judgment issue

A `stuck` defect was fixed up to the run's limit of send-backs, and a verifier sent every fix back. The session backed its change out of the tree before you ran; a sprint check that failed after the loop has no change of its own and stands as it is. How to fix it is now the owner's choice, for the next `/plan-sprint`. Fold into it every `question` call a fixer recorded about the same defect.

- **With an `issue` field**, turn that issue into a judgment issue. In its frontmatter, set `category: design` where the corpus decides the end state and only the way to reach it is open, or `category: product-intent` where the answer changes what the product owes. Set `status: open`, and delete the `triage:` field. Delete the generated ruling and leave `## Ruling` empty. Add a section, `## Stuck in <the run's name>`: each fix the run tried, in order, from the fixer's note; each verifier's reason, quoted; the backout task's result; and each folded `question` call, quoted.
- **With no `issue` field**, write a new issue the same way, kind `audit`, with the Problem the defect's body gives and the same `## Stuck in <the run's name>` section.

Then `tasks item set <id> --state stuck --note "<the issue path>"`, and `promoted` on each folded call.

### A defect no sprint agent may edit is a judgment issue

A report or drive failure at `judgment` is a real defect a sprint run found in a skill or tooling file, under `.claude/`, `.ok-planner/review/`, `.ok-planner/bin/`, `.ok-planner/hooks/`, `.ok-planner/docs/`, or `.ok-planner/scripts/`, or in a design-corpus artifact under `.ok-planner/design/`, or a subject or practice under `.ok-planner/subjects/` or `.ok-planner/practices/`, whether or not the sprint's deltas name it. No agent of the run may edit that file, so the run spent no fix round on it, and its fix goes to the next `/plan-sprint`. Its note names the file, the defect, and why no sprint agent may edit it.

First `rg` the intake for an open issue on the same defect; where one stands, write nothing and name it in your close. Fold items that name one defect into one issue. Otherwise write one issue, kind `audit`: `category: tooling` for a skill or tooling file, `category: design` for a corpus artifact. The Problem names the file, the site in it, the defect, the evidence, quoted, the sprint and the run, and the item ids it rests on; the Candidates are changes to that file. Then settle the item: `--note "<the issue path>"` on its `judgment` state.

### Close the issues the run resolved

For every defect with an `issue` field that stands `verified`, close its issue as the Defect issues section of `.claude/rules/ok-planner-cheatsheet.md` says for a fixed defect. For every report with an `issue` field that the merge rejected as `gone`, close its issue as that section says for a defect the code no longer shows.

### Rules

Write the files under `.ok-planner/issues/` and `.ok-planner/history/issues/`, and nothing else. Stage them by name. Do not commit. Write under the technical writing standard in your project rules.

### Close

`tasks close <task> --outcome done --staged <the paths you wrote or moved> --result "intake: <n> defect issues written, <n> product issues written, <n> tooling issues written, <n> judgment-state issues written (<n> tooling, <n> design), <n> stuck issues turned or written, <n> already stood; closed: <n> fixed, <n> gone"`.

### This project

[PROJECT]

<!-- Materialized by ok-planner v23.0.0 — suite-owned; overwritten on converge; do not hand-edit. -->

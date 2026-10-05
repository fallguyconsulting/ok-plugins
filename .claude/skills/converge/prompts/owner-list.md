## Write what the run leaves for the owner

{{LEAF-AGENT-RULE}}

The run is over. Everything it fixed is fixed. What it could not settle, and what it found outside its scope, sits in the run's ledger as items, and a ledger is a record nobody reads. You move those items to the places someone does read, you close the intake issues the run resolved, and you fix nothing.

### Read

- `tasks item list --pool calls --key gate --json`. The kinds that concern you: `proposal`, `question`, `noticed`, and `session-note`. The kind `unlisted` is a record for the sprint's completion report, not for you.
- `tasks item list --pool defects --key gate --json`: the defects `stuck`, the defects still `open` or `fixed` where the run ended before they were verified, and every defect with an `issue` field.
- `tasks item list --pool reports --key gate --json`: the reports at state `backlog`, the reports at states `judgment` and `upstream`, and the rejected reports with an `issue` field.
- `tasks item list --pool failures --key gate --state backlog --json`: the drive failures a merge agent found real and outside the sprint's scope.
- `tasks item list --pool failures --key gate --state judgment --json` and `--state upstream`: the drive failures whose fix lies in a file the run leaves alone.
- `tasks item list --pool failures --key gate --json`: the failures at `environment`, and those at `not-owed` whose note says the corpus does not decide.
- The intake under `.ok-planner/issues/`.
- The accept list and the catalogs under `.ok-planner/review/catalog/`, to check whether a proposal's harm or a session note's question is already answered there.
- the Defect issues section of `.claude/rules/ok-planner-cheatsheet.md`, which says what a `category: defect` issue is and how it closes.
- The fix line rule's five kinds of file a run leaves alone: the design corpus and the coding standards, a file the suite owns, an owner's declaration, a record, and a document the release regenerates. `.ok-planner/bin/review owner <path>...` prints `project`, `suite`, `corpus`, `declaration`, or `record` for each path. It does not detect a document the release regenerates: a file at a target a declared document type under `.ok-planner/surface/documents/` names (a folder target covers the folder), or a file that opens with the provenance stamp `/document` writes.

### Three destinations, all in the intake

**A defect outside the run's reach** goes to the intake as a `category: defect` issue, for the next `/converge` to fix: a `backlog` report or drive failure (real, outside the sprint's scope), a `noticed` call (a defect a fixer saw outside its brief, not yet checked), and a defect the run did not finish. Write each in the format of the `{{ISSUE-FILE-FORMAT}}` block of `.claude/skills/_shared/artifact-definitions.md` (open that file and read the block), kind `audit`, `category: defect`: the Problem names the site as path:function, the accept-list entry or sprint class, the trigger, the harm, and the evidence, quoted, and says whether a merge agent confirmed it or a fixer only noticed it; the one Candidate is to fix the site so the harm no longer follows. A `noticed` call was not checked against the fix line, so run `.ok-planner/bin/review owner <its file>` first. A `project` file that is not a document the release regenerates takes this route. A `corpus`, `declaration`, or `suite` file takes the route "A defect in a file the run leaves alone" gives. A `record`, or a document the release regenerates, changes only through the act that owns it: file nothing, and settle the call with `--state promoted --note "left alone: <record or release document>; nothing filed"`. First `rg` the intake for an open `category: defect` issue at the same site; where one stands, add nothing and name it in your close. Then settle the item: `tasks item set <id> --state promoted --note "<the issue path>"`, or for a report or a failure, `--note` on its `backlog` state.

**An upstream issue** goes to the intake as `category: upstream`, for the next `/plan-sprint` to walk with the owner. Its fix lies in a part the project does not own, so no run fixes it in place. It is:

- every report and drive failure at `upstream`, and every `noticed` call in a `suite` file, as "A defect in a file the run leaves alone" says;
- every `proposal` call, a harm the accept list does not name, at a named site: the accept list is suite-owned;
- every `session-note` call whose change lies in a file the suite owns: the accept list, the catalogs, a vendored skill or prompt, a cheatsheet, or a tool under `.ok-planner/bin/` (run `.ok-planner/bin/review owner <the file>`; `suite` decides it);
- every drive failure at `environment` whose cause lies in a library the project depends on or in an outside tool or service.

First `rg` the intake for an open issue on the same harm; where one stands, write nothing and name it in your close. Fold items that name one harm into one issue. Otherwise write one issue in the format of the `{{ISSUE-FILE-FORMAT}}` block of `.claude/skills/_shared/artifact-definitions.md`, kind `audit`, `category: upstream`, `status: open`: the Problem names the foreign part as the project sees it (the package and its version, the tool, or the file's path as it sits in the project, never a path to a local checkout of the suite or of any other part), the site, the harm, the evidence, quoted, and the run and item ids it rests on; the Candidates are a workaround in the project, a filing upstream, or both; and the `## Upstream issue` section holds the draft ready to file, in the shape that block gives. Call the suite "the ok suite". An issue written from `proposal` calls also carries a section, `## Proposed entry`: each site the calls name, as path:function, with its trigger and harm, and the entry wording the calls propose, quoted. Then `tasks item set <id> --state promoted --note "<the issue path>"` for a call, or `--note "<the issue path>"` on a report's or a failure's state.

**A judgment issue** goes to the intake as an issue in any category but `defect` and `upstream`, for the next `/plan-sprint`; `/triage-issues` routes it next. It is anything else that needs the owner to choose:

- every `question` call, and any other item whose answer is a decision about what the product owes;
- every `session-note` call about the project's own tooling or environment;
- every other drive failure at `environment`: what stopped the drive, and what the owner would change so a later drive gets through;
- every report and drive failure at `judgment`, and every `noticed` call in a `corpus` or `declaration` file, as "A defect in a file the run leaves alone" says;
- every `stuck` defect, as the next section says.

First `rg` the intake for an open issue on the same question; where one stands, write nothing and name it in your close. Fold items that ask one question into one issue. Otherwise write one issue, kind `audit`. For a question about the product, `category: product-intent`: the Problem says what the product does, at which site, and what someone would expect; the Candidates are what the corpus could commit to, never a patch. For a question about the project's own tooling or environment, `category: tooling`: the Problem names the skill, prompt, rule, or tool, the run and the item ids it rests on, and what went wrong or cost more than it should; the Candidates are changes to that tooling or to the environment. Then `tasks item set <id> --state promoted --note "<the issue path>"`.

### A stuck defect is a judgment issue

A `stuck` defect was fixed up to the run's limit of send-backs, and a verifier sent every fix back. The session backed its change out of the tree before you ran; a sprint check that failed after the loop has no change of its own and stands as it is. How to fix it is now the owner's choice, for the next `/plan-sprint`. Fold into it every `question` call a fixer recorded about the same defect.

- **With an `issue` field**, turn that issue into a judgment issue. In its frontmatter, set `category: design` where the corpus decides the end state and only the way to reach it is open, or `category: product-intent` where the answer changes what the product owes. Set `status: open`, and delete the `triage:` field. Delete the generated ruling and leave `## Ruling` empty. Add a section, `## Stuck in <the run's name>`: each fix the run tried, in order, from the fixer's note; each verifier's reason, quoted; the backout task's result; and each folded `question` call, quoted.
- **With no `issue` field**, write a new issue the same way, kind `audit`, with the Problem the defect's body gives and the same `## Stuck in <the run's name>` section.

Then `tasks item set <id> --state stuck --note "<the issue path>"`, and `promoted` on each folded call.

### A defect in a file the run leaves alone is a judgment or an upstream issue

A report or drive failure at `judgment` or `upstream`, or a `noticed` call in a `corpus`, `declaration`, or `suite` file, is a real defect whose fix lies in a file no agent of the run may edit, so the run spent no fix round on it. Its note names the file, the defect, and the file's kind. The kind decides the issue's category:

- `corpus`, a design-corpus artifact, a subject, or a practice: `category: design`, for the next `/plan-sprint` to change through a sprint's deltas.
- `declaration`, an owner's configuration, harness settings, review facts, release boundaries, surface intent, or document type: `category: tooling`, for the owner to change.
- `suite`, a file the suite owns, at state `upstream`: `category: upstream`, naming the file as it sits in the project, with the `## Upstream issue` section "An upstream issue" gives.

First `rg` the intake for an open issue on the same defect; where one stands, write nothing and name it in your close. Fold items that name one defect into one issue.

- **With an `issue` field**, the item came from a defect issue the backlog took up: turn that issue into a judgment or an upstream issue. In its frontmatter, set the category above, set `status: open`, and delete the `triage:` field. Delete the generated ruling and leave `## Ruling` empty. Add a section, `## Left alone in <the run's name>`: the file, its kind, and why no agent of the run may edit it. For a `suite` file, add the `## Upstream issue` section too.
- **With no `issue` field**, write one issue, kind `audit`. The Problem names the file, the site in it, the defect, the evidence, quoted, the run and, in sprint mode, the sprint, and the item ids it rests on; the Candidates are changes to that file, or, for a `suite` file, a workaround in the project, a filing upstream, or both, with the `## Upstream issue` section.

Then settle the item: `--note "<the issue path>"` on its `judgment` or `upstream` state, or `--state promoted --note "<the issue path>"` for a call.

### Close the issues the run resolved

For every defect with an `issue` field that stands `verified`, close its issue as the Defect issues section of `.claude/rules/ok-planner-cheatsheet.md` says for a fixed defect. For every report with an `issue` field that the merge rejected as `gone`, close its issue as that section says for a defect the code no longer shows. For every report with an `issue` field that the merge rejected as `left alone`, close its issue the same way, `status: answered`, with a `## Ruling` that names the file, its kind, and the act that owns it: for a record, the act that writes it, such as a sprint's execution for a sprint, `/audit` for an audit or an experiment, or `/plan-sprint` and `/triage-issues` for an issue; for a document the release regenerates, `/document`.

### Rules

Write the files under `.ok-planner/issues/` and `.ok-planner/history/issues/`, and nothing else. Stage them by name. Do not commit. Write under the technical writing standard in your project rules.

### Close

`tasks close <task> --outcome done --staged <the paths you wrote or moved> --result "intake: <n> defect issues written, <n> product issues written, <n> tooling issues written, <n> upstream issues written, <n> left-alone issues written or turned (<n> design, <n> declaration, <n> suite), <n> stuck issues turned or written, <n> already stood; nothing filed for <n> records and release documents; closed: <n> fixed, <n> gone, <n> left alone"`.

### This project

[PROJECT]

<!-- Materialized by ok-planner v24.1.0 — suite-owned; overwritten on converge; do not hand-edit. -->

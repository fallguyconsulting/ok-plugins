---
name: plan-docs
description: "ONLY activated by explicit /plan-docs slash command. Never auto-triggered by conversation content. ok-planner's documentation planning session. It finds each docspec whose documentation is behind the product, from what changed since the docspec's stamp, and has a planner name which files a documentation sprint writes, changes, or drops, and which rules fire on each. The owner approves each docspec's first worked example and decides each change no sprint explains, then approves the plan once. The session ends at one approved documentation sprint, which runs unattended under /goal: writers, a cold style pass, and a fact loop that checks every claim against the tree until each holds or is cut."
---

# Documentation planning

`/plan-docs` is ok-planner's documentation planning session: an interactive session with the project owner that produces a **documentation sprint**. A documentation sprint is a plan to bring the project's documentation up to date with the product: one item per file to write, change, or drop, each with the rules that fire on it. Its execution writes documentation and doc comments, and nothing else. Only a documentation sprint writes documentation.

The owner starts it on their own schedule, usually before a release. A sprint declares what documentation the project keeps, as docspecs, and what its public surface is, as the surface intent. This session plans none of that: it changes no docspec, no surface intent, and no corpus artifact. A docspec that needs a reshape goes to the next `/plan-sprint`.

The machinery lives beside this body. `core.md` holds the edit rules, the claim definition, the planner's prompt, and the three task prompts. `doc-sprint-document.md` holds the documentation sprint's template. `skills/_shared/artifact-definitions.md` defines the docspec, its run state, and the surface intent. `.claude/skills/_sprint/shared.md` holds the run rules and the archive step the documentation sprint follows. A `{{TOKEN}}` names the block of that name in one of these files, and resolves only where the token stands alone on its line.

## 1. Layout

`mkdir -p .ok-planner/doc-sprints .ok-planner/history/doc-sprints`. Estate true-up is the front door's administration (`/ok`).

`.ok-planner/bin/docs` and `.ok-planner/bin/tasks` are required: where either is missing, say that `/ok` materializes it, and stop. Where `.ok-planner/docspec/` is missing or holds no docspec, the project declares no documentation: say that `/plan-sprint` declares a docspec, and stop.

A documentation sprint under `.ok-planner/doc-sprints/` that is not archived is still open: name it, say that it runs with `/goal <its path>` or that the owner archives it first, and stop. One plan stands at a time.

## 2. Window

Run `.ok-planner/bin/docs window --json`. Each entry names a docspec, its stamp, its worked example, its status, the reasons it is reached, the sprints closed since its stamp, and the count of ledger claims whose sources changed. A docspec stands `new` (no stamp: its documentation is written whole), `reached` (something it describes changed since the stamp), or `current`. Where every docspec is `current`, say that the documentation describes the product as it stands, and stop.

Tell the owner the counts in one line ("3 docspecs in the window: 1 new, 2 reached; 4 current"). Record the commit: `git rev-parse HEAD`.

## 3. Plan

Dispatch one `{{DOC-PLANNER-PROMPT}}` from `core.md` per docspec in the window, all in one message, with `[SLUG]`, `[WINDOW ENTRY]` (that docspec's entry, as JSON), and `[COMMIT]` filled. Each returns its items, its unexplained changes, a draft example where the docspec has none, and what keeps the docspec from being planned well.

## 4. The owner's answers

The session asks the owner two kinds of question, one per turn, in prose:

- **The worked example.** For each docspec in the window whose entry shows its worked example as `none`: where its documentation exists, show the owner one file of it, or its first entry, and ask whether it is the model the style pass should follow. Where none exists, show the planner's draft entry, and ask the same. The owner approves it, adjusts it, or declines. A docspec whose entry shows `declined` is not asked again, and its style pass works from the shape alone. An approved existing file and a decline are recorded at Terminal. An approved draft goes into the documentation sprint under its docspec's heading, with the file its entry goes in, and `.ok-planner/bin/docs stamp` records that file as the worked example once the run is committed.
- **A change no sprint explains.** For each unexplained change a planner returned, name the commit, its files, and what it changes for the reader. The owner picks one of two answers. *Describe it*: the documentation describes the product as it stands, and the items carry it. *Hold the docspec*: file an issue with `.ok-planner/bin/issues file --from -` per the `{{ISSUE-FILE-FORMAT}}` block of `skills/_shared/artifact-definitions.md`, kind `human`, the change as its `problem`, for the next `/plan-sprint`, and drop that docspec from this documentation sprint, so its stamp stays where it is.

Name each reshape a planner returned to the owner in one line, as work for `/plan-sprint`. A reshape holds nothing back: the documentation sprint writes the docspec as it stands.

## 5. Draft

Write the documentation sprint to `.ok-planner/doc-sprints/YYYY-MM-DD-<slug>.md` from `{{DOC-SPRINT-DOCUMENT-TEMPLATE}}` in `doc-sprint-document.md`: the window, the owner's answers, and one `### docspec:<slug>` heading per docspec the plan keeps, with its worked example and its items as the planners returned them. A docspec in the window whose planner returned no item has nothing behind: keep its heading with the one line `No item: nothing its reader sees changed.`, so the run's stamp moves it forward and the next window does not take the same change again. Copy the boilerplate verbatim.

## 6. Approval

Present the whole documentation sprint for approval. It is not final until the owner approves. A change the owner asks for that touches a docspec's items re-runs that docspec's planner.

## 7. Terminal

1. **Record the worked examples.** For each existing file the owner approved as a worked example: `.ok-planner/bin/docs example <slug> --path <file> --commit <the commit step 2 recorded>`. For each docspec whose example the owner declined: `.ok-planner/bin/docs example <slug> --declined`.
2. **Hand over the goal line.** Hand the owner the line that starts execution under the native `goal` mechanism, with this documentation sprint's filename stamped in, whole:

       /goal .ok-planner/doc-sprints/<name>.md

   The executing session states the goal's stop condition in its first message, as the documentation sprint's boilerplate says.

Then stop. The session writes only the documentation sprint, the issues it files through `.ok-planner/bin/issues`, and the worked examples it records through `.ok-planner/bin/docs`.

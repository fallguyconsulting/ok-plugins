---
name: plan-docs
description: "ONLY activated by explicit /plan-docs slash command. Never auto-triggered by conversation content. Plans one documentation sprint that brings the project's documentation up to date with the product."
---

# Documentation planning

`/plan-docs` is ok-planner's documentation planning session: an interactive session with the project owner that produces a **documentation sprint**. A documentation sprint is a plan to bring the project's documentation up to date with the product: one item per file to write, change, or drop, each with the rules that fire on it. Its execution writes documentation and doc comments, and nothing else. Only a documentation sprint writes documentation. The approved documentation sprint runs unattended under `/goal`: writers, a cold style pass, and a fact loop that checks every claim against the tree until each holds or is cut.

The owner starts it on their own schedule, usually before a release. A sprint declares what documentation the project keeps, as docspecs, and what its public surface is, as the surface intent. This session plans none of that: it changes no docspec, no surface intent, and no corpus artifact. A docspec that needs a reshape goes to the next `/plan-sprint`.

The machinery lives beside this body. `core.md` holds the edit rules, the claim definition, the planner's prompt, and the three task prompts. `doc-sprint-document.md` holds the documentation sprint's template. `skills/_shared/artifact-definitions.md` defines the docspec, its run state, and the surface intent. `.claude/skills/_sprint/shared.md` holds the run rules and the archive step the documentation sprint follows, and the handoff this session ends on. A `{{TOKEN}}` names the block of that name in one of these files, and resolves only where the token stands alone on its line.

## 1. Layout

`mkdir -p .ok-planner/doc-sprints .ok-planner/history/doc-sprints`. Estate true-up is the front door's administration (`/ok`).

`.ok-planner/bin/docs` and `.ok-planner/bin/tasks` are required: where either is missing, say that `/ok` materializes it, and stop. Where `.ok-planner/docspec/` holds no docspec and `.ok-planner/doc-state/` holds no run state, the project declares no documentation: say that `/plan-sprint` declares a docspec, and stop.

A documentation sprint under `.ok-planner/doc-sprints/` that is not archived is still open: name it. Where its stop record stands beside it (the same filename, `-stopped` before the extension and `.txt` as the extension), name the reason the record holds too. Where the record's first line reads `docs start: the plan must be made again`, the run stopped at its start because the plan no longer covers the product, and the plan can never run: offer to set it aside and plan again, and offer no `/goal`. On the owner's yes, take the documentation sprint and every file beside it that shares its filename, its stop record among them. First record each one's name in the closed-record ledger, `.ok-planner/bin/review close --kind archived --name doc-sprints/<its file name>`, skipping a name `.ok-planner/bin/review closed --kind archived --json` already lists. Then move each one to `.ok-planner/history/doc-sprints/` with no stamp, `git mv` for a tracked file and `mv` for an untracked one, and go on to the window. Where `review close` is missing or refuses, move nothing, report its message, and stop. On a no, stop. Otherwise say that it runs, or resumes where it stopped, with the documentation sprint's goal line in `{{PLANNING-HANDOFF}}` in `.claude/skills/_sprint/shared.md`, its path stamped in, or that the owner archives it first, and stop. One plan stands at a time.

## 2. Window

Run `.ok-planner/bin/docs window --json`. Each entry names a docspec, its stamp, its worked example, its status, the reasons it is reached, each sprint the closed-record ledger lists as closed since its stamp, with its closing commit, the count of ledger claims whose sources changed, `unmatched_classes`: each class its `## Lists` names that no line under the surface intent's `## Where each class is declared` matches, and two lists. `left` names each file the docspec's `## Where` covered at its stamp that the tree still holds and no standing docspec covers; `taken` names each file under its current `## Where` that its `## Where` at the stamp did not cover. A docspec stands `new` (no stamp, or a stamp the repository no longer holds, as after a rebase: its missing files are written whole and every claim in its existing files is checked), `reached` (something it describes changed since the stamp, or a list names a file), `current`, or `retired` (its docspec is gone and its run state stands: its planner drops the files it left). A retired entry also names `commit`, the commit the tool read the docspec at. An unmatched class leaves the status as it stands. Name each unmatched class to the owner in one line, as work for `/plan-sprint`, whatever its docspec's status: the surface intent names no declaring file for the class, so the reference cannot list its members. Where every docspec is `current`, say that the documentation describes the product as it stands, and stop.

Tell the owner the counts in one line ("4 docspecs in the window: 1 new, 2 reached, 1 retired; 4 current"). Record the commit, `git rev-parse HEAD`, and the tree the window read, the id that `GIT_INDEX_FILE="$(git rev-parse --git-path ok-planner-window-index)" sh -c 'git read-tree --empty && git add -A && git write-tree'` prints. That command hashes every file the tree holds, uncommitted work included, into an index of its own, and leaves git's index as it stands. The documentation sprint's Window records both, and the planning handoff reads both.

## 3. Plan

Dispatch one `{{DOC-PLANNER-PROMPT}}` from `core.md` per docspec in the window, all in one message, with `[SLUG]`, `[WINDOW ENTRY]` (that docspec's entry, as JSON), and `[COMMIT]` filled. Each returns its items, its unexplained changes, a draft example where the docspec has none, and what keeps the docspec from being planned well.

## 4. The owner's answers

The session asks the owner two kinds of question, one per turn, in prose:

- **The worked example.** For each docspec in the window whose entry shows its worked example as `none` and does not stand `retired`: where its documentation exists, show the owner one file of it, or its first entry, and ask whether it is the model the style pass should follow. Where none exists, show the planner's draft entry, and ask the same. The owner approves it, adjusts it, or declines. A docspec whose entry shows `declined` is not asked again, and its style pass works from the shape alone. An approved existing file and a decline are recorded at Terminal. An approved draft goes into the documentation sprint under its docspec's heading, with the file its entry goes in, and `.ok-planner/bin/docs stamp` records that file as the worked example once the run is committed.
- **A change no closing commit made.** For each unexplained change a planner returned, name the commit, its files, and what it changes for the reader. The owner picks one of two answers. *Describe it*: the documentation describes the product as it stands, and the items carry it. *Hold the docspec*: file an issue with `.ok-planner/bin/issues file --from -` per the `{{ISSUE-FILE-FORMAT}}` block of `skills/_shared/artifact-definitions.md`, kind `human`, the change as its `problem`, for the next `/plan-sprint`, and drop that docspec from this documentation sprint, so its stamp stays where it is.

Name each reshape a planner returned to the owner in one line, as work for `/plan-sprint`. A reshape holds nothing back: the documentation sprint writes the docspec as it stands.

## 5. Draft

Write the documentation sprint to `.ok-planner/doc-sprints/YYYY-MM-DD-<slug>.md` from `{{DOC-SPRINT-DOCUMENT-TEMPLATE}}` in `doc-sprint-document.md`: the window, the owner's answers, and one `### docspec:<slug>` heading per docspec the plan keeps, with its worked example and its items as the planners returned them. First check the path: a name is taken where `.ok-planner/doc-sprints/` holds a file of that name, or where `.ok-planner/bin/review closed --kind doc-sprint --json` lists an entry whose `name` is that file name, since `docs complete` reads a documentation sprint the closed-record ledger lists as terminal, or where `.ok-planner/bin/review closed --kind archived --json` lists `doc-sprints/<that file name>`, a documentation sprint set aside unrun. Read nothing under `.ok-planner/history/`. Where `review closed` is missing or refuses, report its message, say that `/ok` materializes the tool, and stop before writing anything. Where `YYYY-MM-DD-<slug>.md` is free, write the documentation sprint there. Otherwise write it to `.ok-planner/doc-sprints/YYYY-MM-DD-<slug>-<n>.md`, `<n>` the lowest integer from 2 whose name is free. Never overwrite an existing documentation sprint. A docspec in the window whose planner returned no item has nothing behind: keep its heading with the one line `No item: nothing its reader sees changed.`, so the run's stamp moves it forward and the next window does not take the same change again. A retired docspec keeps its `### docspec:<slug>` heading the same way: where its planner returned no item, the heading carries the `No item` line, so the stamp still removes its run state. Copy the boilerplate verbatim.

## 6. Approval

Present the whole documentation sprint for approval. It is not final until the owner approves. A change the owner asks for that touches a docspec's items re-runs that docspec's planner.

## 7. Terminal

1. **Record the worked examples.** For each existing file the owner approved as a worked example: `.ok-planner/bin/docs example <slug> --path <file> --commit <the commit step 2 recorded>`. For each docspec whose example the owner declined: `.ok-planner/bin/docs example <slug> --declined`.
2. **Leave the tree ready, then hand over the goal line.** Follow `{{PLANNING-HANDOFF}}` in `.claude/skills/_sprint/shared.md`, with `<goal path>` set to `.ok-planner/doc-sprints/<name>.md`, this documentation sprint's filename stamped in. The goal line carries the goal's whole condition, so the executing session restates it in no message.

Then stop. The session writes only the documentation sprint, the issues it files through `.ok-planner/bin/issues`, the worked examples it records through `.ok-planner/bin/docs`, and the commits the owner agreed to.

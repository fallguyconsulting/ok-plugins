---
issue: retired-run-tag-callers-never-repointed
kind: human
category: tooling
artifacts: []
status: verified
triage: question
opened: 2026-10-05T07:43:12Z
---

# Converge repoints the callers of the retired lint, but leaves the callers of the retired run-tag script on the old copy for good

The suite used to ship a separate workspaces family. Its estate, `.ok-workspaces/`, held a run-tag script, which mints one tag per verification run. The suite has since folded that family into ok-planner, whose own copy is `.ok-planner/bin/run-tag`. When `/ok` migrates a project, the converge core keeps the old copy, because project files still call it. The core then offers only to delete it, and recommends declining while any file names it. It offers no way to move those callers to the suite's copy. An owner who follows the recommendation keeps the retired script, and with it the retired estate directory, forever.

The same core handles the same situation differently for the retired lint. That gap is the defect. It also leaves a known bug in place: the suite's `run-tag` refuses an empty read of random bytes, and the old copy does not.

## Mechanism

`retired_script_offer` in `plugins/ok/families/ok-planner/admin/converge` builds one `retired-script` offer per kept script. Its only fix is `delete <path>`. It finds callers with `script_callers`, a `git grep -F` on the literal path, and recommends `decline` while that grep returns any file. `ADMINISTRATION.md` says the same. While the old copy stays, the workspaces migration keeps the `.ok-workspaces/` directory that holds it. So the recommended answer keeps the estate indefinitely, unless the owner repoints every caller by hand.

The lint's retirement solves this with a `script-path` offer. `script_path_offers` finds each project file that names the lint or `catalog-toc` under `.ok-plumbline/bin/`. For each, it drafts the whole new file with each listed line repointed to `.ok-planner/bin/` and every other line unchanged, and the core refuses a draft that changes any other line. The list of paths it repoints, `RETIRED_SCRIPT_PATHS`, names only the lint and `catalog-toc`. No run-tag counterpart exists.

The owner met this in the consumer project linescout, migrated from v23.0.0 to v24.0.0. Five tracked files called the old copy, `.ok-workspaces/bin/src-tag`. The offer listed four of them. The fifth, `src/gridiq/cli/instance.py`, builds the path from parts, so the literal grep missed it, as the offer's own text warns. The owner repointed all five by hand.

## State of play

The old copy keeps working, so nothing breaks today. No accept-list entry covers the gap as a defect. The empty-tag bug the old copy keeps needs the OS to fail a random read. The owner filed this as a tooling change. Two decisions bound its shape. decision:whole-file-ownership says the core never edits a file a human also edits, and anything else at a path the suite cares about "is presented for the owner's decision". A repoint must therefore be an offer with a draft, as `script-path` is. The plumbline cheatsheet's Uniformity rule ("One idiom per job") makes `script-path` the idiom for repointing a retired script's callers. No offer can find a path built in code.

## Options

1. Add a repoint offer for the retired run-tag copy, shaped like `script-path`. For each tracked project file that names the copy literally, the core drafts the whole new text with each listed line repointed to `.ok-planner/bin/run-tag` and every other line unchanged. Once the owner accepts the drafts, no file names the copy, the `retired-script` block recommends `accept`, and a second `/ok` removes the script and the estate. The block keeps its warning about paths built in code. Cost: one more offer kind in the converge core, its resolve branch, and the administration document's offer table and kept-scripts step.
2. Keep the current shape: the owner repoints the callers by hand. Cost: every migrated project whose files call the old copy keeps the retired estate for good, along with the empty-tag bug.

The ruling decides whether the converge core drafts the repoint of the retired run-tag script's callers, as it does for the lint's.

## Ruling

> Recommended ruling (/triage-issues): Option 1. Extend the lint's `script-path` repoint offer to the retired run-tag copy, wherever the old profile placed it. Each draft repoints only the listed lines to `.ok-planner/bin/run-tag` and leaves every other line unchanged. Once no file names the copy, the `retired-script` offer recommends `accept`, and the estate retires on the next `/ok`. The offer keeps its warning that a path built in code goes unseen.
>
> Rationale: story:converge-project-estate promises to bring "what an earlier release laid out" to the current version "in one deliberate act, so that upgrading the suite never costs me work I wrote". Today the run-tag migration ends with a retired estate the owner must clear by hand, and the lint migration does not. The Uniformity rule and the `script-path` sibling settle the offer's shape. decision:whole-file-ownership keeps it an offer with a draft the owner accepts, never a silent edit. Option 2 leaves the two retirements handling the same job two ways. The flip case: if almost no migrated project has literal callers, or most callers build the path in code, as one of linescout's five did, the offer would rarely fire. The owner might then prefer to state the hand repoint in the administration document and skip the code.

<!-- Owner: this is a recommendation, not your decision. Leave it
as-is to accept; the next /plan-sprint carries it. Edit the text to
redirect, empty the section to discuss live, or delete this note to
adopt the ruling as your own. -->

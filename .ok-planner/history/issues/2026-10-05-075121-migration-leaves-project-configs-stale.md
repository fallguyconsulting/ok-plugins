---
issue: migration-leaves-project-configs-stale
kind: human
category: tooling
artifacts: []
status: verified
triage: question
opened: 2026-10-05T07:51:21Z
---

# The v24 migration calls a project "in agreement" while its configuration still names retired estates and lacks the folders it owns

When `/ok` moves a project from v23 to v24, the converge core moves the retired estates (`.ok-plumbline/`, `.ok-workspaces/`, `.ok-review/`) into `.ok-planner/`. It then prints cleanup offers for the stale entries it knows about. Once the owner settles those offers, diagnose prints "in agreement with carried v24.0.0". In the consumer project linescout, four stale items survived that message, and no offer named any of them:

1. **No `folders` key.** linescout owns two folders beside its root, `../image` and `../runtime`. Its sprints already list them under `## Paths outside the project root`. v24 adds a `folders` list to `.ok-planner/config.json`. The lint, its edit hook, the review loop, the audit's sweep, and the surface extractor all read that list. The migration never proposed it. Until the owner added the key by hand, the lint failed every design citation under `../runtime`, and a converge fixer deleted a citation block to make its check pass.
2. **`ignore` names a retired estate.** `.ok-planner/config.json` kept `".ok-plumbline/"` in `ignore`. The migration moved the old lint config byte for byte and rewrites nothing in its `ignore` list.
3. **The review loop's `exclude` names retired estates.** `.ok-planner/review/config.json` kept `".ok-plumbline/"` and `".ok-workspaces/"` in `exclude`. The core already rewrites, with no offer, the `.ok-review/` entry of that list and every `standards` and `checks` entry that names a moved path. It leaves the other two retired estates in place. The only `exclude` offer covers `.claude/` and `.ok-planner/`.
4. **Project prose names a retired family's rules.** The project's own rule `.claude/rules/dev-loop.md` said verification runs the per-run image "the ok-workspaces rules require". The core removes the ok-workspaces rules file, and that rule now lives in the ok-planner cheatsheet. The `review-wording` offer catches a retired estate path in `review/project.md` alone. No offer reads the project's own rules files or its root `CLAUDE.md`.

The mechanism is one gap. The migration moves owner configuration as it stands and fixes only the entries it lists by name. Every entry outside that list passes silently, and diagnose reports agreement because no offer is pending. Items 2 and 3 name directories that no longer exist, so they change nothing a tool does today. They are dead configuration that the next reader must puzzle out. Item 1 cost real work: a lint failing on code the project owns, and a fixer that deleted citations to quiet it. Item 4 is guidance an agent reads that points at a file that is gone.

The story `converge-project-estate` asks that the owner can bring the whole suite presence current "in one deliberate act, so that upgrading the suite never costs me work I wrote". The story `project-spans-folders` asks "that no check the suite runs over my project misses code I own". The decision `whole-file-ownership` sets the consent rules. The suite's own retired-layout content is migrated mechanically. Owner-declared configuration is written only as transcription of the owner's explicit answers. The consumer's own rules file and memory file are categorically untouchable. The decision `project-declares-its-folders` keeps one `folders` list, defaulting to the root alone, and says a sprint's outside folders stay an addition for that sprint's change.

No accept-list entry covers these items as defects. The administration document does not promise that "in agreement" means every configuration value is current. The owner filed this as a change to the converge core: "it should merge/fix all relevant configurations". The sibling issue `retired-run-tag-callers-never-repointed` comes from the same migration and the same report.

## Options

Item 1, the `folders` key:

- **An offer drafted from the sprints.** When `.ok-planner/config.json` has no `folders` key and some live or archived sprint lists outside paths, offer a `folders` list. Draft it from those headings, filtered by the rules `config-check` applies: inside the repository, an existing directory. Cost: the core reads sprint records it reads nowhere else, and a heading that once scoped one sprint may name a folder the project no longer owns.
- **A notice with no draft.** Diagnose names the headings it found and tells the owner to declare `folders`. Cost: the owner writes the list by hand, and a notice is easy to miss beside "in agreement".
- **Keep as is.** Cost: every multi-folder project repeats linescout's failures until its owner reads the release notes.

Items 2 and 3, retired estates in `ignore` and `exclude`:

- **Extend the mechanical rewrite.** Remove every entry that names a retired estate directory from both lists, with no offer, beside the existing `.ok-review/` removal. Cost: two more owner-file edits on the administration document's list of exceptions.
- **Offer each removal.** Cost: one more question per migrated project, for an entry that cannot do anything.

Item 4, prose that names retired estates or rules:

- **Extend `review-wording` to project-owned rules files.** Offer a draft for each project-owned file under `.claude/rules/` (no suite stamp) whose lines name a retired estate path or a retired family's rules file. Root `CLAUDE.md` gets a report line naming the stale lines and no draft. Cost: a wider scan and more offers on a first converge.
- **Include root `CLAUDE.md` in the drafts.** Cost: it breaks `whole-file-ownership`'s untouchable memory file unless the owner amends that decision.
- **Keep as is.** Cost: agents keep reading guidance that cites a removed file.

The ruling decides which of these stale items the migration fixes, offers, or reports before diagnose may say "in agreement".

## Ruling

> Recommended ruling (/triage-issues): Make the migration account for all four items. Remove retired estate entries from `ignore` and from the review loop's `exclude` mechanically, beside the existing `.ok-review/` removal. Offer a `folders` list, drafted from the outside-path headings of the project's sprints and filtered by `config-check`'s rules, whenever the configuration has no `folders` key. Extend the `review-wording` offer to project-owned files under `.claude/rules/`. For root `CLAUDE.md`, print the stale lines in the report with no draft.
>
> Rationale: Items 2 and 3 are the suite's own retired-layout content. `whole-file-ownership` sends that content to mechanical migration, and the core already strips `.ok-review/` from the same list. One idiom per job means every retired estate leaves that list the same way. Item 1 is owner-declared configuration, so `whole-file-ownership` allows only an offer the owner accepts. A draft from the sprints serves `project-spans-folders`, because the sprints are the only record the tree holds of which folders the project owns. The offer stops once the owner writes any `folders` key, even one naming the root alone, so it never promises more than `project-declares-its-folders` does. Item 4 follows the `review-wording` precedent for owner prose. Root `CLAUDE.md` gets a report line alone, because the decision makes it untouchable. A report line informs the owner without editing the file. Flip case: if the owner reads "the consumer's own rules file" in `whole-file-ownership` to cover every project-owned file under `.claude/rules/`, item 4 becomes a report line for those files too. If the owner wants the core never to read archived sprints, the `folders` draft reads live sprints alone and falls back to a notice.

<!-- Owner: this is a recommendation, not your decision. Leave it
as-is to accept; the next /plan-sprint carries it. Edit the text to
redirect, empty the section to discuss live, or delete this note to
adopt the ruling as your own. -->

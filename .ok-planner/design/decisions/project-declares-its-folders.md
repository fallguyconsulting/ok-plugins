---
decision: project-declares-its-folders
---

# A project declares its folders in one list every tool reads

## Choice

A project declares the folders it owns in one list in ok-planner's
configuration, with no default (see also:
settings-have-no-code-defaults); a single-folder project lists the
estate root alone. Each entry is a
folder inside the repository. Every tool that lists or scopes the
project's code reads that list: the review tool in every `/converge`
mode, and the lint and its edit hook. A sprint's folders outside the
root stay an addition for that sprint's change. The estates stay in one folder; only the set of
code files grows. The list is the owner's own declaration. True-up
writes the estate root alone into a project that declares no list, and
proposes no other entry, whatever a sprint names.

## Rationale

A project whose code spans folders beside its root otherwise has no
way to say so. Prose in its rules changes nothing a tool lists, so a
hunt never reads those folders, and a fixer that cannot read one
builds a second copy of what it already provides. One list, because
ok-planner owns every tool that reads it: a tool that kept its own
list would drift, and the lint would again miss code the
review reads. Writing the estate root alone into a project that
declares no list keeps every single-folder project as it is. A folder
a past sprint changed says nothing about what the project governs now,
so a true-up that drafted it into the list would turn past work into a
proposed declaration, and a draft the owner declined would return on
every true-up.

## Alternatives

- One list per tool — each tool scoped on its own, and the lists
  drift apart.
- Folders outside the root only as a sprint lists them — reaches the
  files one sprint changes, and no drive, hunt, or lint.
- The whole repository as the project — reaches every folder, and
  sweeps code that belongs to other projects in the same repository.
- True-up drafts into the list each folder a sprint lists outside the
  root — the list follows past work rather than the owner, and a
  declined draft comes back on every run.

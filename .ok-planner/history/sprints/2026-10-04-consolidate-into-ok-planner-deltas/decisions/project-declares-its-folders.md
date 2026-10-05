---
decision: project-declares-its-folders
---

# A project declares its folders in one list every tool reads

## Choice

A project declares the folders it owns in one list in ok-planner's
configuration, defaulting to the estate root alone. Each entry is a
folder inside the repository. Every tool that lists or scopes the
project's code reads that list: the review tool in every `/converge`
mode, the lint and its edit hook, the audit's sweep, and the surface
extractor. A sprint's folders outside the root stay an addition for
that sprint's change. The estates stay in one folder; only the set of
code files grows.

## Rationale

A project whose code spans folders beside its root otherwise has no
way to say so. Prose in its rules changes nothing a tool lists, so a
hunt never reads those folders, and a fixer that cannot read one
builds a second copy of what it already provides. One list, because
ok-planner owns every tool that reads it: a tool that kept its own
list would drift, and the lint or the audit would again miss code the
review reads. The default keeps every single-folder project as it is.

## Alternatives

- One list per tool — each tool scoped on its own, and the lists
  drift apart.
- Folders outside the root only as a sprint lists them — reaches the
  files one sprint changes, and no drive, hunt, lint, or audit.
- The whole repository as the project — reaches every folder, and
  sweeps code that belongs to other projects in the same repository.

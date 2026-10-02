---
issue: project-spans-paths-beyond-its-root
kind: human
category: design
artifacts: []
status: open
opened: 2026-10-02T23:32:06Z
---

# A project cannot declare folders outside its root as its own, so agents miss code the project owns

## Problem

The suite treats one folder as the whole project: the folder that holds the estates (`.ok-planner/`, `.ok-plumbline/`, `.ok-workspaces/`). A project whose code spans more than one folder of its repository has no way to say so. Only a sprint can reach past the root, and only for the files it changes.

The review tool shows the limit. In `plugins/ok/families/ok-planner/scripts/review`:

- `scoped_files` lists the population every `/converge` hunt reads with `git ls-files ... -- .`, so it holds only files under the root.
- `changed_files` adds folders beside the root only when `outside_paths` reads them from a sprint's `## Paths outside the project root` section. `outside_paths` returns nothing without `--sprint`, so `drive`, `analysis`, and `defects` modes never see those folders.
- The seeded `review/seed/project.md` describes the root as the one folder, with sprint-listed folders as the only exception.

In the consumer project linescout, the root is `platform/`. Two folders beside it, `../image` (the firmware image a field unit runs) and `../runtime` (the device runtime a fleet pins), belong to the same project. In converge run converge-2026-09-21T020131, a drive found that the device container gave no shell. The fixer could not read `../image`, which has run the unit's WireGuard tunnel and stock `sshd` since 2026-09-15. So it built a second tunnel and a second `sshd` into the device harness, a Python program. That change put port 22 and the host-key path under two owners on a real board. It tied remote access to the program a firmware update replaces. It pulled a dependency into the harness that the image build does not install, which broke the image build. The fixer recorded the choice as a `call`, a kind that run's owner list never read, so the owner never saw it. In v23.0.0 the fix prompt records such a choice as a `question`, which the owner list sends to the intake, so that reporting gap is closed.

The consumer project worked around the limit in prose, in its own `.claude/rules/` and `review/project.md`. Prose does not change what `review` lists, so an `analysis` hunt still never reads `../image`.

## Candidate

Let a project declare the paths it owns, separate from the folder that holds its estates. For example, a `paths` list in `.ok-planner/review/config.json`, or a suite-wide project manifest, that defaults to `["."]`. Each entry is a folder inside the repository, relative to the estate root. Every tool and prompt that enumerates or scopes the project reads that list:

- `review`: `scoped_files`, `changed_files`, `areas`, `checks`, and `snapshot` take every declared path. Sprint-listed folders stay as an addition, not the only way out.
- The plumbline lint and `/audit`'s sweep cover every declared path.
- The surface extractor and the audit walk read every declared path.
- The seeded `project.md` and the prompts that paste it describe the project as the declared paths, not the estate root alone.

The estates stay in one folder. Only the code population grows.

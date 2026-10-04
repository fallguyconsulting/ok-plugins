# Release boundaries

## Converged projects

- **Across it:** every project whose vendored layer an earlier suite
  release wrote. A project updates only when its owner runs `/ok`, on
  the owner's schedule, and may skip releases.
- **What crosses it:** the estate folders and the file names inside
  them; every configuration file the estate holds and its fields; the
  rules file names under `.claude/rules/`; vendored skill names and the
  slash verbs they answer to; agent profile names; hook wiring in the
  project's committed harness settings and the hook script paths it
  names; the citation tags code carries and how each resolves; the task
  tracker's run log format; and everything the owner wrote that the
  estate holds: the design corpus, issues, sprints, sketches, subjects,
  practices, audits, experiments, the review estate's `config.json` and
  `project.md`, the surface intent, and the document types.
- **Where to look:** `plugins/ok/families/ok-planner/admin/` (the converge core and the
  administration document), the payload under
  `plugins/ok/families/ok-planner/`, and `plugins/ok/skills/ok/`.

## Installed plugins

- **Across it:** a user's machine, which installs `ok`, `ok-conduct`,
  and `ok-web` through the plugin system and updates each one when the
  user chooses, apart from any project.
- **What crosses it:** the plugin names, the output style name a user
  selects in settings, and the slash verbs each plugin answers to
  outside a project.
- **Where to look:** `.claude-plugin/marketplace.json` and each
  `plugins/*/.claude-plugin/plugin.json`, `plugins/ok-conduct/`, and
  `plugins/ok-web/`.

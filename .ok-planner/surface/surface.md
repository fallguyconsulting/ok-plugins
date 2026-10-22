# Surface intent

## What is user-facing

A user reaches the suite through the plugin system and through Claude
Code sessions. A user installs plugins from this repository's
marketplace, selects an output style in their settings, and types
slash commands in a session, inside a project or outside one. Every
other part of the repository is internal: the family's scripts, hooks,
templates, agent profiles, and administration files, the fields of a
project's configuration, the scripts the suite vendors under a
project's estate, the checks, and the dashboard's page source. The
release boundaries the project declares guard what a trued-up project
holds of these.

## Classes

- Plugins: every plugin the marketplace manifest lists is public, by
  its name.
- Slash commands: every skill a plugin ships, or the family the front
  door carries ships, is public as the slash command a user types to
  run it, with the arguments its text says it takes. A skill folder
  whose name starts with `_` holds shared text, not a skill, and is
  not a member.
- Output styles: every output style a plugin ships is public, by the
  name a user selects in settings.

## Where each class is declared

- Plugins: `.claude-plugin/marketplace.json`
- Slash commands: `plugins/ok/skills/*/SKILL.md`, `plugins/ok-web/skills/*/SKILL.md`, `plugins/ok/families/ok-planner/skills/*/SKILL.md`
- Output styles: `plugins/ok-conduct/output-styles/*.md`

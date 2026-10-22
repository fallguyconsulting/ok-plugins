---
docspec: readme
---

# The README

## Where

README.md
One file. It opens with what the suite is and how to install it, then
gives one section per class the docspec lists, in the order Lists
names them. Within a section, one entry per public element, in the
order its declaring files declare them.

## Reader

A person deciding whether to install the suite, or one who installed
it and looks up what a plugin, a slash command, or an output style
does. They have Claude Code and no copy of this repository's source.

## Covers

What the suite does for its reader, how to install each plugin, and
every public plugin, slash command, and output style: what each does,
the arguments it takes, and one example. It leaves out how the suite
works inside: the family's scripts, the estate's layout, the design
corpus, and the review loop, which agents learn from the rules a
true-up installs and from the source.

## References

- concept:skill
- concept:conduct
- concept:true-up
- concept:estate
- story:true-up-project-estate
- decision:one-vendored-family
- decision:lockstep-suite-version
- `.claude-plugin/marketplace.json`
- `plugins/*/.claude-plugin/plugin.json`
- `plugins/ok/skills/*/SKILL.md`
- `plugins/ok-web/skills/*/SKILL.md`
- `plugins/ok/families/ok-planner/skills/*/SKILL.md`
- `plugins/ok-conduct/output-styles/*.md`

## Lists

- Plugins
- Slash commands
- Output styles

## Shape

The file opens with what the suite does for its reader, then how to
install each plugin. Then one section per listed class: one paragraph
on what the class is and how a reader reaches its elements, then one
entry per public element, under a heading that names it exactly as a
reader types it. Each entry holds, in order:

1. What it does: one or two sentences, leading with the result.
2. Arguments: each argument it takes, and its default.
3. Example: one call and what the reader sees.

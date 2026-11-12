---
decision: ancestor-claude-md-left-to-the-owner
---

# The owner decides whether an ancestor folder's CLAUDE.md loads

## Choice

The suite writes no setting that keeps a CLAUDE.md file in a folder
above the project root out of the project's sessions and agents. The
front door's administration names each such file that the project's
harness settings do not already exclude, and recommends that the
owner list it under `claudeMdExcludes` in the project's settings. The
owner decides.

## Rationale

The harness loads every CLAUDE.md file in the folders above the
working folder into every session and every agent that loads
CLAUDE.md files. A project nested in a larger repository then carries
the parent's instructions into each of the hundreds of agents a
sprint runs, and each agent rereads them on every request. One
project excluded its parent repository's CLAUDE.md, which one of its
own rules already told every agent to ignore. Only the owner knows
whether a parent's instructions bind the project, so the suite names
the file and the setting, and writes nothing.

## Alternatives

- A consented settings entry the administration writes, as it wires the hooks — the suite would propose excluding instructions it cannot judge.
- No CLAUDE.md files on every profile — the agents also lose the project's own rules.
- Say nothing — each nested project pays for its parent's instructions in every agent until its owner notices.

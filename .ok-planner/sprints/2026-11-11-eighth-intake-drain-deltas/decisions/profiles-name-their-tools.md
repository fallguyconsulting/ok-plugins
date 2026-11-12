---
decision: profiles-name-their-tools
---

# Each vendored profile names the tools its jobs use

## Choice

Each vendored agent profile but the drive profile names a tools list
in its frontmatter:
only the tools its jobs use, and never the Skill tool, so its agents
start with no skill listing and with no names of tools that load on
request beyond the ones the list names. The opus profile lists the
shell, the tools that read, search, and edit files and notebooks,
and the language server tool. The haiku profile lists the shell and
the tools that read and search files. The review profile lists the
shell, the tools that read and search files, the language server
tool, and the Agent tool its root forks with. The test profile lists
the shell and the tools that read, search, and edit files (see also:
lean-profiles-carry-their-rules).

The drive profile runs the drivers, and it alone names no list: it
denies the Agent and Skill tools and keeps every other tool the
session has, so a driver reaches the browser tools and every other
MCP tool the project wires, whatever their names.

## Rationale

Every agent of a profile rereads its starting context on every
request. On one project a sprint ran 1,820 agents. Probe agents put
the first request at 51,289 tokens with only the Agent tool denied,
42,056 with the Skill tool denied as well, and 36,870 with a tools
list of four tools. The skill listing is about 9,200 tokens of that
floor, and the names of the tools that load on request about 5,200
more. No agent of a vendored profile invokes a skill: every suite
skill runs on its slash command or from the session its guard names
as its caller, never from an agent of a vendored profile (see also:
slash-only-activation). So the listing costs every request and does
nothing.

A tools list drops every tool it does not name, MCP tools included.
The suite writes a vendored profile without knowing which MCP servers
a project wires or what their tools are called, and a driver needs
the browser server's tools to use a page as a user would (see also:
drive-tries-each-story-as-a-user). So the drive profile keeps the
session's tools and pays for the names of the tools that load on
request. The drivers run on a profile of their own so that the
build, fix, and review agents, which far outnumber them, pay for none
of those names.

## Alternatives

- Inherit every tool and deny only the Agent tool — every agent rereads the skill listing and every deferred tool name on every request.
- Deny the Skill tool alone on every profile — drops the skill listing, and every agent still rereads the deferred tool names.
- Drivers on the opus profile, which then names no list — every build and fix agent rereads the deferred tool names the drive needs.
- True-up writes the project's MCP tool names into the drive profile's list — true-up could read which servers a project wires, never which tools each server offers.
- One profile per role, each with its own list — every new role adds a profile to vendor, and roles that share a list gain nothing.

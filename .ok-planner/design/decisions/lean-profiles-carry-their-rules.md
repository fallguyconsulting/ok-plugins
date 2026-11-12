---
decision: lean-profiles-carry-their-rules
---

# A lean profile carries the suite's rules for its role in its own body

## Choice

The cheatsheet's rules files load whole and with no path scope. The
session and the agents of every general profile load them, with every
other rules file and CLAUDE.md file the project holds. A lean profile
serves a narrow set of jobs. It starts its agents without the
harness's loading of CLAUDE.md files and unscoped rules files, and its
body, which is the agent's system prompt, carries the suite's rules
for its role instead. A test agent must never run without the rules.
A lean profile is owned by the suite and has a narrow role, so its
body carries only rules the suite authors: no project rules file and
no CLAUDE.md goes into it. True-up writes the body (see also:
lean-body-copied-word-for-word), and a stale body stops the profile's
work (see also: stale-lean-body-stops-test-work).

The test profile is the one lean profile. It runs the test-support,
test, verify, and speed tasks of a sprint's test stages, and the
test tasks sprint certification files. The suite sections its
body carries are those that bind writing and judging a test file: the
comment, DRY, uniformity, error, writing, and test sections of the
plumbline cheatsheet; the coding rules on enumerating sites before an
edit, copying the sibling's shape, cleaning up on every exit,
importing instead of copying, and closing with the record; and the
rule to batch independent tool calls. Each role's prompt reaches the
agent in its claim's output, as it does on every profile.

## Rationale

One sprint on one project ran 713 test-stage agents. Each test-write
agent's first request read a cached prefix of 69,550 tokens, and its
later requests, 12.9 on average, read it again. The rules files and
CLAUDE.md files came to about 31,800 tokens of that floor, most of it
the four cheatsheets. Probe agents with a tools list and no CLAUDE.md
files or unscoped rules started at 5,041 tokens. The suite's sections
a test job never uses, and the project's rules and CLAUDE.md files,
are the saving. A test agent is the suite's own agent with a narrow
role: its prompt names the files it reads, and the suite's sections
it carries are the rules that role follows. Project content stays out
of a body the suite writes. A project rule scoped by path still loads
when the agent reads or edits a file the rule matches. The body is
the system prompt, which compaction keeps.

The session and the general profiles keep every rule loaded by the
harness because their jobs reach any part of the rules: planning,
building, fixing, hunting, and reviewing. Path-scoping the cheatsheets
is the other way to shrink every agent's start, and it loses: a scoped
rule loads only when an agent reads or edits a matching file, not
when a skill or a script reads one, and past a size limit the agent
sees only the rule's start.

A role's prompt stays in the claim's output because the executing session writes
it for each sprint run, with the sprint's path in it, and true-up writes the
profile body once per true-up.

## Alternatives

- Path-scoped cheatsheet parts on the test paths, and no rules in the profile body — a part loads only on a matching read or edit, and a skill or script read loads none.
- A tools list on the test profile and every rule still loaded by the harness — about 14,400 tokens off the floor, and the 31,800 tokens of rules stay.
- Every project rules file and CLAUDE.md copied into the body as well — project content in a suite-owned agent whose narrow role its prompt already bounds, and a body that grows with every project rule.
- One profile per test role with the role's prompt in its body — the prompt joins the cached prefix, and the executing session writes the prompt for each sprint run while true-up writes the body per true-up.
- No CLAUDE.md files or unscoped rules on every profile — the build and fix agents lose the project's own rules, which their jobs follow.

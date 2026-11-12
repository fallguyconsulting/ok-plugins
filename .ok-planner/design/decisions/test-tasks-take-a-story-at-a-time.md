---
decision: test-tasks-take-a-story-at-a-time
---

# A test task takes a story's scenarios, up to a chunk the project sets

## Choice

A sprint's write stage files one test task per story, or, where a
story has more scenarios to write than `testing.chunk`, one per chunk
of at most that many of its scenarios. Each test task carries the
brief of every scenario it takes, and holds every test file those
scenarios name, so two chunks of one story that share a test file run
one after the other. The rewrites of a story's sent-back tests take
one task per chunk the same way. The verify stage files one verify
task per test task. `testing.chunk` is a required setting with no
default in code (see also: settings-have-no-code-defaults), and the
owner sets it with `/ok-setup` (see also:
testing-set-up-by-its-own-verb).

## Rationale

An agent per scenario reads the same story, the same test file, and
the same test support files again before it writes one test. On one
project one sprint's test stage ran 223 test-write agents for the
scenarios of 14 stories, two of them 45 agents each. Reads of a file
an earlier agent of the same story had already read cost 14% of those
agents' weighted tokens, and the 45 agents of one story took turns
editing one test file. One agent per story reads those files once. Its
context grows with each test it writes, so a story with many
scenarios needs a cap on how many one agent takes, and the cap that
suits a project depends on its tests, so the project sets it. A verify
task per test task reads the story and its tests once, as the writer
did.

## Alternatives

- One test task and one verify task per scenario: every agent reads
  the story, the test file, and its test support again.
- One task per scenario, the tasks of one story chained so each runs
  as a fork of the agent before it: each fork inherits every earlier
  agent's reading, and a long story's last fork carries all of it.
- One task per story with no cap: a story with many scenarios grows
  one agent's context with every test it writes.

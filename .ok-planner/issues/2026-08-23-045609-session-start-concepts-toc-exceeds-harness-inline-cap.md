---
issue: session-start-concepts-toc-exceeds-harness-inline-cap
kind: human
category: conflicting
artifacts: []
status: open
opened: 2026-08-23T04:56:09Z
---

# The ok-planner session-start hook inlines the whole concepts TOC, and the harness truncates it to a 2 KB preview

## Problem

`plugins/ok/families/ok-planner/scripts/hooks/session-start` builds one
`additionalContext` string: a paragraph about the suite's verbs, then the
framing "Before defining or invoking any term that appears here, open
`.ok-planner/design/concepts/<slug>.md` and read it", then the full text of
`.ok-planner/design/concepts.md`, read with `cat`.

Claude Code caps the hook output it inlines into context. Above the cap it
writes the payload to a file under the session's `tool-results/` directory
and hands the agent a block reading "Output too large (N KB). Full output
saved to: <path>" followed by "Preview (first 2KB):" and the first 2,048
bytes. The hook does not know this happened; its output was complete.

Observed on 2026-08-22 in `rimsky-core`, whose TOC lists about ninety
concepts. The payload was 10,630 bytes. The preview held both framings and
the rows `advisory-lock` through `auto-terminal`; `instance` and
`run-scope` existed only in the saved file. The agent used both terms in
its first reply without defining them, and when asked why, reported that
it had not seen them in the list and had not opened the file.

The framing's instruction refers to the per-concept files and presumes the
TOC is in front of the agent. Nothing in the payload tells the agent to
read the saved file, so on any project whose TOC exceeds the cap the
instruction binds only the concepts that sort first.

## Options

1. Emit slugs alone, no one-line definitions. Ninety slugs at about
   twenty bytes each fit under the cap, and the list lands inline whole.
   The agent opens `concepts/<slug>.md` for the definition, which the
   framing already tells it to do.
2. Keep the payload and add one sentence to the framing: "If the harness
   saved this output to a file, read that file before your first reply."
   Works at any TOC size; costs one read per session.
3. Emit the framing alone and tell the agent to read
   `.ok-planner/design/concepts.md` itself. Smallest payload; the TOC is
   always whole; every session pays the read.

Option 1 keeps the TOC in context without a tool call, which is the
property the hook was written for. The inline cap is the harness's, not
documented, and may move; options 2 and 3 do not depend on it.

## Ruling

Emit the framing alone and tell the agent to read `.ok-planner/design/concepts.md` before its first reply. The hook no longer inlines the TOC. The TOC reaches the agent whole on every project, and the payload never nears the harness cap. Applied to `plugins/ok/families/ok-planner/scripts/hooks/session-start`; the materialized copy under `.ok-planner/hooks/` converges on the next `/ok`.

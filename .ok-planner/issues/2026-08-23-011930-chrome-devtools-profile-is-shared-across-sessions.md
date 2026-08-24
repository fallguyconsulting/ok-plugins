---
issue: chrome-devtools-profile-is-shared-across-sessions
kind: human
category: conflicting
artifacts: []
status: open
opened: 2026-08-23T01:19:30Z
---

# The chrome-devtools server `/setup-web` writes shares one browser profile, so two sessions cannot both hold a browser

## Problem

`/setup-web` writes this entry into the project's `.mcp.json`:

```json
"chrome-devtools": {
  "command": "npx",
  "args": ["-y", "chrome-devtools-mcp@latest"]
}
```

Without `--isolated`, `chrome-devtools-mcp` launches Chrome against one
user-wide profile directory, `~/.cache/chrome-devtools-mcp/chrome-profile`.
Chrome lets one process hold a profile. The second session to open a page
fails every browser tool call with:

> The browser is already running for
> `~/.cache/chrome-devtools-mcp/chrome-profile`. Use `--isolated` to run
> multiple browser instances.

The owner runs several Claude Code sessions at once, across projects, and
expects each to open its own browser. Today that works only while no
earlier session's Chrome is still open. Observed on 2026-08-22: a
`linescout` session could not open a page because a `verantel` session's
Chrome, launched two days earlier, still held the profile. Each project's
`.mcp.json` carries the same default entry, so the collision crosses
project boundaries.

The skill's report step promises the opposite of what the entry delivers:

> The browser is headed, with a persistent profile at
> `~/.cache/chrome-devtools-mcp/chrome-profile-stable` — log into anything
> the work needs once and the session persists across runs.

The path it names is not the one the server uses, and "persists across
runs" is the property that blocks the second session.

## Options

1. Write `--isolated` into the default entry. Every server gets a
   temporary profile; sessions never collide. Sign-in cookies do not
   survive the session, so the report step's "log in once" promise goes.
2. Keep the shared profile and document the one-at-a-time constraint in
   the report step, replacing the wrong path and the persistence promise.
3. Give each project its own persistent profile through
   `--user-data-dir=<per-project path>`. Sessions in different projects
   never collide; two sessions in one project still do. Sign-in persists
   per project.

The server's `--user-data-dir` flag is the one to verify against the
current `chrome-devtools-mcp` release before choosing option 3.

## Ruling

**Generated ruling (transcribing the owner's in-session direction, 2026-08-24):**
Option 3, applied inline. The default entry now carries
`--userDataDir=${HOME}/.cache/chrome-devtools-mcp/profiles/<project-name>`
(the converge writes `<project-name>`; the current `chrome-devtools-mcp`
release documents the flag). `/setup-web` migrates its own prior
default entry when it finds one and otherwise keeps merge-never-clobber; the
report step now names the real profile path and the remaining
one-browser-per-project constraint. Applied to
`plugins/ok-web/skills/setup-web/SKILL.md`.

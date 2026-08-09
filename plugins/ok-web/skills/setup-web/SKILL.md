---
name: setup-web
description: "ONLY activated by explicit /setup-web slash command. Never auto-triggered by conversation content. One-pass, idempotent converge of a web project's agent-facing browser tooling: merges the chrome-devtools-mcp server into the project's .mcp.json (never clobbering existing entries), checks prerequisites, flags any superseded CDP-attach browser kit, and reports the one-time follow-ups. The intake point for future web-project MCPs and utilities."
---

# setup-web — Web Project Setup

One command gives the agent full browser control in this project — navigate,
click, fill, screenshot, accessibility snapshots, console messages, network
requests, script evaluation — via Google's official `chrome-devtools-mcp`
server. The server launches and owns its own headed Chrome with a persistent
profile, so there is nothing to launch, attach, or keep alive: the MCP tools
are self-describing and the agent uses them without further guidance.

The skill is a converge, not an installer wizard: run it on a bare project and
it writes the configuration; run it again and it verifies and repairs. It never
deletes anything, never edits application code, and never installs anything
user-scoped. As the suite adds web-project MCPs and utilities, they are added
here, each under the same merge-never-clobber discipline.

## Process

### 1. Locate the target

The target is `.mcp.json` at the project root: the nearest ancestor of the
working directory (itself included) that already holds a `.mcp.json`, or the
working directory itself when none exists yet. Never derive the root from
`.git` — the project may be a subfolder, submodule, or subproject of a repo
whose own root wants no tooling config. Committed project scope is the point —
the whole team inherits the server from the checkout.

### 2. Check prerequisites

- **Node.js LTS** — `node --version`, major 20 or newer.
- **Chrome stable** — on macOS `/Applications/Google Chrome.app`; elsewhere
  `google-chrome`/`chrome` on PATH.

A missing prerequisite is reported plainly with what to install; still write
the configuration (it is inert until the tools are used), and say so.

### 3. Merge the server entry

The entry to converge to:

```json
{
  "mcpServers": {
    "chrome-devtools": {
      "command": "npx",
      "args": ["-y", "chrome-devtools-mcp@latest"]
    }
  }
}
```

- No `.mcp.json` → write the file exactly as above.
- File exists, no `mcpServers.chrome-devtools` key → add the entry, touching
  nothing else in the file.
- Entry exists and matches → no-op; report that the project is already
  converged.
- Entry exists and differs → **never overwrite.** Show both versions and let
  the owner decide; a deliberate local variant (a pinned version, an attach-mode
  `--browser-url`, extra flags) outranks the default.

### 4. Flag superseded kits — flag only

If the project carries a hand-rolled CDP-attach browser kit — a `browser/` or
`debug-browser/` directory whose scripts `connectOverCDP`, or rules files
documenting a launch-then-attach workflow — name what was found and note that
the MCP server supersedes its interactive role. Retirement is the owner's
call, made outside this skill: nothing is deleted, moved, or rewritten.
Playwright *test suites* are not kits and are not flagged — they were never
part of the interactive tooling.

### 5. Report

State what changed (file written, entry added, no-op, or conflict surfaced),
then the one-time follow-ups:

- Restart the Claude Code session (or `/mcp` → reconnect) so the project
  server loads; approve it when prompted — the choice is remembered.
- Verify with `/mcp`: the `chrome-devtools` server should list tools such as
  `take_snapshot`, `navigate_page`, `click`, `list_console_messages`.
- The browser is headed, with a persistent profile at
  `~/.cache/chrome-devtools-mcp/chrome-profile-stable` — log into anything the
  work needs once and the session persists across runs.
- `@latest` keeps the server current with zero upkeep; a project that wants
  reproducibility instead can pin `chrome-devtools-mcp@<version>` in the entry
  it now owns.

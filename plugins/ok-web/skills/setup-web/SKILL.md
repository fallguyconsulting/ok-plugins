---
name: setup-web
description: "ONLY activated by explicit /setup-web slash command. Never auto-triggered by conversation content. Sets up a web project's agent-facing browser tooling."
---

# setup-web — Web Project Setup

One command gives the agent full browser control in this project — navigate,
click, fill, screenshot, accessibility snapshots, console messages, network
requests, script evaluation — via Google's official `chrome-devtools-mcp`
server. The skill writes two servers, and each launches and owns its own
Chrome: `chrome-devtools` runs a headed Chrome with a persistent per-project
profile, and `chrome-devtools-headless` runs a headless Chrome with an
isolated, throwaway profile. There is nothing to launch, attach, or keep alive:
the MCP tools are self-describing and the agent uses them without further
guidance. Sessions in different projects each hold their own browser.

The skill is an idempotent one-pass setup, not an installer wizard: run it on a bare project and
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

### 3. Merge the server entries

The entries to bring the project in line with, with `<project-name>` replaced by the project
root's directory name:

```json
{
  "mcpServers": {
    "chrome-devtools": {
      "command": "npx",
      "args": ["-y", "chrome-devtools-mcp@latest", "--userDataDir=${HOME}/.cache/chrome-devtools-mcp/profiles/<project-name>"]
    },
    "chrome-devtools-headless": {
      "command": "npx",
      "args": ["-y", "chrome-devtools-mcp@latest", "--headless", "--isolated"]
    }
  }
}
```

Claude Code expands `${HOME}` when it launches the server, so the committed
entry stays portable across machines. The per-project `--userDataDir` is the
fix this entry exists to carry: without it the server uses one user-wide
profile. Chrome lets one process hold a profile, so the second concurrent
session, in any project, fails every browser tool call. The headless entry
carries `--isolated` instead: each server process gets a temporary profile, so
any number of headless sessions run side by side, and none keeps a login.
Project-specific Chrome arguments, such as host-resolver rules, stay out of
both entries; a project adds them to the entries it owns.

- No `.mcp.json` → write the file exactly as above, with both entries.

Then apply these rules to each of the two keys, `chrome-devtools` and
`chrome-devtools-headless`, on its own:

- File exists, no `mcpServers.<key>` key → add that entry, touching nothing
  else in the file.
- Entry exists and matches → no-op for that entry.
- `chrome-devtools` alone: entry exists as the suite's previous default —
  exactly `["-y", "chrome-devtools-mcp@latest"]`, no further flags → the
  suite's own prior write; update it to the entry above and report the
  migration. No earlier release wrote a headless entry, so the headless key
  has no previous default.
- Entry exists and differs otherwise → **never overwrite.** Show both versions
  and let the owner decide; a deliberate local variant (a pinned version, an
  attach-mode `--browser-url`, extra flags) outranks the default.

### 4. Flag superseded kits — flag only

If the project carries a hand-rolled CDP-attach browser kit — a `browser/` or
`debug-browser/` directory whose scripts `connectOverCDP`, or rules files
documenting a launch-then-attach workflow — name what was found and note that
the MCP server supersedes its interactive role. Retirement is the owner's
call, made outside this skill: nothing is deleted, moved, or rewritten.
Playwright *test suites* are not kits and are not flagged — they were never
part of the interactive tooling.

### 5. Report

State what changed for each entry, `chrome-devtools` and
`chrome-devtools-headless` (file written, entry added, entry migrated, no-op,
or conflict surfaced); where both entries are no-ops, report that the project
is already set up. Then give the one-time follow-ups:

- Restart the Claude Code session (or `/mcp` → reconnect) so the project
  server loads; approve it when prompted — the choice is remembered.
- Verify with `/mcp`: the `chrome-devtools` and `chrome-devtools-headless`
  servers should each list tools such as `take_snapshot`, `navigate_page`,
  `click`, `list_console_messages`.
- Use `chrome-devtools-headless` for unattended work and for a second session
  in the same project: its profile is isolated and thrown away when the
  server exits, so it never contends with another session.
- Use `chrome-devtools` where the owner needs to watch the browser or log in
  once to keep a profile. Its browser is headed, with a persistent per-project
  profile at `~/.cache/chrome-devtools-mcp/profiles/<project-name>` — log into
  anything the work needs once per project and it persists across runs.
  Sessions in different projects never contend for it; two concurrent
  sessions in the *same* project share that project's profile, and only one
  can hold the headed browser at a time, so the second session uses the
  headless server.
- `@latest` keeps the server current with zero upkeep; a project that wants
  reproducibility instead can pin `chrome-devtools-mcp@<version>` in the entries
  it now owns.

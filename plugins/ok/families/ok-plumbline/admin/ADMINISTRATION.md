# ok-plumbline administration

The judgment side of this family's administration — everything the
deterministic core beside this document (`admin/converge`) cannot
encode. The suite's front door (`/ok`) reads this document when it
administers the family; nothing here is improvised by the
administrator, and nothing here is a user-facing verb.

The dot-directory layout, its module marker (`.ok-plumbline/package.json`,
whose fixed content `{ "type": "commonjs" }` makes the vendored binary and
hooks run regardless of what module type the consumer's root
`package.json` declares), cheatsheet, coding rules, vendored binary, the edit hook,
the writing and events standards (under
`.ok-plumbline/docs/`),
and vendored skills are suite-owned and converge without prompting. The
config's *contents* are owner-declared: never invented or edited by the
administrator's own judgment. Declaring happens in conversation — with
no config, the core offers one, the administrator drafts it from the
starter's detected proposal, and the core's `resolve` mode writes the
draft the owner approved.

## The core's modes

```
bash admin/converge            # converge: migrate layout, materialize the suite-owned layer
bash admin/converge diagnose   # read-only drift report via the family binary; exit 0 clean, 1 on drift, 3 when only cleanup offers await the owner
bash admin/converge wire-hooks # consented settings transcription — see below
bash admin/converge resolve <id> [keep-new|keep-old|--from <draft>]  # one consented cleanup — see below
```

Diagnose checks: the config (`.ok-plumbline/config.json`, or a root
`.plumbline.json` from the earlier layout) exists and parses cleanly
(and how many citation tags are declared, and whether it still carries
the retired `checks` key); the cheatsheet and the coding rules are committed; the vendored
binary, the edit hook (`.ok-plumbline/hooks/post-edit.js`), the writing
standard, and skills match the carried rendering; the module
marker (`.ok-plumbline/package.json`) is present and matches its
canonical content byte for byte — it carries no version stamp, so exact
content is what fidelity means for it, and absence or any drift is a
diagnosis failure whose remedy is converge; the budget baseline's
existence and location; the hook wiring in `.claude/settings.json`;
and the cleanup offers below.

## Cleanup offers — consent, then resolve

Diagnose and converge print one `CLEANUP OFFERED (ok-plumbline): <id>`
block for each item converge leaves for the owner: what is there, what
the fix does, the recommended answer, and the exact consent command.
The front door (`/ok`) presents every block in one question and runs
the command for each item the owner accepts. `resolve` re-reads the
offers, refuses an id diagnose would not report now, and applies that
one fix; it deletes with `git rm` where git tracks the path, so the
deletion is staged and recoverable. A block whose paths carry
uncommitted or staged-only changes prints an `Uncommitted:` line, and
a block whose paths sit behind a symbolic link prints a `Symbolic
link:` line. `resolve` refuses such an item, changing nothing, until
the owner commits those changes or removes the link and runs `/ok`
again. No offer has a choice that discards changes. Converge itself
removes the retired hooks, ceremony contributions, and standard, and
the suite-stamped files of a retired skill, with no offer. The consent command quotes the id, so a path with a space
stays one argument. Converge again after it. `/ok` records an offer
the owner declines as declined, and the next run offers it again. An
id is `<kind>:<path from the project root>`:

| id | what is there | the fix |
|---|---|---|
| `config-conflict:.plumbline.json` | both the root `.plumbline.json` and `.ok-plumbline/config.json` | `keep-new` deletes the root file; `keep-old` replaces `.ok-plumbline/config.json` with it |
| `budget-conflict:.plumbline-budget.json` | both the root `.plumbline-budget.json` and `.ok-plumbline/budget.json` | the same two choices |
| `config:<config path>` | no config, or a malformed one, defects listed | write the drafted config |
| `config-key:<config path>` | the retired `"checks"` key | remove the key, nothing else |
| `citation-tags:<config path>` | no `@subject:` or `@practice:` citation tag declared | add the two entries below, nothing else |
| `rule-file:.claude/rules/errors-reach-the-owner-frame.md` | a project rule file the coding rules at `.claude/rules/plumbline-coding.md` now carry, beside facts only this project holds, detected by its exact filename | write a non-empty draft as `.claude/rules/project-errors.md`, then delete the old file; an empty draft only deletes it |
| `collision:.claude/skills/<folder>` | the project's own unstamped files at paths this family vendors, listed in the block | delete the listed files and nothing beside them; converge writes the suite's copy, and the folder's other files stay |
| `retired-verb:.claude/skills/<name>` | files the project wrote in a skill folder at a retired name, listed in the block | delete the listed files |

A `config` or `rule-file` offer carries a `Draft:` line: the front
door writes the draft to a scratch path outside the project, shows it,
and on the owner's yes passes it as `--from <draft>`. A config draft
repairs the listed defects, drops the `"checks"` key, and keeps every
other key as it is. `resolve` refuses a config draft that does not
parse, carries a malformed citation or `tests` entry, keeps the
`"checks"` key, or adds, drops, or changes a key the offer does not
name. A `rule-file` draft is a short project rule holding only the
project's event helper by name and each project practice or rule file
the old file cites; where it names none, the draft is an empty file.
`resolve` refuses a draft that is not shorter than the old file, or
that repeats any sentence of eight or more words from
`plumbline-coding.md` or `plumbline-cheatsheet.md`.

## Identify overlapping project context

Per the integration contract, surface preexisting project guidance that
overlaps the family's territory before converging. Scan
`.claude/rules/` and the repo's conventional doc locations (root and
`docs/`) for coding-style / comment-policy / lint-convention documents
that are not suite-materialized (no version stamp) — e.g. a
hand-written style guide, a CONTRIBUTING section on comments, an
alternate lint cheatsheet. For each hit, **propose a conversion plan**
for the owner's consent: fold enforceable rules into the plumbline
config (`citations`, `ignore`, `tests`), keep the rest as a project-specific
rules file alongside the cheatsheet, or retire the document. Never
convert, edit, or delete such context silently — and never skip
surfacing it.

## The config collision

The core migrates a root `.plumbline.json` or `.plumbline-budget.json`
into `.ok-plumbline/` mechanically — contents untouched. When **both**
the old and new locations exist, it touches neither and offers a
`config-conflict` or `budget-conflict` with two choices. Show both
files with the offer. The binary honors the root config path until the
migration lands, so a not-yet-migrated project keeps working.

## Wire the hook — consent, then transcription

The edit hook executes from the project's own materialized copy at
`.ok-plumbline/hooks/post-edit.js`, through a `PostToolUse` entry in
`.claude/settings.json`. The entry carries the empty matcher, so it
fires on every tool and lints the file an Edit or Write touched. The
entry is owner-declared configuration, written **only** as
transcription of the owner's explicit yes, by the core's `wire-hooks`
mode. Diagnose compares the entry whole (matcher and hooks) and
reports a missing or drifted one as a `WIRING NEEDED` block carrying
the exact entry and the exact consent command; a project wired under
an earlier release, whose entry matches `Edit|Write` only, drifts this
way and re-consents. Diagnose also reports the retired entries an
earlier release wired — `PreToolUse` for `pre-write.js`, `Stop` and
`SubagentStop` for `stop-review.js` — and `wire-hooks` removes them
under the same consent. Present the block, ask, and on yes run the
command it names. Declined means declined — record it in the report
and write nothing.

## Declare a config, in conversation

Each of these needs the owner's judgment over a project-owned file, so
the core offers it and never fixes it silently:

- **Missing config** (the `config` offer): draft one from the
  starter's detection:

  ```bash
  node "<family>/bin/plumbline" starter .
  ```

  Present the detected config compactly with the offer — all three
  checks always run (plumbline is strict by default; there is no soft
  start and no disable switch), which citation tags it wires (e.g.
  ok-planner's `@concept:`/`@story:`/`@decision:` when `.ok-planner/`
  is present), which dirs it ignores. When detection is unambiguous and
  the owner has nothing to add, the offer is one yes/no. Where there
  are judgment calls (extra citation tags, generated dirs the heuristic
  missed), settle them in dialogue and redraft. The draft holds
  exactly what the owner agreed — never a field the owner did not
  confirm.
- **Malformed config** (the `config` offer): draft the owner's file
  with each listed defect repaired and nothing else changed.
- **Undeclared corpus citation tags** (the `citation-tags` offer): diagnose warns when the estate
  carries the subject and practice collections but the config declares
  no tag that resolves against them. That is the ordinary state of a
  freshly converged project, and it is not drift — tags are
  owner-declared configuration and are never shipped as defaults, so
  the estate can carry the collections while the owner has not yet
  decided to cite them. Present the two entries exactly:

  ```json
  { "tag": "@subject:",  "file_template": ".ok-plumbline/subjects/{slug}.md" }
  { "tag": "@practice:", "file_template": ".ok-plumbline/practices/{slug}.md" }
  ```

  Say what declaring them buys — a `@practice:` line at a governed site
  becomes a link the lint resolves, and a slug that names no practice
  becomes a violation rather than a comment nobody checks — with the
  offer. On the owner's yes, `resolve` adds the two entries and
  nothing else. A no is a valid state, recorded as declined; the next
  run offers it again.

## What the administration does NOT do here

- Does not write the config without consent — its contents are the
  owner's declaration, written only by `resolve` from an approved draft
  or an accepted offer.
- Does not run the lint, the budget check, or any other work-driving
  verb — administration is upkeep, not enforcement.
- Does not touch the project's own rules files or root `.gitignore`,
  except the one rule file `resolve` replaces on the owner's yes;
  outside the estate it owns only the cheatsheet and the vendored
  skill files, and reaches `.claude/settings.json` solely through the
  consented `wire-hooks` path.

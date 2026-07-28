# ok-plumbline administration

The judgment side of this family's administration — everything the
deterministic core beside this document (`admin/converge`) cannot
encode. The suite's front door (`/ok`) reads this document when it
administers the family; nothing here is improvised by the
administrator, and nothing here is a user-facing verb.

The dot-directory layout, its module marker (`.ok-plumbline/package.json`,
whose fixed content `{ "type": "commonjs" }` makes the vendored binary and
edit hook run regardless of what module type the consumer's root
`package.json` declares), cheatsheet, vendored binary, edit hook, and
vendored skills are suite-owned and converge without prompting. The
config's *contents* are owner-declared: never invented or edited by the
administrator's own judgment. Declaring happens in conversation — with
no config, walk the owner through the starter's detected proposal and
transcribe their answers; never send them away to hand-edit a file
unless they ask to.

## The core's modes

```
bash admin/converge            # converge: migrate layout, materialize the suite-owned layer
bash admin/converge diagnose   # read-only drift report via the family binary; non-zero on drift
bash admin/converge wire-hooks # consented settings transcription — see below
```

Diagnose checks: the config (`.ok-plumbline/config.json`, or a root
`.plumbline.json` from the earlier layout) exists and parses cleanly
(and how many citation tags are declared, and whether it still carries
the retired `checks` key); the cheatsheet is committed; the vendored
binary, edit hook, and skills match the carried rendering; the module
marker (`.ok-plumbline/package.json`) is present and matches its
canonical content byte for byte — it carries no version stamp, so exact
content is what fidelity means for it, and absence or any drift is a
diagnosis failure whose remedy is converge; the budget baseline's
existence and location; the hook wiring in `.claude/settings.json`.

## Identify overlapping project context

Per the integration contract, surface preexisting project guidance that
overlaps the family's territory before converging. Scan
`.claude/rules/` and the repo's conventional doc locations (root and
`docs/`) for coding-style / comment-policy / lint-convention documents
that are not suite-materialized (no version stamp) — e.g. a
hand-written style guide, a CONTRIBUTING section on comments, an
alternate lint cheatsheet. For each hit, **propose a conversion plan**
for the owner's consent: fold enforceable rules into the plumbline
config (`citations`, `ignore`), keep the rest as a project-specific
rules file alongside the cheatsheet, or retire the document. Never
convert, edit, or delete such context silently — and never skip
surfacing it.

## The config collision

The core migrates a root `.plumbline.json` or `.plumbline-budget.json`
into `.ok-plumbline/` mechanically — contents untouched. When **both**
the old and new locations exist, it prints `CONFLICT` and touches
neither: ask the owner which is authoritative, and carry out their
answer (keep one, fold the other into it, or archive it). This is the
one layout question the owner must decide; never pick silently. The
binary honors the root config path until the migration lands, so a
not-yet-migrated project keeps working.

## Wire the hook — consent, then transcription

The edit hook executes from the project's own materialized copy at
`.ok-plumbline/hooks/post-edit.js`, reached through a `PostToolUse`
entry in `.claude/settings.json` — owner-declared configuration,
written **only** as transcription of the owner's explicit yes, by the
core's `wire-hooks` mode. Diagnose reports a missing or drifted entry
as a `WIRING NEEDED` block carrying the exact entry and the exact
consent command. Present the block, ask, and on yes run the command it
names. Declined means declined — record it in the report and write
nothing.

## Declare a config, in conversation

For each remaining diagnosis failure or warning — these require
judgment or project-owned changes, so they are reported with a remedy,
never fixed silently:

- **Missing config**: declare one with the owner, in conversation. Run
  the starter's detection and hold its output — never park it in a
  file and leave:

  ```bash
  node "<family>/bin/plumbline" starter .
  ```

  Present the detected config compactly — both checks always run
  (plumbline is strict by default; there is no soft start and no
  disable switch), which citation tags it wires (e.g. ok-planner's
  `@concept:`/`@story:`/`@decision:` when `.ok-planner/` is present),
  which dirs it ignores — and ask. When detection is unambiguous and
  the owner has nothing to add, that's one yes/no: "declare this as
  `.ok-plumbline/config.json`?" Where there are judgment calls (extra
  citation tags, generated dirs the heuristic missed), settle them in
  dialogue. On consent, write the result to `.ok-plumbline/config.json`
  exactly as agreed — transcription of explicit answers, never a field
  the owner didn't confirm. If the owner prefers to hand-edit, print
  the proposal and stop.
- **Malformed config**: surface the parse error and propose the fix —
  the owner's file, the owner's yes.

## What the administration does NOT do here

- Does not write the config without consent — its contents are the
  owner's declaration, transcribed from explicit answers only.
- Does not run the lint, the budget check, or any other work-driving
  verb — administration is upkeep, not enforcement.
- Does not touch the project's own rules files or root `.gitignore`;
  outside the estate it owns only the cheatsheet and the vendored
  skill files, and reaches `.claude/settings.json` solely through the
  consented `wire-hooks` path.

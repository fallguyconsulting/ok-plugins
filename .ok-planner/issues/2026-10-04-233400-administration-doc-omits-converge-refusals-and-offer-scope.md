---
issue: administration-doc-omits-converge-refusals-and-offer-scope
kind: audit
category: defect
artifacts:
  - story:converge-project-estate
status: verified
triage: defect
opened: 2026-10-04T23:34:00Z
---

# The administration document and the /ok report template describe refusals and offers the converge core no longer applies

## Problem

The sites are `plugins/ok/families/ok-planner/admin/ADMINISTRATION.md:converge modes, worktrees offer, retired verbs` and `plugins/ok/skills/ok/SKILL.md:report template`. The entry is A8, under the rule in `.claude/rules/plumbline-coding.md` rule 1: before changing a definition, `rg` for every literal that restates it "across code, templates, static assets, docs examples", and "Edit every site on the list in the same change". The trigger was sprint certification run converge-2026-10-04T060800. It changed the core's mode refusal, its worktrees refusal, and its retired-name offer scope, and backed its prose hunks out of both documents. The harm, in the entry's words: the code breaks a rule the project states, and the rule decides the fix. The rule leaves one compliant form: the documents that `/ok` follows state what the core applies. Today they disagree with the core in four places.

1. Mode refusal. `plugins/ok/families/ok-planner/admin/converge:17-18` refuses any first argument that names no mode: `printf 'converge: %s names no mode; nothing written\n%s\n'`. Lines 13-15 print the usage line for `-h|--help|help`. `ADMINISTRATION.md:17` names only one refusal: "A bare `wire-hooks` is refused with a usage line naming the groups".
2. Worktrees refusal. `converge:1472-1474` states the refusal as "unless every worktree is clean, unlocked, and free of populated submodules, and every branch is merged into HEAD and checked out in no other worktree". `ADMINISTRATION.md:97` and `ADMINISTRATION.md:195` say only "unless every worktree is clean and every branch is merged into `HEAD`".
3. Retired-verb offers. The `converge:retirements` docstring says "At a RETIRED_WHERE_STAMPED name converge removes the suite-stamped files and offers nothing". `converge:1012` computes `owned` as empty for those names: `slug`, `ci`, `budget`, `events`, `explain`, `patterns`, `port`, `starter`, `suggest`, `version`, `open`, `close`, `ok-workspaces`, `ok-planner`, and `execute-tasks` (`converge:138-139`). `ADMINISTRATION.md:225` says for every retired verb: "Files the project wrote inside a retired verb's folder are the project's: diagnose and converge list them in a `retired-verb:.claude/skills/<name>` cleanup offer".
4. Lint-rules line. Diagnose and converge print `lint rules: ... turn a lint check off by setting it to false under lint_checks in .ok-planner/config.json` (`converge:309-310`). The report template at `plugins/ok/skills/ok/SKILL.md`, section "7. Report", does not name that line.

A fixer noticed this (call i86, fix task t44), and triage confirmed it against the code. The fix edits prose in the product tree. The converge fix prompt bars every prose edit, so issue `fix-loop-cannot-fix-prose-sites` bears on which run can make this fix.

## Ruling

> Generated ruling (/triage-issues): fix `plugins/ok/families/ok-planner/admin/ADMINISTRATION.md:converge modes, worktrees offer, retired verbs` and `plugins/ok/skills/ok/SKILL.md:report template` so the documents state the refusals and the offer scope the converge core applies.

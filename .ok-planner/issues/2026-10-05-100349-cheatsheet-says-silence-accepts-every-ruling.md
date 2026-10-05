---
issue: cheatsheet-says-silence-accepts-every-ruling
kind: audit
category: defect
artifacts:
  - decision:foreign-harms-become-upstream-issues
status: verified
triage: defect
opened: 2026-10-05T10:03:49Z
---

# The ok-planner cheatsheet tells its reader that silence accepts an upstream issue's ruling and that planning closes a judgment issue only as promoted or retired

## Problem

The site is `plugins/ok/families/ok-planner/scripts/ok-planner-cheatsheet.md:issues/ bullet`, under "The content kinds". Entry A8 covers it: the text breaks a commitment of the live decision foreign-harms-become-upstream-issues, which leaves one compliant form: "The planning session walks it with the owner, who resolves it one of three ways: a workaround in the project, which becomes sprint work; a filing upstream, after which the planning session closes the issue on the owner's resolution, naming where it was filed; or both."

Trigger: an agent or an owner reads the always-loaded cheatsheet to learn how a triaged upstream issue is settled and closed. Harm: the code breaks a rule the project states, and the rule decides the fix. The reader takes silence as the owner's answer to an upstream issue, and takes `promoted` or `retired` as the only ways a planning session closes one, where the decision requires a walk with the owner and an `answered` close on a filing upstream.

Evidence, from the code as it stands:

- `plugins/ok/families/ok-planner/scripts/ok-planner-cheatsheet.md:27-29`: "`/triage-issues` makes each one ready for its next reader and ends it in a marked generated or recommended ruling the owner accepts by silence or overrides".
- `plugins/ok/families/ok-planner/scripts/ok-planner-cheatsheet.md:29-31`: "A `/plan-sprint` session closes a judgment issue, **promoted** into that sprint (file stamped with the sprint's name) or **retired**."
- The same file's Routing paragraph, `plugins/ok/families/ok-planner/scripts/ok-planner-cheatsheet.md:195-200`, and `plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md:48` ("a recommended ruling on it does not ride the sweep: walk each at Resolve") follow the decision, so the bullet disagrees with its own file and with the skill.

The issue was filed with one Candidate, to fix the bullet so it no longer says silence settles an upstream issue; the decision foreign-harms-become-upstream-issues forces that fix.

## Ruling

> Generated ruling (/triage-issues): fix `plugins/ok/families/ok-planner/scripts/ok-planner-cheatsheet.md:issues/ bullet` so the cheatsheet no longer tells its reader that silence settles an upstream issue or that a planning session closes a judgment issue only as promoted or retired.

---
issue: conduct-session-start-carries-prose-comment
kind: audit
category: defect
artifacts: []
status: promoted
triage: defect
opened: 2026-10-04T23:34:00Z
sprint: 2026-10-05-drain-the-intake.md
---

# The conduct's session-start hook ships a prose comment block the comment rule forbids

## Problem

The site is `plugins/ok-conduct/hooks/session-start:header comment`. Accept-list entry A8 covers it: the Comments rule in `.claude/rules/plumbline-cheatsheet.md`, a code-rule file `.ok-planner/review/project.md` lists under `## Code rules`, leaves one compliant form for the site, and the code has another. The rule says a comment that is not a machine directive, a configured citation, or a documentation comment in an opted-in file is residue whose default action is delete. decision:comments-forbidden-by-default says the same: "Everything else is residue whose default action is delete, including in code you didn't write."

Trigger: any lint run over the file, such as `/audit`'s lint sweep. Harm: the code breaks a rule the project states, and the rule decides the fix.

Evidence: `plugins/ok-conduct/hooks/session-start:2-10` opens with nine prose comment lines below the shebang, starting `# Direct plugin hook — ok-conduct is user-scoped, so machine-global execution` and ending `# user's choice in the harness; the announcement only names what is installed.` `node .ok-planner/bin/plumbline plugins/ok-conduct/hooks/session-start` prints `plugins/ok-conduct/hooks/session-start:2: plumbline/comment-hygiene: comment is not permitted (not a machine directive, not a configured citation, no docstring opt-in)` and exits 2. The rule forces the filed Candidate: delete lines 2-10 and keep the shebang on line 1.

## Ruling

> Generated ruling (/triage-issues): fix `plugins/ok-conduct/hooks/session-start:header comment` so the code no longer breaks the comment rule the project states, and the lint passes.

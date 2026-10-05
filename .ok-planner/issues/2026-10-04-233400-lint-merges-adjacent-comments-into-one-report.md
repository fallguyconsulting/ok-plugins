---
issue: lint-merges-adjacent-comments-into-one-report
kind: audit
category: defect
artifacts:
  - story:edit-time-lint-enforcement
  - story:lint-rules-compliance-report
status: verified
triage: defect
opened: 2026-10-04T23:34:00Z
---

# The lint judges a run of adjacent comments as one comment, so the edit hook passes new prose and a shebang blocks a clean citation

## Problem

The site is `plugins/ok/families/ok-planner/scripts/plumbline:mergeConsecutiveLineComments`. It folds every run of adjacent line comments into one comment, reported at the line of the first offending line it finds. A trailing comment on the next code line and a shebang on line 1 join the run.

The accept-list entry is A9: the system reports something false that someone acts on. The lint's exit code and printed result tell the agent and the edit hook "clean" over a violation, and "violation" over a compliant file. For the shebang case, A3 also holds: `plumbline` is a script that `.ok-planner/review/project.md` lists for developers and operators, and it refuses a compliant file with an error that names the wrong cause.

Trigger one: an agent edit that adds a comment line directly below an unchanged comment line. The edit hook passes `--lines` with the changed range, and `plugins/ok/families/ok-planner/scripts/plumbline:lintCmd` keeps only violations whose reported line lies in that range, at `plumbline:1260`, `violations = violations.filter((v) => v.code === CODE_NO_TESTS || lineInRanges(v.line, opts.lines));`. The merged comment reports at the unchanged line, so the hook exits 0 over the new prose comment.

Trigger two: a script with `#!/usr/bin/env python3` on line 1 and a slug-only citation such as `# @story: greet` on line 2. The merged comment is not a pure citation block, and its first offending line is a citation tag, so the lint prints `p.py:2: plumbline/comment-hygiene: citation comment must be slug-only` and exits 2. The citation alone passes.

Evidence, re-verified at this tree in a scratch project:

- `plumbline:655`, `if (last && last.kind === 'line' && last.endLine === c.line - 1) {`, merges the line into the previous comment.
- A committed `g.py` with `    # say hello` on line 2, edited to add `    # prefix the name with a friendly hi` on line 3: `plumbline --lines 3 g.py` exits 0, and the materialized `post-edit.js` hook exits 0.
- `e.py` with `    # first note` then `    y = x  # second note` reports only `e.py:2`.
- `p.py` with a shebang and `# @story: greet` exits 2 with the slug-only message; `q.py` with the citation alone exits 0.

decision:comments-forbidden-by-default names shebangs and slug-only citation tags as exemptions, so the fix the issue's one Candidate names, judging each comment line at its own line and keeping a shebang out of a citation block, is the one the rule forces.

## Ruling

> Generated ruling (/triage-issues): fix `plugins/ok/families/ok-planner/scripts/plumbline:mergeConsecutiveLineComments` so the lint no longer reports clean over a new comment line below an unchanged one, and no longer refuses a slug-only citation below a shebang.

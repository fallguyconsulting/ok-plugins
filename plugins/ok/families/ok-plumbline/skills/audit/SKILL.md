---
name: audit
description: "ONLY activated by explicit /ok-plumbline:audit slash command. Never auto-triggered by conversation content. Audit the current project against the Plumbline lint. Runs the lint across the whole codebase, groups violations by check category and by file, and surfaces a remediation plan distinguishing mechanical fixes from structural issues. Read-only — proposes fixes; does not apply them."
---

# /ok-plumbline:audit

Run the Plumbline lint across the current project and analyze the findings.

## What this does

1. Run `plumbline .` from the project root.
2. Capture the violation report (exit 0 = clean, 2 = violations, 1 = internal error).
3. Group violations by check category and by file.
4. Distinguish:
   - **comment-hygiene** — comments that are not a machine directive, not a configured citation, and not a docstring in an opt-in file. Default action is delete; a small share will be load-bearing and want conversion to an assertion / test / type / name. Use `/ok-plumbline:suggest` for per-violation proposals.
   - **citation-unresolved** — a comment uses a project-configured citation tag (e.g. `@concept:`, `@story:`), but the slug after the tag does not resolve. Either correct the slug, create the artifact at the resolved path, or remove the citation.
5. Surface a summary back to the user with a proposed remediation plan; do not apply fixes without confirmation.

## Run

```bash
# Prefer the project's vendored binary: an audit must report what THIS project
# was trued up to, not whatever version is installed on the machine today.
bin=".ok-plumbline/bin/plumbline"
if [ ! -x "$bin" ]; then
  bin="${CLAUDE_PLUGIN_ROOT:-plugins/ok}/families/ok-plumbline/bin/plumbline"
  echo "note: no vendored binary — using the payload's copy; /ok pins one to this project" >&2
fi

set +e
output=$(node "$bin" . 2>&1)
exit_code=$?

echo "$output"
echo "---"

if [ "$exit_code" -eq 0 ]; then
  echo "audit: clean — no Plumbline violations"
  exit 0
fi

if [ "$exit_code" -ne 2 ]; then
  echo "audit: lint failed with internal error (exit $exit_code)"
  exit "$exit_code"
fi

total=$(echo "$output" | grep -c "plumbline/")
echo "audit: $total violation(s)"

echo
echo "by category:"
echo "$output" | grep -oE "plumbline/[a-z-]+" | sort | uniq -c | sort -rn | sed 's/^/  /'

echo
echo "top files:"
echo "$output" | grep "plumbline/" | awk -F: '{print $1}' | sort | uniq -c | sort -rn | head -10 | sed 's/^/  /'

exit 0
```

## Reporting to the user

After the script completes, present:

- The totals and category breakdown the script printed.
- A remediation view splitting the findings two ways, so the user sees at a glance what a sweep can take and what needs their call:
  - **mechanical** — the fix is fully determined and changes no decision: residue, restatement, dividers, commented-out code, TODO markers (delete), and citations whose slug is a typo or a rename away from resolving (repoint).
  - **judgment** — the fix would decide something: a comment naming a real constraint that should become an assertion / test / type / name (`/ok-plumbline:suggest` proposes, the user chooses), a docstring block on a public-API surface that may warrant the file-level opt-in marker, and an unresolved citation whose artifact may need creating or whose link may no longer be load-bearing.
- For each violation category, propose a remediation approach the user can authorize:
  - **comment-hygiene** — usually a sweep; offer to batch-delete the mechanical share or run `/ok-plumbline:suggest` for the few load-bearing ones that warrant conversion to code.
  - **citation-unresolved** — for each tag, list the unresolved slugs and propose either correcting the slug, creating the missing artifact, or removing the citation.

Do not begin applying fixes until the user authorizes a specific category or file scope.

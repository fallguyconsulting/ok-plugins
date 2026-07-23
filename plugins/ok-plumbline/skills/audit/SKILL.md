---
name: audit
description: Audit the current project against the Plumbline lint. Runs the lint across the whole codebase, groups violations by check category and by file, and surfaces a remediation plan distinguishing mechanical fixes from structural issues. Read-only — proposes fixes; does not apply them.
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
  bin="${CLAUDE_PLUGIN_ROOT%/}/bin/plumbline"
  echo "note: no vendored binary — using the plugin's copy; /ok-plumbline:true-up pins one to this project" >&2
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
- For each violation category, propose a remediation approach the user can authorize:
  - **comment-hygiene** — usually a sweep; offer to batch-delete or run `/ok-plumbline:suggest` for the few load-bearing ones that warrant conversion to code.
  - **citation-unresolved** — for each tag, list the unresolved slugs and propose either correcting the slug, creating the missing artifact, or removing the citation.

Do not begin applying fixes until the user authorizes a specific category or file scope.

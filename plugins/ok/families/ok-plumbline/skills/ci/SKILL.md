---
name: ci
description: "ONLY activated by explicit /ok-plumbline:ci slash command. Never auto-triggered by conversation content. Emit a CI workflow that runs the Plumbline lint and budget check on every PR. Supports GitHub Actions, GitLab CI, and pre-commit. Prints the workflow to stdout; user reviews and saves."
---

# /ok-plumbline:ci

Generate a CI workflow that invokes Plumbline against the project. The workflow runs the lint (failing on any violation) and the budget check (failing if `.ok-plumbline/budget.json` — or a not-yet-migrated root `.plumbline-budget.json` — exists and the count has gone up).

## Supported platforms

- `github` — `.github/workflows/plumbline.yml` for GitHub Actions
- `gitlab` — a `.gitlab-ci.yml` job snippet
- `pre-commit` — a `.pre-commit-config.yaml` entry for the pre-commit framework

## Usage

```
/ok-plumbline:ci github
/ok-plumbline:ci gitlab
/ok-plumbline:ci pre-commit
```

## Run

```bash
# Prefer the project's vendored binary. This matters most here: the CI config
# this emits should invoke the committed .ok-plumbline/bin/plumbline, so the
# pipeline lints at the project's pinned version with no plugin installed.
bin=".ok-plumbline/bin/plumbline"
if [ ! -x "$bin" ]; then
  bin="${CLAUDE_PLUGIN_ROOT:-plugins/ok}/families/ok-plumbline/bin/plumbline"
  echo "note: no vendored binary — CI needs one committed; run /ok first" >&2
fi

platform="${1:-}"
if [ -z "$platform" ]; then
  node "$bin" ci
  exit 0
fi
node "$bin" ci "$platform"
```

## After the script runs

Surface the proposed workflow to the user. Propose saving it at the conventional location for the platform:
- GitHub Actions: `.github/workflows/plumbline.yml`
- GitLab CI: append the job to `.gitlab-ci.yml`
- pre-commit: append to `.pre-commit-config.yaml`

The default templates invoke the project's committed `.ok-plumbline/bin/plumbline` directly — no clone step, no network fetch, no plugin install. CI lints at whatever version is currently vendored in the project; keeping that pinned is a matter of when the owner next converges (`/ok`) to refresh the vendored copy, not anything the CI template itself controls.

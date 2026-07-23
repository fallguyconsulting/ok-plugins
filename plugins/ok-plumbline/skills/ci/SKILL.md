---
name: ci
description: Emit a CI workflow that runs the Plumbline lint and budget check on every PR. Supports GitHub Actions, GitLab CI, and pre-commit. Prints the workflow to stdout; user reviews and saves.
---

# /ok-plumbline:ci

Generate a CI workflow that invokes Plumbline against the project. The workflow runs the lint (failing on any violation) and the budget check (failing if `.plumbline-budget.json` exists and the count has gone up).

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
  bin="${CLAUDE_PLUGIN_ROOT%/}/bin/plumbline"
  echo "note: no vendored binary — CI needs one committed; run /ok-plumbline:true-up first" >&2
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

The default templates clone plumbline from GitHub at lint time. For pinned versions or air-gapped CI, propose editing the `git clone` step to a specific tag or a vendored copy.

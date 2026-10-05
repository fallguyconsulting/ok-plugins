---
issue: review-project-facts-omit-opened-key
kind: audit
category: tooling
artifacts: []
status: verified
triage: question
opened: 2026-10-05T12:23:52Z
---

# The review loop's project facts omit the record key that `issues show`, `issues read`, and two dashboard routes now take

`/converge` reads `.ok-planner/review/project.md` to learn what a driver may run and with which inputs. The file is the owner's declaration: no agent of a run may edit it. Its section "Scripts for developers and operators" lists `show <id> [--json]` and `read <id>` for the intake module, and `GET /api/issue/<id>` and `POST /api/issue/<id>/read` for the dashboard. Since sprint certification of `2026-10-05-issue-dashboard.md` (run `converge-2026-10-05T045158`, defects i23 and i28), each of those four takes one more input: a record's opened time, which names one record among several closed records under the same id. The file now omits an input the code takes.

## Mechanism

`plugins/ok/families/ok-planner/scripts/issues` gives `read` and `show` an `--opened` argument, with the help text "the record's opened time, naming one record among several under the id". It refuses an unknown key with a message that points to `issues history --json`. `scripts/dashboard` reads an `opened` query on `GET /api/issue/<id>` and on `POST /api/issue/<id>/read` and passes it to the same lookup.

The review loop pastes `project.md` into every prompt that reads or runs the tree. Accept-list entry A3 counts as sites every script "as `.ok-planner/review/project.md` lists them, and every input it takes". A driver works from that list, so it meets the opened key only if it happens to read the module's help. A defect behind `--opened` or `?opened=` is then less likely to be found. The fixer noted the gap as item i40: "a declaration, the owner's to update so A3 drives cover the record key."

## State of play

Every other input the section lists still matches the parsers. Only the opened key is missing.

## Options

1. Add the key to the section: `[--opened <time>]` after `read <id>` and after `show <id> [--json]`, and the `opened` query on `GET /api/issue/<id>` and `POST /api/issue/<id>/read`. Cost: one edit; the owner keeps the file current as the module grows.
2. Leave the section as it stands. Cost: drives cover the key only where a driver reads `--help`.

The ruling decides whether the project facts list the opened key.

## Ruling

> Generated ruling (/triage-issues): in `.ok-planner/review/project.md`, section "Scripts for developers and operators", the intake module's entry now reads `read <id>` and `show <id> [--json]`; after the change it reads `read <id> [--opened <time>]` and `show <id> [--json] [--opened <time>]`. The dashboard's entry now lists `GET /api/issue/<id>` and `POST /api/issue/<id>/read` with no query; after the change each carries the query `opened`. The rule that forces it: the file holds "the facts a general loop cannot know", its section lists every input each script takes, and accept-list entry A3 takes its sites from that list. The file is the owner's, so the owner makes the edit. Nothing was applied.

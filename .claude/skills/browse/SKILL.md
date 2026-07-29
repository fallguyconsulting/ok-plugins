---
name: browse
description: "ONLY activated by explicit /browse slash command. Never auto-triggered by conversation content. Starts the corpus view: a read-only local web page showing which code each live story and decision claims, which regions of a source file nothing claims, and the sources no artifact reaches at all. Read-only — it starts a server and writes nothing."
---

<!-- @story: trace-corpus-to-code -->
<!-- @decision: local-web-surface -->

# Browse the Corpus

Start the corpus view and hand the owner its address. The view answers one
question in both directions: **which code does each story and decision
actually claim, and what claims this line?** It reads the project's design
corpus, its implementation audits, and its committed source graph, and it
resolves every citation by calling the project's own materialized checker —
so it can never call a citation stale that this project's certification gate
calls clean, or the reverse.

The view is read-only. Nothing in this verb writes to the working tree.

## What the reader gets

- **Stories** and **decisions**, each with its audit determination and the
  code that audit cites — excerpted in place, foldable, with the declared-unit
  chain shown where the citation names one.
- **Code**, the other direction: a source file with a gutter mark on every
  line some artifact's citation reaches, the artifacts named, and the rest of
  the file visibly unclaimed.
- A **whole-file claim shown as what it is** — a population the audit read
  entire. It is rendered as a file-level badge, never as a mark on each line,
  because "this artifact read this file" is not "every line here serves this
  artifact."
- **Sources nothing claims**, as a view of their own rather than an absence
  the reader has to infer.

## Run

```bash
# Prefer the project's vendored copy: it resolves citations with the same
# arithmetic this project's certification gate uses, and understands the
# corpus of the version this project is pinned to.
bin=".ok-planner/bin/corpus-view"
if [ ! -x "$bin" ]; then
  bin="${CLAUDE_PLUGIN_ROOT:-plugins/ok}/families/ok-planner/scripts/corpus-view"
  echo "note: no vendored binary — using the payload's copy; /ok pins one to this project" >&2
fi

port="${1:-7777}"
log=$(mktemp)
nohup python3 "$bin" --port "$port" > "$log" 2>&1 &
pid=$!
sleep 1
cat "$log"
echo "corpus view: pid $pid — stop it with 'kill $pid'"
```

## After the script runs

Give the owner the URL the script printed and repeat, in one line, the
version the view announced — which suite version is answering, and whether it
is the one this project is pinned to. A view running a different version than
the estate reads an older corpus with a newer reader, and the owner should
know that before they trust what they see.

Then stop. Do not summarize the corpus for them: the page is the deliverable,
and reading it is theirs to do.

## What this skill does NOT do

- Does not write. No file in the working tree is created, edited, or removed;
  the view is a reader.
- Does not judge. A determination shown here is the one certification's
  implementation auditor recorded — this verb never re-audits, never
  re-derives a verdict, and never disagrees with `audit-check`, because it
  calls it rather than reimplementing it.
- Does not build its own frontend. The page is the build the suite's
  administration placed at `.ok-planner/browser/`, matching the version this
  estate is stamped with. A project that has not been converged — a fresh
  clone, say, where the build is ignored rather than committed — falls back
  to the front door's carried build and says so, the same announced fallback
  every read-only advisory verb here makes. With neither present, the data
  routes still answer and the page says why.

<!-- Materialized by ok-planner v12.0.0 — suite-owned; overwritten on converge; do not hand-edit. -->

---
concept: surface-extraction
---

# Surface extraction

## What it is

The surface extraction is the enumerated index of user-facing
elements the audit produces per run, at
`.ok-planner/audits/surface/extraction.json`. A subagent reads the
surface intent, walks the code and the deployment configuration
purpose-bound to classification, and writes one entry per element the
walk found — each entry naming the element's kind, its identifier,
its location, and the rule from the intent that placed it public or
internal. Kinds are discovered by the walk, not pre-declared: CLI
verbs, HTTP routes, env vars, config keys, ports, published files,
protocol schemas, or whatever the codebase actually exposes. The
extraction is committed with the audit corpus and stamped with the
`commit:` the audit describes.

## Purpose

The extraction is the audit's operational surface — the version of
"the public surface at this commit" that the story auditor drives
experiments through, that `/document` ships against, and that a
reader can inspect after the fact to see exactly what was treated as
public when the audit ran. Keeping the extraction a per-run artifact
means the answer is always current with the tree the audit describes:
nothing carries between runs, no cached partition can drift, and
freshness is a git question ("is HEAD past this commit?") anyone can
answer without a validator. Element inventory changes as the code
moves; intent changes only when the owner edits it; the extraction is
the run's join of the two.

## Boundaries

The extraction is not the intent, and it is not a verdict. It states
what the walk found and how the intent classified it — nothing else.
An element the intent cannot settle does not get a placeholder
verdict: the extraction records it as internal for this run, with a
note that the classification was defaulted, and the subagent files an
intake issue asking the owner to amend the intent. Whether a story is
actually supported by what the extraction lists as public is the
story auditor's question, not this record's — the extraction is the
input to that audit, never a substitute for it. The extraction is not
consulted to understand the project; it is a run's snapshot, and
readers doing project comprehension read the intent instead.

## Invariants

- **Written only by the audit run.** No hand editing, no tool with a
  pass/fail exit, no reconciler. A subagent produces the file; the
  orchestrator commits it with the rest of the audit corpus and
  stamps the closing commit.
- **One file per audit run, one entry per element found.** Every
  entry names the element's kind, its identifier, its location in the
  tree, whether the intent placed it public or internal, and — for a
  defaulted-internal element — that the classification was defaulted.
- **Kinds are descriptive, not declared.** The walk groups elements
  by natural kind. New kinds appear in the extraction the moment the
  codebase adds them; retired kinds vanish. No committed list of
  admissible kinds exists anywhere in the estate.
- **Ambiguities file issues, never block.** Where the intent does not
  clearly settle an element the walk suspects may be public, the
  extraction defaults it to internal for this run and the subagent
  files one intake issue per genuinely ambiguous element. The audit
  proceeds. The owner amends the intent; a future run picks up the
  amendment.
- **A statement about a named commit.** The extraction's `commit:`
  field names the tree it describes. Whether it still holds is how
  far HEAD has moved; nothing recomputes that.

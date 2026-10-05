---
issue: design-catalog-tocs-have-no-generator
kind: audit
category: product-intent
artifacts:
  - decision:generated-catalog-tocs
  - concept:catalog-toc
status: verified
triage: question
opened: 2026-10-04T23:34:00Z
---

# An agent writes the design catalogs' tables of contents by hand, though the corpus says a generator writes every one

Each catalog in the planner's estate has a table of contents beside it: one line per artifact, so a session learns what exists without reading every file. Every session reads these files first. decision:generated-catalog-tocs says "Every durable catalog in an estate carries a table of contents beside it, and a generator writes that file from the catalog's own artifacts. Nobody edits a table of contents by hand". concept:catalog-toc calls it "the generated one-file index beside each durable catalog".

Only two of the five catalogs have a generator. The script `plugins/ok/families/ok-planner/scripts/catalog-toc`, materialized as `.ok-planner/bin/catalog-toc`, writes `subjects.md` and `practices.md` and nothing else; its `--check` mode covers the same two. An agent writes the three design tables of contents, `concepts.md`, `stories.md`, and `decisions.md`, by hand. Step 7 of the discover-design skill tells the agent to read every artifact and write each file. The sprint build instructions run `catalog-toc` only for subject and practice deltas, so a design delta leaves the agent to rewrite the design tables of contents itself.

## Why it matters

A hand-written table of contents is a second authored copy of the catalog, and a second copy drifts. That is the reason the decision gives for generation. The drift happened: before sprint 2026-10-04-consolidate-into-ok-planner applied its deltas, `concepts.md` carried a stale completion-report row. The three design tables of contents match their catalogs today (35 concepts, 23 stories, 50 decisions), but nothing mechanical keeps them so.

The sprint also removed the decision's sentence naming the audit and certification as the checks on each table of contents. The design-doc compliance reviewer still checks consistency, and concept:catalog-toc's Boundaries give the check to the corpus audit, so drift surfaces at the next audit at the earliest.

The summaries need no judgment. Each design bullet is the artifact's leading line cut to about 117 characters: the first sentence of a concept's What it is, the `As … I want …` line of a story, the first sentence of a decision's Choice. `catalog-toc` already applies this rule to subjects and practices.

Sprint certification run converge-2026-10-04T060800 found two readings of the decision (call i77). First: an agent following a fixed procedure is a generator, and the tree complies. Second: the decision means a mechanical generator, and the design tables of contents break it. No accept-list entry names the harm.

## Options

1. Amend decision:generated-catalog-tocs to say one generator script writes every catalog's table of contents, the design catalogs included, and extend `catalog-toc` to concepts, stories, and decisions. Discover-design step 7 and the sprint build steps then run the script. Cost: a script change with a summary rule for three more kinds, and edits to the skills that now tell an agent to write the files.
2. Amend the decision to say a script writes the subject and practice tables of contents and an agent following a fixed procedure writes the design ones. Cost: "Nobody edits a table of contents by hand" needs rewording, and design drift stays possible with only the compliance reviewer and the audit to notice it.
3. Leave the decision as written, read "generator" as mechanical, and treat extending the script as remediation with no corpus change. Cost: the tree breaks the decision until a sprint builds the script, and the wording that allowed two readings stays.

The ruling decides whether a design catalog's table of contents comes from a script or from an agent.

## Ruling

Option 1. One generator script writes the table of contents of every durable catalog, the three design catalogs included. Extend `catalog-toc` to concepts, stories, and decisions with the same leading-line rule, cover them in its `--check` mode, have discover-design and the sprint build steps run it in place of writing the files, and amend decision:generated-catalog-tocs to say one generator script writes every catalog's table of contents.

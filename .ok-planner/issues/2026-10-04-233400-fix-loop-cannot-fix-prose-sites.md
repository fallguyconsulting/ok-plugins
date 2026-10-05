---
issue: fix-loop-cannot-fix-prose-sites
kind: audit
category: tooling
artifacts: []
status: verified
triage: question
opened: 2026-10-04T23:34:00Z
---

# The converge loop sends prose defects to fixers who may not edit prose, so they can only end stuck

`/converge` finds defects, merges them into one list, then has fixers fix each one and verifiers check each fix. Every fixer is barred from prose, and every verifier sends back a change that touches prose. The merge step does not filter prose sites out first. So a defect whose fix is an edit to a `.md` file in the product tree enters the fix loop, and the loop cannot fix it. The defect ends stuck or declined, after spending fix rounds. This breaks the find-and-fix-defects story's promise that the owner meets only the questions that need their judgment: a prose defect that needs no judgment still reaches the owner, late, after wasted work.

## How it happens

All paths are product source under `plugins/ok/families/ok-planner/skills/converge/`; the copies under `.claude/` are materialized from them.

- The finders can report prose sites. `SKILL.md` says "Code only", and the analysis hunt's file list excludes `.md`, `.markdown`, `.rst`, and `.txt`. But sprint certification's review and the story drive read beyond that list, and they report prose sites.
- The merge lets them through. Step 3a of `prompts/merge.md` sends to `judgment`, with no fix round, only files under `.claude/`, the tooling folders of `.ok-planner/`, the design corpus, and subjects and practices. Prose under `plugins/` or `docs/` passes.
- The fix loop forbids the fix. `prompts/fix.md`: "Leave every prose file, `.claude/`, and `.ok-planner/` untouched". `prompts/verify.md`: "A change that edited a prose file or an estate is sent back whatever else it did." `prompts/backout.md`: "Edit no prose file or estate."

In ok-plugins the product is mostly prose: skill bodies, `ADMINISTRATION.md`, and `docs/`. A skill body is this product's executable code.

## What it cost

In sprint certification run converge-2026-10-04T060800, verifiers sent back 7 of 9 round-1 fixes, each for editing a `.md` file. One defect went stuck at `docs/integration-contract.md`, and one was declined at `README.md`. Four fixers backed their prose hunks out in round 2, which left `ADMINISTRATION.md` and the /ok skill describing less than the code does. That gap is now its own issue, administration-doc-omits-converge-refusals-and-offer-scope, triaged as a defect. Its fix is a prose edit the next `/converge` cannot make under today's prompts, so its path depends on this ruling.

## What bounds the answer

The corpus decision on the loop (converge-finds-then-fixes) says nothing about prose. The decision on placed documents (placed-documents-are-records) says a fixer's restatement sweep stops at a document `/document` places in the tree. `README.md` and `docs/integration-contract.md` carry no provenance stamp, and the project declares no document types, so neither is a placed document today. Any option must still keep fixers off placed documents.

## Options

- **Route at merge.** Step 3a sends a defect whose only fix is a product-prose edit to `judgment`, so the run spends no fix round on it. Cost: in ok-plugins, where most of the product is prose, most defects leave `/converge` and wait for `/plan-sprint`. This is the one option that keeps "Code only" and the fixer's prose bar as they stand.
- **Let fixers edit product prose.** The fix and verify prompts let a fixer edit a prose file where the defect's site is that file, and keep the bar on `.claude/`, the estates, and placed documents. Cost: "Code only" changes for every project, and in a project whose prose is mostly documentation, fixers start editing documents with no declared standard for them.
- **Declare product prose.** `.ok-planner/review/config.json` gains a setting naming the prose paths that are product, and fixers may edit there alone. Cost: a new config key, its seed, and review-tool support.

The ruling decides whether `/converge` may fix prose, and where.

## Ruling

Neither a blanket prohibition nor a blanket allowance. What a fixer may change is decided by whether the defect's class decides the fix, not by the kind of file.

- Replace the fix and verify prompts' bar on every prose file with this test: a fixer edits a file, prose or code, only where the defect's class leaves exactly one compliant fix (A8's own test: "the rule decides the fix"; two compliant forms make it a question). A defect whose fix needs a choice of wording or meaning goes to `judgment` at the merge, step 3a, and the run spends no fix round on it.
- Keep a hard bar on prose another owner holds: the design corpus, the estates, and documents `/document` places in the tree.
- Let a project state its prose rules through A8: widen or rename `.ok-planner/review/project.md`'s `## Code rules` so a project may list rules files that govern prose (in this repository, skill bodies and administration documents), and say so in A8's sources.
- A project that lists no prose rules behaves as today, except that its prose defects no class decides go to `judgment` at the merge instead of reaching a fixer.
- Whether the analysis hunt reads prose files a project's listed rules govern follows from this ruling; the sprint decides it.

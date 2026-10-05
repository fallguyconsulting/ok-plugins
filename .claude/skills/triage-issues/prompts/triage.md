## Triage issues

Your task holds up to six issue files from `.ok-planner/issues/`. You route each one, and you write the file for three of the routes. You edit the issue files your task names and nothing else: no code, nothing under `.ok-planner/design/`, no other issue.

### Read

1. `.ok-planner/review/catalog/accept.md`, whole: entries A1 to A9, "What the list leaves standing", and "Where a site is unclear".
2. `.claude/rules/plumbline-coding.md`, on catches. It decides when a library error reaching the owner frame is the intended path.
3. Every issue file your task names, whole.
4. For each issue, the corpus artifacts that bear on it: run `OK_PLANNER_PROJECT_ROOT="$(pwd)" python3 .ok-planner/scripts/surface-corpus <the issue file>`, and read what it lists and what the frontmatter cites. An artifact two of your issues share is read once.
5. The code at every site an issue names, as it stands now. The filed evidence may have rotted: the code decides, not the issue.

Issue independent reads together in one message.

### Route each issue

First sort each issue. A **defect claim** asserts that the code is wrong and asks only that it be fixed: `category: defect`, or a Problem whose one Candidate fixes a code site. A **judgment issue** asks the owner to choose: what the product commits to, or how the project's own tooling works (its skills, prompts, and rules under `.claude/` and `.ok-planner/`). The accept list filters defect claims alone, as it stands.

A file is **suite-owned** when `/ok` overwrites it on every converge: a `Materialized by ok-` stamp stands on its last line or on one of its first five lines, it lies under `.ok-planner/review/catalog/`, it is a `LICENSE` whose first line says `materialized by the ok-* suite`, or it is `.ok-planner/package.json` or `.claude/rules/ok-concepts.md`, which the suite writes with no stamp. A change to a suite-owned file is the ok-plugins suite's to make, never the project's.

An issue with a `## Stuck in <run>` section is a judgment issue, whatever it claims: a `/converge` run fixed it up to its limit of send-backs, and a verifier sent every fix back, so how to fix it is the owner's choice. Route it `answered` where the code no longer shows the harm, and `question` otherwise, never `defect`. Its Options are the fixes the section records, each with the verifier's reason, and the fix no run has tried.

An issue with a `## Proposed entry` section is a defect claim first. A `/converge` finder met a harm at a named site that no accept-list entry named, and left the code. Judge each site the section names under the accept list as it stands; the proposed entry counts for nothing. Where a listed entry covers the harm and the fix changes code alone, route `defect`, and name that entry in the Problem. Where no listed entry covers it, the proposal is an upstream proposal: route `answered`, upstream, as "Write the file" says.

Then take the questions in this order. The first that settles the issue is its route.

1. **Is it settled already?** The code no longer does what the issue says, a live concept, story, or decision decides the question in words you can quote without interpretation you would have to defend, or the tooling now does what the issue asks. Route `answered`.
2. **For a judgment issue about the tooling:** where the change falls in a suite-owned file, route `answered`, upstream. Where it falls in the project's own tooling, route `question`; where a stated rule decides the one compliant change, say so in the brief, and the author writes a generated ruling.
3. **For a defect claim, does the accept list cover a harm?** Name the site as `path:function`, the entry, the trigger, and the harm in the entry's words. Apply "What the list leaves standing" before you decide. Where no entry covers a harm the code causes today, route `retired`. These defect claims are `retired`:
   - a value, route, or rule spelled in more than one place, unless the copies disagree today in a way an entry covers, or A8 applies because a stated rule leaves one compliant form;
   - corpus wording, a missing annotation, an event, a name, or a code shape, with no harm an entry covers;
   - a risk with no trigger that the product meets on a system deployed and configured correctly.
4. **Does the fix change what the design corpus commits to?** This question takes every defect claim an entry covers, and every judgment issue about the product.
   - No: the corpus or a stated rule decides the end state, and only the mechanism is open. Route `defect`. Several ways to write the fix is the fixer's choice, never a question.
   - Yes, and the rules decide the corpus change: the corpus contradicts a later ruling, or the code and a counterpart artifact both contradict one sentence. Route `corpus`.
   - Yes, and the owner must choose: two live commitments cannot both hold, or the answer adds, drops, widens, or narrows a promise the corpus makes. Route `question`.

In doubt between a defect claim and a judgment issue, ask whether the filer offers the owner a choice. Where it does, it is a judgment issue. In doubt between `defect` and `question`, ask whether a fixer would have to edit a file under `.ok-planner/design/` to make the fix correct. Where no, it is `defect`. In doubt between `retired` and any other route for a defect claim, name the harm in the entry's words. Where you cannot, it is `retired`.

### Write the file

For `answered`, `retired`, and `defect`, add `triage: <route>` to the frontmatter on the line after `status:`. Keep every other frontmatter field. Leave `opened:` and `issue:` as they are.

**`answered`.** Set `status: answered`. Replace the body with the title and one short section, `## Ruling`, that reads: `Answered (/triage-issues): <the question in one plain sentence>. <what settles it: the artifact's slug and the clause quoted, or what the code does now, as path:function>.`

**`answered`, upstream.** Set `status: answered`. Replace the body with the title, a `## Ruling` that reads `Answered (/triage-issues): the change falls in a suite-owned file, <the file>, so it goes upstream to the ok-plugins suite as the issue below, which the owner files there.`, and a section `## Upstream issue` holding the issue ready to file: a plain title; the suite file and the version its stamp names; each site, as path:function, with its trigger and harm, and the evidence quoted; and, for a proposal, the proposed entry wording, quoted.

**`retired`.** Set `status: retired`. Keep the title and the body above `## Ruling`. Replace the Ruling section, or add one at the end, with: `Retired (/triage-issues): no accept-list entry covers this defect claim. <why, in one or two sentences: the harm the issue names, and the entry or the "leaves standing" line that keeps it off the list>.`

**`defect`.** Set `category: defect` and `status: verified`. Replace the body with:

```markdown
# <plain title naming what goes wrong>

## Problem

<The site, as path:function. The accept-list entry. The trigger: the
input or event that sets it off. The harm, in the entry's words. The
evidence, as path:line quoted from the code as it stands.>

## Ruling

> Generated ruling (/triage-issues): fix <the site> so <the harm> no longer follows.
```

Where the issue was filed with one Candidate that names the fix the rules force, add one sentence to the Problem naming that rule.

**`corpus` and `question`.** Leave the file untouched: the author writes it and stamps it, so a file whose author never finishes stays in scope for the next run. File one brief:

```
tasks item add --pool questions --key triage --field file=<the issue file> --field route=<corpus|question> --body "<the brief>" --task <task>
```

The brief carries what the author writes from, and nothing else:

- the evidence, re-verified: what the code, the corpus, or the tooling says now, with `path:line` citations, and where the filed Problem has rotted;
- the mechanism: the one or two cause-and-effect facts a reader needs;
- the corpus: each bearing artifact by slug with the one clause that matters, and where it is silent; for a tooling issue, the skill, prompt, catalog, or rule the change would edit;
- the harm, and its accept-list entry where one covers it;
- for `corpus`: the one compliant corpus change and the rule that forces it;
- for `question`: each real option with its main cost, including any the filer missed, and where a stated rule decides a tooling change, that rule;
- sibling issues this should be ruled with.

Where the file already holds a verified narrative and a `Recommended ruling` that routes the same way and still matches the code, write `reuse` as the whole brief. The author then leaves the file as it is.

### Close

`tasks close <task> --outcome done --result "triage: <n> answered (<n> upstream), <n> retired, <n> defect, <n> corpus, <n> question" --staged <every issue file you edited>`. Stage each file by name first. Where you could not route an issue, leave its file untouched, close `partial`, and name it in the result.

<!-- Materialized by ok-planner v23.0.0 — suite-owned; overwritten on converge; do not hand-edit. -->

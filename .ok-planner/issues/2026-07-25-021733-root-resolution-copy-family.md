---
issue: root-resolution-copy-family
kind: discover
category: inconsistent
artifacts:
  - concept:estate
status: verified
opened: 2026-07-25T02:17:33Z
---

# Project-root resolution is independently implemented at least five times

## Problem

Nearest-git-ancestor root resolution exists in two bash and three node implementations with the same semantics and no shared definition — a copy family the suite's own lint methodology would flag, tolerated because skills are prompt text.

## Candidates

- Amend concept:estate Invariants to define root resolution once as a named property all implementations must match
- Accept the copy family explicitly as a decision with its single-file-script tradeoff

## Discussion

**The question.** Project-root resolution — walk up from the current directory to the nearest ancestor containing `.git`, else fall back to the starting directory — is implemented independently across the suite instead of being defined once and shared. Should the corpus state this as a single invariant every implementation must match, or accept the duplication outright as a tolerated tradeoff?

**Where it comes from.** Filed by `discover-design`'s extraction pass as a copy family the suite's own lint methodology would ordinarily flag — tolerated here because these are prompt-adjacent shim scripts, not application code plumbline lints.

**Re-verified against current code — the evidence understates the count.** Three distinct shapes exist, not one:
- A hand-rolled bash walk-up loop (`resolve_root()`, checking `[ -e "$dir/.git" ]`) appears near-verbatim in `plugins/ok-planner/hooks/session-start`, `plugins/ok-planner/hooks/user-prompt-submit`, `plugins/ok-planner/scripts/true-up`, and `plugins/ok-workspaces/hooks/session-start` — four copies.
- The same walk-up logic is reimplemented in JavaScript (`fs.existsSync(path.join(dir, '.git'))`) in `plugins/ok-plumbline/scripts/hooks/post-edit.js`.
- A third, different strategy delegates to `git rev-parse --show-toplevel` entirely, used in `plugins/ok-workspaces/scripts/detect.js`, `diagnose.js`, `true-up.js`, and `scripts/src-tag`.

That's six-plus independent expressions of the same semantic, across two languages and two genuinely different resolution strategies (manual walk-up vs. delegating to git), none referencing a shared definition or citing each other.

**What the corpus says today.** `concept:estate` never mentions root resolution — it only says the estate is rooted at "the consumer repo root," without defining how that root is found. `decision:filesystem-discovery-markers` states the *result* as settled fact ("resolved as the nearest git ancestor") but its Choice and Rationale are scoped to *why discovery is a filesystem check at all* (vs. inference or a registry), not to how many independent implementations compute that root. `decision:single-source-transclusion` establishes the precedent that shared canonical text should live once and be transcluded — but its Choice is explicitly scoped to "the planner's skills" canonical definitions, templates, and rules (prompt text shared via `{{TOKEN}}` blocks), not to logic duplicated across bash/node scripts belonging to different plugins; extending its precedent here is a plausible analogy, not something the decision itself claims. `decision:content-addressed-src-tag` is adjacent only in that its script also needs a root to operate from; it says nothing about root resolution itself. None of the three cited decisions squarely settles whether the duplication is a decision-worthy tradeoff or an oversight to consolidate.

**What the code does today.** Every implementation encodes the identical rule but as separately maintained text with no shared source. A change to the semantics (handling worktrees, submodules, or a missing `.git` differently) would have to be hand-applied at every one of the six-plus sites, with nothing to catch a site that's missed or silently drifts from the others.

**Candidates and their tradeoffs, undecided:**
- *Amend `concept:estate` Invariants to name root resolution as a single corpus-level property.* Gives every implementation one definition to conform to, and a future drift becomes inspectable against a stated rule. It does not, by itself, deduplicate any code — actual consolidation into one shared script or module would be separate follow-up work, and may sit uneasily against the suite's "ships no application runtime" constraint (`concept:plugin`) if it implies shared runtime code between plugins.
- *Accept the copy family as a decision, naming the single-file-script tradeoff.* Matches a value already present elsewhere in the corpus (`decision:content-addressed-src-tag`'s "POSIX shell with no dependency beyond git" — each shim staying self-contained and dependency-free). But the six copies aren't even textually identical across bash and node and across the two resolution strategies, so "the same tradeoff, repeated" would still need to say what, exactly, must stay in lockstep across them.

**What the ruling must decide.** Whether project-root resolution becomes a named, single corpus-level invariant every implementation is expected to match (leaving consolidation as later work), or whether the current multi-shape duplication is accepted outright as the cost of keeping each shim self-contained.

## Ruling

<!-- Owner: write your decision here in your own words.
The next /plan-sprint picks it up. Leave empty to discuss
it live in a planning session instead. -->

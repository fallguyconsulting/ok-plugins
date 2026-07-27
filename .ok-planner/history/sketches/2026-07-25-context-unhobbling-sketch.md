# Context Unhobbling — Design Sketch

**Date:** 2026-07-25
**Status:** Sketch (not a sprint; not authorization to build)

## Idea

Anthropic's Claude 5 context-engineering guidance ("The new rules of context
engineering", claude.com blog) reports removing over 80% of Claude Code's
system prompt with no performance loss, and recommends judgment-framed rules
over guardrails, progressive disclosure over upfront context, and eliminating
redundant restatement across surfaces. Surveyed against that guidance, the
suite's *rules* are largely earned (responses to failure modes that persist in
v5 models), but its *delivery* is redundant: the same rule is stamped into
every surface that might plausibly need it, and the copies are already
drifting. This sketch proposes trimming the delivery without weakening the
rules — governed by one principle that decides every edit.

**The principle: judge each surface by the context it runs under.**

- A **main-session skill body** executes with the conduct, the cheatsheet, and
  a v5 model present. It can state rules as judgment and lean on the ambient
  layers instead of restating them.
- A **dispatched subagent prompt** is context-free — it sees only itself. Its
  transcluded rule blocks and fencing stay ({{LEAF-AGENT-RULE}},
  anti-padding, artifact-definition tokens).
- A **traveling artifact** (a sprint handed to `/goal` or an external
  orchestrator) executes outside conduct-bearing sessions. Its baked-in
  boilerplate is load-bearing, not redundant.
- Any rule stated on two surfaces gets exactly one home, chosen by who has to
  see it. Per `concept:cheatsheet`, cheatsheet content is "a condensation of
  rules canonical elsewhere, never the canonical statement itself" — the same
  discipline should hold for every other surface.

## Shape

### 1. Planner session-start hook: banner + concepts TOC only

The materialized hook currently injects ~16.5KB: a version banner, the 12.1KB
`context/skills-index.md` (a copy of the hub SKILL.md), and the 4.4KB concepts
TOC. Keep the banner and the TOC; retire the skills index.

- The TOC earns its place: it is project-state, changes with every sprint,
  cannot be baked into a materialized cheatsheet at true-up time, and its
  framing ("open the full file; do not paraphrase") is progressive disclosure
  working as intended.
- The skills index does not: it is a third copy of the hub content (plugin
  SKILL.md → materialized index → injected context), already drifted from the
  plugin copy, and its always-in-context job — "these skills exist,
  slash-command only" — is done by the skill listing's frontmatter
  descriptions plus the one-line banner.
- Mechanics: edit `.ok-planner/hooks/session-start` template and drop the copy
  step in `plugins/ok-planner/scripts/true-up` (line 105,
  `cp "$SKILL_INDEX" "${OK_DIR}/context/skills-index.md"`). Retire the
  materialized `context/` file in consumer projects via true-up migration.

### 2. Workspaces session-start hook: delete

Match plumbline's shape, which is the proof case: plumbline is the most
ambient plugin (its convention applies to every edit) and has **no**
SessionStart hook — awareness via the cheatsheet, enforcement via the
deterministic PostToolUse lint hook. Workspaces materializes a cheatsheet
*and* injects its hub SKILL.md (~4KB) at session start; the second is
redundant with the first. Ambient conventions belong in the cheatsheet;
skill discovery belongs to frontmatter; SessionStart injection needs a
justification neither covers (planner's concepts TOC has one; hub bodies
don't).

### 3. Hub SKILL.md: shrink to a router

- Drop the instruction-priority ladder — the harness already enforces
  precedence (project rules > user instructions > skills > defaults).
- Shrink the per-skill table entries to one line each. The dense paragraphs
  duplicate the skills' own frontmatter descriptions, which every session
  already carries.
- Keep the "what ok-planner is" framing and the intake-vs-sprint distinction —
  that is the hub's real job.

### 4. Estate CLAUDE.md: point at the sprint boilerplate

The "Executing a sprint" section restates, in long form, what `/plan-sprint`
bakes into every sprint as "How to execute this sprint". The sprint's copy is
canonical (self-sufficiency requires it to travel); the estate CLAUDE.md
shrinks to a short pointer plus the close/certify-gate summary. The
cheatsheet's lifecycle paragraph likewise stays a pointer, not a paraphrase.

### 5. Sprint boilerplate: keep whole (explicit non-change)

The boilerplate's conduct-overlapping steps — completeness floor, never
destroy uncommitted work, run unsupervised — looked like redundancy in the
first inventory pass but are load-bearing: a sprint executes via `/goal` or an
external orchestrator with no conduct present. Traveling artifacts carry
their own rules. Do not trim.

### 6. Skill bodies: prune fencing that doesn't trace to a failure

Editing rule for every planner skill (and the suite generally):

- **"What this skill does NOT do" lists** — keep entries that trace to an
  observed failure or a genuine boundary confusion (certify's scope-creep
  entries, sketch's "not authorization to build"); drop entries that merely
  negate the skill's own description ("does not implement work items" on
  plan-sprint).
- **Dispatched prompts keep their fencing.** Anti-padding blocks,
  {{LEAF-AGENT-RULE}}, "NEVER spawn subagents" — subagents see only their
  prompt; this is the context-free surface the principle protects.
- **Main-session prose leans to judgment.** Where a skill body lectures the
  orchestrating session on things the conduct or cheatsheet already govern,
  cut to a reference.

### 7. Cheatsheets: untouched

They are the ambient vehicle, already sized right (~1.1k tokens for
planner's). This sketch strengthens their role: they become the *only*
always-in-context rules layer, with no hub-body injection competing beside
them.

## Open questions

- Should "SessionStart injection needs a justification the cheatsheet and
  frontmatter don't cover" be captured as a decision artifact (it is a real
  choice with a rejected alternative), or is it just an edit?
- Do the skill frontmatter descriptions themselves need trimming? They are
  paragraph-length and always in context, but they are also now the sole
  carrier of per-skill discovery once the hub table shrinks — trimming them
  may cut the wrong way.
- Does the concepts-TOC injection stay in the hook, or move to a
  directory-scoped mechanism if the harness offers a better one later?
- How does true-up retire `context/skills-index.md` in already-trued-up
  consumer projects — delete the file, or leave it orphaned and stop reading
  it? (Deletion is cleaner; the estate is plugin-owned there.)
- Item 6 needs a per-skill walk to enumerate exactly which "NOT do" entries
  trace to observed failures — not done in this sketch.

## Risks / unknowns

- **Cutting earned scar tissue by mistake.** The suite's rules respond to
  failures that persist in v5 models (observed this month: runaway verifier
  subagents, certify scope creep). The mitigation is the tracing test in
  item 6 — but the tracing itself is judgment, and an entry whose origin
  nobody remembers may still be load-bearing.
- **Frontmatter as single point of discovery.** After items 1–3, a session
  that has never run a planner command knows the skills only from frontmatter
  descriptions. If those prove too thin in practice, the fix is enriching
  frontmatter, not resurrecting the injection.
- **Consumer-project drift during rollout.** Hooks are materialized per
  project; until owners run true-up, old estates keep injecting the retired
  index. Harmless (stale context, not breakage), but the version banner will
  disagree with `/ok-version` — which is exactly the drift signal true-up
  exists to converge, so this is working as designed.
- **The corpus lags.** `concept:skill`, `concept:cheatsheet`, and the
  session-context-injection material under `design/_discover/` describe
  today's shape; the sprint that implements this must carry the corpus deltas
  (and can catch the known `concept:issue` / jsonl-era rot in the same pass).

## What this is not

- Not a rewrite of ok-conduct — the conduct is a consumer-side behavioral
  layer, out of scope here entirely.
- Not a change to dispatch discipline or the transclusion convention — the
  context-free-surface rule keeps those exactly as they are.
- Not a bundling of the parked update-status dashboard work — that is its own
  planned sprint.
- Not a general "make skills shorter" pass — plumbline's big true-up skill,
  for example, is long because it is mostly literal bash, which is
  determinism, not prescription, and stays.

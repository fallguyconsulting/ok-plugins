---
issue: check-flags-vs-no-soft-start
kind: discover
category: conflicting
artifacts:
  - decision:comments-forbidden-by-default
  - decision:ratchet-over-soft-start
status: verified
opened: 2026-07-25T02:16:44Z
---

# Config can disable checks the doctrine says have no soft start

## Problem

The lint config carries enable flags for both checks while starter and cheatsheet insist 'there is no soft start'; the knob exists mechanically but is doctrinally discouraged and nothing reconciles the two.

## Candidates

- Amend decision:ratchet-over-soft-start Alternatives/Choice to record the flags as retired and remove them via a sprint
- Amend decision:comments-forbidden-by-default Choice to document the flags as a sanctioned escape with stated limits

## Discussion

**The question.** `.ok-plumbline/config.json` accepts `checks.comment_hygiene` and
`checks.citation_resolution` as booleans that fully disable either lint check, while
two corpus artifacts flatly assert that adoption never involves disabling checks.
Does the corpus document these flags as a sanctioned, limited escape, or does it
retire them so mechanism and doctrine agree?

**Where it comes from, re-verified.** The issue's Problem still holds against
current code (`plugins/ok-plumbline/bin/plumbline`):

- `loadConfig` (line 106) seeds the check defaults at lines 131–132:
  `comment_hygiene: true, citation_resolution: true, ...(userConfig.checks || {})`
  — a project config can override either to `false`.
- `runLint` (line 1135) gates each check's entire violation-collection loop on the
  flag: `if (config.checks.comment_hygiene)` (line 1143) and
  `if (config.checks.citation_resolution)` (line 1150). Setting either `false` is a
  full skip of that check, not a suppressed report.
- No validation rejects `false` anywhere in the binary; the schema treats it as an
  ordinary boolean.

No shipped skill ever sets either flag `false`. `plugins/ok-plumbline/skills/starter/SKILL.md`
always emits both flags `true` (line 15: "Default check selection: both
`comment_hygiene` and `citation_resolution` enabled … there is no 'soft start' with
checks disabled"). `plugins/ok-plumbline/docs/plumbline-porting-guide.md` describes
the only sanctioned adoption path — Adopt → Audit → Sweep → Maintain, with the
budget ratchet as the fallback for large backlogs — and every phase keeps "both
checks on (the default)" (lines 11, 55, 81, 115, 162). So the flags are real,
fully honored, and completely unproposed anywhere in the suite: a bare capability
reachable only by hand-editing the config, never one any skill walks an owner
toward.

**What the corpus says.**

- decision:ratchet-over-soft-start Choice: "The checks themselves stay strict from
  day one; there is no soft start." Its Alternatives explicitly name and reject
  "Disable checks until the backlog is cleared — a soft start that in practice
  never ends." Setting `checks.comment_hygiene: false` to ease a legacy backlog is
  exactly that rejected alternative, made available by the schema the decision's
  Proof section implicitly presumes is closed off.
- story:incremental-lint-adoption Falsifier lists "adoption requires disabling the
  checks" as one of four conditions that falsify the story outright. Because the
  flags are config-flippable, that falsifier is exhibitable today by any owner who
  chooses to flip them — the story's guarantee rests on nobody doing so, not on
  anything mechanical preventing it.
- decision:comments-forbidden-by-default Choice governs which comment *forms* are
  exempt from the no-comments rule (machine directives, citation tags, opted-in
  docstrings) — it says nothing about whether the comment-hygiene *check itself*
  can be turned off. It is silent on this question; the config-flag mechanism is
  outside what it currently decides.
- concept:citation-tag defines the citation-tag escape for comment *forms*
  specifically, not a check-disabling escape. Also silent on `checks.*`.

No artifact squarely answers the question as filed — it stays open for a full
discussion rather than closing by citation.

**What the code does today.** As above: both flags exist, default to `true`, are
fully honored as a real skip (not a cosmetic report filter), are never set `false`
by any shipped skill or doc, and are validated for nothing beyond JSON parsing.
The only mechanically sanctioned way to ease adoption is the budget ratchet
(`ok-plumbline:budget`), which keeps both checks running and instead tracks a
violation-count baseline that can only hold or fall.

**Candidates.**

1. *(filer)* Amend ratchet-over-soft-start's Alternatives/Choice to record the
   flags as retired, and remove `checks.comment_hygiene` /
   `checks.citation_resolution` from the schema via a sprint. Corpus effect:
   closes the gap by deleting the capability, so doctrine and mechanism converge
   because the mechanism no longer exists. Code effect: `loadConfig` stops merging
   a `checks` override (or rejects a `false` value outright), `runLint` always runs
   both checks unconditionally; any project with a stray `checks: {...: false}`
   in its config would need a migration note (e.g. `true-up` flagging or ignoring
   the dead key). Tradeoff: forecloses any legitimate use the flags might serve —
   see candidate 3 — with no replacement offered.

2. *(filer)* Amend comments-forbidden-by-default's Choice to document the flags as
   a sanctioned escape with stated limits. Scope mismatch to note: that decision's
   Choice is about which comment *forms* are exempt from the no-comments rule, not
   about whether the check that enforces the rule *runs at all* — documenting a
   check-disabling escape there stretches the artifact past what it currently
   decides. If this shape is chosen, ratchet-over-soft-start (which is specifically
   about how adoption may or may not be eased) or a new decision scoped to the
   config schema itself are closer fits. Whichever artifact carries it, "stated
   limits" is undefined as filed — the owner would need to specify what the
   sanctioned use actually is (temporary? time-boxed? logged? gated separately in
   CI?) for this to be more than a description of the status quo.

3. *(third shape, found in verification)* Treat this as a scope mismatch rather
   than a genuine conflict: ratchet-over-soft-start's "no soft start" claim is
   paired with story:incremental-lint-adoption and reads as being about *adoption*
   specifically, not about every conceivable reason to disable a check. This
   candidate would amend ratchet-over-soft-start's Alternatives to scope the
   rejected "disable checks" alternative explicitly to adoption/backlog use, leave
   the flags in the schema, and document them (in whichever decision) as reserved
   for a narrower, named non-adoption purpose (e.g. an emergency or temporary
   bypass unrelated to backlog size). Tradeoff: avoids candidate 2's "undefined
   limits" problem by naming a purpose, but that purpose is speculative — nothing
   in the code, docs, or issue history shows an existing or anticipated non-adoption
   use of the flags, so this candidate proposes relief for a problem not yet
   observed, versus candidates 1 and 2 which resolve what is actually present
   today.

**What the ruling must decide.** Whether the `checks.comment_hygiene` /
`checks.citation_resolution` config flags should be removed from the schema
entirely, or kept and formally documented as a sanctioned escape with owner-stated
limits (and in which decision), or reserved narrowly for a non-adoption purpose.

## Ruling

<!-- Owner: write your decision here in your own words.
The next /plan-sprint picks it up. Leave empty to discuss
it live in a planning session instead. -->

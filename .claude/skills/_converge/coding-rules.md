# Converge shared blocks

The blocks `/converge`'s prompts and the sprint build prompt transclude by name. `{{TOKEN}}` names a block to use verbatim, resolved only where the token stands alone on its line, as in `../_shared/dispatch-discipline.md`.

---

### {{CONVERGE-CODING-RULES}}

The one paragraph on the coding rules every agent that writes code under a converge skill carries: each prompt transcludes it by name from this file. Rule 2 is excluded: an agent that copies a sibling copies whatever it finds.

```
Follow `.claude/rules/plumbline-coding.md` rules 1, 3, 4, 6, 7, and
9, and rule 5 before you delete anything, together with
`.claude/rules/plumbline-cheatsheet.md` and
`.ok-planner/docs/events.md`, on every line you write: enumerate
before you edit, walk every exit of a function that holds state,
one state change in one transaction, import never copy, and before
you delete a route, verb, column writer, helper, or branch, list
what it alone provides and record a fork where the deletion
removes the only writer or the only site that realizes something
the corpus still claims. Rule 2, copy the sibling's shape, does not
bind you, and rule 9.4's sibling citation is void with it, so your
note carries the enumeration alone. The standard fixes the shape of
a handler, an emission, a teardown, a lock, or a retry; where the
standard leaves a choice open, keep the shape the file you are
editing already uses for that job, or choose and record a call
where it has none. Never read a sibling file to decide a shape. The
rules govern what you write; they do not send you sweeping for
anything your brief marks as another loop's. To learn what a shell
construct does, test the construct alone, with throwaway functions,
in the foreground.
```

---

---

### {{PROSE-SCOPE-RULE}}

Which prose a converge agent reviews and edits. Carried by the merge, fix, verify, sprint review, and sprint pass prompts. Skill text is the product's code, so no configuration lists it: the agent that meets a file judges whether it is skill text.

```
Skill text is code. A skill is a prompt the product ships for an
agent session to run: its body, the prompts and shared blocks it
reads, and the scripts and tools it calls. Review skill text and
fix it as code, under the same rules: the fixer picks the wording;
where the code and the design corpus do not decide the fix, it
builds the reading it judges best and records a question; it
declines a fix that changes what a user across a release boundary
observes. Other prose, such as documentation, a README, or a guide,
is in review only where the sprint this run certifies added or
changed it (`.ok-planner/bin/review changed` lists it); there it is
reviewed and fixed as skill text is. Anywhere else, and in a run
that certifies no sprint, file no finding on it and edit none of
it. No agent of this run edits the design corpus, an estate
(`.claude/`, `.ok-planner/`), a document the release regenerates,
or a file the suite materializes.
```

<!-- Materialized by ok-planner v24.0.0 — suite-owned; overwritten on converge; do not hand-edit. -->

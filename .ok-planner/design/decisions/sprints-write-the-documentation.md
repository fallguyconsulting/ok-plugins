---
decision: sprints-write-the-documentation
---

# A sprint's builders write the documentation its work changes, after the code

## Choice

Of the suite's runs, only a sprint writes a project's documentation; a
person's edit outside a sprint is reconciled at planning (see also:
out-of-band-documentation-reconciled). The administrator's one
exception is true-up's removal of a provenance stamp a retired verb
wrote (see also: whole-file-ownership). Planning writes none of the
documentation's text. Planning reads the docspecs' index and matches the drafted work against each
docspec's references, the corpus artifacts and code paths its
documentation describes, and adds one work item for each docspec the
work touches, naming that docspec. The builders write the
documentation after the code it describes, against the docspec, and
decide which files under the docspec's location to add, change, or
drop. A builder who edits documentation the sprint did not name
records the edit as a call. Sprint certification reviews each touched
documentation against its docspec and the change, as it checks that
every corpus delta landed. Outside these, documentation stays as it is. Nothing writes documentation at release time, and no document
carries a stamp of the commit it describes.

A docspec is owner intent, like a corpus artifact: it changes only
through a sprint's approved delta, in final form, save the
administrator's migrations, which change no commitment (see also:
final-form-deltas).

## Rationale

The documentation describes code that does not exist yet at planning,
so planning cannot write its final text; the builder who has just
written the code can. Matching the work against each docspec's
references at planning puts the documentation in the sprint the owner
approves, so a change and its documentation land together and
certification judges both. A sprint that names no docspec leaves the
documentation alone, so prose no change affects never churns. A
release-time ceremony leaves the documentation behind the tree for
every commit between releases, and needs a run of its own to catch it
up. Changing a docspec only through a delta gives the owner's sign-off
the same weight over documentation as over the corpus.

## Alternatives

- Generate the documentation whole at each release from declared types
  — the documentation lags the tree between releases, and a ceremony
  stands between a change and its documentation.
- Planning writes the documentation's final text as a delta — the text
  describes code no one has written, and it is wrong wherever the build
  departs from the plan.
- Hand-maintained prose outside any sprint — no step ties a change to
  the documentation it affects, so the documentation drifts with
  nothing to notice.
- The owner edits docspecs freely between sprints — the next sprint
  plans against an order the owner never signed off in a sprint, and
  the documentation answers to whichever edit came last.

# ok-plumbline — documentation ceremony contribution

What the suite's release-documentation ceremony does about this
family's estate. Materialized into consumer projects at
`.ok-plumbline/ceremony/document.md`; the ceremony reads it there when
`.ok-plumbline/` exists.

## Requires

Nothing beyond the estate itself. The contribution below is a
derivation over the project's code and tests, not over this family's
own corpus.

## Project

The **story↔test map** — the linkage set the warrant ladder's first
rung climbs. Build it mechanically from the codebase at the release:

```
rg -n '@story:\s*\S+' <test paths>
```

plus the test scenario names that name a story outright. The map pairs
each story slug with the tests that exercise it, so the Assess phase
can find an existing passing run — the cheapest warrant — before it
reads or builds anything. Report the map's shape in one line: stories
with at least one linked test, stories with none.

## Boundaries

- Contributes no records to the documentation corpus and writes no
  files: the map is handed to the ceremony in-context.
- Never runs the tests it maps. Whether they pass at the release is
  the Assess phase's business.
- Its subject and practice catalogs are not user-visible material and
  never enter the synthesis box.

<!-- Materialized by ok-plumbline v18.4.1 — suite-owned; overwritten on converge; do not hand-edit. -->

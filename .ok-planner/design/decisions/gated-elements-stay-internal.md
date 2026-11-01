---
decision: gated-elements-stay-internal
---

# A gated element stays internal until a sprint makes it public

## Choice

A gated element is internal, whatever class it belongs to. A gated
element is one the product exposes only while a gate setting is on,
and a gate setting is an on-off setting that exists to expose debug or
test elements, such as a verb that runs a timed job now or an admin
route that moves the product's clock. No class rule of the surface
intent reaches a gated element: a rule such as every verb of one
command covers only the elements the product exposes with every gate
off. A gated element becomes public only through a sprint's surface
intent delta that names it (see also: surface-intent-changed-by-sprints).
No caller outside the project may rely on a gated element, so changing
or removing one crosses no release boundary. Whoever lists a class's
members leaves out each gated element.

## Rationale

A debug or test element is built for the project's own use, not
offered to callers outside it. A class rule written for the elements a
user meets would otherwise make each one a promise the moment it
lands, so a time control a test sprint builds would need a surface
decision before any test could use it. Reading the gate from the
element itself lets any run build one without a planning question,
and leaves the owner's sign-off over what is public unchanged.

## Alternatives

- Class rules reach gated elements, and the owner names each as an
  exception: every debug element needs a surface delta before it can
  land.
- Gated elements live only behind an entry point no class covers: the
  project builds a second interface for each kind of entry point.
- Gated elements are public: every debug element becomes a contract
  its callers may rely on.

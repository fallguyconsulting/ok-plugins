---
decision: svelte-dashboard-frontend
---

# The dashboard's frontend is Svelte 5, built with Vite

## Choice

The dashboard's frontend is written in Svelte 5 and built with Vite
into static files the service serves.

## Rationale

The page is small: a header, a list, a thread, and a few keyed
actions. Svelte compiles it to a small static bundle with no runtime
framework to ship, and Svelte 5 is the supported major line, so no
later release has to migrate the page.

## Alternatives

- Svelte 4 — the previous major line, which a later release would have to migrate.
- React — a larger runtime for a page this size.
- Server-rendered pages with no build — no Node at release time, but every action costs a page round trip, and keyed queue work needs script anyway.

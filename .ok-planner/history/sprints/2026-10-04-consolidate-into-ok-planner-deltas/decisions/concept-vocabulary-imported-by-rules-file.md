---
decision: concept-vocabulary-imported-by-rules-file
---

# The concept vocabulary reaches every session through an import in a suite-owned rules file

## Choice

A suite-owned rules file in the project's always-in-context rules directory imports the concept catalog's table of contents, naming it by a path relative to the rules file. The harness loads the table whole into every session before its first reply. The session-start hook announces the governing version and carries no concept instruction.

## Rationale

`story:session-awareness` needs every session to start knowing the project's concept vocabulary, and only a load the harness performs itself delivers that every time. An import in a rules file is such a load, and it brings the whole table at any size. A path relative to the rules file resolves; a path relative to the project root does not. A hook that pastes the table hits the harness's cap on hook context: above 10,000 characters only a 2,000-character preview reaches the session, and a mature catalog passes that size. A hook that tells the agent to read the table leaves the read to the agent's discretion, and agents were observed to skip it.

## Alternatives

- The session-start hook pastes the table — capped by the harness at 10,000 characters, above which only a 2,000-character preview reaches the session.
- The session-start hook tells the agent to read the table — the read is left to discretion, and was observed ignored.

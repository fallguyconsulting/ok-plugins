---
decision: skill-text-is-reviewed-as-code
---

# A review treats skill text as code and other prose as in scope only where the sprint changed it

## Choice

`/converge` reviews and fixes skill text as it reviews and fixes code. Skill text is a prompt the product ships for an agent session to run: its body, the prompts and shared blocks it reads, and the scripts and tools it calls. A fixer edits skill text under the code fix rules: it picks the wording, builds the reading it judges best and records a question where the code and the corpus do not decide the fix, and declines a fix that changes what a user across a release boundary observes. Other prose, such as documentation, is in review only where the sprint the run certifies added or changed it, and is then fixed the same way; elsewhere no agent files a finding on it or edits it. No configuration lists skill text: the agent that meets a file judges whether it is. No fixer edits the design corpus, an estate, a document the release regenerates, or a file the suite materializes. The analysis hunt reads code alone.

## Rationale

In a product made of skills, the skill text is the executable product, and a review that may not fix it can only send its defects to the owner, late, after spending fix rounds. The code fix rules already route a fix that changes intent to the owner, so skill text needs no stricter rule of its own. Documentation a sprint did not touch is not the sprint's work, and reviewing it widens every run without a standard to judge it by. Leaving skill text unconfigured keeps the review working the same way in every project, whether its product is mostly skills or mostly code.

## Alternatives

- Bar every prose file from fixers — keeps "code only", and in a product of skills sends most defects to the owner unfixed.
- Let a fixer edit prose only where the defect's class leaves exactly one compliant fix — stricter than the rule for code, and most skill defects have more than one compliant wording.
- A configuration key naming the prose paths that are product — one more setting to keep, and the driver that finds a skill surface already knows which files it read.
- An inline execution path for skill projects, chosen by an owner flag — a second shape to keep, retired once skill surfaces could be reviewed by the drive.

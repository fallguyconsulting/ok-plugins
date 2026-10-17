---
concept: true-up
---

# True-up

## What it is

True-up is the suite's administration act: the idempotent pass that brings a project's suite presence — every layer the integration contract defines — to what the front door's carried payload declares.

## Purpose

True-up lets one administration act cover bootstrap, upgrade, migration, and repair alike, so bringing a project's whole suite presence current is a single deliberate pass per project.

## Boundaries

True-up is what the front door does, not a verb a project carries (see also: skill, integration-contract). It does not validate artifact contents. It finds and fixes no defect in the files the project owns — that is a review run's job (see also: defect). Which content true-up ports, archives, or removes is the ownership rule's, and which of its steps wait for the owner's word is the consent rule's (see also: estate; whole-file-ownership, true-up-asks-once-before-destructive-steps, skills-read-only-the-current-layout under decisions).

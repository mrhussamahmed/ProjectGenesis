artifact_id: ART-CONTRIB-001
title: Contributing
type: contribution-guide
status: authoritative
version: v1.0
created: 2026-05-09
updated: 2026-05-09
owner: AI Bootstrap Maintainers
source: User request
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# Contributing

## Before You Start

1. Read `AGENTS.md` or `CLAUDE.md`.
2. Read the minimum context in `CONTEXT_INDEX.md`.
3. Run `git status --short --branch` when Git is available.
4. Confirm the task meets Definition of Ready.
5. Create a branch unless the user explicitly allows direct work on `main`.

## During Work

- Keep changes scoped.
- Follow the spec.
- Write or update tests where practical.
- Update shared state as facts change.
- Record assumptions and open questions.
- Do not rely on chat memory as source of truth.
- Do not overwrite unrelated user or agent changes.

## Before You Stop

- Run relevant validation.
- Update `CURRENT_STATE.md`.
- Update `AI_HANDOFF.md`.
- Update `ARTIFACT_REGISTRY.md`.
- Update `TRACEABILITY_MATRIX.md`.
- Update `TEST_RESULTS.md` if checks ran.
- Record dirty worktree status.

## PRs

Every PR needs a review package and fresh-context adversarial review. Use
`PR_REVIEW_POLICY.md`, `PR_MERGE_POLICY.md`, and templates under `REVIEWS/`.


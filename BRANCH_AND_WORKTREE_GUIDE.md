artifact_id: ART-GIT-001
title: Branch And Worktree Guide
type: guide
status: authoritative
version: v1.0
created: 2026-05-09
updated: 2026-05-09
owner: AI Bootstrap Maintainers
source: User request and reference repository audit
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# Branch And Worktree Guide

## Branch Rules

- Never work directly on `main` unless explicitly allowed.
- Create one branch per feature, spike, fix, chore, documentation change, or
  implementation phase.
- Keep commits small and meaningful.
- Never mix unrelated changes in one branch.
- Include a spec or ticket ID in commit messages where possible.
- Do not commit secrets, generated noise, or build artifacts unless
  intentionally versioned.

Recommended branch names:

- `feature/<spec-id>-<short-name>`
- `spike/<spec-id>-<short-name>`
- `fix/<issue-id>-<short-name>`
- `chore/<short-name>`
- `docs/<short-name>`
- `test/<short-name>`

## Worktree Rules

- Use separate worktrees for concurrent AI agents.
- Avoid overlapping file ownership between agents.
- Declare branch purpose, worktree path, task, and owner in `AI_HANDOFF.md`.
- Stop and report unexpected changes from another agent.
- Do not overwrite another agent's work without analysis.
- Clean up merged branches and stale worktrees.

## Start Checklist

1. Run `git status --short --branch`.
2. Read minimum context from `CONTEXT_INDEX.md`.
3. Confirm task readiness.
4. Confirm branch/worktree plan.
5. Confirm file ownership and parallel risk.
6. Record the active branch and worktree in `CURRENT_STATE.md` and
   `AI_HANDOFF.md`.

## Stop Checklist

1. Run relevant tests and validation.
2. Run `git status --short --branch`.
3. Record changed files, tests, failures, assumptions, and next action in
   `AI_HANDOFF.md`.
4. Update `CURRENT_STATE.md`, `ARTIFACT_REGISTRY.md`, and
   `TRACEABILITY_MATRIX.md`.
5. Explain any dirty or untracked files.

## Dirty Worktree Handling

- If the worktree is dirty before starting, inspect changes before editing.
- Preserve user or agent changes you did not make.
- If unrelated files are dirty, leave them alone and document status.
- If changes block your task, record the blocker and choose safe independent
  work if possible.

## Commit Rules

- Commit only coherent changes.
- Use messages like `SPEC-001 create initial auth spec` or
  `HUS-123 add readiness checks` when IDs exist.
- Do not commit secrets.
- Do not commit generated local files unless required.
- Each commit should be explainable from a spec, backlog item, ticket, or ADR.


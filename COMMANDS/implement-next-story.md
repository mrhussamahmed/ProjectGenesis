artifact_id: ART-COMMAND-IMPLEMENT-NEXT-STORY
title: Implement Next Story
type: command
status: active
version: v1.0
created: 2026-06-10
updated: 2026-06-10
owner: AI Bootstrap Maintainers
source: GEN-16 pipeline commands
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: false

# Implement Next Story

## Purpose

Execute the highest-priority ready backlog story end to end with scoped
validation: verify readiness, branch, implement test-first, run only the
checks the story and change class require, and finish with one evidence note.
Never re-runs the full suite for small diffs.

Recognized user triggers: `Implement next story`, `Implement next item`,
`Pick up the next story`.

## Required Role

- `memory/ai/ROLE_IMPLEMENTATION_AGENT.md`

## Required Files To Read

- `memory/ai/SHARED_AGENT_RULES.md`
- `memory/ai/ROLE_IMPLEMENTATION_AGENT.md`
- `CONTEXT_PACKS/implementation.md` (authoritative read list for this command)
- `BACKLOG/BACKLOG_INDEX.md` and the selected item file
- The spec linked by the selected item
- `BRANCH_AND_WORKTREE_GUIDE.md`
- `OPERATION_ROUTING.md` (profile selection)

## Inputs

- The user trigger, optionally naming a specific item ID.
- Backlog items with `readiness: ready`, ordered by priority then dependency.

## Workflow

1. Select the first `readiness: ready` item by priority whose `blocked_by`
   list is clear; confirm Definition of Ready including the readiness gate
   fields (user value, measurable success criterion, observability
   expectation, security triggers checked).
2. Classify the operation profile per `OPERATION_ROUTING.md`; run
   `bash SCRIPTS/session.sh start <profile> "<item-id>"` for scoped local
   validation.
3. Create a branch per `BRANCH_AND_WORKTREE_GUIDE.md`; set item readiness to
   `in-progress` in its frontmatter and mirror the index row.
4. Implement test-first against the item's Acceptance Criteria.
5. Run ONLY the checks named in the item's Test Expectations plus the
   validation the profile requires; validate once per PR, not per edit.
6. Open the PR with one validation-evidence note (checks run, results, scope)
   and the review tier the profile requires; set readiness to `in-review`.

## Outputs

- A branch and PR implementing exactly one story, with tests.
- One validation-evidence note in the PR body.
- Updated item frontmatter readiness and matching index row.
- `.ai/SESSION.md` resume context while the PR is open.

## Stop Conditions

- No item is `ready`, a gate field is missing, or dependencies are unclear;
  report instead of guessing.
- The item's spec is missing, not approved, or contradicts the item.
- Implementation reveals scope beyond the story; split instead of expanding.

## Validation

- The checks named in the selected item's Test Expectations.
- `bash SCRIPTS/validate-bootstrap.sh` when the change class requires it per
  `OPERATION_ROUTING.md`; `git diff --check` always.

## Authority Limit

This command is a workflow shortcut. It cannot mark its own PR reviewed,
cannot weaken validation or review tiers, and cannot override repository
governance, approved or active specs, accepted ADRs, `CONTEXT_INDEX.md`,
selected role files, `OPERATION_ROUTING.md`, `ARTIFACT_REGISTRY.md`,
`TRACEABILITY_MATRIX.md`, `CURRENT_STATE.md`, or `AI_HANDOFF.md`.

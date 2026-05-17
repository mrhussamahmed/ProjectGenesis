artifact_id: ART-AI-ROLE-DOCUMENTATION-CURATOR
title: Role - Documentation Curator
type: agent-role
status: authoritative
version: v1.2
created: 2026-05-09
updated: 2026-05-17
owner: AI Bootstrap Maintainers
source: User request and SPEC-BOOT-003
linked_specs: [SPEC-BOOT-003]
linked_tickets: [BOOT-STATE-001]
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# Role: Documentation Curator

## Purpose

Keep shared state and documentation aligned.

## Required Context Files To Read

- `memory/ai/SHARED_AGENT_RULES.md`
- `.ai/SESSION.md` for local resume context when unmerged local work remains
- `CURRENT_STATE.md` and `AI_HANDOFF.md` only when durable project truth
  changed and should remain true on `main` after merge
- `ARTIFACT_REGISTRY.md`
- `TRACEABILITY_MATRIX.md`
- `OPERATION_ROUTING.md`
- `STALE_ITEMS.md`
- `SPECS/SPEC_INDEX.md`
- `ADR/ADR_INDEX.md`
- `BACKLOG.md`
- `DIAGRAMS/DIAGRAM_INDEX.md` if diagrams exist

## Responsibilities

- Detect stale docs.
- Update current state.
- Update handoff.
- Update artifact registry.
- Update traceability.
- Mark stale or superseded files.
- Prevent conflicting project memory.
- Apply operation routing, impact mapping, and current-truth versus history
  rules when curating state or handoff artifacts.
- When curating state, prefer replace-in-place current snapshots. Do not append
  session diaries to canonical state files. Link to PRs, commits, CI runs, and
  rare archives for history.

## Allowed Actions

- Update shared state, handoff, registry, traceability, stale items, indexes,
  and usage documentation.
- Mark artifacts superseded, deprecated, archived, or stale when evidence
  supports it.
- Reconcile documentation conflicts using the source-of-truth hierarchy.

## Forbidden Actions

- Do not change product behavior.
- Do not choose between conflicting authoritative sources silently.
- Do not rewrite history or remove useful evidence.
- Do not create duplicate sources of truth for the same rule.

## Required Outputs

- Updated shared state and handoff when durable project truth changed.
- Updated artifact registry and traceability matrix.
- Stale item or open question entries when conflicts remain.
- Documentation changes scoped to alignment and source-of-truth clarity.

## Required Updates Before Stopping

- `.ai/SESSION.md` for local resume context when unmerged local work remains
- `CURRENT_STATE.md` and `AI_HANDOFF.md` only when durable project truth
  changed and should remain true on `main` after merge
- `ARTIFACT_REGISTRY.md`
- `TRACEABILITY_MATRIX.md`
- `STALE_ITEMS.md` when drift exists
- `WORKLOG/WORKLOG_INDEX.md`

## Handoff Requirements

For unmerged branch work, record tactical resume details in `.ai/SESSION.md`
and shared branch status in the PR body or review package. Update committed
state only for durable changes that should remain true on `main`.

Record files aligned, stale items found or resolved, conflicts, changed
artifacts, operation profile, validation run, skipped validation, remaining
risks, and next safe action.

## Evidence Requirements

Documentation updates must cite repository files, validation output, current
diffs, artifact lifecycle rules, or explicit user instructions.

## Escalation And Stop Conditions

Stop when documentation conflicts require a product, architecture, security, or
release decision outside the curator role.

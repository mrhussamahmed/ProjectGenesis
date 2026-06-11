artifact_id: ART-AI-ROLE-SPEC-AUTHOR
title: Role - Spec Author
type: agent-role
status: authoritative
version: v2.1
created: 2026-05-09
updated: 2026-06-11
owner: AI Bootstrap Maintainers
source: User request; BOOT-RESEARCH-001 UX-brief and research-brief inputs
linked_specs: []
linked_tickets: [BOOT-STATE-001]
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# Role: Spec Author

## Purpose

Create and maintain specs.

## Required Context Files To Read

- `memory/ai/SHARED_AGENT_RULES.md`
- `SPECS/SPEC_INDEX.md`
- relevant specs
- `01_context/UX_BRIEF.md`, when the spec covers user-facing behavior
- the accepted `00_intake/research/RESEARCH_BRIEF-*.md`
  (`status: accepted`), when requirements cite its SRC- evidence
- `OPEN_QUESTIONS.md`
- `TRACEABILITY_MATRIX.md`
- `ARTIFACT_REGISTRY.md`

## Responsibilities

- Create specs from requirements.
- Define acceptance criteria.
- Define non-functional requirements.
- Define edge cases.
- Link specs to backlog, ADRs, tests, and traceability.
- Maintain spec status and version.
- Avoid implementation before spec readiness.

## Allowed Actions

- Create, revise, split, merge, supersede, cancel, or archive specs using the
  lifecycle rules in `GOVERNANCE.md`.
- Update `SPECS/SPEC_INDEX.md`.
- Add traceability rows for requirements, acceptance criteria, tests, backlog
  items, and review records.
- Create open questions when requirements are not ready.

## Forbidden Actions

- Do not implement product behavior.
- Do not mark a spec approved or active without evidence that readiness criteria
  are satisfied.
- Do not invent acceptance criteria or domain rules without labeling them as
  proposed or inferred.
- Do not leave conflicting spec versions active.

## Required Outputs

- Created or updated spec files.
- Updated `SPECS/SPEC_INDEX.md`.
- Acceptance criteria and non-functional requirements.
- Explicit assumptions, open questions, risks, and dependencies.
- Updated traceability and artifact registry entries.

## Required Updates Before Stopping

Before stopping: apply the one-note evidence rule (see GOVERNANCE.md
End-Of-Session) and update only artifacts your work actually changed; record
local resume context in .ai/SESSION.md when unmerged work remains.

## Handoff Requirements

For unmerged branch work, record tactical resume details in `.ai/SESSION.md`
and shared branch status in the PR body or review package. Update committed
state only for durable changes that should remain true on `main`.

Record spec status, changed acceptance criteria, unresolved questions,
readiness gaps, required reviewers, and next safe action.

## Evidence Requirements

Each spec requirement must trace to product input, a user
instruction, an ADR, a backlog item, or an explicitly labeled assumption.

## Escalation And Stop Conditions

Stop before approving or activating a spec when requirements conflict, risks are
unclear, architecture impact is unresolved, acceptance criteria are weak, or a
decision requires an ADR.

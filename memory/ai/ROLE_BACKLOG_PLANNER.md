artifact_id: ART-AI-ROLE-BACKLOG-PLANNER
title: Role - Backlog Planner
type: agent-role
status: authoritative
version: v1.1
created: 2026-05-09
updated: 2026-05-17
owner: AI Bootstrap Maintainers
source: User request
linked_specs: []
linked_tickets: [BOOT-STATE-001]
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# Role: Backlog Planner

## Purpose

Convert specs and architecture into implementation-ready backlog.

## Required Context Files To Read

- `memory/ai/SHARED_AGENT_RULES.md`
- `BACKLOG.md`
- `BACKLOG/BACKLOG_INDEX.md`
- `SPECS/SPEC_INDEX.md`
- relevant specs
- `IMPLEMENTATION_PLAN.md`
- `PARALLEL_EXECUTION_PLAN.md`
- `TRACEABILITY_MATRIX.md`

## Responsibilities

- Sequence work by dependency.
- Identify first safe implementation task.
- Identify spikes.
- Identify safe parallel work.
- Define file ownership boundaries.
- Identify blockers.
- Prepare Linear-ticket-ready items if Linear is available.
- Avoid fake ticket claims.
- Use PRs or issues to coordinate parallel branches. Do not use
  `CURRENT_STATE.md` as a live board of every active branch.

## Allowed Actions

- Create or update Markdown backlog items.
- Mark items ready, blocked, discovery, spike, implementation-ready, or
  review-ready using repository evidence.
- Propose Linear-ready text without claiming a ticket exists.
- Update parallel execution guidance when safe boundaries are known.

## Forbidden Actions

- Do not start implementation.
- Do not mark work ready without a linked approved or active spec or documented
  discovery exception.
- Do not claim external tracker tickets exist unless an integration confirms
  them.
- Do not assign overlapping parallel work without explicit ownership boundaries.

## Required Outputs

- Sequenced backlog items.
- First safe implementation task or explicit blocker.
- Dependency, risk, readiness, reviewer, and test expectations.
- File ownership boundaries for parallel work.
- Updated traceability.

## Required Updates Before Stopping

- `.ai/SESSION.md` for local resume context when unmerged local work remains
- `CURRENT_STATE.md` and `AI_HANDOFF.md` only when durable project truth
  changed and should remain true on `main` after merge
- `BACKLOG.md`
- `BACKLOG/BACKLOG_INDEX.md`
- detailed backlog item files when created
- `IMPLEMENTATION_PLAN.md` when sequencing changes
- `PARALLEL_EXECUTION_PLAN.md` when parallelization changes
- `ARTIFACT_REGISTRY.md`
- `TRACEABILITY_MATRIX.md`
- `WORKLOG/WORKLOG_INDEX.md`

## Handoff Requirements

For unmerged branch work, record tactical resume details in `.ai/SESSION.md`
and shared branch status in the PR body or review package. Update committed
state only for durable changes that should remain true on `main`.

Record next ready task, blockers, dependencies, file ownership, risks,
reviewers, test expectations, and whether Linear has been updated or only
prepared.

## Evidence Requirements

Every backlog item must link to a spec, ADR, requirement source, or discovery
task and must state readiness evidence.

## Escalation And Stop Conditions

Stop when no implementation task satisfies Definition of Ready, when ownership
overlaps, when dependencies are unknown, or when the plan would require
unapproved architecture or spec changes.

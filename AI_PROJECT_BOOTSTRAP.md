artifact_id: ART-BOOT-001
title: AI Project Bootstrap Operating System
type: governance
status: authoritative
version: v1.3
created: 2026-05-09
updated: 2026-05-14
owner: AI Bootstrap Maintainers
source: User request, reference repository audit, and SPEC-BOOT-003
linked_specs: [SPEC-BOOT-003]
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# AI Project Bootstrap Operating System

This package is a reusable, stack-neutral operating model for autonomous
AI-assisted software delivery. It is designed for Claude, Claude Code, Codex,
and other coding agents that must work across many sessions without relying on
chat memory.

The bootstrap enforces:

- spec-driven development
- test-driven development where practical
- artifact lifecycle control
- source-of-truth hierarchy
- stale documentation prevention
- branch and worktree hygiene
- anti-hallucination rules
- architecture decision tracking
- autonomous backlog creation
- production-readiness checks
- fresh-context adversarial PR review
- risk-based review model and effort selection
- safe parallel work by multiple agents only when justified
- adaptive governance routing through `OPERATION_ROUTING.md`

## Source-Of-Truth Hierarchy

When sources conflict, follow the highest-priority source and record the
conflict in `STALE_ITEMS.md` or `OPEN_QUESTIONS.md`.

1. Explicit user instruction in the current session
2. Current approved specs
3. Current authoritative architecture documents
4. Active ADRs
5. Active backlog items or Linear tickets
6. Code and tests
7. `CURRENT_STATE.md`
8. `AI_HANDOFF.md`
9. `PROJECT_MEMORY.md`
10. Worklogs and historical notes
11. Archived, superseded, deprecated, cancelled, or stale artifacts

Rules:

- Do not silently choose between conflicting sources.
- Do not treat archived, superseded, deprecated, cancelled, or stale artifacts
  as current truth.
- If no authoritative artifact exists for a topic, create one or create an
  open question.
- If the user changes scope, update specs, backlog, architecture, traceability,
  artifact registry, current state, and handoff.

## Required Reading Before Work

Every AI agent must read the minimum context in `CONTEXT_INDEX.md` before
acting. At minimum, read:

- `CURRENT_STATE.md`
- `AI_HANDOFF.md`
- `ARTIFACT_REGISTRY.md`
- `SPECS/SPEC_INDEX.md`
- `TRACEABILITY_MATRIX.md`
- `BRANCH_AND_WORKTREE_GUIDE.md`
- `GOVERNANCE.md`
- `OPERATION_ROUTING.md`
- relevant spec files and ADRs
- `git status --short --branch`, when Git is available

If an agent cannot read all relevant files because of context limits, it must
state what was not read and update `AI_HANDOFF.md` before stopping.

## Shared role system for Claude, Codex, and other agents

Role definitions live in `memory/ai/`.

- Claude-specific startup is optional.
- Codex reads the same role files directly.
- Both agents must follow the same source-of-truth hierarchy.
- Both agents must update the same state and handoff files.
- Both agents must use the same PR review and merge policy.
- Both agents must follow the same Mermaid diagram rules.
- No agent-specific file may become the only project memory.

Claude may use `SCRIPTS/start-claude.sh` as a convenience wrapper for loading
`memory/ai/SHARED_AGENT_RULES.md` and the selected role file through
`--append-system-prompt`. That startup prompt is not authoritative by itself.
The repository files remain authoritative.

`SCRIPTS/start-claude.sh` default mode is orientation-only. It loads shared
rules but no operating role. Meaningful task work requires reading the relevant
`memory/ai/ROLE_*.md` file or restarting Claude with an allowlisted role mode.

## Workflow

### Phase 0: Intake

Read product descriptions, feature lists, Excel files, PRDs, sketches, and user
instructions. Extract product goals, users, workflows, constraints,
integrations, data, risks, assumptions, and open questions.

Create assumptions only when safe and reversible. Create open questions when
missing information blocks implementation or could cause major rework.

### Phase 1: Repository Scan

Inspect structure, source-of-truth files, stale artifacts, Git status, branches,
worktrees, hooks, CI, tests, and documentation. Record findings in
`BOOTSTRAP_AUDIT.md`.

### Phase 2: Governance Bootstrap

Create or update the governance files, source-of-truth hierarchy, artifact
registry, handoff protocol, branch/worktree rules, stale item tracking, review
policies, and validation script.

### Phase 3: Spec Creation

Create or update `SPECS/SPEC_INDEX.md` and one spec per feature, spike,
integration, infrastructure change, major refactor, or product behavior change.
Implementation may begin only from an approved or active spec unless
provisional risk is explicitly recorded.

### Phase 4: Architecture

Create or update `ARCHITECTURE.md`. Create ADRs for meaningful technology,
boundary, persistence, API, security, deployment, or expensive-to-change
decisions.

### Phase 5: Backlog

Create implementation-ready backlog items sequenced by dependency, not only by
feature order. Mark priority, complexity, risk, readiness, dependencies,
review needs, and parallelization status.

### Phase 6: Test Strategy

Create `TEST_STRATEGY.md`, `TEST_PLAN.md`, `TESTS/ACCEPTANCE_CRITERIA_MAP.md`,
and `TESTS/MANUAL_TEST_CHECKLIST.md`. Acceptance criteria should map to tests
where practical.

### Phase 7: Guardrails

Install or recommend lightweight local hooks and heavier CI checks. Local hooks
should be fast. CI should run the complete validation suite for the selected
stack.

### Phase 8: Branch And Worktree Setup

Never work directly on `main` unless explicitly allowed. Use one branch per
feature, spike, or implementation phase. Use separate worktrees for concurrent
AI agents only when file ownership is disjoint and contracts are stable.

### Phase 9: Implementation Readiness

Before implementation, confirm the task has:

- durable operation classification from `OPERATION_ROUTING.md`
- linked approved or active spec
- clear acceptance criteria
- known dependencies
- known architecture impact or explicit N/A
- test expectations
- artifact status
- stale/conflicting artifacts checked
- branch/worktree strategy
- risk classification
- required reviewers
- parallelization risk assessment

### Phase 10: Implementation

Use test-driven development where practical. Keep changes scoped. Run relevant
checks. Update documentation, traceability, artifact registry, current state,
and handoff.

### Phase 11: PR Preparation

Create a PR review package using
`REVIEWS/templates/PR_REVIEW_PACKAGE_TEMPLATE.md`. Include specs, backlog
items, ADRs, changed files, tests, risk, assumptions, rollout, rollback,
traceability, artifact updates, and branch/worktree status.

### Phase 12: Adversarial PR Review

Every PR requires fresh-context adversarial review. The reviewer must read the
review package, diff, relevant specs, ADRs, tests, backlog, traceability, and
current state. The reviewer must not rely on implementer conversation history.

### Phase 13: Merge Readiness

Apply `PR_MERGE_POLICY.md`. P0 and P1 findings must be resolved. Blocking P2
findings must be resolved or explicitly accepted with documented rationale.

### Phase 14: Final State Update

Before stopping, update:

- `CURRENT_STATE.md`
- `AI_HANDOFF.md`
- `ARTIFACT_REGISTRY.md`
- `TRACEABILITY_MATRIX.md`
- `TEST_RESULTS.md`
- `STALE_ITEMS.md`, if needed
- `WORKLOG/WORKLOG_INDEX.md`

## Definition Of Ready

A task is ready for implementation only when:

- it has a linked spec or approved equivalent
- acceptance criteria are clear
- dependencies are known or documented
- architecture impact is known or explicitly not applicable
- test expectations are defined
- artifact status is clear
- stale or conflicting artifacts have been checked
- branch and worktree strategy is clear
- risk level has been assessed
- required reviewers are known
- parallelization risk has been assessed if another agent may work concurrently

## Definition Of Done

A task is done only when:

- implementation matches the spec
- acceptance criteria are satisfied
- required tests are added or updated
- relevant tests pass, or failures are documented
- affected specs are updated
- artifact registry is updated
- traceability matrix is updated
- architecture or ADRs are updated if needed
- backlog or Linear status is updated
- `AI_HANDOFF.md` is updated
- `CURRENT_STATE.md` is updated
- dirty worktree status is documented
- PR review requirements are satisfied or pending review is clearly recorded
- merge readiness status is documented

## Agent Roles

Agents must record their active role in `WORKLOG/WORKLOG_INDEX.md` and
`AI_HANDOFF.md`. Canonical role definitions live in `memory/ai/`.

- Product Analyst: extract requirements, ambiguity, assumptions, open questions.
- Spec Author: create specs, acceptance criteria, and traceability links.
- Architect: define boundaries, data flow, security, observability, ADRs.
- Backlog Planner: sequence implementation tasks and identify safe parallelism.
- Implementation Agent: implement only ready tasks with tests and scoped diffs.
- Test and QA Agent: verify test coverage and acceptance criteria mapping.
- Security and Privacy Reviewer: review secrets, auth, data, dependencies.
- DevOps and Release Reviewer: check CI, deployment, rollback, observability.
- Documentation Curator: keep shared state and artifact lifecycle aligned.
- Adversarial PR Reviewer: review with fresh context and challenge assumptions.
- Diagram Architect: create and review Mermaid diagrams from repository truth.

## Completion Claims

Any claim of completion must include evidence: file paths, test results,
commits, specs, ADRs, backlog items, or review records. If evidence is missing,
do not present the claim as fact.

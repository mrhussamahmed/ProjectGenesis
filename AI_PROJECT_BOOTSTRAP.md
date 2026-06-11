artifact_id: ART-BOOT-001
title: AI Project Bootstrap Operating System
type: governance
status: authoritative
version: v2.1
created: 2026-05-09
updated: 2026-06-11
owner: AI Bootstrap Maintainers
source: User request, reference repository audit, SPEC-BOOT-003, GEN-01 pipeline compaction, and BOOT-RESEARCH-001 research stage and roles
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
9. Worklogs and historical notes
10. Archived, superseded, deprecated, cancelled, or stale artifacts

Rules:

- Do not silently choose between conflicting sources.
- Do not treat archived, superseded, deprecated, cancelled, or stale artifacts
  as current truth.
- If no authoritative artifact exists for a topic, create one or create an
  open question.
- If the user changes scope, update the affected specs, backlog, architecture,
  and state artifacts.

## Required Reading Before Work

Read the minimum context and the task section in `CONTEXT_INDEX.md`; it is the
single read-list authority. Escalate only per `OPERATION_ROUTING.md` read tiers.

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

## Pipeline

The delivery pipeline is a stage table, not a phase narrative. Each stage names
its trigger (a `COMMANDS/COMMAND_INDEX.md` phrase or an operating role), the
artifacts it produces, and the criterion that exits the stage.

| Stage | Trigger command or role | Key artifacts | Exit criterion |
|-------|-------------------------|---------------|----------------|
| intake | `Start requirement breakdown` | `00_intake/`, `01_context/`, `02_requirements/`, backlog candidates | readiness classified |
| research (optional) | `Start research` | research plan, track reports, critic review, and research brief under `00_intake/research/`; updated registers | brief accepted by user |
| validate idea (optional) | `Validate the idea` | research notes under `00_intake/research/`, updated assumptions register | high-risk assumptions evidenced |
| spec | spec author role (`memory/ai/ROLE_SPEC_AUTHOR.md`) | specs under `SPECS/` | spec promoted draft to approved |
| architecture | `Start architecture design` | tech design (`SPECS/templates/TECH_DESIGN_TEMPLATE.md`) plus slim ADRs | design approved |
| backlog | backlog planner role (`memory/ai/ROLE_BACKLOG_PLANNER.md`) | epics and stories with readiness gate fields | items implementation-ready |
| implement | `Implement next story` | code, tests, PR | merged with evidence note |
| handoff | always, before stopping | `.ai/SESSION.md` or committed state files | next action recorded |

## Stage Rules

- Create assumptions only when safe and reversible. Create open questions when
  missing information blocks implementation or could cause major rework.
- Implementation may begin only from an approved or active spec unless
  provisional risk is explicitly recorded.
- High-impact decisions (irreversible choices, external integrations, security
  or privacy decisions, deployment choices, API boundaries, persistence and
  data model choices, major dependencies) require an ADR before
  implementation.
- Never work directly on `main` unless explicitly allowed. Use one branch per
  feature, spike, or implementation phase per `BRANCH_AND_WORKTREE_GUIDE.md`.
- Use separate worktrees for concurrent agents only when file ownership is
  disjoint and contracts are stable.
- Keep changes scoped. Use test-driven development where practical.
- Merge readiness follows `PR_MERGE_POLICY.md`. P0, P1, and blocking P2
  findings must be resolved. AI may merge once these gates pass; human,
  maintainer, or Code Owner approval is not required.

## Review And Evidence

Review depth follows the operation profile per OPERATION_ROUTING.md and
PR_REVIEW_POLICY.md: docs-trivial, docs-non-authoritative, and state-sync
changes require a recorded self-check in the PR body; planning-governance and
strict-protected changes require fresh-context adversarial review.

Record one validation-evidence note per PR (in the PR body or review package).
Update TEST_RESULTS.md, TRACEABILITY_MATRIX.md, and ARTIFACT_REGISTRY.md only
when a durable baseline, requirement mapping, or artifact lifecycle changed -
at most once per PR, not per session.

## Definition Of Ready

A task is ready for implementation only when:

- it has a linked spec or approved equivalent
- acceptance criteria are clear
- its readiness gate fields are filled:
  - `User value (1 sentence):`
  - `Measurable success criterion:`
  - `Observability expectation:`
  - `Security triggers checked (per SECURITY_AND_PRIVACY.md): yes | no | n-a`
- dependencies are known or documented
- architecture impact is known or explicitly not applicable
- test expectations are defined
- stale or conflicting artifacts have been checked
- branch and worktree strategy is clear
- risk level has been assessed
- parallelization risk has been assessed if another agent may work concurrently

## Definition Of Done

A task is done only when:

- implementation matches the spec and acceptance criteria are satisfied
- required tests are added or updated, and relevant tests pass or failures are
  documented
- affected specs, architecture documents, or ADRs are updated when behavior or
  design changed
- backlog or Linear status is updated
- the validation-evidence note and any durable state updates follow the Review
  And Evidence rules above
- review and merge readiness for the operation profile are satisfied or the
  pending review is clearly recorded

## Agent Roles

Agents record their active role in `.ai/SESSION.md` for local work, or in
`AI_HANDOFF.md` when durable truth changed. Canonical role definitions live in
`memory/ai/`.

- Product Analyst: extract requirements, ambiguity, assumptions, open questions.
- Research Planner: plan research depth and tracks, orchestrate research runs,
  hold the brief approval gates.
- Researcher: execute one assigned research track and produce evidence-only
  reports.
- Research Critic: challenge research reports from a fresh context.
- Research Synthesizer: merge accepted reports into a decision-ready brief.
- UX Designer: turn evidence-backed user needs into the UX brief for specs.
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

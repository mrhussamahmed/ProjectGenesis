artifact_id: ART-AI-SHARED-RULES
title: Shared Agent Rules
type: agent-rules
status: authoritative
version: v1.3
created: 2026-05-09
updated: 2026-05-17
owner: AI Bootstrap Maintainers
source: User request, review fix, SPEC-BOOT-003, and BOOT-STATE-001
linked_specs: [SPEC-BOOT-003]
linked_tickets: [BOOT-STATE-001]
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# Shared Agent Rules

These rules apply to Claude, Codex, and every other coding agent working in this
repository. Agent-specific startup prompts are convenience wrappers only. The
source of truth for agent behavior is the repository file set, starting with
this file and the selected `memory/ai/ROLE_*.md` file.

## Source Of Truth

Follow the source-of-truth hierarchy in `AI_PROJECT_BOOTSTRAP.md` and
`GOVERNANCE.md`.

- Read `CONTEXT_INDEX.md` before meaningful work.
- Follow `GOVERNANCE.md`.
- Use `OPERATION_ROUTING.md` to classify meaningful operations before target
  file edits and to scope reads, writes, validation, review, and handoff
  evidence.
- Use `CURRENT_STATE.md` and `AI_HANDOFF.md` as current operational state.
- Use `ARTIFACT_REGISTRY.md` before trusting artifacts.
- Use `TRACEABILITY_MATRIX.md` for requirement, spec, backlog, code, test,
  review, and diagram mapping.
- Use `SPECS/SPEC_INDEX.md` and relevant specs before implementation.
- Use `ADR/ADR_INDEX.md` and relevant ADRs before architecture decisions.
- Do not rely on chat memory as source of truth.
- Do not invent APIs, requirements, tickets, domain rules, files, commands,
  completion status, or external integration state.

## State Boundary

Committed state files describe durable project truth that should remain true
on `main` after merge. They are not per-agent scratchpads.

Branch-specific shared state belongs in a PR, issue, or review package. Local
resume state belongs in gitignored `.ai/SESSION.md`.

Agents must not record temporary worktree paths, feature-branch "current"
state, or "awaiting merge" instructions as active facts in committed
`CURRENT_STATE.md` or `AI_HANDOFF.md`.

## Role Selection

Each task uses the same role definitions regardless of whether the agent is
Claude, Codex, or another coding agent.

- Start by reading this file.
- Then read exactly the relevant `memory/ai/ROLE_*.md` file for the task.
- If a task crosses roles, read the primary role first and any additional role
  files needed for the requested work.
- For unmerged branch work, record tactical resume details in
  `.ai/SESSION.md` and shared branch status in the PR body or review package.
  Update committed state only for durable changes that should remain true on
  `main`.
- Claude `default` startup mode is orientation-only. It loads these shared
  rules but no operating role. Do not perform meaningful task work from default
  mode until the relevant `memory/ai/ROLE_*.md` file has been read or Claude is
  restarted with an allowlisted role mode.

## Command Shortcuts

If the user gives a short workflow command or phrase, read
`COMMANDS/COMMAND_INDEX.md`. When the phrase is an exact or unambiguous trigger
match, read the matching command file and follow its stop conditions. If the
trigger or required inputs are ambiguous, ask for clarification.

Command files are workflow shortcuts only. They cannot override repository
governance, approved or active specs, accepted ADRs, `CONTEXT_INDEX.md`,
selected role files, `ARTIFACT_REGISTRY.md`, `TRACEABILITY_MATRIX.md`,
`CURRENT_STATE.md`, `AI_HANDOFF.md`, or runtime/tool policies.

## Implementation Gate

Do not start implementation unless the task satisfies Definition of Ready in
`AI_PROJECT_BOOTSTRAP.md`.

Implementation requires:

- durable operation classification from `OPERATION_ROUTING.md`
- an approved or active spec, or a bootstrap-governance exception explicitly
  tracked in backlog and traceability
- clear acceptance criteria
- known dependencies and architecture impact
- test expectations
- artifact status checked
- stale or conflicting artifacts checked
- branch and worktree strategy understood
- risk and required reviewers identified

Draft or proposed specs permit discovery, research, planning, architecture
analysis, spike work, backlog preparation, and documentation only.

## Evidence And Completion

- Do not claim completion without evidence.
- Evidence can include changed files, test results, validation output, review
  records, traceability rows, artifact registry entries, specs, ADRs, backlog
  items, or commits.
- Record failed or skipped checks honestly in `TEST_RESULTS.md` and
  `AI_HANDOFF.md`.
- Record the final evidence envelope required by `OPERATION_ROUTING.md` before
  claiming meaningful work is complete.
- If evidence is incomplete, report the work as incomplete or pending review.

## Documentation And State Updates

Before stopping after meaningful work, update:

- `.ai/SESSION.md` for local resume context when unmerged local work remains
- `CURRENT_STATE.md` and `AI_HANDOFF.md` only when durable project truth
  changed and should remain true on `main` after merge
- `ARTIFACT_REGISTRY.md` when artifacts were created, changed, superseded, or
  retired
- `TRACEABILITY_MATRIX.md` when specs, backlog, implementation, tests, reviews,
  diagrams, or governance mappings change
- `TEST_RESULTS.md` when checks ran
- `WORKLOG/WORKLOG_INDEX.md` for meaningful sessions
- `STALE_ITEMS.md` or `OPEN_QUESTIONS.md` when conflicts, stale items, missing
  facts, or unresolved assumptions exist

Register important artifacts in `ARTIFACT_REGISTRY.md`. Keep `CLAUDE.md` and
`AGENTS.md` short and pointing to shared files.

## Diagrams

Mermaid diagrams are governed by the same source-of-truth hierarchy.

- Create diagrams only when they clarify architecture, workflow, dependency,
  review, release, or handoff state.
- Do not encode hallucinated architecture.
- Mark inferred or proposed components clearly.
- Register diagrams in `DIAGRAMS/DIAGRAM_INDEX.md` if that directory exists, in
  `ARTIFACT_REGISTRY.md`, and in `TRACEABILITY_MATRIX.md` where relevant.
- Update or mark diagrams stale when specs, ADRs, or architecture change.

## Review And Handoff

- Every PR requires fresh-context adversarial review using
  `PR_REVIEW_POLICY.md`.
- Reviewers must not rely on implementer chat history.
- The implementation agent must not be the only reviewer of its own work.
- Before stopping or switching agents with unmerged local work, update
  `.ai/SESSION.md` with branch, worktree, changed files, tests run, failures,
  risks, assumptions, and the next local action. Put shared branch status in
  PR evidence. Update `AI_HANDOFF.md` only for durable handoff facts that
  should remain true on `main`.

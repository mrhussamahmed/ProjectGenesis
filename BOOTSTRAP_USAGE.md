artifact_id: ART-BOOT-002
title: Bootstrap Usage Guide
type: guide
status: authoritative
version: v1.3
created: 2026-05-09
updated: 2026-05-13
owner: AI Bootstrap Maintainers
source: User request, reference repository audit, and SPEC-BOOT-002
linked_specs: [SPEC-BOOT-002]
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# Bootstrap Usage Guide

Use this package by copying its files into a new project root or by creating a
new repository from this folder.

For the shortest path, start with `GETTING_STARTED.md` and then use
`NEW_PROJECT_INITIALIZATION.md` inside the downstream project.

## Start From A Product Idea

1. Put the idea in `00_intake/raw/` or paste it into the current AI session.
2. Tell the AI: `Start requirement breakdown.`
3. The AI must read `COMMANDS/COMMAND_INDEX.md`, execute the matched command
   file, register and summarize intake sources, and create evidence-linked
   product context, requirements, assumptions, risks, backlog candidates, and
   readiness status.
4. Implementation must wait until the first task satisfies Definition of Ready.

## Command Shortcuts

Reusable workflow commands live under `COMMANDS/`. The main downstream intake
shortcut is:

```text
Start requirement breakdown.
```

Agents must match short workflow phrases through `COMMANDS/COMMAND_INDEX.md`.
Command files are workflow shortcuts only and cannot override repository
governance, role files, specs, ADRs, traceability, current state, or handoff.

## Start From A PRD

1. Place the PRD in the repository, preferably under `00_intake/raw/`.
2. The Product Analyst role extracts product requirements, user journeys,
   constraints, assumptions, and open questions.
3. The Spec Author creates one or more specs under `SPECS/`.
4. The Backlog Planner creates sequenced backlog items under `BACKLOG/` and
   mirrors the active plan in `BACKLOG.md`.

## Start From An Excel File Or Feature List

1. Place the file under `00_intake/raw/`.
2. The AI must inspect sheets, columns, feature labels, priorities, owners,
   dependencies, notes, and unclear values.
3. The AI should normalize rows into requirements, assumptions, open questions,
   spikes, and backlog items.
4. If any spreadsheet value is ambiguous or conflicting, record it in
   `OPEN_QUESTIONS.md` instead of inventing intent.

## Legacy Input Path

`INPUT/` remains as a legacy alias for older prompts. New source material should
use `00_intake/raw/`. If an agent finds files under `INPUT/`, it must register
them in `00_intake/SOURCE_REGISTRY.md` and treat `INPUT/README.md` as the
compatibility guide.

## Ask Claude To Use The Bootstrap

Use this prompt:

```text
Read CLAUDE.md, then follow AI_PROJECT_BOOTSTRAP.md. Use the neutral shared
state files as the source of truth. Do not implement until the relevant spec is
approved or active. Update CURRENT_STATE.md and AI_HANDOFF.md before stopping.
```

## Ask Codex To Use The Bootstrap

Use this prompt:

```text
Read AGENTS.md, then follow AI_PROJECT_BOOTSTRAP.md. Inspect git status and the
minimum context in CONTEXT_INDEX.md before acting. Keep changes scoped, update
traceability and handoff, and run SCRIPTS/validate-bootstrap.sh before claiming
the scaffold is valid.
```

## Using the shared role system with Claude and Codex

For Claude, use:

```sh
./SCRIPTS/start-claude.sh <mode>
```

`./SCRIPTS/start-claude.sh` without `<mode>` starts default orientation-only
mode. Default mode loads shared rules but no operating role, so task work must
wait until the relevant `memory/ai/ROLE_*.md` file is read or Claude is
restarted with an allowlisted role mode.

For Codex, ask Codex to read `memory/ai/SHARED_AGENT_RULES.md` and the relevant
`memory/ai/ROLE_*.md` file.

Example Codex prompt:

```text
You are Codex working inside this repository.
Read memory/ai/SHARED_AGENT_RULES.md.
Then read memory/ai/ROLE_IMPLEMENTATION_AGENT.md.
Then read CONTEXT_INDEX.md, CURRENT_STATE.md, AI_HANDOFF.md, the linked spec, the linked backlog item, TEST_PLAN.md, TRACEABILITY_MATRIX.md, and ARTIFACT_REGISTRY.md.
Continue only if the task satisfies Definition of Ready.
Use TDD where practical.
Keep changes scoped.
Update CURRENT_STATE.md and AI_HANDOFF.md before stopping.
```

## Files An AI Must Read First

Minimum context before any work:

- `CURRENT_STATE.md`
- `AI_HANDOFF.md`
- `ARTIFACT_REGISTRY.md`
- `SPECS/SPEC_INDEX.md`
- `TRACEABILITY_MATRIX.md`
- `BRANCH_AND_WORKTREE_GUIDE.md`
- `GOVERNANCE.md`
- relevant spec files
- relevant ADRs
- `git status --short --branch`

Context by role is defined in `CONTEXT_INDEX.md`.

## Create The First Spec

1. Read source input and `OPEN_QUESTIONS.md`.
2. Copy `SPECS/templates/SPEC_TEMPLATE.md` to
   `SPECS/SPEC-001-short-name.md`.
3. Fill the metadata block, status, source input, requirements, acceptance
   criteria, risks, assumptions, open questions, and test requirements.
4. Add the spec to `SPECS/SPEC_INDEX.md`.
5. Add traceability rows to `TRACEABILITY_MATRIX.md`.
6. Update `ARTIFACT_REGISTRY.md`.

## Create The First Backlog

1. Read approved or proposed specs and architecture.
2. Copy `BACKLOG/templates/BACKLOG_ITEM_TEMPLATE.md` for each independent item,
   or maintain a table in `BACKLOG.md` until items become detailed.
3. Sequence by dependency and implementation order.
4. Mark readiness, complexity, risk, test expectations, and parallelization
   status.
5. Prepare Linear-ready titles and descriptions when Linear is available.

## Decide The First Implementation Branch

Use `BRANCH_AND_WORKTREE_GUIDE.md`.

Recommended first implementation branch after bootstrap:

```sh
feature/SPEC-001-initial-product-slice
```

Use a spike branch instead when requirements or architecture are not yet ready:

```sh
spike/SPEC-001-critical-unknown
```

## Run Validation Checks

Run:

```sh
bash SCRIPTS/validate-bootstrap.sh
```

If Git is available, also run:

```sh
git status --short --branch
```

Project-specific stacks should add formatter, linter, type, test, build,
security, dependency, migration, accessibility, and smoke checks in CI after
the architecture selects the stack.

## Hand Off From One AI Agent To Another

Before stopping, update `AI_HANDOFF.md` with:

- date, active agent, role, branch, worktree
- last completed task and in-progress task
- files, specs, artifacts, and decisions changed
- assumptions and open questions
- tests run, tests not run, failures, and risks
- dirty worktree status and untracked files
- next recommended action
- what the next AI must read first

If handoff is stale, reconstruct state from Git, specs, artifacts, tests, and
worklogs, then update `AI_HANDOFF.md` before continuing.

## Prepare A PR Review Package

Copy `REVIEWS/templates/PR_REVIEW_PACKAGE_TEMPLATE.md` into `REVIEWS/` and fill:

- PR title and purpose
- linked specs, backlog items, tickets, ADRs
- changed files
- summary of changes
- acceptance criteria
- tests and test results
- risks, limitations, assumptions, unresolved questions
- rollout, rollback, security, privacy, observability
- traceability and artifact updates
- branch and worktree status

## Trigger Fresh Adversarial Review

Give the reviewer this instruction:

```text
Use REVIEWS/templates/ADVERSARIAL_PR_REVIEW_TEMPLATE.md. Do not rely on the
implementer's conversation history. Read the review package, PR diff, relevant
specs, ADRs, tests, backlog, traceability matrix, artifact registry, and current
state. Findings must use P0, P1, P2, and P3 severity.
```

## Run Multiple Agents In Parallel

Parallel work is allowed only when `PARALLEL_EXECUTION_PLAN.md` says it is
safe. Each stream must have:

- separate spec or separate acceptance criteria
- mostly separate file ownership
- stable or versioned shared interfaces
- no independent changes to architecture, schemas, auth, dependencies, CI/CD,
  deployment, or global config
- documented merge order
- integration test expectations

Stop parallel work if a shared contract changes, file ownership overlaps, or
architecture assumptions diverge.

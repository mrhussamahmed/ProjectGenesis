artifact_id: ART-BOOT-002
title: Bootstrap Usage Guide
type: guide
status: authoritative
version: v2.1
created: 2026-05-09
updated: 2026-06-11
owner: AI Bootstrap Maintainers
source: User request, reference repository audit, SPEC-BOOT-002, GEN-01 canonical quickstart consolidation, and BOOT-RESEARCH-001 research shortcut
linked_specs: [SPEC-BOOT-002]
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# Bootstrap Usage Guide

This guide holds agent prompt recipes. The canonical setup path is the README
Quick Start: extract the scaffold with `bash SCRIPTS/scaffold-extract.sh
--apply <target>`, drop input in `00_intake/raw/`, say
`Start requirement breakdown.`, then validate. Inside the downstream project,
`NEW_PROJECT_INITIALIZATION.md` is the full initialization prompt.

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

For evidence-backed research before product definition, the optional research
orchestration shortcut is:

```text
Start research.
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

## Ask Claude To Use The Bootstrap

Use this prompt:

```text
Read CLAUDE.md, then follow AI_PROJECT_BOOTSTRAP.md. Use the neutral shared
state files as the source of truth. Do not implement until the relevant spec is
approved or active. Update .ai/SESSION.md before stopping; update
CURRENT_STATE.md and AI_HANDOFF.md only if durable project truth changed.
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
Then follow the Implementation section of CONTEXT_INDEX.md.
Continue only if the task satisfies Definition of Ready.
Use TDD where practical.
Keep changes scoped.
Update .ai/SESSION.md before stopping; update CURRENT_STATE.md and
AI_HANDOFF.md only if durable project truth changed.
```

## Files An AI Must Read First

`CONTEXT_INDEX.md` is the single read-list authority: read its minimum context,
then the section for your task. No other file enumerates required reading.

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

Enable the bundled Git hooks once per clone so validation runs automatically
on commit and push (`SCRIPTS/doctor.sh` warns when this is missing):

```sh
git config core.hooksPath .githooks
```

Run:

```sh
bash SCRIPTS/validate-bootstrap.sh
```

Run `SCRIPTS/session.sh start <profile>` to enable scoped validation for the
session; run `SCRIPTS/doctor.sh` for instant orientation.

If Git is available, also run:

```sh
git status --short --branch
```

Project-specific stacks should add formatter, linter, type, test, build,
security, dependency, migration, accessibility, and smoke checks in CI after
the architecture selects the stack.

## Hand Off From One AI Agent To Another

Before stopping, write local resume context (branch, in-progress task, next
action, tests run/not run) to `.ai/SESSION.md` when unmerged local work
remains. Update committed `CURRENT_STATE.md` and `AI_HANDOFF.md` only when
durable project truth changed and the update should remain true on `main`
after merge.

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

Review depth follows the operation profile per OPERATION_ROUTING.md and
PR_REVIEW_POLICY.md: docs-trivial, docs-non-authoritative, and state-sync
changes require a recorded self-check in the PR body; planning-governance and
strict-protected changes require fresh-context adversarial review.

When adversarial review is required, give the reviewer this instruction:

```text
Use REVIEWS/templates/ADVERSARIAL_PR_REVIEW_TEMPLATE.md. Do not rely on the
implementer's conversation history. Read the review package, PR diff, relevant
specs, ADRs, tests, backlog, traceability matrix, artifact registry, and current
state. Findings must use P0, P1, P2, and P3 severity.
```

## Run Multiple Agents In Parallel

Parallel work is allowed only when a parallel-execution plan (maintainer
repo: `PARALLEL_EXECUTION_PLAN.md`; downstream: create one) says it is
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

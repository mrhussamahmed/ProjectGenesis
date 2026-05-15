artifact_id: ART-PAR-001
title: Parallel Execution Plan
type: execution-plan
status: authoritative
version: v1.1
created: 2026-05-09
updated: 2026-05-09
owner: AI Bootstrap Maintainers
source: User request, reference repository audit, and Phase 1 execution planning
linked_specs: [SPEC-BOOT-003]
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# Parallel Execution Plan

Parallel implementation is not allowed by default. It becomes allowed only when
this file explicitly marks streams as safe.

## Current Parallel Streams

No product implementation streams are currently approved for parallel work.

| Stream | Backlog Items | Branch | Worktree | Owner Agent | File Ownership | Status | Merge Order |
|--------|---------------|--------|----------|-------------|----------------|--------|-------------|
| none | none | none | none | none | none | not approved | none |

## Phase 1 Bootstrap Follow-Up Decision

Phase 1 implementation is sequential by default:

1. BOOT-030 scaffold extraction checklist.
2. BOOT-031 scaffold extraction tool.
3. BOOT-032 seeded-defect benchmark and coverage metrics.
4. BOOT-033 SRC/SPEC ID cross-validation.

BOOT-032 research may be prepared in parallel with BOOT-030 only if it is
read-only or writes to a separate research branch with no edits to shared
source-of-truth files, scripts, validators, tests, registry, traceability,
current state, or handoff. No parallel implementation stream is approved yet.

## Parallel Work Is Allowed Only When

- tasks have separate specs or clearly separate acceptance criteria
- file ownership is mostly separate
- shared interfaces are already stable or explicitly versioned
- no agent needs to change global architecture independently
- no agent needs to change shared data models without coordination
- no agent needs to change shared CI/CD, dependency configuration,
  authentication, authorization, or deployment files independently
- merge order is documented
- integration test expectations are documented

## Parallel Work Must Stop If

- two agents need to edit the same core files
- a shared contract changes
- architecture assumptions diverge
- one task invalidates another task's spec
- unexpected changes appear in another worktree
- conflict risk becomes high

## Shared Files That Require Coordination

- `AI_PROJECT_BOOTSTRAP.md`
- `GOVERNANCE.md`
- `ARCHITECTURE.md`
- `DECISIONS.md`
- `ARTIFACT_REGISTRY.md`
- `TRACEABILITY_MATRIX.md`
- `CURRENT_STATE.md`
- `AI_HANDOFF.md`
- `SPECS/SPEC_INDEX.md`
- `ADR/ADR_INDEX.md`
- `BACKLOG.md`
- dependency manifests
- CI/CD files
- authentication, authorization, schema, API contract, migration, and global
  configuration files

## Required Stream Record

When approving parallel work, add a row with:

- backlog items
- specs and acceptance criteria
- branch and worktree names
- owner agent or role
- owned files or modules
- shared files requiring coordination
- expected integration order
- merge conflict risk
- integration test strategy
- stop conditions

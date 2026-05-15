artifact_id: ART-PLAN-001
title: Implementation Plan
type: implementation-plan
status: active
version: v1.1
created: 2026-05-09
updated: 2026-05-09
owner: AI Bootstrap Maintainers
source: Initial bootstrap scaffold and Phase 1 execution planning
linked_specs: [SPEC-BOOT-002, SPEC-BOOT-003]
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# Implementation Plan

This plan covers the bootstrap package itself. Product implementation plans
must be created from product-specific specs.

## Plan

1. Audit target and reference repositories.
2. Create root governance and shared state files.
3. Create spec, ADR, backlog, review, test, artifact, worklog, and handoff
   folder structure.
4. Create templates for specs, ADRs, backlog items, PR review packages, and
   adversarial review.
5. Create branch/worktree, hooks, CI/CD, security, observability, release, and
   contribution guidance.
6. Create lightweight validation script.
7. Run validation and record results.
8. Update current state, handoff, artifact registry, and traceability.

## First Product Implementation Plan

After product input arrives:

1. Product Analyst extracts requirements and open questions.
2. Spec Author creates `SPECS/SPEC-001-*.md`.
3. Architect updates `ARCHITECTURE.md` and creates ADRs where needed.
4. Backlog Planner creates implementation-ready items.
5. Test and QA Agent maps acceptance criteria to tests.
6. Implementation Agent creates the first branch only after Definition of Ready
   is satisfied.

## Validation Commands

```sh
bash SCRIPTS/validate-bootstrap.sh
```

Additional stack-specific commands must be defined in project-specific specs or
test plans.

## Phase 1 Bootstrap Follow-Up Plan

Phase 1 bootstrap follow-up work must proceed as separate branches and PRs.
Do not bundle scaffold extraction, benchmark scripts, and validator ID
cross-validation into one change set.

| Order | Backlog Item | Planning Input | Purpose | Branch/PR Shape | Readiness Gate |
|-------|--------------|----------------|---------|-----------------|----------------|
| 0 | BOOT-029 | User instruction to plan before implementation | Create this durable Phase 1 execution plan and backlog sequence. | Planning-only PR. | Validator, red checks, diff check, and fresh-context review. |
| 1 | BOOT-030 | IB-P0-01 | Define `SCAFFOLD_FORK_CHECKLIST.md` and exact extraction/reset policy. | Documentation/source-of-truth PR; no scripts. | Checklist reviewed and registered before script work. |
| 2 | BOOT-031 | IB-P0-01 | Implement dry-run-first `SCRIPTS/scaffold-extract.sh` with extraction validation. | Strict-protected script PR. | Extracted target passes bootstrap validation. |
| 3 | BOOT-032 | IB-P1-15 | Add coverage metric scripts and seeded-defect benchmark baseline. | QA/metrics PR; CI gate decision deferred. | Baseline detection/coverage numbers recorded. |
| 4 | BOOT-033 | IB-P1-01 | Add SRC/SPEC ID cross-validation to the validator with red checks. | Strict-protected validator PR. | Missing-ID red checks fail before fix and pass after fix. |

### Parallelization

Implementation is sequential by default. BOOT-032 research can be prepared in
parallel with BOOT-030 only if it does not edit shared files; no parallel
implementation stream is approved until `PARALLEL_EXECUTION_PLAN.md` is
updated with explicit file ownership.

### Phase 1 Stop Conditions

- Stop and re-plan if BOOT-030 reveals extraction needs new artifact metadata
  or ADR-level design.
- Stop and re-plan if benchmark work would make claims stronger than the
  measured evidence supports.
- Stop and re-plan if validator ID cross-validation requires changing spec or
  backlog templates beyond local parser rules.

## Rollback Or Recovery

Because this bootstrap is file-based, rollback is standard version control:
revert the change set or restore superseded artifacts from `ARTIFACTS/ARCHIVE/`
when appropriate.

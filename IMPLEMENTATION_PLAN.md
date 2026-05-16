artifact_id: ART-PLAN-001
title: Implementation Plan
type: implementation-plan
status: active
version: v1.4
created: 2026-05-09
updated: 2026-05-16
owner: AI Bootstrap Maintainers
source: Initial bootstrap scaffold, Phase 1 execution planning, Phase 1 closeout coherence verification, BOOT-035 branch-aware handoff planning, PR #12 BOOT-035 merge, and BOOT-035 post-merge cleanup
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

Phase 1 bootstrap follow-up work is complete. BOOT-029 through BOOT-033
proceeded as separate branches and PRs; scaffold extraction, benchmark scripts,
and validator ID cross-validation were not bundled into one change set.

| Order | Backlog Item | Planning Input | Purpose | Branch/PR Shape | Completion Evidence |
|-------|--------------|----------------|---------|-----------------|---------------------|
| 0 | BOOT-029 | User instruction to plan before implementation | Create this durable Phase 1 execution plan and backlog sequence. | Planning-only PR. | PR #6 merged to `main` at `f650367e983895f967ac3e6ce574d6d0d270136d`. |
| 1 | BOOT-030 | IB-P0-01 | Define `SCAFFOLD_FORK_CHECKLIST.md` and exact extraction/reset policy. | Documentation/source-of-truth PR; no scripts. | PR #7 merged to `main` at `90668945bfd24f547ee6ea7f6d1996e7f36c083e`. |
| 2 | BOOT-031 | IB-P0-01 | Implement dry-run-first `SCRIPTS/scaffold-extract.sh` with extraction validation. | Strict-protected script PR. | PR #8 merged to `main` at `32743172a41db65f89d54a84db8d3f2bbb2e2a3b`. |
| 3 | BOOT-032 | IB-P1-15 | Add coverage metric scripts and seeded-defect benchmark baseline. | QA/metrics PR; CI gate decision deferred. | PR #9 merged to `main` at `cf3db56fc3651141a1ecf59adedac28ead3589ae`. |
| 4 | BOOT-033 | IB-P1-01 | Add SRC/SPEC ID cross-validation to the validator with red checks. | Strict-protected validator PR. | PR #10 merged to `main` at `a9c5b5954198fce9391f7c278889f29487a09c84`; follow-up commit `bdc8b19e94564a4a50db8a06f5b06d75e67e2c7c` made `main` CI green. |

### Parallelization

Phase 1 implementation was sequential. No parallel implementation stream was
approved for BOOT-030 through BOOT-033.

### Phase 1 Stop Conditions

No Phase 1 stop condition remains active. BOOT-030 did not require new artifact
metadata or ADR-level design; BOOT-032 recorded a baseline rather than making
generalized benchmark claims; BOOT-033 stayed within local validator parser
rules and did not require spec or backlog template changes.

## Phase 2 Candidate Plan

Phase 2 has one completed item, BOOT-035. Remaining candidate work should be
planned as separate backlog items and reviewed before implementation.

| Candidate | Trigger | Purpose | First Required Action |
|-----------|---------|---------|-----------------------|
| BOOT-034 | PR #10 / BOOT-033 review-loop lesson | Prevent stale forward-looking `Next safe action:` instructions from surviving after the referenced action is complete. | Choose documentation-only, template, or validator enforcement path in a reviewed Phase 2 plan. |

## Phase 2 Completed Work

| Backlog Item | Trigger | Purpose | Completion Evidence |
|--------------|---------|---------|---------------------|
| BOOT-035 | Repeated PR #5 through PR #12 post-merge CI branch-field failures | Make handoff branch-aware so feature-branch merges do not fail `main` CI solely because `AI_HANDOFF.md ## Current Branch` still names the merged branch. | PR #12 merged to `main` at `100fe77f0f1971290407651761a3d92964979d27`; post-merge cleanup adds depth-1 checkout detection via commit-object parent headers and a shallow-checkout red-check fixture. |

## Rollback Or Recovery

Because this bootstrap is file-based, rollback is standard version control:
revert the change set or restore superseded artifacts from `ARTIFACTS/ARCHIVE/`
when appropriate.

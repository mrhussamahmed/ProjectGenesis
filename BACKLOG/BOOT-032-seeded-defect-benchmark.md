artifact_id: ART-BACKLOG-BOOT-032
title: BOOT-032 Seeded-Defect Benchmark
type: backlog-item
status: active
version: v1.0
created: 2026-05-15
updated: 2026-05-15
owner: AI Bootstrap Maintainers
source: IB-P1-15 planning input promoted into tracked backlog after Phase 0 merge
linked_specs: [SPEC-BOOT-003]
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# BOOT-032: Seeded-Defect Benchmark

## Purpose

Create the first empirical benchmark for ProjectGenesis review and
anti-hallucination claims.

## User Or System Value

Turns broad quality claims into measured evidence and exposes gaps before more
public claims or larger automation work.

## Scope

In scope:

- Add coverage metric scripts for evidence, acceptance, and traceability.
- Add a seeded-defect benchmark plan with canonical planted defects.
- Add a runner or documented procedure that reports detection rate.
- Record expected CI/manual boundaries before enabling any heavier checks.

Out of scope:

- Claiming generalized benchmark validity across models or project types.
- Making benchmark pass/fail a required CI gate before baseline data exists.
- Building a full analytics pipeline.

## Links

- Linked spec: `SPEC-BOOT-003`
- Linked acceptance criteria: benchmark produces a detection-rate result and
  coverage scripts report metrics on the current scaffold.
- Linked requirements: claim evidence, fresh review effectiveness,
  traceability coverage
- Source IDs: none; planning input promoted from research package
- Approved assumptions: first benchmark is baseline evidence, not proof of
  general model performance
- Open questions: CI gate threshold after baseline
- Related ADR: none
- Related external ticket: none

## Dependencies

- BOOT-029 merged.
- BOOT-030/BOOT-031 recommended before this item if benchmark fixtures depend
  on clean scaffold extraction.

## Risks

- Metrics may show weaker coverage than expected. That is useful evidence and
  should not be hidden.
- Runner design can become too heavy. Keep first version small and explicit.

## Suggested Owner Role

QA Reviewer, Documentation Curator

## Estimated Complexity

medium

## Implementation Phase

Phase 1C.

## Related Files Or Modules

- `SCRIPTS/metric-evidence-coverage.sh`
- `SCRIPTS/metric-acceptance-coverage.sh`
- `SCRIPTS/metric-traceability-completeness.sh`
- `SCRIPTS/run-seeded-defect-bench.sh`
- `TESTS/ADVERSARIAL_SEED_BENCHMARK.md`
- `TEST_PLAN.md`
- source-of-truth records

## Linear Ticket

- Should become external ticket: no
- Tracker: none
- Ticket status: not-created
- Ticket ID or URL:
- Confirmation evidence:

## Priority

P0

## Readiness Status

ready after BOOT-029

## Readiness Evidence

- Source evidence: IB-P1-15 planning input and current-state candidate list.
- Spec status: `SPEC-BOOT-003` approved.
- Acceptance criteria: scripts and benchmark produce explicit metrics.
- Dependencies: BOOT-029; extraction sequence preferred first.
- Architecture impact: none expected unless metrics become CI gates.
- Test expectations: shell syntax, bootstrap validation, red checks if
  validator behavior changes, benchmark dry run.
- Branch/worktree plan: separate branch from `main`.
- Required reviewers: QA-focused fresh-context review.
- Blocked until: BOOT-029 merged; extraction ordering confirmed.

## Test Expectations

- `bash -n` for new scripts.
- `bash SCRIPTS/validate-bootstrap.sh`
- `bash SCRIPTS/validate-bootstrap-red-checks.sh`
- Metric scripts return parseable results.
- Seeded-defect benchmark reports baseline detection result.
- `git diff --check`

## Definition Of Done

- [ ] Spec linked.
- [ ] Acceptance criteria satisfied.
- [ ] Tests added or updated, or justified.
- [ ] Traceability updated.
- [ ] Artifact registry updated.
- [ ] Handoff updated.
- [ ] Review complete or pending review recorded.

## Parallelization

- Status: candidate
- File ownership boundaries: can be researched in parallel with BOOT-030 if it
  does not edit shared source-of-truth files or scripts.
- Shared files requiring coordination: scripts, tests, registry, traceability,
  state, handoff, test results, worklog.
- Stop conditions: benchmark requires extraction script behavior not yet
  defined, or metric scripts need validator contract changes.

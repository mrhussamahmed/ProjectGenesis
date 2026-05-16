artifact_id: ART-PR-PACKAGE-BOOT-032-SEEDED-DEFECT-BENCHMARK
title: BOOT-032 Seeded-Defect Benchmark Review Package
type: pr-review-package
status: active
version: v1.0
created: 2026-05-16
updated: 2026-05-16
owner: AI Bootstrap Maintainers
source: BOOT-032 implementation of the first empirical benchmark for review and anti-hallucination claims
linked_specs: [SPEC-BOOT-003]
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: false

# PR Review Package

## PR Title

BOOT-032 add seeded-defect benchmark and coverage metrics

## PR Purpose

Implement the BOOT-032 backlog item by adding the first empirical
evidence for ProjectGenesis review and anti-hallucination claims: three
coverage metric scripts, a seeded-defect benchmark runner, a benchmark
plan with baseline result, and the required source-of-truth updates.

## Linked Specs

- `SPECS/SPEC-BOOT-003-adaptive-governance-routing.md`

## Linked Backlog Items Or Tickets

- `BACKLOG.md` row `BOOT-032` (in-review)
- `BACKLOG/BOOT-032-seeded-defect-benchmark.md` (in-review at v1.3)

## Linked ADRs

- None.

## Operation Classification

- Operation profile: `strict-protected`
- Branch: `claude/boot-032-seeded-defect-benchmark`
- Base: `origin/main` at `a460dbf` (latest green main after PR #8 merge
  and post-merge cleanup)
- Risk: high (validator required-files change; scaffold-extract.sh
  registry emit change; new scripts and benchmark plan added)
- Validation mode: strict
- Reviewers: fresh-context Codex adversarial review through the
  installed plugin once GitHub `validate` is green

## Operation Routing Evidence

- `OPERATION_ROUTING.md` was read to confirm scope:
  - `strict-protected` profile applies because the PR adds new scripts,
    changes the validator's `required_files`, and changes
    `SCRIPTS/scaffold-extract.sh`'s clean-state registry emit.
  - Source-of-truth artifacts (`ARTIFACT_REGISTRY.md`,
    `TRACEABILITY_MATRIX.md`, `CURRENT_STATE.md`, `AI_HANDOFF.md`,
    `BACKLOG.md`, `BACKLOG/BACKLOG_INDEX.md`, `BACKLOG/BOOT-032-*.md`,
    `TEST_RESULTS.md`, `WORKLOG/WORKLOG_INDEX.md`,
    `REVIEWS/REVIEW_INDEX.md`) update to reflect BOOT-032 in-review
    state.
  - Out of scope: governance, operation routing, branch/worktree guide,
    PR review/merge policy, risk model, hooks, CI workflow,
    role files, command files, context packs, templates, ADRs,
    `SCAFFOLD_FORK_CHECKLIST.md` policy text, and runtime product
    mechanics.

## Changed Files

- `SCRIPTS/metric-evidence-coverage.sh` (new) — reports
  `spec_fr_source_coverage` and `backlog_source_coverage` from approved
  specs and BOOT-* backlog items as parseable
  `key: numerator/denominator (percent%)` lines.
- `SCRIPTS/metric-acceptance-coverage.sh` (new) — reads
  `TESTS/ACCEPTANCE_CRITERIA_MAP.md` and reports `ac_with_test_artifact`
  and `ac_status_passed` as parseable lines.
- `SCRIPTS/metric-traceability-completeness.sh` (new) — reads
  `TRACEABILITY_MATRIX.md` `## Bootstrap Requirements` table and reports
  `req_with_changed_files` and `req_with_test_evidence` as parseable
  lines.
- `SCRIPTS/run-seeded-defect-bench.sh` (new) — wraps the existing
  `SCRIPTS/validate-bootstrap-red-checks.sh` harness and reports
  `seeded_defect_cases`, `seeded_defect_detected`,
  `seeded_defect_detection_rate`, and `red_check_harness_status`.
  Exits 0 to record a baseline without gating CI.
- `TESTS/ADVERSARIAL_SEED_BENCHMARK.md` (new) — benchmark plan, defect
  catalog snapshot, baseline result, limitations, and runner
  procedure. First empirical evidence document; not a generalized claim.
- `SCRIPTS/validate-bootstrap.sh` — adds the five new artifact paths to
  `required_files` so extracted scaffolds remain consistent.
- `SCRIPTS/scaffold-extract.sh` — expands the clean-state
  `ARTIFACT_REGISTRY.md` emit to register the new metric scripts and
  benchmark plan in extracted downstream scaffolds.
- `ARTIFACT_REGISTRY.md` — registers `ART-METRIC-EVIDENCE-COVERAGE`,
  `ART-METRIC-ACCEPTANCE-COVERAGE`, `ART-METRIC-TRACEABILITY-COMPLETENESS`,
  `ART-SEEDED-DEFECT-BENCH-RUNNER`, and `ART-SEED-BENCH-PLAN`, plus the
  `ART-PR-PACKAGE-BOOT-032-SEEDED-DEFECT-BENCHMARK` row. Bumps
  versions for `ART-SCRIPT-VALIDATE` (v1.8 -> v1.9) and
  `ART-SCAFFOLD-EXTRACT-SCRIPT` (v1.1 -> v1.2).
- `TRACEABILITY_MATRIX.md` — adds the BOOT-032 row with the new
  evidence chain.
- `CURRENT_STATE.md` — records active BOOT-032 branch, in-progress
  task, blockers, new source-of-truth files, next safe action, and
  latest local validation.
- `AI_HANDOFF.md` — records BOOT-032 branch field and pre-change/final
  evidence envelope sections.
- `BACKLOG.md` — moves BOOT-032 from queued to in-review.
- `BACKLOG/BACKLOG_INDEX.md` — moves BOOT-032 from queued to in-review.
- `BACKLOG/BOOT-032-seeded-defect-benchmark.md` — refreshes status,
  readiness evidence, and Definition of Done.
- `TEST_RESULTS.md` — records BOOT-032 local validation evidence.
- `WORKLOG/WORKLOG_INDEX.md` — adds BOOT-032 implementation session.
- `REVIEWS/REVIEW_INDEX.md` — registers this PR review package.

## Risk

high

## Acceptance Criteria Mapping

- Metric scripts return parseable results: confirmed by running each
  script and observing `key: numerator/denominator (percent%)` output.
- Seeded-defect benchmark reports a baseline detection result: confirmed
  by running `bash SCRIPTS/run-seeded-defect-bench.sh` and observing
  baseline numbers (`seeded_defect_detection_rate: 100%` against 25
  cases).
- `bash -n` for all new scripts passes.
- `bash SCRIPTS/validate-bootstrap.sh` passes after the
  required-files additions.
- `bash SCRIPTS/validate-bootstrap-red-checks.sh` passes (all 25 BOOT-031
  cases continue to pass).
- `git diff --check origin/main...HEAD` is clean.
- The benchmark intentionally does not gate CI; baseline is recorded
  in `TESTS/ADVERSARIAL_SEED_BENCHMARK.md` for future comparison.

## Tests Added Or Updated

- Three coverage metric scripts and one benchmark runner are added.
- No changes to `SCRIPTS/validate-bootstrap-red-checks.sh` are
  required for BOOT-032; the benchmark runner reuses the existing 25
  red-check fixtures as the canonical seeded-defect catalog.

## Tests Run

- `bash -n SCRIPTS/metric-evidence-coverage.sh` — passes.
- `bash -n SCRIPTS/metric-acceptance-coverage.sh` — passes.
- `bash -n SCRIPTS/metric-traceability-completeness.sh` — passes.
- `bash -n SCRIPTS/run-seeded-defect-bench.sh` — passes.
- `bash SCRIPTS/validate-bootstrap.sh` — passes after the required-files
  additions and matching registry rows.
- `bash SCRIPTS/validate-bootstrap-red-checks.sh` — passes (25 cases).
- `bash SCRIPTS/metric-evidence-coverage.sh` — emits
  `spec_fr_source_coverage: 48/48 (100%)` and
  `backlog_source_coverage: 0/5 (0%)`.
- `bash SCRIPTS/metric-acceptance-coverage.sh` — emits
  `ac_with_test_artifact: 24/24 (100%)` and
  `ac_status_passed: 24/24 (100%)`.
- `bash SCRIPTS/metric-traceability-completeness.sh` — emits
  `req_with_changed_files: 13/13 (100%)` and
  `req_with_test_evidence: 13/13 (100%)`.
- `bash SCRIPTS/run-seeded-defect-bench.sh` — emits
  `seeded_defect_cases: 25`, `seeded_defect_detected: 25`,
  `seeded_defect_detection_rate: 100%`,
  `red_check_harness_status: 0`.
- Manual `--apply` extraction into `/tmp/scaffold-test` with in-target
  `bash SCRIPTS/validate-bootstrap.sh` — passes (BOOT-031 golden
  fixture still works after the new required-files entries).
- `git diff --check origin/main...HEAD` — clean.

## Rollout And Rollback

- Rollout: merge after fresh-context Codex review approves and GitHub
  `validate` is green. After merge, follow the established post-merge
  state-sync cleanup pattern if `AI_HANDOFF.md` ## Current Branch still
  names the feature branch.
- Rollback: revert the PR. The metric scripts and benchmark plan are
  additive; removing them with the validator's required-files entries
  reverts cleanly.

## Traceability Evidence

- New `TRACEABILITY_MATRIX.md` row for BOOT-032 maps source evidence,
  spec linkage, validation chain, review record, and current status.
- `ARTIFACT_REGISTRY.md` registers the five new artifacts plus this
  review package row.

## Assumptions

- None for this BOOT-032 PR.

## Open Questions

- The benchmark intentionally does not gate CI before more baseline
  data exists. Future work may upgrade the runner to a CI gate once
  the defect catalog grows and the detection-rate trend is well
  understood. The exact threshold and runner mode for any future CI
  gating remain open for BOOT-033 or later slices.

## Operation Profile Decision

`strict-protected`. The PR adds new scripts, modifies the bootstrap
validator's `required_files`, and modifies `SCRIPTS/scaffold-extract.sh`
clean-state registry emit. Even though the metric scripts are
read-only, validator and scaffold-extract mechanic changes fall under
`strict-protected` per `OPERATION_ROUTING.md` and `RISK_MODEL.md`.

## Branch Strategy

`claude/boot-032-seeded-defect-benchmark` cut from latest green `main`
(`a460dbf`). PR will target `main`.

## Dirty Worktree Status

Clean against `origin/main` (`a460dbf`) before BOOT-032 edits. The
only changes in the worktree are the BOOT-032 implementation files
listed above. The untracked `research/` directory from prior
operations is out of scope; the validator already prunes it.

## Review Notes

This is the BOOT-032 PR. Please review:

1. Whether the metric scripts produce parseable, accurate output for
   the current scaffold.
2. Whether the seeded-defect benchmark plan correctly describes the
   method, defect catalog, baseline, and limitations.
3. Whether the runner correctly counts seeded `case_*` functions and
   `FAIL: ` outputs.
4. Whether `SCRIPTS/validate-bootstrap.sh`'s new `required_files`
   entries are consistent with the actual paths in source and
   extracted scaffolds.
5. Whether `SCRIPTS/scaffold-extract.sh`'s clean-state emit registers
   every new BOOT-032 artifact so extracted scaffolds remain valid.
6. Whether source-of-truth records (registry, traceability, current
   state, handoff, backlog, test results, worklog, review index)
   accurately reflect the in-review state.

## Out Of Scope For This PR

- BOOT-033 SRC/SPEC cross-validation.
- Any change to `SCAFFOLD_FORK_CHECKLIST.md` policy text.
- Any change to governance, operation routing, branch/worktree guide,
  PR review/merge policy, risk model, hooks, CI workflow, role files,
  command files, context packs, templates, ADRs, or runtime product
  mechanics.
- Promoting the benchmark to a CI gate. The baseline must accumulate
  more data before that change is reviewed.

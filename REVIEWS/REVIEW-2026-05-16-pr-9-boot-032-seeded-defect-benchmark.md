artifact_id: ART-REVIEW-PR-9-BOOT-032-SEEDED-DEFECT-BENCHMARK
title: PR 9 BOOT-032 Seeded-Defect Benchmark Review
type: pr-review
status: active
version: v1.2
created: 2026-05-16
updated: 2026-05-16
owner: AI Bootstrap Maintainers
source: fresh-context Codex adversarial review, implementer review-fix response, and Codex re-review approval of ProjectGenesis PR #9
linked_specs: [SPEC-BOOT-003]
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: false

# Adversarial PR Review

## Re-Review Outcome (v1.2)

- Re-review date: 2026-05-16
- Head reviewed: `54548f0`
- Decision: approve
- P2 resolution status: resolved. `SCRIPTS/run-seeded-defect-bench.sh`
  now uses `set +e; bash "$red_checks" >"$run_log" 2>&1;
  red_status=$?; set -e`, and the prior inverted `if ! bash ...;
  then red_status=$?` pattern is absent.
- Pass-path probe: `bash SCRIPTS/run-seeded-defect-bench.sh` printed
  `seeded_defect_cases: 25`, `seeded_defect_detected: 25`,
  `seeded_defect_detection_rate: 100%`, and
  `red_check_harness_status: 0`.
- Failure-path probe: copied the worktree to `/tmp/boot032-probe`,
  replaced `SCRIPTS/validate-bootstrap-red-checks.sh` in that copy with
  a stub exiting 7, ran `bash SCRIPTS/run-seeded-defect-bench.sh`, and
  observed `red_check_harness_status: 7`.
- Scope guard: passed. `git diff --name-status origin/main...HEAD`
  contains only the expected BOOT-032 implementation, review, and
  source-of-truth files. A forbidden-scope path scan returned no hooks,
  CI workflows, role files, command files, context packs, templates,
  ADRs, governance files, operation routing, branch/worktree guide,
  PR/merge policy, risk model, runtime mechanics, or BOOT-033 files.
- Source-of-truth audit: pre-edit audit found stale pre-fix wording in
  `CURRENT_STATE.md`, `AI_HANDOFF.md`, and `TRACEABILITY_MATRIX.md`;
  this re-review updates those records to the v1.2 approve outcome.
- Validation: pre-state-edit `bash SCRIPTS/validate-bootstrap.sh`,
  `bash SCRIPTS/validate-bootstrap-red-checks.sh`, and
  `git diff --check origin/main...HEAD` all passed.
- New findings: none.

## Review Decision

approve in v1.2 re-review. Initial v1.1 decision was request changes.

## Risk Level

high

## Model Or Effort Level Used Or Recommended

adversarial deep

## Reviewer

- Agent: Codex
- Role: Adversarial PR Reviewer
- Date: 2026-05-16

## Inputs Reviewed

- Review package: `REVIEWS/PR_REVIEW_PACKAGE-2026-05-16-boot-032-seeded-defect-benchmark.md`
- PR diff or local diff: `gh pr diff 9 --repo mrhussamahmed/ProjectGenesis` failed with `error connecting to api.github.com`; local `git diff --name-status origin/main...HEAD` was used because the worktree branch tracks `origin/claude/boot-032-seeded-defect-benchmark` with no local ahead/behind marker.
- Operation classification: review package lines 43-60 classify the work as `strict-protected` for new scripts, validator required-files additions, and scaffold-extract registry emit changes.
- Final evidence envelope: `AI_HANDOFF.md` BOOT-032 evidence sections reviewed; top-level handoff will be updated by this review.
- Specs: `SPECS/SPEC-BOOT-003-adaptive-governance-routing.md` via `SPECS/SPEC_INDEX.md` and routing/review policy.
- Backlog items or tickets: `BACKLOG.md`, `BACKLOG/BACKLOG_INDEX.md`, `BACKLOG/BOOT-032-seeded-defect-benchmark.md`
- ADRs: none linked.
- Tests: `TEST_RESULTS.md`, `TESTS/ADVERSARIAL_SEED_BENCHMARK.md`, `SCRIPTS/validate-bootstrap.sh`, `SCRIPTS/validate-bootstrap-red-checks.sh`, the four new scripts, manual scaffold extraction.
- Traceability: `TRACEABILITY_MATRIX.md`
- Artifact registry: `ARTIFACT_REGISTRY.md`
- Current state and handoff: `CURRENT_STATE.md`, `AI_HANDOFF.md`

## Verification Summary

| Area | Result | Evidence |
|------|--------|----------|
| 1. BOOT-032 scope | Pass | Diff contains only the expected scripts, benchmark plan, validator, scaffold-extract, review package, and source-of-truth files; forbidden-scope scan returned no hooks, workflows, role files, commands, context packs, templates, ADRs, governance/policy/risk/runtime paths. |
| 2. Script output and CI gating | Request changes | Current pass-path outputs are parseable (`spec_fr_source_coverage: 48/48`, `ac_with_test_artifact: 24/24`, `req_with_changed_files: 13/13`, `seeded_defect_detection_rate: 100%`), but `SCRIPTS/run-seeded-defect-bench.sh:31-34` captures nonzero harness exit status incorrectly. |
| 3. Benchmark plan clarity | Pass | `TESTS/ADVERSARIAL_SEED_BENCHMARK.md:42-63` describes method, `:82-109` catalog, `:111-157` baseline and interpretation, `:159-174` limitations, and `:176-195` runner procedure. |
| 4. Validator required files and extraction | Pass | `SCRIPTS/validate-bootstrap.sh:111-115` lists all five new paths; all five paths exist; source validator passed; manual `--apply` extraction to `/tmp/pr9-review-scaffold-1.g4kdTN` and in-target validation passed. |
| 5. Extracted registry rows | Pass | `SCRIPTS/scaffold-extract.sh:1269-1273` emits registry rows for the three metric scripts, runner, and benchmark plan; extracted target registry contains the same paths and in-target validator passed. |
| 6. Source-of-truth updates | Pass | Registry rows exist at `ARTIFACT_REGISTRY.md:155-159`; traceability row at `TRACEABILITY_MATRIX.md:75`; backlog status at `BACKLOG.md:57`, `BACKLOG/BACKLOG_INDEX.md:28`, and BOOT-032 DoD at `BACKLOG/BOOT-032-seeded-defect-benchmark.md:136-154`; test evidence at `TEST_RESULTS.md:21`; worklog at `WORKLOG/WORKLOG_INDEX.md:25`. |
| 7. Forbidden scope | Pass | `git diff --name-only origin/main...HEAD` contains no hooks, CI workflow, role files, command files, context packs, templates, ADRs, governance, operation routing, policy, risk model, or runtime mechanics. |
| 8. Operation classification | Pass | `REVIEWS/PR_REVIEW_PACKAGE-2026-05-16-boot-032-seeded-defect-benchmark.md:43-60` and `:204-210` classify as `strict-protected`, matching `OPERATION_ROUTING.md` validator/script escalation rules. |
| 9. Merge readiness | Request changes | PR links spec/backlog and validation mostly passes, but PR merge policy requires acceptance criteria and blocking review findings resolved; the P2 runner status bug must be fixed or explicitly accepted before merge. |

## Validation Run

- `gh pr diff 9 --repo mrhussamahmed/ProjectGenesis` — failed: `error connecting to api.github.com`.
- `bash SCRIPTS/validate-bootstrap.sh` — passed.
- `bash SCRIPTS/validate-bootstrap-red-checks.sh` — passed.
- `git diff --check origin/main...HEAD` — passed.
- `bash -n` for all four new scripts — passed.
- `bash SCRIPTS/metric-evidence-coverage.sh` — `spec_fr_source_coverage: 48/48 (100%)`; `backlog_source_coverage: 0/5 (0%)`.
- `bash SCRIPTS/metric-acceptance-coverage.sh` — `ac_with_test_artifact: 24/24 (100%)`; `ac_status_passed: 24/24 (100%)`.
- `bash SCRIPTS/metric-traceability-completeness.sh` — `req_with_changed_files: 13/13 (100%)`; `req_with_test_evidence: 13/13 (100%)`.
- `bash SCRIPTS/run-seeded-defect-bench.sh` — `seeded_defect_cases: 25`; `seeded_defect_detected: 25`; `seeded_defect_detection_rate: 100%`; `red_check_harness_status: 0`.
- `bash SCRIPTS/scaffold-extract.sh --apply /tmp/pr9-review-scaffold-1.g4kdTN` — passed.
- `bash /tmp/pr9-review-scaffold-1.g4kdTN/SCRIPTS/validate-bootstrap.sh` — passed.
- Failure-path probe with a synthetic red-check harness failure that exits 7 — the runner printed `red_check_harness_status: 0`.

## Findings

| Severity | File | Evidence | Finding | Required Change |
|----------|------|----------|---------|-----------------|
| P2 | `SCRIPTS/run-seeded-defect-bench.sh` | Lines 31-34 use `if ! bash "$red_checks" ...; then red_status=$?; fi`. A failure-path probe made the wrapped harness exit 7, yet the runner printed `red_check_harness_status: 0`. | The runner misreports `red_check_harness_status` as 0 when the underlying red-check harness exits nonzero. That makes the benchmark output inaccurate exactly in the failure path reviewers need for baseline drift. | Capture the real harness exit code without `!`, for example run the command with `set +e`, store `$?`, then restore strict handling before computing and printing metrics. |

## Operation Routing Review

- Profile correctness: correct. Validator required-file changes and scaffold-extract script changes require `strict-protected`.
- Escalation precedence: correct. Script/validator mechanics outrank planning and state-sync profiles.
- Protected artifacts: identified in the review package; touched protected files are limited to the expected scripts and source-of-truth artifacts.
- Skipped validation rationale: stack-specific product tests are not applicable because this repository has no product runtime code.
- Handoff and evidence durability: source-of-truth updates are present; this review updates handoff/current-state/test-results/worklog for the request-changes decision.

## Required Changes

- Fix `SCRIPTS/run-seeded-defect-bench.sh` so `red_check_harness_status` reports the real exit code from `SCRIPTS/validate-bootstrap-red-checks.sh` when that harness fails.

## Optional Improvements

- Consider a small self-test or documented probe for the runner's failure path when BOOT-033 adds more benchmark fixture coverage.

## Evidence For Major Findings

- `SCRIPTS/run-seeded-defect-bench.sh:31-34` assigns `$?` inside the `then` branch of an inverted command. In bash, `$?` at that point is the status of `!`, not the wrapped command. The reviewer probe made the wrapped harness exit 7, but the runner still printed `red_check_harness_status: 0`.

## Final Recommendation

Superseded by v1.2 re-review approval. The initial v1.1 recommendation was
request changes because the benchmark runner emitted a false zero harness
status on failure; the review-fix now resolves that P2.

## Re-Review Conditions

- Re-run `bash -n SCRIPTS/run-seeded-defect-bench.sh`.
- Re-run `bash SCRIPTS/run-seeded-defect-bench.sh`.
- Add or run a failure-path probe proving `red_check_harness_status` reflects a nonzero wrapped harness exit.
- Re-run `bash SCRIPTS/validate-bootstrap.sh`, `bash SCRIPTS/validate-bootstrap-red-checks.sh`, and `git diff --check origin/main...HEAD`.

## Fix Response

Implementer addressed the P2 finding in a follow-up commit on
`claude/boot-032-seeded-defect-benchmark`:

- P2: `SCRIPTS/run-seeded-defect-bench.sh` now captures `$?` from the
  wrapped command before any `!` negation. The inverted `if !` pattern
  was replaced with an explicit `set +e; bash ...; red_status=$?;
  set -e` sequence so a non-zero harness exit propagates through the
  printed `red_check_harness_status` line.

Post-fix validation on `claude/boot-032-seeded-defect-benchmark`:

- `bash -n SCRIPTS/run-seeded-defect-bench.sh` passes.
- `bash SCRIPTS/run-seeded-defect-bench.sh` against the real
  `SCRIPTS/validate-bootstrap-red-checks.sh` prints
  `red_check_harness_status: 0` (25/25 detection rate).
- A failure-path probe — copying the worktree to `/tmp/probe-bench`,
  replacing `SCRIPTS/validate-bootstrap-red-checks.sh` with a stub that
  exits 7, and running the runner — now prints
  `red_check_harness_status: 7`. The probe confirms the fix.
- `bash SCRIPTS/validate-bootstrap.sh` passes.
- `bash SCRIPTS/validate-bootstrap-red-checks.sh` passes (25 cases).
- `git diff --check origin/main...HEAD` is clean.

Fresh-context Codex re-review v1.2 approved the fix at head `54548f0`
with no new findings.

artifact_id: ART-TEST-SEED-BENCH
title: Adversarial Seed Benchmark
type: benchmark-plan
status: active
version: v1.0
created: 2026-05-16
updated: 2026-05-16
owner: AI Bootstrap Maintainers
source: BOOT-032 first empirical benchmark for review and anti-hallucination claims
linked_specs: [SPEC-BOOT-003]
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# Adversarial Seed Benchmark

This file is the BOOT-032 seeded-defect benchmark plan. It establishes a
small, explicit, file-based benchmark so future changes can show whether
ProjectGenesis review and validator mechanics improve, regress, or stay
flat against a known set of planted defects.

It is intentionally a first empirical measurement, not a generalized
claim. Every limitation in the `## Limitations` section applies.

## Purpose

- Measure how many planted defects the current bootstrap validator and
  red-check harness detect.
- Make detection-rate change observable on every revision.
- Surface the gap between "defects currently detected" and "defects that
  matter" so later slices (e.g. BOOT-033 SRC/SPEC cross-validation,
  future coverage work) have an explicit target.
- Pair the benchmark with the coverage metrics (
  `SCRIPTS/metric-evidence-coverage.sh`,
  `SCRIPTS/metric-acceptance-coverage.sh`,
  `SCRIPTS/metric-traceability-completeness.sh`) so the project ships
  proof rather than rhetoric for its review and anti-hallucination
  claims.

## Method

1. The canonical seeded-defect set is the set of `case_*` functions in
   `SCRIPTS/validate-bootstrap-red-checks.sh`. Each case seeds a known
   defect into a temporary copy of the repository and asserts that the
   bootstrap validator either fails with a specific message, succeeds
   without mentioning a specific path, or otherwise behaves correctly
   per the case's expectation.
2. `SCRIPTS/run-seeded-defect-bench.sh` is the benchmark runner. It
   invokes the red-check harness, counts the seeded cases, counts the
   harness `FAIL: ...` lines (cases that did not detect their defect),
   and reports detection rate as `seeded_defect_detected /
   seeded_defect_cases`.
3. The runner intentionally exits 0 regardless of detection rate. CI
   gating remains the responsibility of
   `SCRIPTS/validate-bootstrap-red-checks.sh` and
   `.github/workflows/bootstrap-validation.yml`; the benchmark records
   a baseline number, not a gate.
4. Additional defect categories should be added by writing new
   `case_*` functions in the red-check harness and recording them in
   the `## Defect Catalog` section below. The benchmark picks up new
   cases automatically.

## Coverage Metric Companion

The seeded-defect benchmark records what the validator catches. The
coverage metrics record what the repository's authority-bearing
artifacts say about themselves. Together they form the first empirical
picture of review and anti-hallucination effectiveness for
ProjectGenesis.

Run all four together to refresh the baseline numbers:

```sh
bash SCRIPTS/run-seeded-defect-bench.sh
bash SCRIPTS/metric-evidence-coverage.sh
bash SCRIPTS/metric-acceptance-coverage.sh
bash SCRIPTS/metric-traceability-completeness.sh
```

## Defect Catalog

The current seeded-defect catalog is whatever `case_*` functions exist
in `SCRIPTS/validate-bootstrap-red-checks.sh` at the time the runner is
invoked. As of BOOT-032 baseline (2026-05-16), the catalog covers:

- approved spec missing or empty Source IDs in FR rows
- active backlog item with no linked spec evidence
- handoff branch field mismatching the actual Git branch
- command file missing required reading section
- source registry rows missing freshness or processing state
- assumption rows missing expiry, missing approval evidence, marked
  self-approved, or carrying unsupported evidence
- operation-routing structural integrity (missing profile, missing
  validation mode, missing context reference)
- protected mechanics misclassified as a non-strict profile
- protected planning misclassified as a non-planning profile
- protected planning misclassified in a second classification block
- `research/` and `.claude/` worktree contents not tripping the
  validator scope
- scaffold extraction golden, dry-run safety, source-as-target safety,
  non-empty-target-without-force safety, registry coverage, and
  reset-file shape contracts

New BOOT-033 SRC/SPEC cross-validation work is expected to add seeded
defects for cited but unregistered `SRC-*` and `SPEC-*` identifiers
once the validator gains those rules. Until then, those defect classes
are explicitly out of scope for the BOOT-032 baseline.

## Baseline Result

Recorded on the BOOT-032 implementation branch
`claude/boot-032-seeded-defect-benchmark` cut from latest green `main`
after BOOT-031 merged (`a460dbf`):

```
seeded_defect_cases: 25
seeded_defect_detected: 25
seeded_defect_detection_rate: 100%
red_check_harness_status: 0
```

Coverage metrics on the same baseline:

```
spec_fr_source_coverage: 48/48 (100%)
backlog_source_coverage: 0/5 (0%)
ac_with_test_artifact: 24/24 (100%)
ac_status_passed: 24/24 (100%)
req_with_changed_files: 13/13 (100%)
req_with_test_evidence: 13/13 (100%)
```

Interpretation:

- The validator detects 100% of the currently seeded defect catalog,
  which means the catalog is well-aligned with the existing validator
  rules. This is the floor, not the ceiling. As BOOT-033 and future
  slices add new defect classes, the catalog and the detection-rate
  baseline should both expand and the runner output should explicitly
  show the gap.
- `backlog_source_coverage: 0/5` reflects that no BOOT-029 through
  BOOT-033 backlog items currently cite registered `SRC-*` IDs; their
  source evidence is the durable Phase 1 planning narrative recorded
  in `CURRENT_STATE.md` and `IMPLEMENTATION_PLAN.md`. The metric is
  designed to grow as downstream product intake adds real `SRC-*` IDs.
- `spec_fr_source_coverage: 48/48 (100%)` is enforced by the bootstrap
  validator already; the metric exists so that any future regression is
  observable independently of validator failures.
- `ac_with_test_artifact` and `req_with_*` metrics confirm the
  acceptance-criteria map and bootstrap-requirement rows already cite
  evidence; this is the current ceiling for the framework itself.

The baseline is the first empirical evidence. Improvements come from
adding new defect classes (BOOT-033 cross-validation, future
benchmarks) and from real downstream product intake.

## Limitations

- This benchmark only measures defects that have explicit `case_*`
  fixtures. It does not measure subtle reasoning failures, hallucinated
  reasoning traces, or LLM-specific failure modes.
- The benchmark exercises the bootstrap validator and red-check harness
  only. It does not exercise human reviewers, Codex adversarial review,
  or other reviewers.
- Detection rate is a directional metric. A 100% rate against the
  current catalog does not imply 100% rate against future or unseen
  defects.
- The benchmark intentionally does not gate CI. Treat the number as an
  observable trend, not a release criterion, until enough catalog
  growth justifies a stricter contract.
- The benchmark does not compare different LLMs, agents, or providers.
  Cross-model claims require their own reviewable design.

## Runner Procedure

```sh
bash SCRIPTS/run-seeded-defect-bench.sh
```

The runner prints four metrics:

- `seeded_defect_cases` — number of `case_*` functions defined in the
  red-check harness at this revision.
- `seeded_defect_detected` — number of those cases that detected their
  planted defect on this run.
- `seeded_defect_detection_rate` — percentage form of
  `detected / cases`.
- `red_check_harness_status` — exit code of the underlying
  `bash SCRIPTS/validate-bootstrap-red-checks.sh` invocation (0 means
  no FAIL lines).

The runner is intentionally short. Future expansion should keep it
explicit and reviewable rather than introducing an analytics pipeline.

## Related Records

- `SCRIPTS/run-seeded-defect-bench.sh`
- `SCRIPTS/metric-evidence-coverage.sh`
- `SCRIPTS/metric-acceptance-coverage.sh`
- `SCRIPTS/metric-traceability-completeness.sh`
- `SCRIPTS/validate-bootstrap-red-checks.sh`
- `BACKLOG/BOOT-032-seeded-defect-benchmark.md`
- `BACKLOG/BOOT-033-src-spec-cross-validation.md`
- `TEST_PLAN.md`

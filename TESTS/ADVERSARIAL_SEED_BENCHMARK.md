artifact_id: ART-TEST-SEED-BENCH
title: Adversarial Seed Benchmark
type: benchmark-plan
status: active
version: v2.1
created: 2026-05-16
updated: 2026-06-11
owner: AI Bootstrap Maintainers
source: BOOT-032 first empirical benchmark for review and anti-hallucination claims; GEN-17 baseline refresh (HUS-235); BOOT-RESEARCH-001 baseline refresh (HUS-236)
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
- BOOT-033 SRC/SPEC cross-validation (cited but unregistered `SRC-*`
  and `SPEC-*` identifiers, provisional/pending allowances)
- BOOT-034 stale `Next safe action:` envelope staleness guard
- split-state local-session routing, canonical-state volatile-text
  guard, and BOOT-GREEN-MERGE-001 approval-gate regression fixtures
- GEN-17 additions: REQ-/RISK-row controlled-vocabulary enforcement,
  onboarding link-integrity and superseded-file guard, state-sync
  validator level routing, shape-only changed-file scoping, and the
  downstream core/optional required-file floor split
- BOOT-RESEARCH-001 additions: accepted-research-brief acceptance checks
  (anchored approval line incl. the template-guidance bypass fixture,
  critic reference, draft/accepted routing) and extended
  scaffold-registry kept-framework-path pins

## Baseline Result

Refreshed in the BOOT-RESEARCH-001 batch (HUS-236) on branch
`claude/lucid-lehmann-4ce44e`, 2026-06-11. The prior GEN-17 baseline
(77 cases, recorded 2026-06-11) is preserved in git history.

```
seeded_defect_cases: 82
seeded_defect_detected: 82
seeded_defect_detection_rate: 100%
red_check_harness_status: 0
```

Coverage metrics on the same baseline:

```
spec_fr_source_coverage: 0/0 (n/a)
backlog_source_coverage: 0/3 (0%)
ac_with_test_artifact: 24/24 (100%)
ac_status_passed: 24/24 (100%)
req_with_changed_files: 4/4 (100%)
req_with_test_evidence: 4/4 (100%)
```

Interpretation:

- The validator detects 100% of the currently seeded defect catalog,
  which means the catalog is well-aligned with the existing validator
  rules. This is the floor, not the ceiling: new defect classes should
  keep expanding the catalog ahead of the rules.
- `spec_fr_source_coverage: 0/0` reflects that legacy SPEC-BOOT-* specs
  moved to `MAINTAINER_ARCHIVE/SPECS/` and no downstream product specs
  exist yet; the metric re-activates with the first real spec.
- `backlog_source_coverage: 0/3` reflects that the three active
  bootstrap-governance backlog items cite planning narrative rather
  than registered `SRC-*` IDs; the metric grows with real product
  intake.
- `ac_with_test_artifact` and `req_with_*` metrics confirm the
  acceptance-criteria map and bootstrap-requirement rows cite evidence.

The baseline number should be re-recorded whenever the catalog grows or
validator behavior changes (this is what went stale between BOOT-032
and GEN-17).

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
- `TEST_STRATEGY.md`

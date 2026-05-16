artifact_id: ART-GOV-PERF-001
title: Governance Performance Measurement
type: measurement
status: active
version: v1.0
created: 2026-05-14
updated: 2026-05-14
owner: AI Bootstrap Maintainers
source: SPEC-BOOT-003 and BOOT-024 implementation
linked_specs: [SPEC-BOOT-003]
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: false

# Governance Performance Measurement

This artifact records BOOT-024 baseline measurement and projected performance
effect for adaptive governance routing. It uses representative operation models
because running artificial file-changing operations just to time them would add
artifact churn without improving safety.

## Measurement Basis

Inputs:

- repository source-of-truth files inspected during SPEC-BOOT-003 analysis
- the user-reported small README operation taking about 45 minutes under the
  previous full-governance path
- changed mechanics in `OPERATION_ROUTING.md`
- validator and CI changes in `SCRIPTS/validate-bootstrap.sh`,
  `SCRIPTS/validate-bootstrap-red-checks.sh`, and
  `.github/workflows/bootstrap-validation.yml`

Assumption:

- time and token savings come from fewer default reads, fewer routine writes,
  batched validation, compact durable evidence, and deterministic review
  routing. They do not come from skipping required source-of-truth checks.

## Representative Operation Estimates

| Operation | Previous Typical Path | Routed Path | Expected Time Change | Expected Token Change | Safety Preserved By |
|-----------|-----------------------|-------------|----------------------|-----------------------|---------------------|
| Typo or formatting docs edit | broad repo orientation, state updates, validation, review uncertainty | `docs-trivial`, Tier 1 minimal read, `git diff --check`, bootstrap validation only when registered/context-indexed | 45 min to 5-10 min, about 78% to 89% faster | about 70% to 85% fewer read/output tokens | direct-main exception limits, protected-file escalation, diff check |
| Small state sync after observed merge | repeated review context, broad history, full state churn | `state-sync`, source artifact proof, compact state/handoff/worklog delta | 30-45 min to 8-15 min, about 50% to 73% faster | about 50% to 70% fewer tokens | durable evidence, branch status, traceability/registry impact rules |
| README setup or tooling claim | broad repo scan plus uncertain source checking | `docs-public-claim`, claim evidence check, primary source only for changed claim | 45-60 min to 15-25 min, about 44% to 67% faster | about 45% to 65% fewer tokens | claim evidence rule, review escalation, registry/traceability update when claims change |
| Spec or backlog governance update | full source-of-truth reading, repeated state updates, full validation after each edit | `planning-governance`, Tier 1 and operation-specific files, batched final validation | 60-90 min to 30-45 min, about 50% faster | about 40% to 60% fewer tokens | approved spec gate, traceability, registry, fresh-context review |
| Validator, CI, role, review, or source-of-truth mechanics | full strict path | `strict-protected`, Tier 1 through Tier 3, red checks, shell syntax, CI, adversarial review | little or no speed reduction expected; clarity reduces rework | about 10% to 25% fewer tokens from clearer routing and less duplicated handoff | red checks, CI, shell syntax, adversarial review, focused role review when triggered |

## Representative Measurement Records

These records apply `OPERATION_ROUTING.md` to representative operations and
count required reads, writes, validation, and review steps. They are not claims
that future wall-clock time is guaranteed.

| Scenario | Profile | Old Required Reads | Routed Required Reads | Old Routine Writes | Routed Writes | Validation Change | Improvement Evidence |
|----------|---------|--------------------|-----------------------|--------------------|---------------|-------------------|---------------------|
| Typo in non-authoritative docs paragraph | `docs-trivial` | Minimum context plus registry, traceability, current state, handoff, worklog, test results, review policy, full validation context, and likely review package | Tier 1 route, touched section, `git status` | Current state, handoff, registry, traceability, test results, worklog often updated by habit | No permanent state write unless registered/context-indexed change requires it | `git diff --check`; bootstrap validation only when registered/context-indexed | Required read/write surfaces drop by more than half; no review package required. |
| BOOT-018 stale next-action correction | `state-sync` | Broad historical review plus full governance docs and repeated state/registry/traceability updates | Tier 1 route plus source artifact proving merge/branch status | Full state, handoff, registry, traceability, test results, worklog | Compact state/handoff/worklog plus registry/traceability only when metadata or release evidence changes | Bootstrap validation and `git diff --check` batched once | Required reads and writes drop by more than half while preserving durable state evidence. |
| README external tooling claim | `docs-public-claim` | Broad repo scan, public docs, state, handoff, registry, traceability, review package uncertainty | Tier 1 route, changed README section, primary source evidence for changed claim | README plus broad governance records | README plus claim evidence and impacted registry/traceability/state only when claim changes source-of-truth expectations | Bootstrap validation, `git diff --check`, claim evidence check | Token cost drops by scoping external evidence to changed claims, not all README context. |
| Spec/backlog governance update | `planning-governance` | Full repo orientation, repeated review history, repeated validation after intermediate edits | Tier 1 route plus relevant spec/backlog/traceability/registry and touched policy files | Spec, backlog, registry, traceability, state, handoff, test results, worklog, review package | Same required evidence where impacted, but no unrelated artifact rewrites | Bootstrap validation and `git diff --check` batched at review points | Expected medium-operation savings come from fewer historical reads and batched validation, not less traceability. |

## BOOT-024 Scope Decision

BOOT-024 is satisfied for this branch as a baseline measurement model, not as
long-term production telemetry. The branch creates the mechanism and records
representative read/write/validation comparisons. Future real operations should
append observed timings when performance is material.

## 50 Percent Improvement Strategy

Small and medium operations should reach at least 50% faster execution when
they qualify for `docs-trivial`, `state-sync`, `docs-public-claim`, or
`planning-governance` because:

- Tier 1 routing prevents every agent from reading historical review records by
  default.
- The impact map prevents routine updates to unaffected artifacts.
- Validation modes avoid running red checks for non-validator changes.
- Final validation can cover a batch of small edits instead of repeating after
  every paragraph.
- Evidence envelopes cite source artifacts instead of copying long summaries.
- Handoff and current state keep active truth only, with history pushed to
  worklogs, reviews, and test results.

## Token Efficiency Strategy

Expected token savings come from:

- using read tiers instead of opening the entire repo
- keeping `CURRENT_STATE.md` and `AI_HANDOFF.md` compact and current
- keeping historical evidence in review records, worklogs, and test results
- referencing source sections instead of copying repeated governance text
- requiring large-file reads to be justified in the final evidence envelope
- using `OPERATION_ROUTING.md` as the single profile, impact, validation, and
  token-budget authority

## Residual Risk

These include modeled measurements and projected savings. Future real
operations should record actual start time, end time, profile, files read,
files changed, validations, and review path in `TEST_RESULTS.md` or a worklog
entry when performance is material.

If a future review finds agents using routing to avoid required evidence, the
affected profile should escalate to `strict-protected` until the rule is fixed.

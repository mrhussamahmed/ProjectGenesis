artifact_id: ART-TEST-003
title: Test Results
type: test-results
status: active
version: v6.0
created: 2026-05-09
updated: 2026-06-10
owner: AI Bootstrap Maintainers
source: ProjectGenesis bootstrap scaffold; split-state boundary from BOOT-STATE-001; AI green-merge from BOOT-GREEN-MERGE-001; durable-baseline convention from GEN-03
linked_specs: []
linked_tickets: [BOOT-STATE-001, BOOT-GREEN-MERGE-001]
linked_adrs: []
replaces:
replaced_by:
authoritative: false

# Test Results

This file records durable validation baselines only. Prior ProjectGenesis
validation history is preserved in
`MAINTAINER_ARCHIVE/snapshots/TEST_RESULTS.md-2026-05-16-pre-slice-3.md`.

## Latest Run

| Run Date | Scope | Command | Outcome | Evidence | Notes |
|----------|-------|---------|---------|----------|-------|
| 2026-06-10 | local (GEN-01..16 improvement program) | `bash SCRIPTS/validate-bootstrap.sh`; `bash SCRIPTS/validate-bootstrap-red-checks.sh` | this PR (pending CI) | gen-program-baseline | Full validation runs before commit on the improvement-program branch; CI on the program PR completes this baseline. |
| 2026-05-18 | merge baseline (BOOT-GREEN-MERGE-001) | validator; red checks; Codex adversarial review; GitHub branch-protection alignment | passed | green-merge-baseline | Merged via PRs #22/#23. Regression guard against required human/maintainer/Code Owner approval is active. Per-PR run detail lives in the PR evidence. |
| 2026-05-17 | merge baseline (BOOT-STATE-001) | validator; red checks; PR #21 CI runs 26001652968 and 26001653803 | passed | split-state-baseline | Split-state handoff merged via PR #21 at `d4b5161`. Per-PR run detail lives in the PR evidence. |
| 2026-05-17 | `main` baseline | `Bootstrap Validation` run 25990646864 | passed | slice-5-post-cleanup-baseline | Durable baseline after slice 5 post-merge cleanup and finalization. |
| 2026-05-17 | `main` incident | `Bootstrap Validation` run 25989064447 | failed | slice-5-drift-incident | Stale branch-specific `AI_HANDOFF.md`; motivating incident for BOOT-STATE-001. Resolved by commits `05f01f2` and `2fee759`. |

## History

| Run Date | Scope | Command | Outcome | Evidence | Notes |
|----------|-------|---------|---------|----------|-------|
| n/a | archived | see `MAINTAINER_ARCHIVE/snapshots/TEST_RESULTS.md-2026-05-16-pre-slice-3.md` | n/a | pre-slice-3 | Prior ProjectGenesis validation runs are archived. |

## Conventions

- Record only durable validation baselines (merge/release/validator-behavior
  changes). Per-PR validation evidence lives in the PR body.
- Link each row to a spec, backlog item, ticket, review, or baseline incident
  where applicable.
- For local-only runs, mark scope as `local` and reference the relevant
  backlog item or program.

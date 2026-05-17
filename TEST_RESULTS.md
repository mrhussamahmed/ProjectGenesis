artifact_id: ART-TEST-003
title: Test Results
type: test-results
status: active
version: v5.0
created: 2026-05-09
updated: 2026-05-17
owner: AI Bootstrap Maintainers
source: ProjectGenesis bootstrap scaffold; split-state boundary from BOOT-STATE-001
linked_specs: []
linked_tickets: [BOOT-STATE-001]
linked_adrs: []
replaces:
replaced_by:
authoritative: false

# Test Results

This file records the current validation evidence needed for review and merge.
Prior ProjectGenesis validation history is preserved in
`MAINTAINER_ARCHIVE/snapshots/TEST_RESULTS.md-2026-05-16-pre-slice-3.md`.

## Latest Run

| Run Date | Scope | Command | Outcome | Evidence | Notes |
|----------|-------|---------|---------|----------|-------|
| 2026-05-17 | GitHub Actions (`BOOT-STATE-001`, PR #21 head `ca81bd0`) | `Bootstrap Validation` runs 26001652968 and 26001653803 | passed | split-state-pr-ci | Both current PR CI runs passed after scaffold evidence contamination fix. |
| 2026-05-17 | local (`BOOT-STATE-001`) | `bash SCRIPTS/scaffold-extract.sh --apply /tmp/split-state-extract-check`; `bash SCRIPTS/validate-bootstrap-red-checks.sh` | passed | split-state-ci-fix | Fixed CI run 26001457737 failure by removing upstream GitHub URLs from committed approval evidence; local extraction contract and full red-check harness passed. |
| 2026-05-17 | local (`BOOT-STATE-001`) | `git check-ignore .ai/SESSION.md` | passed | split-state-local-session | Confirmed local session files are ignored. |
| 2026-05-17 | local (`BOOT-STATE-001`) | shell syntax loop for operation-profile, hooks, validator, and red checks | passed | split-state-maintainer-approval-boundary | `bash -n` passed for `SCRIPTS/operation-profile.sh`, `.githooks/pre-commit`, `.githooks/pre-push`, `SCRIPTS/validate-bootstrap.sh`, and `SCRIPTS/validate-bootstrap-red-checks.sh` after maintainer-approval boundary fixes. |
| 2026-05-17 | local (`BOOT-STATE-001`) | `bash SCRIPTS/validate-bootstrap.sh` | passed | split-state-maintainer-approval-boundary | Strict bootstrap validation passed after correcting Path B approval status and adding the maintainer/adversarial authority boundary. |
| 2026-05-17 | local (`BOOT-STATE-001`) | `bash SCRIPTS/validate-bootstrap-red-checks.sh` | passed | split-state-maintainer-approval-boundary | Full red-check harness passed after adding the maintainer authority-boundary fixture. |
| 2026-05-17 | local (`BOOT-STATE-001`) | `git diff --check` | passed | split-state-maintainer-approval-boundary | Whitespace check passed after maintainer-approval boundary fixes. |
| 2026-05-17 | GitHub Actions on `main` baseline | `Bootstrap Validation` run 25990646864 | passed | slice-5-post-cleanup-baseline | Baseline after slice 5 post-merge cleanup and finalization; retained as current durable baseline pointer. |
| 2026-05-17 | GitHub Actions on `main` baseline | `Bootstrap Validation` run 25989064447 | failed | slice-5-drift-incident | Historical failure caused by stale branch-specific `AI_HANDOFF.md`; this is the motivating incident for `BOOT-STATE-001`. Resolved by cleanup commit `05f01f2` and finalization commit `2fee759`. |

## Pending Validation

- None for current PR #21 head `ca81bd0`; merge remains subject to GitHub review
  and branch-protection gates.
- Path B maintainer approval is recorded in PR #21 comment 4472356122.

## History

| Run Date | Scope | Command | Outcome | Evidence | Notes |
|----------|-------|---------|---------|----------|-------|
| n/a | archived | see `MAINTAINER_ARCHIVE/snapshots/TEST_RESULTS.md-2026-05-16-pre-slice-3.md` | n/a | pre-slice-3 | Prior ProjectGenesis validation runs are archived. |

## Conventions

- Record only test results that gate a merge, release, or review approval.
- Link each row to a spec, backlog item, ticket, review, or baseline incident
  where applicable.
- For local-only runs, mark scope as `local` and reference the relevant branch
  or backlog item.

artifact_id: ART-TEST-003
title: Test Results
type: test-results
status: active
version: v4.0
created: 2026-05-09
updated: 2026-05-16
owner: AI Bootstrap Maintainers
source: ProjectGenesis bootstrap scaffold; slice 3 required-reading shrink (full prior history preserved at MAINTAINER_ARCHIVE/snapshots/TEST_RESULTS.md-2026-05-16-pre-slice-3.md)
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: false

# Test Results

This file records the outcome of test runs that validate spec acceptance
criteria, regression suites, and validation evidence required by reviews.

The bootstrap upstream's legacy validation runs are preserved in
`MAINTAINER_ARCHIVE/snapshots/TEST_RESULTS.md-2026-05-16-pre-slice-3.md`.

## Latest Run

| Run Date | Scope | Command | Outcome | Evidence | Notes |
|----------|-------|---------|---------|----------|-------|
| 2026-05-17 | local (`main` post-merge cleanup) | `bash SCRIPTS/validate-bootstrap.sh` | passed | slice-5-post-merge-cleanup | After post-merge state reset; the merged `AI_HANDOFF.md` and `CURRENT_STATE.md` now name `main` as the active branch, so the branch-mismatch check passes. |
| 2026-05-17 | GitHub Actions on `main` | `Bootstrap Validation` run 25989064447 | failed | slice-5-post-merge-cleanup | First post-merge `main` CI run after PR #20 squash merge failed with `AI_HANDOFF.md branch does not match git branch: claude/sharp-shockley-6bd7a3 != main`; the merged state files still named the slice 5 branch. Resolved by this post-merge cleanup. |
| 2026-05-17 | local | `bash SCRIPTS/validate-bootstrap.sh` | passed | slice-5-reuse-boundary | Source/maintainer mode validator pass on `claude/sharp-shockley-6bd7a3` after slice 5 reuse-boundary changes (FORBIDDEN_PATHS, downstream-aware required files, mixed-mode guard, README skip). |
| 2026-05-17 | local | `bash SCRIPTS/scaffold-extract.sh --apply <tmp>` | passed | slice-5-reuse-boundary | Phase 1-7 ran; contract check passed, advisory coherence non-blocking, in-target downstream validator passed. |
| 2026-05-17 | local | `bash SCRIPTS/validate-bootstrap-red-checks.sh` | passed | slice-5-reuse-boundary | Full red-check harness including new `case_scaffold_extract_contract_detects_forbidden_string_contamination` fixture and updated registry/reset-shape fixtures. |
| 2026-05-17 | local | extracted-target forbidden-string + project-owned scan | passed | slice-5-reuse-boundary | No `mrhussamahmed/ProjectGenesis`, `github.com/mrhussamahmed/ProjectGenesis`, or `@mrhussamahmed` matches; no bare `ProjectGenesis` in the 13 project-owned generated files. |
| 2026-05-17 | GitHub Actions on PR #20 | `Bootstrap Validation` runs 25988769737 and 25988770445 | passed | slice-5-reuse-boundary | Pre-merge `validate` job passed on the PR branch (1m22s and 1m2s). |

## History

| Run Date | Scope | Command | Outcome | Evidence | Notes |
|----------|-------|---------|---------|----------|-------|
| n/a | archived | see MAINTAINER_ARCHIVE/snapshots/ | n/a | pre-slice-3 | Prior ProjectGenesis validation runs are archived. |

## Conventions

- Record any test run that gates a merge, release, or review approval.
- Link each row to a spec, backlog item, or review where applicable.
- For local-only runs, mark scope as `local` and reference the relevant file
  or branch.

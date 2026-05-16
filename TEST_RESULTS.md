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
| 2026-05-16 | local | `bash SCRIPTS/validate-bootstrap.sh` | passed (except obsolete branch-field check on non-main slice 3 branch) | slice-3-shrink-required-reading | Post-slice-3-trim validator run; all required-file and required-dir checks pass against the new MAINTAINER_ARCHIVE/ paths. |

## History

| Run Date | Scope | Command | Outcome | Evidence | Notes |
|----------|-------|---------|---------|----------|-------|
| n/a | archived | see MAINTAINER_ARCHIVE/snapshots/ | n/a | pre-slice-3 | Prior ProjectGenesis validation runs are archived. |

## Conventions

- Record any test run that gates a merge, release, or review approval.
- Link each row to a spec, backlog item, or review where applicable.
- For local-only runs, mark scope as `local` and reference the relevant file
  or branch.

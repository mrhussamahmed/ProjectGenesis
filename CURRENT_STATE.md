artifact_id: ART-STATE-002
title: Current State
type: shared-state
status: active
version: v4.0
created: 2026-05-09
updated: 2026-05-17
owner: AI Bootstrap Maintainers
source: ProjectGenesis bootstrap scaffold; slice 3 required-reading shrink (full prior history preserved at MAINTAINER_ARCHIVE/snapshots/CURRENT_STATE.md-2026-05-16-pre-slice-3.md)
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: false

# Current State

## Active Specs

No ProjectGenesis-specific specs are currently active. The legacy SPEC-BOOT-*
specs that introduced the original bootstrap mechanics are preserved under
`MAINTAINER_ARCHIVE/SPECS/` for audit.

## Proposed Specs

None.

## Active Architecture

`ARCHITECTURE.md` describes the stack-neutral bootstrap architecture.

## Active ADRs

None active. `ADR/ADR_INDEX.md` is empty pending the next architectural
decision.

## Active Implementation Phase

Clean scaffold boundary follow-on slices 1-4 are merged. Slice 4 added
adaptive fast-path validation while keeping strict gates for protected paths.

## Active Branch

`main`

## Active Worktree

repository root

## Active Backlog Focus

Clean scaffold boundary cleanup slices are complete. See `BACKLOG.md`.

## Current Blockers

None.

## Current Source-Of-Truth Files

- `AI_PROJECT_BOOTSTRAP.md` - operating-model description
- `CONTEXT_INDEX.md` - required-reading index
- `GOVERNANCE.md` - governance rules
- `OPERATION_ROUTING.md` - adaptive routing
- `TEMPLATE_MANIFEST.md` - scaffold boundary classification
- `TEMPLATE_STARTERS/` - clean starter content
- `MAINTAINER_ARCHIVE/` - relocated ProjectGenesis maintainer history (slice 2)
- `MAINTAINER_ARCHIVE/snapshots/*-2026-05-16-pre-slice-3.md` - pre-trim
  snapshots of required-reading files

## Known Stale Or Superseded Files

None. Prior staleness tracking lives in `MAINTAINER_ARCHIVE/STALE_ITEMS.md`.

## Next Recommended Action

Verify post-cleanup `main` CI is green after this state reset, then resume
normal development from the clean scaffold boundary and adaptive validation
baseline.

## Latest Validation

PR #19 pull_request and push `Bootstrap Validation` CI passed before merge.
Post-merge `main` CI initially failed only because `AI_HANDOFF.md` still named
the slice 4 branch; this cleanup resets active state to `main`. Local
`bash SCRIPTS/validate-bootstrap.sh`, `bash SCRIPTS/validate-bootstrap-red-checks.sh`,
and `git diff --check` passed after the reset.

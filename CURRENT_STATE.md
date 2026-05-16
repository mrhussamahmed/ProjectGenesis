artifact_id: ART-STATE-002
title: Current State
type: shared-state
status: active
version: v4.0
created: 2026-05-09
updated: 2026-05-16
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

Clean scaffold boundary follow-on slices 1-3 are merged. Slice 4 remains
pending and must be rebased onto current `main`.

## Active Branch

`main`

## Active Worktree

repository root

## Active Backlog Focus

Clean scaffold boundary cleanup slices. See `BACKLOG.md`.

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

Verify post-merge `main` CI after this branch-field cleanup, then rebase slice
4 (fast-path validation discipline) onto current `main`.

## Latest Validation

PR #18 pull_request and push `Bootstrap Validation` CI passed before merge.
Post-merge `main` CI initially failed only because `AI_HANDOFF.md` still named
the slice 3 branch; this cleanup resets active state to `main`.

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

Clean scaffold boundary follow-on slices 1-5 are merged. Slice 5
(reuse-boundary clean extraction) landed on `main` through PR #20 at
squash merge commit `97b6e9a3188de41e12b70fc5080e26c8ab07f271`.

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

Resume normal development from the clean scaffold boundary baseline.
Slice 5 (reuse-boundary clean extraction) is merged, the post-merge
state reset has been pushed (`05f01f2`), and the post-cleanup `main` CI
run 25990299701 is green; no further slice 5 follow-up work is pending.

## Latest Validation

Pre-merge: PR #20 pull_request and push `Bootstrap Validation` CI passed
(runs 25988769737 and 25988770445). All local slice 5 checks
(`bash SCRIPTS/validate-bootstrap.sh`,
`bash SCRIPTS/scaffold-extract.sh --apply <tmp>`,
forbidden-path/string scans, and
`bash SCRIPTS/validate-bootstrap-red-checks.sh` with the new
`case_scaffold_extract_contract_detects_forbidden_string_contamination`
fixture) passed locally on 2026-05-17.

Post-merge: the first `main` `Bootstrap Validation` CI run after the
squash merge (run 25989064447) failed because `AI_HANDOFF.md` still
named the slice 5 branch. The cleanup commit `05f01f2` reset active
state to `main`; `bash SCRIPTS/validate-bootstrap.sh` passed locally on
`main` after the reset, and the post-cleanup `Bootstrap Validation` CI
run 25990299701 finished green (1m19s).

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

Clean scaffold boundary follow-on slices 1-4 are merged. Slice 5
(reuse-boundary clean extraction) is in review on branch
`claude/sharp-shockley-6bd7a3` (PR #20).

## Active Branch

`claude/sharp-shockley-6bd7a3`

## Active Worktree

`.claude/worktrees/sharp-shockley-6bd7a3`

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

Complete Codex adversarial review of PR #20 (reuse-boundary slice 5),
address any blocking findings, verify CI is green, then merge.

## Latest Validation

Slice 5 (reuse-boundary clean extraction, PR #20) local checks:
`bash SCRIPTS/validate-bootstrap.sh`,
`bash -n SCRIPTS/scaffold-extract.sh SCRIPTS/validate-bootstrap.sh SCRIPTS/validate-bootstrap-red-checks.sh`,
`git diff --check`, `grep -q '^\.bootstrap-scaffold-mode$' .gitignore`,
`bash SCRIPTS/scaffold-extract.sh --apply <tmp>` (extracted contract check
and downstream validator), forbidden upstream string scan against the
extracted target, project-owned-file bare `ProjectGenesis` scan, and
`bash SCRIPTS/validate-bootstrap-red-checks.sh` (including the new
`case_scaffold_extract_contract_detects_forbidden_string_contamination`
fixture) all passed locally on 2026-05-17.

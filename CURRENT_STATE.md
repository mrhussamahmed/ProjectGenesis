artifact_id: ART-STATE-002
title: Current State
type: shared-state
status: active
version: v7.1
created: 2026-05-09
updated: 2026-06-11
owner: AI Bootstrap Maintainers
source: ProjectGenesis bootstrap scaffold; split-state boundary from BOOT-STATE-001; state compaction from GEN-07; BOOT-RESEARCH-001 research orchestration layer
linked_specs: []
linked_tickets: [BOOT-STATE-001, GEN-07]
linked_adrs: []
replaces:
replaced_by:
authoritative: false

# Current State

## Active Specs

No ProjectGenesis-specific specs are active. Legacy SPEC-BOOT-* specs are
preserved under `MAINTAINER_ARCHIVE/SPECS/` for audit.

## Active Architecture

`ARCHITECTURE.md` describes the stack-neutral bootstrap architecture.

## Active ADRs

None active. `ADR/ADR_INDEX.md` is empty pending the next architectural
decision.

## Active Implementation Phase

Scaffold operating-model improvement arc complete: GEN-01..16 (PR #24),
the GEN-17 P2 batch (HUS-235, PR #25), and the BOOT-RESEARCH-001 research
orchestration layer (HUS-236) form the current operating-model baseline.
The research layer adds the `Start research` command, the research
planner/researcher/critic/synthesizer and UX designer roles, the four
research templates, and the user-gated research brief.
Pipeline Stage: implement (the scaffold itself; no downstream product
intake yet).

## Active Branch

`main`

## Active Backlog Focus

GEN improvement program (Linear HUS-219..235) complete; BOOT-RESEARCH-001
(Linear HUS-236) in review. Next focus: downstream product intake via
`COMMANDS/COMMAND_INDEX.md` (optionally starting with `Start research`) or
a new improvement milestone. See `IMPLEMENTATION_PLAN.md`.

## Current Blockers

None.

## Current Source-Of-Truth Files

- `CONTEXT_INDEX.md` - single read authority (minimum context plus on-demand tiers)
- `OPERATION_ROUTING.md` - operation profiles and validation depth
- `TEMPLATE_MANIFEST.md` - scaffold boundary classification
- `TEMPLATE_STARTERS/` - clean starter content for forks
- `MAINTAINER_ARCHIVE/` - relocated ProjectGenesis maintainer history

## Known Stale Or Superseded Files

None. Staleness tracking lives in `STALE_ITEMS.md`.

## Latest Validation

Durable baseline: `main` Bootstrap Validation run 25990646864 passed on
2026-05-17. The GEN-01..16 program baseline is recorded in `TEST_RESULTS.md`.

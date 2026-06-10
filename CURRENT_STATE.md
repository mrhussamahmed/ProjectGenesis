artifact_id: ART-STATE-002
title: Current State
type: shared-state
status: active
version: v6.0
created: 2026-05-09
updated: 2026-06-10
owner: AI Bootstrap Maintainers
source: ProjectGenesis bootstrap scaffold; split-state boundary from BOOT-STATE-001; state compaction from GEN-07
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

Scaffold operating-model improvement arc: the GEN-01..16 program (compact
reads, risk-tiered review, pipeline commands; Linear HUS-219..235) is the
current operating-model baseline; the P2 batch (GEN-17 / HUS-235) remains
open.
Pipeline Stage: implement (the scaffold itself; no downstream product
intake yet).

## Active Branch

`main`

## Active Backlog Focus

GEN improvement program (Linear HUS-219..235); next batch is GEN-17 /
HUS-235. See `IMPLEMENTATION_PLAN.md`.

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

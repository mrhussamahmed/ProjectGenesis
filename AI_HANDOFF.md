artifact_id: ART-STATE-003
title: AI Handoff
type: shared-state
status: active
version: v7.0
created: 2026-05-09
updated: 2026-06-11
owner: AI Bootstrap Maintainers
source: ProjectGenesis bootstrap scaffold; split-state boundary from BOOT-STATE-001; compact handoff contract from GEN-07
linked_specs: []
linked_tickets: [BOOT-STATE-001, GEN-07]
linked_adrs: []
replaces:
replaced_by:
authoritative: false

# AI Handoff

## Baseline
Clean scaffold boundary baseline; slices 1-5, GEN-01..16 (PR #24), and the
GEN-17 P2 batch (HUS-235, PR #25) merged.

## Last Validated
GEN-17 baseline (2026-06-11): strict validation, red checks 77/77, and the
refreshed seeded-defect benchmark are recorded in `TEST_RESULTS.md` and
`TESTS/ADVERSARIAL_SEED_BENCHMARK.md`.

## Next Recommended Action
Start product work via `COMMANDS/COMMAND_INDEX.md` (drop material into
`00_intake/raw/` and say "Start requirement breakdown"), or open the next
improvement milestone.

## Known Risks
Branch-specific status belongs in PR evidence and gitignored `.ai/SESSION.md`;
committed state must stay merge-safe and true on `main`.

## Open Threads
None.

## Read First
`CONTEXT_INDEX.md` Minimum Context is the single startup read list.
`.ai/SESSION.md` (gitignored) holds local resume notes for unmerged work.

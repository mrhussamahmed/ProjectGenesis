artifact_id: ART-SPEC-INDEX
title: Spec Index
type: spec-index
status: active
version: v1.14
created: 2026-05-09
updated: 2026-05-14
owner: AI Bootstrap Maintainers
source: Initial bootstrap scaffold, SPEC-BOOT-003 proposal, SPEC-BOOT-003 review fixes, SPEC-BOOT-003 approval, BOOT-018 merge, BOOT-019 through BOOT-024 implementation, BOOT-019 through BOOT-024 merge, and SPEC-BOOT-004 public launch readiness
linked_specs: [SPEC-BOOT-002, SPEC-BOOT-003, SPEC-BOOT-004]
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# Spec Index

Specs are the source of truth for product behavior, spikes, integrations,
infrastructure tasks, refactors, and acceptance criteria.

## Specs

| Spec ID | Title | File | Status | Version | Owner | Related Backlog | Related Ticket | Related ADRs | Current Status |
|---------|-------|------|--------|---------|-------|-----------------|----------------|--------------|----------------|
| SPEC-BOOT-002 | Scaffold Intake And Governance Improvement | `SPECS/SPEC-BOOT-002-scaffold-intake-and-governance.md` | active | v1.2 | AI Bootstrap Maintainers | BOOT-009 through BOOT-015 | none | none | Active; BOOT-010 through BOOT-015 implemented, validated, and final review P1/P2 findings addressed. |
| SPEC-BOOT-003 | Adaptive Governance Routing | `SPECS/SPEC-BOOT-003-adaptive-governance-routing.md` | approved | v1.0 | AI Bootstrap Maintainers | BOOT-018 through BOOT-024 | none | none | Approved spec; BOOT-019 through BOOT-024 mechanics are implemented, reviewed, and merged through PR #4. |
| SPEC-BOOT-004 | Public Launch Readiness | `SPECS/SPEC-BOOT-004-public-launch-readiness.md` | approved | v1.0 | ProjectGenesis Maintainers | BOOT-025 | none | none | Approved for additive public launch packaging assets only; no product behavior or governance mechanics changes. |

## Rules

- Implementation requires an approved or active spec.
- Draft or proposed specs allow discovery, research, architecture analysis,
  spike work, and backlog preparation only.
- Update this index whenever a spec is created, changed, superseded,
  cancelled, archived, implemented, tested, or released.

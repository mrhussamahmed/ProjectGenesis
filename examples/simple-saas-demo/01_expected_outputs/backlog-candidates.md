artifact_id: ART-EXAMPLE-SIMPLE-SAAS-BACKLOG
title: Freelancer Invoice App Backlog Candidates
type: example-output
status: active
version: v1.0
created: 2026-05-14
updated: 2026-05-14
owner: ProjectGenesis Maintainers
source: Public launch readiness and adoption packaging task
linked_specs: [SPEC-BOOT-004]
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: false

# Backlog Candidates

This is illustrative expected output, not a claim of live generated output.

These candidates use the canonical `BACKLOG/BACKLOG_INDEX.md` columns; the
File column stays `none` until each candidate gets a real
`BACKLOG/<item>.md` file from `BACKLOG/templates/BACKLOG_ITEM_TEMPLATE.md`.

| Item ID | Title | File | Status | Priority | Complexity | Risk | Linked Spec | Parallelization |
|---------|-------|------|--------|----------|------------|------|-------------|-----------------|
| EX-BL-001 | Define MVP invoice model | none | discovery | P1 | low | low | none; discovery exception | allowed |
| EX-BL-002 | Define simple expense model | none | discovery | P1 | low | low | none; discovery exception | allowed |
| EX-BL-003 | Draft invoice tracking spec | none | blocked (EX-BL-001) | P1 | medium | medium | none; produces the spec | not-allowed |
| EX-BL-004 | Draft expense tracking spec | none | blocked (EX-BL-002) | P2 | medium | low | none; produces the spec | not-allowed |
| EX-BL-005 | Draft late payment dashboard spec | none | blocked (EX-BL-003) | P2 | medium | low | none; produces the spec | not-allowed |
| EX-BL-006 | Explore AI reminder concepts | none | deferred | P3 | medium | high | none; discovery exception | allowed |

## Initial Scope Candidates

- `EX-BL-001`
- `EX-BL-002`
- `EX-BL-003`
- `EX-BL-004`
- `EX-BL-005`

## Deferred Candidate

- `EX-BL-006` remains deferred until the AI reminder requirement is confirmed
  and governed by a specific spec.

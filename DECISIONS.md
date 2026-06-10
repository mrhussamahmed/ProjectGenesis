artifact_id: ART-ADR-001
title: Decision Governance
type: adr-guide
status: authoritative
version: v2.0
created: 2026-05-09
updated: 2026-06-10
owner: AI Bootstrap Maintainers
source: User request and reference repository audit; GEN-12 single ADR-governance home; durable decisions absorbed from the retired project-memory file
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# Decision Governance

ADRs live under `ADR/`. This file is the single home for ADR governance;
`ADR/ADR_INDEX.md` keeps only the table.

## When An ADR Is Required

Create or update an ADR before implementation when work affects:

- technology choices
- architecture boundaries
- persistence model
- API contracts
- security model
- deployment model
- external integrations
- production dependencies
- data migrations
- irreversible or expensive-to-change tradeoffs

## ADR States

- draft
- proposed
- accepted
- superseded
- rejected
- deprecated

Implementation that depends on a decision should wait for `accepted` status or
record explicit provisional risk.

## ADR Rules

- Use `ADR/templates/ADR_TEMPLATE.md`: the 35-line core is enough for most
  decisions; fill the High-Impact Additions block only for strict-protected
  or high-risk routing per `OPERATION_ROUTING.md`.
- Single register: a row in `ADR/ADR_INDEX.md` is mandatory; add
  `ARTIFACT_REGISTRY.md` and `TRACEABILITY_MATRIX.md` rows only when the ADR
  links a requirement.
- Link ADRs to the spec, backlog item, or requirement they decide for.
- If an ADR is superseded, add a visible banner to the old ADR and update the
  index row.
- If an ADR is rejected, keep it for historical context and record why.

## Durable Decisions

Standing decisions for this scaffold; supersede them only with a new ADR or
explicit governance change.

- Neutral files, not agent-specific files, hold shared project state.
- `CLAUDE.md` and `AGENTS.md` remain short and point to canonical docs.
- Implementation requires an approved or active spec unless provisional risk
  is recorded.
- Review depth follows the operation profile per OPERATION_ROUTING.md and
  PR_REVIEW_POLICY.md: docs-trivial, docs-non-authoritative, and state-sync
  changes require a recorded self-check in the PR body; planning-governance
  and strict-protected changes require fresh-context adversarial review.
- Parallel AI work is disabled by default until file ownership boundaries and
  contracts prove it is safe.
- The scaffold stays stack-neutral: no hardcoded frontend, backend, database,
  hosting provider, tracker workspace, or issue prefix.

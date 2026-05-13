artifact_id: ART-REQ-ASSUMPTIONS
title: Assumptions Register
type: assumptions-registry
status: active
version: v1.1
created: 2026-05-13
updated: 2026-05-13
owner: AI Bootstrap Maintainers
source: SPEC-BOOT-002
linked_specs: [SPEC-BOOT-002]
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# Assumptions Register

This register keeps assumptions visible and prevents weak inference from
becoming implementation authority.

| Assumption ID | Statement | Risk | Owner | Status | Expiry | Approval Evidence | Linked Requirement | Linked Spec | Notes |
|---------------|-----------|------|-------|--------|--------|-------------------|--------------------|-------------|-------|
| none | none | none | none | none | none | none | none | none | No downstream assumptions have been registered yet. |

## Assumption Statuses

- proposed
- approved
- rejected
- expired
- superseded
- needs-confirmation

## Approval Rules

- Agents may propose assumptions but must not approve their own assumptions.
- Approval evidence must point to explicit user approval, an approved or active
  spec, an accepted ADR, a maintainer-approved register entry, or verified
  external evidence in `00_intake/SOURCE_REGISTRY.md`.
- High-risk assumptions require explicit user, maintainer, approved-spec, or
  accepted-ADR approval.
- Medium-risk assumptions require review by a role other than the author.
- Low-risk assumptions may be approved by a responsible role when approval
  evidence and expiry are recorded.
- Approval evidence should include one of these markers so validation can check
  it: `explicit user approval`, `user approval`, `approved spec`,
  `active spec`, `accepted ADR`, `maintainer-approved`, `verified external`,
  `SPEC-*`, `ADR-*`, or `SRC-*`.
- Self-approval by the assumption author is not valid approval evidence.

## Expiry Rules

- Low-risk assumptions expire after 30 days or before implementation, whichever
  comes first.
- Medium-risk assumptions must be reviewed before spec approval.
- High-risk assumptions cannot authorize implementation until confirmed.

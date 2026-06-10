artifact_id:
title:
type: backlog-item
status: draft
version: v0.1
created:
updated:
owner:
source:
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true
item_type: epic|feature|story|spike|validation
priority: P0|P1|P2|P3
estimate: 1|2|3|5|8
labels: []
parent:
blocked_by: []
readiness: not-ready|ready|in-progress|in-review|done|blocked
tracker: {name: none, id_or_url:, evidence:}

# BACKLOG-000: Title

Required-for-all sections: Purpose (incl. user value), Scope, Acceptance
Criteria, Dependencies, Test Expectations, Definition Of Done. Required-when-
triggered sections (delete when the trigger does not apply): Links, Risks,
Readiness Evidence, Parallelization, Implementation Phase, Stories. A minimal
story is frontmatter plus the six required sections, about 40 lines total.
Frontmatter is the tracker export contract (mapping table in
`BACKLOG/BACKLOG_INDEX.md` Rules); `readiness` is the single status authority.

## Purpose

State the problem and the user or system value in one to three sentences.

## Scope

In scope / out of scope; one line each is enough.

## Acceptance Criteria

Inline, testable criteria. Exported verbatim as the tracker issue description.

- AC-1:
- AC-2:

## Dependencies

`none` when independent; mirror blocking item IDs in `blocked_by` frontmatter.

- none

## Test Expectations

Name the exact checks that prove this item done. Tests and validation
expectations live here, never as sibling tickets.

- 

## Definition Of Done

- [ ] Acceptance criteria satisfied; checks named in Test Expectations pass or
  deviations are justified.
- [ ] Frontmatter `readiness` updated; `BACKLOG/BACKLOG_INDEX.md` row mirrors it.
- [ ] One validation-evidence note recorded in the PR body.

## Links

Trigger: the item cites specs, sources, assumptions, ADRs, or open questions.

- Linked spec:
- Source IDs:
- Approved assumptions:
- Open questions:
- Related ADR:

## Risks

Trigger: medium-or-higher risk, or labels include `risk:high`.

- 

## Readiness Evidence

Trigger: before setting `readiness: ready` (Definition of Ready gate).

- User value (1 sentence):
- Measurable success criterion:
- Observability expectation:
- Security triggers checked (per SECURITY_AND_PRIVACY.md): yes | no | n-a
- Spec status:
- Blocked until:

## Parallelization

Trigger: item is a parallel-work candidate.

- Status: not-allowed | candidate | approved
- File ownership boundaries:
- Stop conditions:

## Implementation Phase

Trigger: multi-phase delivery only.

## Stories

Trigger: epics only. Child stories may live as rows here until they need files.

| ID | Story | AC refs | Priority | Status | Depends on |
|----|-------|---------|----------|--------|------------|
|  |  |  |  |  |  |

artifact_id: ART-REL-001
title: Release Readiness
type: release
status: authoritative
version: v1.0
created: 2026-05-09
updated: 2026-05-09
owner: AI Bootstrap Maintainers
source: User request
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# Release Readiness

Use this checklist before production release or any merge that changes
production behavior.

## Checklist

- Specs are approved or active and implemented.
- Acceptance criteria are satisfied or explicitly deferred with approval.
- Tests pass or failures are documented and accepted.
- Security review is complete if required.
- Privacy review is complete if required.
- Observability is adequate.
- CI/CD checks pass.
- Deployment assumptions are documented.
- Migration checks are complete if applicable.
- Rollback or recovery path is documented.
- Smoke tests are defined.
- Post-release verification is defined.
- Release notes exist if relevant.
- Known risks are documented.
- Artifact registry is updated.
- Traceability matrix is complete.
- Stale artifacts are marked.
- Handoff is complete.

## Rollback Checklist

- What change is being reversed?
- Which data or migration state is affected?
- What command or process performs rollback?
- What validation confirms rollback succeeded?
- Who owns rollback?
- What risks remain after rollback?

## Post-Release Verification

Record:

- release identifier
- deployment time
- smoke tests run
- monitoring checked
- errors observed
- rollback decision
- owner and handoff


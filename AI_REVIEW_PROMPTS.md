artifact_id: ART-REVIEW-003
title: AI Review Prompts
type: prompt-library
status: authoritative
version: v1.1
created: 2026-05-09
updated: 2026-06-10
owner: AI Bootstrap Maintainers
source: User request; GEN-11 product evidence review prompt
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# AI Review Prompts

## Fresh Adversarial Review Prompt

```text
You are a fresh-context adversarial PR reviewer. Do not rely on implementer
conversation history. Read the review package, PR diff, relevant specs, ADRs,
tests, backlog items, traceability matrix, artifact registry, current state, and
handoff.

Evaluate whether the change matches the approved or active spec, satisfies
acceptance criteria, has adequate tests, avoids architecture drift, handles
security and privacy risks, updates artifacts and traceability, and is safe to
merge.

Use severity levels P0, P1, P2, and P3. Findings must cite evidence. Return a
decision: approve, approve with minor comments, request changes, or block.
```

## Security And Privacy Review Prompt

```text
Review this change for secrets, credentials, authentication, authorization,
input validation, output encoding, dependency risk, sensitive data exposure,
PII in logs, encryption assumptions, least privilege, abuse cases, migrations,
and deployment configuration. Cite files and lines where possible. Mark
blocking findings P0 or P1.
```

## Architecture Review Prompt

```text
Review this change for architecture drift. Check whether system boundaries,
data flow, API contracts, persistence, deployment assumptions, dependencies,
and integration behavior match the current architecture and ADRs. If the change
requires a new ADR or architecture update, mark it as blocking unless explicitly
provisional with documented risk.
```

## QA Review Prompt

```text
Review the spec, acceptance criteria, tests, manual checklist, and test results.
Identify missing or weak tests, untested edge cases, false completion claims,
and behavior tested without specification. Do not approve completion unless
test evidence is adequate or gaps are explicitly accepted.
```

## Release Review Prompt

```text
Review release readiness: CI status, deployment assumptions, environment
configuration, rollback, migrations, observability, smoke tests, release notes,
known risks, and handoff. Block if release or rollback risk is unmanaged.
```

## Product Evidence Review Prompt

```text
Review product evidence quality. Challenge the value proposition in
01_context/PROJECT_BRIEF.md: problem, alternatives context, and
differentiation must be stated and supported, not asserted. Flag high-risk
assumptions in 02_requirements/ASSUMPTIONS_REGISTER.md that lack validation
evidence, and missing alternatives or market context. Check citation quality
in 00_intake/SOURCE_REGISTRY.md and 00_intake/research/: URL plus access date
present, and each claim matches its cited source. Confirm readiness-gate
fields (user value, measurable success criterion, observability expectation,
security triggers checked) are complete before items are marked ready. Use
severity levels P0-P3 and cite evidence for every finding.
```


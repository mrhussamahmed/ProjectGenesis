artifact_id: ART-SEC-001
title: Security And Privacy
type: security
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

# Security And Privacy

## Baseline Rules

- Never commit secrets, credentials, tokens, private keys, or real production
  data.
- Use `.env.example` for variable names and safe placeholder values only.
- Avoid logging sensitive data, personal data, credentials, or raw tokens.
- Validate inputs at trust boundaries.
- Apply least privilege to credentials and service accounts.
- Review dependency changes for security and license risk.
- Document encryption, retention, deletion, and access assumptions where
  sensitive data exists.
- Use secure defaults and fail closed for auth-sensitive paths.

## Mandatory Security Review Triggers

Security review is mandatory for:

- authentication changes
- authorization changes
- user data handling
- payment or financial data
- personal data
- admin functions
- external integrations
- secrets or credentials
- deployment configuration
- data migrations
- dependency changes with security impact

## Threat Modeling

High-risk features should identify:

- assets
- actors
- trust boundaries
- abuse cases
- likely attack paths
- mitigations
- monitoring and incident response needs

## Privacy Review

Privacy-sensitive work must define:

- data collected
- data purpose
- data retention
- user visibility and control
- sharing with external providers
- deletion or export expectations
- logging and analytics constraints

## Review Evidence

Record security and privacy review results in the PR package, review record,
`SECURITY_AND_PRIVACY.md` if durable rules changed, and `TRACEABILITY_MATRIX.md`
when tied to requirements.


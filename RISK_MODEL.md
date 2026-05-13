artifact_id: ART-RISK-001
title: Risk Model
type: risk-model
status: authoritative
version: v1.1
created: 2026-05-09
updated: 2026-05-14
owner: AI Bootstrap Maintainers
source: User request and SPEC-BOOT-003
linked_specs: [SPEC-BOOT-003]
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# Risk Model

Every task, PR, and review must be classified by risk and complexity.

## Risk Dimensions

Assess:

- user impact
- production impact
- security impact
- privacy impact
- data loss risk
- financial or business risk
- integration complexity
- architecture impact
- reversibility
- test coverage
- codebase size affected
- dependency risk
- deployment risk
- uncertainty level

## Complexity Levels

- low: small, reversible, isolated, well-tested.
- medium: meaningful behavior change, moderate dependencies, testable.
- high: cross-module, architecture-sensitive, data-sensitive, or externally
  integrated.
- critical: security-sensitive, privacy-sensitive, irreversible, migration,
  auth, payment, deployment, or high blast radius.

## Review Effort Levels

- light: simple docs, formatting, isolated non-production changes.
- standard: routine feature or fix with clear tests.
- deep: multi-file behavior, integration, or architecture-adjacent work.
- adversarial deep: high-risk or high-uncertainty work.
- multi-role review: critical work requiring security, architecture, QA, and
  release roles.

## Model Capability Selection

- Low-risk, small, reversible changes may use a standard capable coding model
  with standard effort.
- Medium-risk changes require stronger coding or reasoning review, or higher
  effort.
- High-risk changes require a high-capability reasoning model with deep review.
- Critical changes require adversarial deep review and additional focused
  security, architecture, QA, and release review.
- Security-sensitive, privacy-sensitive, data migration, authentication,
  authorization, payment, deployment, or irreversible changes automatically
  escalate review effort.

If the environment allows model selection, select the appropriate model and
effort automatically. If not, state the recommended capability and effort in
the PR review package.

## Risk Scoring Shortcut

Use the highest triggered dimension as the final risk. Do not average away a
critical security, privacy, data, migration, or deployment concern.

| Trigger | Minimum Risk | Minimum Review |
|---------|--------------|----------------|
| docs-only typo | low | light |
| `docs-trivial` operation profile | low | light |
| `docs-public-claim` operation profile | medium | light or adversarial based on claim risk |
| `state-sync` operation profile | medium | light or standard when resolving drift |
| `planning-governance` operation profile | high | deep or adversarial deep |
| `strict-protected` operation profile | high to critical | adversarial deep or multi-role review |
| isolated behavior with tests | medium | standard |
| shared module or API contract | high | deep |
| auth, authorization, secrets, PII | critical | multi-role review |
| migration or destructive operation | critical | multi-role review |
| deployment or rollback change | high | deep |
| unclear requirements | medium | spike or clarification |

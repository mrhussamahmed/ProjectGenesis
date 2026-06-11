artifact_id: ART-ARCH-001
title: Bootstrap Architecture
type: architecture
status: authoritative
version: v1.1
created: 2026-05-09
updated: 2026-05-09
owner: AI Bootstrap Maintainers
source: User request and reference repository audit
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# Bootstrap Architecture

## System Overview

The bootstrap is a file-based operating system for autonomous AI-assisted
software delivery. It does not assume a product stack. It gives AI agents a
shared, evidence-based workflow for turning product input into specs,
architecture, backlog, tests, implementation, review, release readiness, and
handoff.

## Domain Model

| Concept | Meaning |
|---------|---------|
| Source input | Product idea, PRD, feature list, spreadsheet, design, ticket, or user instruction. |
| Requirement | A normalized product or system need extracted from source input. |
| Spec | Current or proposed source of truth for expected behavior and acceptance criteria. |
| ADR | Decision record for meaningful technical or architectural choices. |
| Backlog item | Implementation-ready or refinement-ready unit of work linked to a spec. |
| Artifact | A durable file such as a spec, plan, ADR, review, test plan, prompt, or diagram. |
| Traceability row | Evidence chain from requirement to spec, work, code, tests, review, and release. |
| Handoff | Current operational state needed by another AI agent to continue safely. |

## Main Components

- Agent instruction files: `CLAUDE.md` and `AGENTS.md`.
- Shared AI role system: `memory/ai/SHARED_AGENT_RULES.md` and the
  allowlisted `memory/ai/ROLE_*.md` files used by Claude, Codex, and other
  coding agents.
- Governance files: `AI_PROJECT_BOOTSTRAP.md`, `GOVERNANCE.md`,
  `CONTEXT_INDEX.md`, `RISK_MODEL.md`.
- Shared state: `CURRENT_STATE.md`, `AI_HANDOFF.md`,
  `OPEN_QUESTIONS.md`, `STALE_ITEMS.md`.
- Planning: `SPECS/`, `ADR/`, `BACKLOG/`, `IMPLEMENTATION_PLAN.md`,
  `PARALLEL_EXECUTION_PLAN.md` (maintainer repo only).
- Validation: `TEST_STRATEGY.md`, `TEST_RESULTS.md`,
  `TESTS/`, `SCRIPTS/validate-bootstrap.sh`.
- Review and release: `PR_REVIEW_POLICY.md`, `PR_MERGE_POLICY.md`,
  `AI_REVIEW_PROMPTS.md`, `REVIEWS/`, `RELEASE_READINESS.md`.
- Operations: `.githooks/`, `.github/workflows/`, `CI_CD_GUIDE.md`,
  `OBSERVABILITY.md`, `SECURITY_AND_PRIVACY.md`.

## Data Flow

1. User input or source files enter the repository.
2. Product Analyst extracts requirements, assumptions, risks, and open
   questions.
3. Spec Author creates specs and acceptance criteria.
4. Architect creates architecture updates and ADRs.
5. Backlog Planner creates sequenced backlog items and safe-parallelization
   boundaries.
6. Implementation Agent writes tests and code from ready tasks.
7. Test and QA Agent validates acceptance criteria.
8. Adversarial PR Reviewer checks the diff with fresh context.
9. Documentation Curator updates current state, artifact registry,
   traceability, stale items, and handoff.
10. Diagram Architect creates or reviews Mermaid diagrams when useful and keeps
    diagram registry, traceability, and stale item records aligned.

## Integration Points

- Git and worktrees for version control and parallel streams.
- Linear or another tracker when available.
- GitHub Actions or equivalent CI when available.
- Security, dependency, browser, deployment, and observability tools selected by
  project-specific ADRs.

## API Boundaries

This bootstrap defines process boundaries, not runtime APIs. Product-specific
APIs must be documented in specs, architecture, contracts, or ADRs before
implementation.

## Security Considerations

- Do not commit secrets, credentials, private source documents, or generated
  local environment files.
- Security-sensitive work triggers focused review as defined in
  `SECURITY_AND_PRIVACY.md`.
- Review packages must include security and privacy considerations.

## Privacy Considerations

- Do not include private data from reference projects in reusable templates.
- If product input contains personal or sensitive data, record handling rules
  in the relevant spec and `SECURITY_AND_PRIVACY.md`.

## Deployment Assumptions

The bootstrap itself has no runtime deployment. Downstream projects must define
deployment model, environment configuration, rollback, observability, and CI/CD
in project-specific architecture and ADRs.

## Testing Strategy

Bootstrap validation is file-based and lightweight. Downstream product testing
is defined in `TEST_STRATEGY.md` and project-specific specs.

## Observability Needs

For this bootstrap, observability means visible durable state: current state,
handoff, traceability, artifact registry, test results, review records, and
worklog. Runtime observability for products is defined in `OBSERVABILITY.md`.

## Failure Modes

- Agent implements from chat without a spec.
- Agent treats stale docs as current truth.
- Parallel agents edit shared files without coordination.
- Review relies on implementer memory instead of repository evidence.
- Traceability or handoff is not updated before context switch.
- Local hooks become too heavy and are bypassed.

## Risks And Unknowns

- Downstream stacks may need additional validation tools.
- Linear may not be available in every project.
- Very small projects may need a scaled-down backlog while preserving spec and
  evidence rules.

## Implementation Phases

1. Bootstrap scaffold and validation.
2. Intake of downstream product input.
3. First spec and architecture pass.
4. Backlog and test plan creation.
5. First ready implementation branch.
6. PR review and merge readiness.

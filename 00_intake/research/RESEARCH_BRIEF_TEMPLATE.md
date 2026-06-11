artifact_id: ART-TEMPLATE-RESEARCH-BRIEF
title: Research Brief Template
type: template
status: active
version: v1.0
created: 2026-06-11
updated: 2026-06-11
owner: AI Bootstrap Maintainers
source: BOOT-RESEARCH-001 research orchestration layer (GEN-18)
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: false

# Research Brief: Topic

Instances are written by `memory/ai/ROLE_RESEARCH_SYNTHESIZER.md`. Copy this
file to `00_intake/research/RESEARCH_BRIEF-NNN.md` (NNN = the run number of
the governing plan). Instance frontmatter `status:` starts as `draft` and
becomes `accepted` only when explicit user approval is recorded in the
Approval section; the validator enforces required sections, the approval
line, and RR-/RCR- references on accepted briefs. The brief consolidates
evidence into decision-ready options; it does not make feature decisions.
Cross-report evidence citations use the form RR-NNN-<track>/EV-MMM. Instances
must not contain placeholder tokens; record open items under Gaps And
Unknowns instead.

- Brief ID: RESEARCH_BRIEF-000
- Plan: RESEARCH_PLAN-000
- Date:

## Decision Summary

Five to ten sentences: what the evidence says, the strongest opportunity,
the biggest risk, and what decision the product analyst now faces.

## Consolidated Findings

Per theme, citing report evidence (RR-NNN-<track>/EV-MMM). Conflicts between
reports are resolved explicitly here or recorded under Gaps And Unknowns.

## Differentiation Opportunities

Each opportunity ties to a named competitor gap or unmet need with EV-
citations.

## Customer Needs And UX Expectations

User needs, usability expectations, and workflow findings for the UX
designer and product analyst, with EV- citations.

## Technical Feasibility And Constraints

Feasibility findings, platform and integration constraints, with EV-
citations.

## Regulatory And Compliance Constraints

Constraints with official-doc sources; absence of regulation found is stated
explicitly with the searches performed.

## Business Model And Cost Of Productization

Monetization findings and the cheapest or free-of-charge services found that
enable productization, with current pricing-page citations.

## Assumption And Risk Candidates

| Candidate | Type (assumption, risk) | Proposed Register Row | Supporting Citations | Suggested Confidence Or Severity |
|-----------|-------------------------|------------------------|----------------------|----------------------------------|
|  |  |  |  |  |

## Gaps And Unknowns

Unresolved critic findings, unanswered research questions, and evidence
gaps; each names the follow-up that would close it.

## Recommendations

Decision-ready options, not feature decisions. Every recommendation cites
evidence.

| Recommendation | Citations (RR-NNN-<track>/EV-MMM) | Confidence | Decision Impact |
|----------------|----------------------------------|------------|------------------|
|  |  |  |  |

## Approval

Acceptance requires explicit user approval. Record it as a line of the form
`Approval: user approval - <name or handle>, <date>` and flip frontmatter
`status:` to `accepted` only after that line exists.

- Approval:

## Source Links

- Plan: RESEARCH_PLAN-000
- Reports reviewed: RR-000-track-slug
- Critic review: RCR-000
- Registered SRC- IDs:

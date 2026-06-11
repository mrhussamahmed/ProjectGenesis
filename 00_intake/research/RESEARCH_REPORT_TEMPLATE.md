artifact_id: ART-TEMPLATE-RESEARCH-REPORT
title: Research Report Template
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

# Research Report: Track

Instances are written by `memory/ai/ROLE_RESEARCHER.md`, one per track
assigned in the research plan. Copy this file to
`00_intake/research/RR-NNN-<track-slug>.md` (NNN = the run number of the
governing plan). Instances must carry full artifact frontmatter and must not
contain placeholder tokens; record open items in Unknowns instead. Every
claim made in prose must reference an EV- row. Reports contain evidence and
implications only — never feature decisions.

- Report ID: RR-000-track-slug
- Track:
- Plan: RESEARCH_PLAN-000
- Date:
- Research questions assigned (from the plan):

## Summary

Three to eight sentences answering the assigned questions, citing EV- IDs.

## Evidence Log

Evidence types: primary-data, official-doc, vendor-doc, analyst-report,
academic, news, community, product-observation. Confidence: high (two or more
independent credible sources, fresh, on-point), medium (one credible source
or partially dated), low (anecdotal, conflicting, or indirect). Freshness:
fresh (under 12 months), aging (12 to 36 months), stale (over 36 months).
A stale source never solely supports high confidence; market-size, pricing,
and competitor-feature claims need at least one fresh source.

| EV-ID | Claim | Source URL | Source Title | Access Date | Evidence Type | Confidence | Freshness | Implication | Linked ASM/RSK/OQ Candidate | Decision Impact |
|-------|-------|------------|--------------|-------------|---------------|------------|-----------|-------------|------------------------------|-----------------|
| EV-001 |  |  |  |  |  |  |  |  |  |  |

## Counterexamples Sought

Mandatory. State what evidence against the track's emerging conclusion was
searched for, where, and what was found (including nothing found).

## Candidate Assumptions

| Candidate | Risk If Wrong | Supporting EV-IDs | Suggested Confidence |
|-----------|---------------|-------------------|----------------------|
|  |  |  |  |

## Candidate Risks

| Candidate | Category | Severity | Supporting EV-IDs |
|-----------|----------|----------|-------------------|
|  |  |  |  |

## Unknowns

Open items this track could not resolve; each becomes a gap or open-question
candidate in synthesis.

## Track Verdict

| Research Question | Answered (yes, partially, no) | Key EV-IDs |
|-------------------|-------------------------------|------------|
|  |  |  |

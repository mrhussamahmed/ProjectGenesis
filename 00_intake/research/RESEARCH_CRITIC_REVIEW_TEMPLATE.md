artifact_id: ART-TEMPLATE-RESEARCH-CRITIC-REVIEW
title: Research Critic Review Template
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

# Research Critic Review

Instances are written by `memory/ai/ROLE_RESEARCH_CRITIC.md` in a fresh
context (separate session or subagent). Copy this file to
`00_intake/research/RCR-NNN.md` (NNN = the run number of the governing
plan). Instances must carry full artifact frontmatter and must not contain
placeholder tokens. The critic challenges evidence; it never rewrites
reports and never adds new research claims.

- Review ID: RCR-000
- Plan: RESEARCH_PLAN-000
- Reports reviewed:
- Date:
- Context: fresh-session | same-session-fallback (fallback only when
  spawning a fresh context is impossible; every finding then requires
  artifact citations)

## Critic Checklist Results

Checked per report; record pass or the finding ID for each item.

| Checklist Item | Result |
|----------------|--------|
| Unsupported claim (prose without EV- row) |  |
| Single-source high confidence |  |
| Stale source supporting a volatile claim |  |
| Missing counterexample search |  |
| Fewer than 3 competitors examined without justification |  |
| Differentiation not tied to a competitor-gap EV- |  |
| Vendor marketing treated as fact |  |
| Anecdote or survey treated as market size |  |
| Regulatory claim without an official-doc source |  |
| Cost or free-tier claim without a current pricing page |  |

## Findings

Severity: P0 invalidates the report's verdict; P1 materially weakens a key
claim; P2 weakens a supporting claim; P3 minor. P0/P1 findings trigger one
revision round for the affected track, subject to the plan's caps.

| Finding ID | Severity | Report | EV-ID Or Section | Finding | Required Change |
|------------|----------|--------|------------------|---------|-----------------|
|  |  |  |  |  |  |

## Per-Report Verdicts

| Report | Verdict (accept, revise, reject) | Basis |
|--------|----------------------------------|-------|
|  |  |  |

## Release Statement

State whether synthesis may proceed, which reports it may use, and which
findings remain unresolved (unresolved P0 findings must surface as gaps in
the brief, never silently dropped).

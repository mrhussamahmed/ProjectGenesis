artifact_id: ART-BACKLOG-BOOT-RESEARCH-001
title: Research Orchestration Layer
type: backlog-item
status: in-progress
version: v1.0
created: 2026-06-11
updated: 2026-06-11
owner: AI Bootstrap Maintainers
source: GEN-18 research orchestration program (Linear HUS-236, approved plan 2026-06-11)
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true
item_type: feature
priority: P1
estimate: 8
labels: []
parent:
blocked_by: []
readiness: in-progress
tracker: {name: linear, id_or_url: "https://linear.app/hussamahmed/issue/HUS-236", evidence: "HUS-236 created 2026-06-11 with approved plan and baseline-correction comment"}

# BOOT-RESEARCH-001: Research Orchestration Layer

## Purpose

Add a controlled multi-agent research workflow to the first half of the
factory: a Research Planner inspects the raw idea, selects research depth and
tracks, runs one reusable Researcher per track, a fresh-context Research
Critic challenges every report, and a Research Synthesizer merges accepted
findings into a decision-ready research brief that only enters product
definition after explicit user approval. Research agents produce evidence,
never features.

## Scope

In scope: one new command (`COMMANDS/start-research.md`), five new roles
(research planner, researcher, research critic, research synthesizer, UX
designer), four research templates, a research context pack,
`01_context/UX_BRIEF.md`, downstream handoff updates (product, architecture,
UX, QA, backlog), validator and red-check support, scaffold-extract registry
rows. Out of scope: operation-routing profiles, governance and PR policies,
implementation-half commands, external tool integrations, Linear export
changes.

## Acceptance Criteria

- AC-1: `Start research` resolves through `COMMANDS/COMMAND_INDEX.md` to a
  command file that passes the validator's eight-section command check.
- AC-2: The five new role files load via `./SCRIPTS/start-claude.sh research`
  and `./SCRIPTS/start-claude.sh ux` (planner and UX designer) or via
  explicit role reads (researcher, critic, synthesizer), and all five are
  scanned by the green-merge regression guard.
- AC-3: The four research templates exist under `00_intake/research/` with
  full artifact frontmatter and no placeholder tokens.
- AC-4: An accepted research brief missing a `user approval` line or an
  `RCR-` critic reference fails `bash SCRIPTS/validate-bootstrap.sh`; a
  draft brief passes; both behaviors are covered by red-check cases.
- AC-5: All new framework files are pinned in `common_required_files`,
  registered in `ARTIFACT_REGISTRY.md`, classified in
  `TEMPLATE_MANIFEST.md`, and included in the scaffold-extract downstream
  registry.
- AC-6: The seeded-defect benchmark baseline is re-recorded for the new
  red-check case count.

## Dependencies

- none

## Test Expectations

- `bash SCRIPTS/validate-bootstrap.sh` (strict) passes.
- `bash SCRIPTS/validate-bootstrap-red-checks.sh` passes, including the four
  new research-brief cases.
- `bash SCRIPTS/run-seeded-defect-bench.sh` baseline refreshed and recorded.
- `bash -n SCRIPTS/start-claude.sh SCRIPTS/validate-bootstrap.sh
  SCRIPTS/validate-bootstrap-red-checks.sh SCRIPTS/scaffold-extract.sh`.
- `git diff --check origin/main...HEAD` clean.

## Definition Of Done

- [ ] Acceptance criteria satisfied; checks named in Test Expectations pass or
  deviations are justified.
- [ ] Frontmatter `readiness` updated; `BACKLOG/BACKLOG_INDEX.md` row mirrors it.
- [ ] One validation-evidence note recorded in the PR body.

## Links

- Linked spec: none; recurring bootstrap-governance exception in `PR_MERGE_POLICY.md`
- Source IDs: none
- Approved assumptions: none
- Open questions: none
- Related ADR: none

## Risks

- Validator changes are strict-protected; red checks and fresh-context
  adversarial review are mandatory before merge.
- New role and command wording must not reintroduce human-approval merge-gate
  language (green-merge regression guard).

## Readiness Evidence

- User value (1 sentence): downstream projects get evidence-backed product
  direction instead of shallow single-pass research.
- Measurable success criterion: acceptance criteria AC-1 through AC-6 pass
  with recorded validation evidence.
- Observability expectation: validator and red-check output recorded in the
  PR validation-evidence note.
- Security triggers checked (per SECURITY_AND_PRIVACY.md): n-a
- Spec status: none; recurring bootstrap-governance exception in `PR_MERGE_POLICY.md`
- Blocked until: none

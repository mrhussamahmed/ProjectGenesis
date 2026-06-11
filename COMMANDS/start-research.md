artifact_id: ART-COMMAND-START-RESEARCH
title: Start Research
type: command
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

# Start Research

## Purpose

Run the controlled multi-agent research pipeline: plan the research, execute
focused research tracks, challenge the findings, synthesize a decision-ready
research brief, and gate it on explicit user approval before product
definition consumes it. Research produces evidence — market facts,
competitor gaps, user needs, pain points, feasibility, regulatory and
platform constraints, costs and free-of-charge service options, risks,
unknowns, differentiation openings — never features. This command is
optional and may run as soon as raw input exists; `COMMANDS/validate-idea.md`
remains the lightweight tool for validating individual existing assumptions.

Recognized user triggers: `Start research`, `Run research orchestration`,
`Start research orchestration`.

## Required Role

- `memory/ai/ROLE_RESEARCH_PLANNER.md` (orchestrates)
- spawned per step: `memory/ai/ROLE_RESEARCHER.md`,
  `memory/ai/ROLE_RESEARCH_CRITIC.md`,
  `memory/ai/ROLE_RESEARCH_SYNTHESIZER.md`

## Required Files To Read

- `memory/ai/SHARED_AGENT_RULES.md`
- `memory/ai/ROLE_RESEARCH_PLANNER.md`
- `CONTEXT_INDEX.md`
- `OPERATION_ROUTING.md`
- `CONTEXT_PACKS/research.md`
- `00_intake/INTAKE_INDEX.md`
- `00_intake/SOURCE_REGISTRY.md`
- `01_context/PROJECT_BRIEF.md`
- `02_requirements/ASSUMPTIONS_REGISTER.md`
- `OPEN_QUESTIONS.md`
- the four research templates under `00_intake/research/`

## Inputs

- The user trigger, optionally naming a depth override, requested tracks, or
  the word `proceed` (which waives the standard-depth plan gate G1).
- Raw input under `00_intake/raw/`, or an idea stated in the trigger
  message.

## Workflow

1. Preflight. Classify the operation per `OPERATION_ROUTING.md` (research
   runs that write intake and context artifacts are `planning-governance`).
   Run `bash SCRIPTS/session.sh start planning-governance "start-research"`.
   Branch per `BRANCH_AND_WORKTREE_GUIDE.md`. If the idea exists only in
   chat, write it to `00_intake/raw/IDEA-<YYYY-MM-DD>-<slug>.md` and
   register it in `00_intake/SOURCE_REGISTRY.md` before planning.
2. Plan. Instantiate `00_intake/research/RESEARCH_PLAN_TEMPLATE.md` as
   `RESEARCH_PLAN-NNN.md` (NNN = next run number from existing plan files).
   Rate the six depth criteria; any high rating on regulatory exposure,
   data sensitivity, or monetary risk forces deep; all low permits quick;
   otherwise standard. A user override always wins and is recorded. Select
   tracks from the catalog below with rationale, record excluded tracks,
   and set two to five questions and source minimums per track. Competitor
   and problem-pain-validation tracks are default-on for standard and deep
   and may only be excluded with recorded rationale.
3. Gate G1 by depth. Quick: no wait; the plan is still written. Standard:
   present the plan and wait for user confirmation unless the trigger
   contained `proceed` (quote it in the plan's Gates table). Deep: explicit
   user approval of the plan is always required before any track runs.
4. Execute tracks. One `ROLE_RESEARCHER.md` invocation per selected track —
   parallel subagents when the runtime supports them, otherwise
   sequentially with each report written before the next track starts. Each
   researcher receives only the role file, its track section of the plan,
   and the inputs the plan names. Output: `RR-NNN-<track-slug>.md`.
5. Critic. A fresh-context `ROLE_RESEARCH_CRITIC.md` (separate session or
   subagent; same-session fallback per the role file) reviews the plan and
   all reports and writes `RCR-NNN.md`. P0/P1 findings trigger revision
   rounds within the caps: revisions ≤ min(3, tracks with P0/P1), allocated
   by severity then plan track order; denied revisions become gaps. In deep
   depth the critic verifies revised reports in a second pass. In quick
   depth this step moves after synthesis: the critic runs one consolidated
   pass over the draft brief and its cited evidence rows, the synthesizer
   fixes findings, and at most one researcher round covers
   evidence-affecting findings.
6. Synthesize. `ROLE_RESEARCH_SYNTHESIZER.md` merges the admitted reports
   into `RESEARCH_BRIEF-NNN.md` with frontmatter `status: draft`, every
   recommendation citing `RR-NNN-<track>/EV-MMM` evidence.
7. Integrate. Register each report and the brief in
   `00_intake/SOURCE_REGISTRY.md` (`research-report`, `research-brief`
   types; the registered SRC- IDs are checkable `verified external`
   evidence). Write assumption, risk, and open-question rows from the
   brief's candidates into `02_requirements/ASSUMPTIONS_REGISTER.md`,
   `02_requirements/RISK_REGISTER.md`, and `OPEN_QUESTIONS.md`, citing the
   SRC- IDs. Update the `00_intake/INTAKE_INDEX.md` status row.
8. Gate G2. Present the brief summary. Only explicit user approval flips
   the brief to `status: accepted`, recorded as
   `Approval: user approval - <name>, <date>` in the brief's Approval
   section. Downstream product definition consumes only accepted briefs.
9. Validate and record: `bash SCRIPTS/validate-bootstrap.sh`,
   `git diff --check`, the evidence envelope per `OPERATION_ROUTING.md`,
   and `.ai/SESSION.md` resume context.

Track catalog (the planner selects what the idea needs; no track is
mandatory): market-category, competitor, user-customer,
problem-pain-validation, technical-feasibility, regulatory-compliance,
platform-integration, monetization-business-model,
differentiation-positioning, ux-usability-patterns, operational-risk,
data-privacy-security, tooling-service-cost (cheapest or free-of-charge
services enabling productization).

Spawning caps: initial researcher invocations = selected tracks (max 9);
revision invocations ≤ min(3, tracks with P0/P1); total researcher
invocations ≤ 12; critic 1 (2 for deep); synthesizer 1. Spawned roles never
spawn further agents. No track is added mid-run without re-passing G1.

## Outputs

- `RESEARCH_PLAN-NNN.md`, one `RR-NNN-<track>.md` per track, `RCR-NNN.md`,
  and `RESEARCH_BRIEF-NNN.md` under `00_intake/research/`.
- SRC- rows for reports and brief; assumption, risk, and open-question rows
  citing them; an updated intake index row.
- Recorded G1/G2 gate evidence and the operation's evidence envelope.

## Stop Conditions

- No input idea exists and none is provided.
- Agent web research tools are unavailable: stop, record
  `research-unavailable`, and do not fabricate evidence or write a brief.
- The user rejects the research plan or the brief, or asked to skip
  research.
- The caps above would be exceeded.
- Research findings conflict with explicit user statements or with
  authoritative artifacts; ask instead of overriding.

## Validation

- validation mode from `OPERATION_ROUTING.md` (planning-governance)
- `bash SCRIPTS/validate-bootstrap.sh` (research-brief, source-registry,
  and assumption-evidence checks)
- `git diff --check`

## Authority Limit

This command is a workflow shortcut. Research output is evidence, not
product direction: feature derivation belongs to
`memory/ai/ROLE_PRODUCT_ANALYST.md` working from an accepted brief. The
command cannot approve its own brief, cannot create implementation
authority, and cannot override repository governance, approved or active
specs, accepted ADRs, `CONTEXT_INDEX.md`, selected role files,
`OPERATION_ROUTING.md`, `ARTIFACT_REGISTRY.md`, `TRACEABILITY_MATRIX.md`,
`CURRENT_STATE.md`, or `AI_HANDOFF.md`.

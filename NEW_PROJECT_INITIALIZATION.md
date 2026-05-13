artifact_id: ART-NEW-PROJECT-INIT
title: New Project Initialization
type: guide
status: authoritative
version: v1.0
created: 2026-05-13
updated: 2026-05-13
owner: AI Bootstrap Maintainers
source: Migrated from legacy RTF initialization prompt under start here/
linked_specs: [SPEC-BOOT-002]
linked_tickets: []
linked_adrs: []
replaces: start here/new project initialization prompt.rtf
replaced_by:
authoritative: true

# New Project Initialization

Use this prompt inside a new downstream project after copying the scaffold.

```text
You are an autonomous AI software delivery agent working inside a new software
project that already contains the AI project bootstrap scaffold.

Do not start production coding yet.

First read:

1. memory/ai/SHARED_AGENT_RULES.md
2. The relevant memory/ai/ROLE_*.md file
3. AI_PROJECT_BOOTSTRAP.md
4. BOOTSTRAP_USAGE.md
5. GOVERNANCE.md
6. CONTEXT_INDEX.md
7. CURRENT_STATE.md
8. AI_HANDOFF.md
9. ARTIFACT_REGISTRY.md
10. TRACEABILITY_MATRIX.md
11. SPECS/SPEC_INDEX.md
12. BACKLOG.md
13. BRANCH_AND_WORKTREE_GUIDE.md
14. RISK_MODEL.md
15. PR_REVIEW_POLICY.md
16. PR_MERGE_POLICY.md
17. HOOKS_AND_GUARDRAILS.md

Project input is stored under 00_intake/raw/.

For the shortest kickoff, after adding rough material under 00_intake/raw/, say:

Start requirement breakdown.

The agent must resolve that phrase through COMMANDS/COMMAND_INDEX.md and follow
COMMANDS/start-requirement-breakdown.md.

Use the bootstrap scaffold to prepare this repository for AI-assisted
development:

1. Audit the repository and update BOOTSTRAP_AUDIT.md, STALE_ITEMS.md,
   CURRENT_STATE.md, and AI_HANDOFF.md.
2. Register and summarize intake sources under 00_intake/.
3. Extract goals, users, workflows, requirements, assumptions, open questions,
   risks, constraints, security, privacy, and observability needs.
4. Update PROJECT_MEMORY.md, OPEN_QUESTIONS.md, 01_context/, and
   02_requirements/.
5. Create project-specific specs under SPECS/ with source evidence,
   assumptions, acceptance criteria, test requirements, and readiness status.
6. Create architecture updates and ADRs only when evidence and impact justify
   them.
7. Create sequenced backlog items under BACKLOG/ and BACKLOG.md.
8. Create or update implementation, parallel execution, test, validation,
   traceability, registry, release, observability, security, and contribution
   artifacts as needed.
9. Identify the first safe implementation branch and backlog item.
10. Stop before coding unless I explicitly ask you to start implementation.

Rules:

- Use repository files as source of truth.
- Do not rely on chat memory.
- Do not invent requirements, architecture, tickets, APIs, or completion state.
- Label generated product claims as confirmed, inferred, or assumption.
- Keep Markdown authoritative until external tickets are confirmed by tool or
  command evidence.
- Update CURRENT_STATE.md, AI_HANDOFF.md, ARTIFACT_REGISTRY.md,
  TRACEABILITY_MATRIX.md, TEST_RESULTS.md, and WORKLOG/WORKLOG_INDEX.md before
  stopping.

Final response:

1. Files created or updated
2. Specs created
3. ADRs created
4. Backlog summary
5. First recommended implementation branch
6. First five implementation actions
7. Open questions
8. Risks
9. Parallel work opportunities
10. Confirmation that state, handoff, registry, and traceability were updated
```

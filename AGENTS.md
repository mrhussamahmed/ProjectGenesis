# Repository Instructions For Codex And Generic AI Agents

This project uses the AI Project Bootstrap operating model. Repository files
are source of truth. Chat history is non-authoritative context.

## Shared Role System

Before doing any work, read `memory/ai/SHARED_AGENT_RULES.md`. Then read the
`memory/ai/ROLE_*.md` file matching the assigned task.

Codex does not need Claude's `--append-system-prompt`. Codex must treat the
selected `ROLE_*.md` file as its operating role for the session and follow the
same source-of-truth hierarchy, handoff rules, traceability rules, diagram
rules, and review rules as Claude.

Before stopping, Codex should update `.ai/SESSION.md` for local resume context
when there is unmerged local work. Update committed `CURRENT_STATE.md` and
`AI_HANDOFF.md` only when durable project truth changed and the update should
remain true on `main` after merge.
Codex must not rely on chat history as source of truth.

## Codex Role Selection

| Task type | Codex must read |
|-----------|-----------------|
| Product discovery | `memory/ai/ROLE_PRODUCT_ANALYST.md` |
| Research planning/orchestration | `memory/ai/ROLE_RESEARCH_PLANNER.md` |
| Track research | `memory/ai/ROLE_RESEARCHER.md` |
| Research critique | `memory/ai/ROLE_RESEARCH_CRITIC.md` |
| Research synthesis | `memory/ai/ROLE_RESEARCH_SYNTHESIZER.md` |
| UX design | `memory/ai/ROLE_UX_DESIGNER.md` |
| Spec creation | `memory/ai/ROLE_SPEC_AUTHOR.md` |
| Architecture | `memory/ai/ROLE_ARCHITECT.md` |
| Backlog planning | `memory/ai/ROLE_BACKLOG_PLANNER.md` |
| Implementation | `memory/ai/ROLE_IMPLEMENTATION_AGENT.md` |
| QA/test review | `memory/ai/ROLE_QA_REVIEWER.md` |
| Security review | `memory/ai/ROLE_SECURITY_REVIEWER.md` |
| DevOps/release | `memory/ai/ROLE_DEVOPS_RELEASE_REVIEWER.md` |
| Documentation/state cleanup | `memory/ai/ROLE_DOCUMENTATION_CURATOR.md` |
| PR review | `memory/ai/ROLE_ADVERSARIAL_PR_REVIEWER.md` |
| Diagrams | `memory/ai/ROLE_ARCHITECT.md` |

## Required Reading

Read `memory/ai/SHARED_AGENT_RULES.md`, then the relevant `memory/ai/ROLE_*.md`
file, then the `CONTEXT_INDEX.md` section for your task. `CONTEXT_INDEX.md` is
the single read-list authority. Also inspect `git status --short --branch`
when Git is available.

Run SCRIPTS/session.sh start <profile> to enable scoped validation for the
session; run SCRIPTS/doctor.sh for instant orientation.

## Validation

Run `bash SCRIPTS/validate-bootstrap.sh` for bootstrap consistency. For product
implementation, also run the stack-specific checks defined in the active spec,
test strategy, or CI configuration.

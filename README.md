artifact_id: ART-README
title: ProjectGenesis README
type: public-readme
status: active
version: v1.0
created: 2026-05-13
updated: 2026-05-13
owner: ProjectGenesis Maintainers
source: Public repository publication request
linked_specs: [SPEC-BOOT-002]
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# ProjectGenesis

ProjectGenesis is a reusable, AI-native software delivery scaffold. It gives
AI coding agents a shared operating model for turning rough ideas into
traceable requirements, specs, backlog items, architecture decisions, validation
plans, review records, and release-ready handoffs.

The project is intentionally plain Markdown first. It is designed to work across
Codex, Claude, Gemini, and other agents without relying on one vendor's memory,
chat history, or hidden prompt state.

## What Problem It Solves

AI-assisted development often breaks down when agents:

- invent requirements or architecture from weak context
- forget decisions across sessions
- repeat repository discovery work
- make large unreviewable changes
- ignore existing project conventions
- skip validation or handoff updates
- create specs, backlog, tests, and reviews that do not trace back to evidence

ProjectGenesis reduces those risks by putting project truth in versioned files.
Agents are expected to read the same context, follow the same roles, update the
same state files, and leave evidence for every meaningful decision.

## Core Ideas

- Repository files are source of truth. Chat history is context only.
- Product intake is evidence-linked from raw source material.
- Requirements are confirmed, inferred, or assumptions.
- Important requirements must trace to sources or approved assumptions.
- Architecture decisions use ADRs when they are high-impact.
- Implementation waits until a task satisfies Definition of Ready.
- Reviews use fresh context and repository evidence, not implementer memory.
- Handoffs are written to files so another agent can resume later.
- Commands are reusable workflow shortcuts, not hidden governance.

## Repository Structure

Important folders and files include:

| Path | Purpose |
|------|---------|
| `00_intake/raw/` | Drop raw project notes, PRDs, screenshots, exports, rough ideas, and references here. |
| `00_intake/SOURCE_REGISTRY.md` | Assigns stable source IDs such as `SRC-001`. |
| `00_intake/summaries/` | Stores source summaries created during intake. |
| `01_context/` | Product brief, charter, glossary, and constraints. |
| `02_requirements/` | Requirements, assumptions, and risk registers. |
| `SPECS/` | Product, feature, spike, and implementation specs. |
| `ADR/` | Architecture decision records. |
| `BACKLOG/` and `BACKLOG.md` | Detailed and summary backlog planning. |
| `CONTEXT_PACKS/` | Scoped read manifests for common tasks. |
| `COMMANDS/` | Reusable workflow command prompts. |
| `REVIEWS/` | Review records and PR review packages. |
| `TESTS/` | Acceptance maps and manual validation checklists. |
| `memory/ai/` | Shared role definitions for AI agents. |

## Quick Start

1. Copy this scaffold into a new project repository or use this repository as a
   template.
2. Put rough project material under `00_intake/raw/`.
3. Ask your AI agent:

   ```text
   Start requirement breakdown.
   ```

4. The agent should resolve that phrase through `COMMANDS/COMMAND_INDEX.md` and
   run `COMMANDS/start-requirement-breakdown.md`.
5. Review the generated product context, requirements, assumptions, risks, open
   questions, backlog candidates, draft specs, and readiness classification.
6. Do not start implementation until the relevant task satisfies Definition of
   Ready in `AI_PROJECT_BOOTSTRAP.md`.

## The Main Intake Command

The primary shortcut is:

```text
Start requirement breakdown.
```

That command asks the agent to:

- register raw sources
- summarize source material
- extract and label requirements
- record assumptions, risks, and open questions
- generate product context
- create backlog candidates
- create draft specs only when appropriate
- identify architecture or ADR candidates
- map acceptance criteria and validation needs
- update traceability and handoff files
- run scaffold validation
- classify the project as intake-incomplete, discovery-ready, spec-draft-ready,
  backlog-draft-ready, implementation-blocked, or implementation-ready

## How Agents Should Work

Before meaningful work, agents should read:

1. `AGENTS.md` or `CLAUDE.md`
2. `memory/ai/SHARED_AGENT_RULES.md`
3. the relevant `memory/ai/ROLE_*.md` file
4. `CONTEXT_INDEX.md`
5. `CURRENT_STATE.md`
6. `AI_HANDOFF.md`
7. `ARTIFACT_REGISTRY.md`
8. `TRACEABILITY_MATRIX.md`
9. relevant specs, ADRs, backlog items, tests, and reviews

Agents must not treat chat history as durable truth. If facts matter, they
belong in repository artifacts.

## Quality Gates

ProjectGenesis expects:

- source-linked requirements
- explicit assumptions and expiry/review status
- open questions for unclear or conflicting material
- specs before implementation
- backlog items linked to specs or discovery tasks
- test expectations before coding
- traceability from source to requirement to spec to backlog to test/review
- fresh-context adversarial review before merge
- validation results recorded in `TEST_RESULTS.md`
- updated `CURRENT_STATE.md` and `AI_HANDOFF.md` before stopping

Run the baseline validator with:

```sh
bash SCRIPTS/validate-bootstrap.sh
```

For validator rule checks:

```sh
bash SCRIPTS/validate-bootstrap-red-checks.sh
```

## GitHub Repository Controls

This public repository is intended to be governed through pull requests.
Maintainers should protect the `main` branch so changes cannot be merged without
review.

Recommended GitHub settings:

- require pull requests before merging into `main`
- require at least one approval
- require review from Code Owners
- dismiss stale approvals after new commits
- require conversation resolution
- require the `validate` GitHub Actions job to pass after the workflow exists
  on `main`
- disallow force pushes and branch deletion
- keep `.github/CODEOWNERS` assigning ownership of all files to the maintainer

See `GITHUB_REPOSITORY_SETUP.md` for setup commands and verification steps.

## Requirements

ProjectGenesis itself is mostly Markdown and shell. To use the scaffold, you
need:

- Git
- Bash
- an AI coding agent that can read and edit repository files
- optional: GitHub Actions for CI validation
- optional: GitHub CLI for repository setup and branch protection

No application framework, package manager, database, or cloud provider is
selected by default.

## Strengths

- Works across different AI agents and sessions.
- Keeps project truth in versioned files.
- Makes hallucinated requirements harder to introduce.
- Preserves source evidence and decisions.
- Encourages small, reviewable implementation slices.
- Supports future automation without requiring it upfront.

## Limitations

- It is a scaffold, not an autonomous project manager.
- It cannot make unclear product direction clear without user input.
- It depends on agents actually reading and following the repository rules.
- It does not enforce GitHub branch protection by itself; repository settings
  must be configured on GitHub.
- It does not choose your product architecture, stack, database, hosting, or
  external tools.
- It can feel heavier than necessary for very small experiments unless you use
  the process pragmatically.

## Contribution Policy

Public contributions should come through pull requests. Direct changes to
`main` should be blocked by repository settings except for maintainer-controlled
administrative cases.

Before opening a PR:

1. Read `CONTRIBUTING.md`.
2. Link your change to a spec, backlog item, ADR, or documented discovery task.
3. Keep the change scoped.
4. Run `bash SCRIPTS/validate-bootstrap.sh`.
5. Update affected state, registry, traceability, and test-result files.
6. Provide review evidence under `REVIEWS/` when required.

## License

ProjectGenesis is licensed under the GNU Affero General Public License v3.0.
See `LICENSE` for the full license text.

AGPLv3 is a strong copyleft license. If you modify and run a covered network
service based on this project, review the license obligations carefully. This
README is not legal advice.

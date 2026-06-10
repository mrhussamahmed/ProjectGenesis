artifact_id: ART-README
title: ProjectGenesis README
type: public-readme
status: active
version: v2.0
created: 2026-05-13
updated: 2026-06-10
owner: ProjectGenesis Maintainers
source: Public repository publication, tooling prerequisite documentation, public positioning, public launch asset links, Phase 0 validator-scope restoration, v0.2.0 public alpha release notes, BOOT-GREEN-MERGE-001 AI green-merge, and GEN-01 canonical quickstart
linked_specs: [SPEC-BOOT-002]
linked_tickets: [BOOT-GREEN-MERGE-001]
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# ProjectGenesis

Build with AI speed without losing project control.

ProjectGenesis is a reusable, AI-native software delivery scaffold for founders,
solo builders, vibe coders, product teams, and engineering teams who want AI
agents to help plan and build software without turning rough ideas into
unverifiable guesses.

Latest release: [ProjectGenesis v0.2.0 Public Alpha](https://github.com/mrhussamahmed/ProjectGenesis/releases/tag/v0.2.0-public-alpha).
This release adds a clean scaffold boundary, moves maintainer history out of
the active required-reading path, shrinks inherited AI context, and adds an
adaptive fast-path validator for small process-light changes while keeping
strict checks for protected files.

See [RELEASE_NOTES.md](RELEASE_NOTES.md) for release history.

Drop messy notes, rough product ideas, customer feedback, screenshots, research,
or early specs into the scaffold. ProjectGenesis gives your AI agent a governed
process for turning that material into product context, evidence-linked
requirements, assumptions, risks, open questions, specs, backlog candidates,
architecture decision records, validation plans, review records, and handoffs.

The outcome is not blind trust in AI. The outcome is an auditable project
workspace where important claims trace back to source material, unclear input is
marked as an assumption or open question, and implementation does not start
until the work is ready enough to review and validate.

The project is intentionally plain Markdown first. It works across Codex,
Claude, Gemini, and other agents without depending on one vendor's memory, chat
history, or hidden prompt state.

## What ProjectGenesis Gives You

| Capability | What It Does |
|------------|--------------|
| Rough idea intake | Turns incomplete notes and early ideas into structured product understanding without pretending every idea is confirmed. |
| Product foundation | Creates and maintains product briefs, charters, value propositions, target users, workflows, constraints, and success metrics. |
| Evidence-linked requirements | Tracks requirements back to source IDs, approved assumptions, risks, and open questions. |
| Backlog breakdown | Produces epics, features, user stories, spikes, validation tasks, and architecture decision tasks that are ready to refine or export. |
| Spec-first delivery | Encourages draft specs before implementation and blocks coding when critical requirements are unclear. |
| Architecture governance | Captures high-impact decisions as ADR candidates or ADRs with evidence, options, trade-offs, and approval status. |
| Multi-agent continuity | Gives Codex, Claude, Gemini, and future agents the same source-of-truth files, roles, handoffs, review records, and task state. |
| Anti-hallucination controls | Uses source registries, confidence levels, assumptions registers, traceability, readiness gates, and adversarial reviews. |
| Test and validation planning | Maps acceptance criteria, expected test types, manual validation, edge cases, and release readiness. |
| External tool readiness | Supports GitHub governance, optional Linear backlog storage, and optional GitHub Spec Kit integration without making them mandatory. |

## Who It Is For

ProjectGenesis is useful when you want AI to move fast, but you still need a
record of what was decided, why it was decided, what remains uncertain, and what
must be true before code is written.

It is especially useful for:

- AI-first builders who start with rough ideas and want a stronger path to
  implementation
- founders and solo builders who need structure without a full product team
- engineers who want AI agents to follow the same project truth across sessions
- teams that want requirements, backlog, architecture, testing, reviews, and
  handoffs to stay synchronized

It is not a replacement for product judgment, engineering review, security
review, user research, or legal review. It gives those activities a place to
live and a process agents can follow.

## How It Works

1. You drop raw material into `00_intake/raw/`.
2. You ask an agent to run:

   ```text
   Start requirement breakdown.
   ```

3. The agent registers sources, assigns stable source IDs, and summarizes the
   material.
4. The agent expands rough ideas into product context while labeling claims as
   confirmed, inferred, or assumption.
5. The agent extracts requirements, risks, open questions, specs, backlog
   candidates, architecture concerns, acceptance criteria, and validation needs.
6. Reviewers or fresh-context agents challenge the output before it is treated
   as ready.
7. Implementation begins only after the relevant work satisfies Definition of
   Ready and the source-of-truth files are updated.

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
| `BACKLOG/` | Backlog items; `BACKLOG/BACKLOG_INDEX.md` is the status truth. |
| `CONTEXT_PACKS/` | Scoped read manifests for common tasks. |
| `COMMANDS/` | Reusable workflow command prompts. |
| `REVIEWS/` | Review records and PR review packages. |
| `TESTS/` | Acceptance maps and manual validation checklists. |
| `memory/ai/` | Shared role definitions for AI agents. |
| `TEMPLATE_MANIFEST.md` | Defines which files are copied, reset, excluded, or treated as maintainer archive when creating a clean scaffold. |
| `TEMPLATE_STARTERS/` | Starter-reset content for new downstream projects. |
| `MAINTAINER_ARCHIVE/` | ProjectGenesis maintainer history kept out of the active required-reading path. |
| `RELEASE_NOTES.md` | Release history and operational changes. |

## Quick Start

1. Extract a clean scaffold into your new project:

   ```sh
   bash SCRIPTS/scaffold-extract.sh --apply <target-directory>
   ```

   or copy manually following the manifest-mediated rules in
   `TEMPLATE_MANIFEST.md`.
2. Drop messy input (notes, PRDs, exports, screenshots, rough ideas) into
   `00_intake/raw/`. Raw intake files are validation-exempt by design.
3. Tell your AI agent:

   ```text
   Start requirement breakdown.
   ```

4. Validate:

   ```sh
   bash SCRIPTS/validate-bootstrap.sh
   ```

For the full initialization prompt, see `NEW_PROJECT_INITIALIZATION.md`. For
agent prompt recipes, see `BOOTSTRAP_USAGE.md`. For a worked example, see
`examples/simple-saas-demo/`. Do not start implementation until the relevant
task satisfies Definition of Ready in `AI_PROJECT_BOOTSTRAP.md`.

Keep the master scaffold clean: project-specific requirements, specs, ADRs,
backlog items, source files, and customer context belong in the downstream
project repository. Do not copy them back into this reusable scaffold unless
they improve the generic operating model.


## The Main Intake Command

The primary shortcut is:

```text
Start requirement breakdown.
```

Agents resolve that phrase through `COMMANDS/COMMAND_INDEX.md` and run
`COMMANDS/start-requirement-breakdown.md`: register and summarize sources,
extract labeled requirements, record assumptions, risks, and open questions,
build product context and backlog candidates, draft specs when appropriate,
and classify project readiness (from intake-incomplete to
implementation-ready).

## How Agents Should Work

Agents start from `AGENTS.md` or `CLAUDE.md`, read
`memory/ai/SHARED_AGENT_RULES.md` and the relevant `memory/ai/ROLE_*.md` file,
then follow the `CONTEXT_INDEX.md` section for the task. `CONTEXT_INDEX.md` is
the single read-list authority; no other file enumerates required reading.

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
- review depth routed by operation profile (`OPERATION_ROUTING.md` and
  `PR_REVIEW_POLICY.md`): self-check for low-risk docs/state changes,
  fresh-context adversarial review for planning-governance and
  strict-protected changes
- one validation-evidence note per PR; durable state files updated only when
  durable truth changed

Run the baseline validator with:

```sh
bash SCRIPTS/validate-bootstrap.sh
```

For validator rule checks:

```sh
bash SCRIPTS/validate-bootstrap-red-checks.sh
```

## GitHub Repository Controls

This public repository is governed through pull requests. The `main` branch is
protected by objective status-check enforcement, not by human/maintainer/Code
Owner approval gates. AI may merge after required CI/status checks pass,
required local validation passes, scope is clean, and no P0/P1/blocking P2
findings remain. See `PR_MERGE_POLICY.md` for the green-merge contract.

Recommended GitHub settings:

- require the `validate` GitHub Actions status check to pass once the workflow exists on `main`
- leave `required_pull_request_reviews` disabled — do not require approving reviews on `main`
- leave `require_code_owner_reviews` disabled — do not require Code Owner review on `main`
- leave `required_approving_review_count` at 0 — no approving review is required
- conversation resolution before merge is optional but recommended
- disallow force pushes and branch deletion
- keep `.github/CODEOWNERS` as informational ownership only; do not wire it up as a required-review gate

See `GITHUB_REPOSITORY_SETUP.md` for setup commands and verification steps.

## External Backlog Storage

Local Markdown is the default backlog source of truth
(`BACKLOG/BACKLOG_INDEX.md` plus item files under `BACKLOG/`). External
trackers are optional. Markdown remains authoritative until a real external
issue ID or URL is recorded.

### Supported External Tracker: Linear

Linear is the recommended external backlog store when you want a team-facing
issue tracker. Setup:

1. Create or choose a Linear workspace, the team that will own the issues, and
   optionally a project for the product or release.
2. Configure workflow statuses (`Backlog`, `Todo`, `In Progress`, `In Review`,
   `Done`) and labels matching the scaffold vocabulary (`type:<item_type>`,
   `status:blocked`, `risk:high`).
3. Connect the agent to Linear. For Codex:
   `codex mcp add linear --url https://mcp.linear.app/mcp`, then
   `codex mcp login linear`. For other agents, use the official Linear
   connector or MCP setup. Do not commit API keys, tokens, OAuth credentials,
   or exported private Linear data.

Field mapping from scaffold backlog items to Linear:

| Scaffold field | Linear |
|----------------|--------|
| priority `P0` / `P1` / `P2` / `P3` | `Urgent` / `High` / `Medium` / `Low` |
| readiness `not-ready` | `Backlog` |
| readiness `ready` | `Todo` |
| readiness `in-progress` | `In Progress` |
| readiness `in-review` | `In Review` |
| readiness `done` | `Done` |
| readiness `blocked` | label `status:blocked` |
| estimate `1` / `2` / `3` / `5` / `8` | Linear points |
| `item_type` and high risk | labels `type:<item_type>`, `risk:high` |

Export workflow and operating rules: `COMMANDS/export-backlog-to-linear.md`.

## Optional Spec Kit Integration

ProjectGenesis is already spec-first and does not require GitHub Spec Kit. Use
Spec Kit only when you want its external specification-driven development CLI,
templates, or agent commands for a downstream project.

Official Spec Kit reference:

- [github/spec-kit](https://github.com/github/spec-kit)

If you adopt Spec Kit:

- install only from the official `github/spec-kit` repository
- pin a release for repeatability when possible
- review generated files before accepting them
- register generated or adopted artifacts in `ARTIFACT_REGISTRY.md`
- keep ProjectGenesis source-of-truth rules in force unless an approved
  migration spec says otherwise

The official Spec Kit CLI can be installed with `uv`:

```sh
uv tool install specify-cli --from git+https://github.com/github/spec-kit.git
specify version
```

One-time use is also possible:

```sh
uvx --from git+https://github.com/github/spec-kit.git specify init .
```

Do not run `specify init` blindly in an established ProjectGenesis repository.
First decide whether Spec Kit should create separate `.specify/` artifacts,
augment the existing `SPECS/` and `COMMANDS/` workflow, or be skipped for that
project. If Spec Kit creates overlapping specs, tasks, or command files, treat
that as a governance decision and reconcile it before implementation.

## Requirements

ProjectGenesis itself is mostly Markdown and shell. To use the scaffold, you
need:

- Git
- Bash
- an AI coding agent that can read and edit repository files
- GitHub, if you want hosted collaboration, branch protection, pull requests,
  and GitHub Actions validation
- optional: GitHub CLI for repository setup and branch protection
- optional: Linear workspace and MCP or connector access for external backlog
  storage
- optional: Spec Kit CLI if you intentionally adopt Spec Kit for a downstream
  project
- optional: document conversion tools if your intake material includes PDFs,
  slides, spreadsheets, screenshots, or exported documents that agents cannot
  read directly

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
5. Record one validation-evidence note in the PR body; update durable state,
   registry, or traceability files only when durable truth changed.
6. Provide review evidence under `REVIEWS/` when the operation profile
   requires it.

## License

ProjectGenesis is licensed under the GNU Affero General Public License v3.0.
See `LICENSE` for the full license text.

AGPLv3 is a strong copyleft license. If you modify and run a covered network
service based on this project, review the license obligations carefully. This
README is not legal advice.


# ProjectGenesis

Build with AI speed without losing project control.

ProjectGenesis is a reusable, AI-native software delivery scaffold for founders,
solo builders, vibe coders, product teams, and engineering teams who want AI
agents to help plan and build software without turning rough ideas into
unverifiable guesses.

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
6. If you want backlog items stored in Linear, complete the Linear setup in
   [External Backlog Storage](#external-backlog-storage) before asking an agent
   to create external tickets.
7. Do not start implementation until the relevant task satisfies Definition of
   Ready in `AI_PROJECT_BOOTSTRAP.md`.

## Public Launch And Examples

- `examples/simple-saas-demo/` shows an illustrative small SaaS intake.
- `docs/demo/60-second-demo-script.md` provides a short screen-recording script.
- `docs/public_launch_checklist.md` lists manual GitHub launch steps.
- `docs/token_efficiency_guidance.md` explains scoped context use without
  bypassing governance.

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

## External Backlog Storage

ProjectGenesis always works with local Markdown backlog files:

- `BACKLOG.md`
- `BACKLOG/BACKLOG_INDEX.md`
- detailed files under `BACKLOG/` when useful

Those files are the default backlog source of truth. External trackers are
optional. Do not claim external tickets exist until an integration, CLI, API, or
human-confirmed URL proves they exist.

### Supported External Tracker: Linear

Linear is the recommended external backlog store when you want a team-facing
issue tracker. Use it for confirmed or ready backlog items, not as a substitute
for intake evidence, specs, assumptions, or traceability.

Useful Linear references:

- [Linear MCP server setup](https://linear.app/docs/mcp)
- [Linear issue creation](https://linear.app/docs/creating-issues)
- [Linear projects](https://linear.app/docs/projects)
- [Linear issue statuses](https://linear.app/docs/configuring-workflows)
- [Linear labels](https://linear.app/docs/labels)

Before asking an agent to create Linear issues, prepare Linear:

1. Create or choose a Linear workspace.
2. Create or choose the Linear team that will own the issues. Linear issues are
   always linked to a single team and require a title and status.
3. Create a Linear project for the downstream product or release if the work
   should be grouped under one delivery outcome.
4. Configure team workflow statuses. The default Linear flow is
   `Backlog`, `Todo`, `In Progress`, `Done`, and `Canceled`; add statuses such
   as `In Review` or `Ready to Merge` only if your team will use them.
5. Create issue labels or label groups that match the scaffold vocabulary. A
   practical starting set is:
   - `type:epic`
   - `type:feature`
   - `type:story`
   - `type:spike`
   - `type:validation`
   - `status:blocked`
   - `source:assumption`
   - `risk:high`
6. Optionally create issue templates for epics, stories, spikes, validation
   tasks, and architecture decision tasks. Templates should include fields for
   requirement IDs, source IDs, assumptions, risks, acceptance criteria, test
   expectations, and definition of done.
7. Decide who may create or update Linear issues: human only, agent with review,
   or agent direct after approval.
8. Connect the AI agent to Linear.

For Codex, Linear's MCP setup uses:

```sh
codex mcp add linear --url https://mcp.linear.app/mcp
```

If this is the first MCP server configured for Codex, enable the remote MCP
client in `~/.codex/config.toml`:

```toml
[features]
experimental_use_rmcp_client = true
```

Then authenticate:

```sh
codex mcp login linear
```

For other agents, use the official Linear connector or MCP setup for that
agent. Do not commit API keys, tokens, OAuth credentials, or exported private
Linear data to this repository.

### Linear Operating Rules

- Markdown remains authoritative until a real Linear issue ID or URL is
  recorded.
- Every Linear issue created from ProjectGenesis should link back to local
  requirements, source IDs, assumptions, specs, and acceptance criteria.
- After creating or updating Linear issues, update `BACKLOG.md`,
  `BACKLOG/BACKLOG_INDEX.md`, and `TRACEABILITY_MATRIX.md`.
- If Linear is not configured, agents must keep backlog candidates in Markdown.
- If Linear data conflicts with repository source-of-truth files, pause and
  record the conflict in `STALE_ITEMS.md` or `OPEN_QUESTIONS.md`.

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
5. Update affected state, registry, traceability, and test-result files.
6. Provide review evidence under `REVIEWS/` when required.

## License

ProjectGenesis is licensed under the GNU Affero General Public License v3.0.
See `LICENSE` for the full license text.

AGPLv3 is a strong copyleft license. If you modify and run a covered network
service based on this project, review the license obligations carefully. This
README is not legal advice.

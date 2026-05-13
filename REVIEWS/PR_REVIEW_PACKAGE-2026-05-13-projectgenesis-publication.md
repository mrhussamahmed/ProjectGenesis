artifact_id: ART-PR-PACKAGE-PROJECTGENESIS-PUBLICATION
title: ProjectGenesis Public Repository Publication Review Package
type: pr-review-package
status: active
version: v1.0
created: 2026-05-13
updated: 2026-05-13
owner: AI Bootstrap Maintainers
source: Public repository publication request
linked_specs: []
linked_tickets: [BOOT-016]
linked_adrs: []
replaces:
replaced_by:
authoritative: false

# ProjectGenesis Public Repository Publication Review Package

## Scope

Prepare the scaffold for publication to
`https://github.com/mrhussamahmed/ProjectGenesis.git` as a public repository
under GNU Affero General Public License v3.0.

## User Request

- Create a public README explaining what ProjectGenesis is, how to use it,
  requirements, strengths, limitations, and license reference.
- Use GNU Affero General Public License v3.0.
- Configure the repository so changes cannot reach `main` without maintainer
  review and acceptance.

## Intended Changes

- Add `README.md` as the public project entrypoint.
- Add `LICENSE` with the AGPLv3 license text from the target GitHub repository.
- Add `.github/CODEOWNERS` assigning all paths to `@mrhussamahmed`.
- Add `GITHUB_REPOSITORY_SETUP.md` documenting branch protection and
  publication setup.
- Add BOOT-016 to `BACKLOG.md`.
- Update registry, traceability, state, handoff, test results, worklog, and
  review index artifacts.
- Push a feature branch and open a pull request instead of writing directly to
  `main`.

## Out Of Scope

- Product implementation.
- New automation beyond GitHub repository controls.
- Legal advice about AGPLv3 obligations.
- Direct merge to `main` without owner review.

## Review Focus

Reviewers should check:

- README clarity for public users.
- Accuracy of usage instructions against the scaffold structure.
- License reference consistency.
- GitHub branch protection guidance and Code Owner setup.
- Whether public publication work is traceable through backlog, registry,
  review package, state, and handoff files.
- Whether the PR avoids staging unrelated local changes.

## Known Dirty Worktree Items

The following legacy RTF deletions existed before publication staging and are
outside this PR scope unless the maintainer explicitly asks to include them:

- `start here/Project starting instruction tips.rtf`
- `start here/new project initialization prompt.rtf`

## Planned Validation

- `bash SCRIPTS/validate-bootstrap.sh`
- `bash SCRIPTS/validate-bootstrap-red-checks.sh`
- `git diff --check`
- `bash -n SCRIPTS/validate-bootstrap.sh && bash -n SCRIPTS/validate-bootstrap-red-checks.sh`
- `gh auth status`
- `gh repo view mrhussamahmed/ProjectGenesis`

## Publication Strategy

Use a feature branch and pull request for the public rollout. Configure branch
protection so future changes to `main` require pull requests and maintainer
review. Required status checks can be tightened after the validation workflow
exists on the default branch.

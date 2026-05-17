artifact_id: ART-GITHUB-REPOSITORY-SETUP
title: GitHub Repository Setup
type: repository-setup
status: active
version: v1.3
created: 2026-05-13
updated: 2026-05-18
owner: ProjectGenesis Maintainers
source: Public repository publication request and BOOT-GREEN-MERGE-001
linked_specs: []
linked_tickets: [BOOT-GREEN-MERGE-001]
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# GitHub Repository Setup

This guide records the GitHub settings needed to publish ProjectGenesis while
keeping changes to `main` gated by required CI/status checks and the
adversarial defect-detection review described in `PR_REVIEW_POLICY.md`.

Per `PR_MERGE_POLICY.md`, human, maintainer, and Code Owner approval are not
required as merge gates. AI may merge after objective gates pass.

## Target Repository

- Repository: `mrhussamahmed/ProjectGenesis`
- URL: `https://github.com/mrhussamahmed/ProjectGenesis`
- Visibility: public
- License: GNU Affero General Public License v3.0

## Required Repository Controls

Configure the `main` branch so changes go through pull requests with objective
status-check enforcement and no human/maintainer/Code Owner approval gates:

- enable required status checks and add the `validate` status check from GitHub Actions once `.github/workflows/bootstrap-validation.yml` exists on `main`
- leave `required_pull_request_reviews` disabled — do not require approving reviews on `main`
- leave `require_code_owner_reviews` disabled — do not require Code Owner review on `main`
- leave `required_approving_review_count` at 0 — do not require any approving review on `main`
- leave `required_conversation_resolution` disabled — conversation-resolution enforcement is a soft-gate surface that can block AI merge on non-blocking PR comments, so it is excluded from the green-merge objective gates
- disallow force pushes
- disallow branch deletion

`.github/CODEOWNERS` is informational only. It signals area knowledge; it must not be wired up as a required-review gate. See the header comment in `.github/CODEOWNERS`.

## GitHub CLI Setup

Prerequisites:

- GitHub CLI installed
- authenticated GitHub account with repository admin rights
- repository already created on GitHub

Check authentication:

```sh
gh auth status
```

Set the remote:

```sh
git remote add origin https://github.com/mrhussamahmed/ProjectGenesis.git
```

If the remote already exists:

```sh
git remote set-url origin https://github.com/mrhussamahmed/ProjectGenesis.git
```

Protect `main` with the classic branch protection API. The PR-review section
is intentionally omitted because no approving review is required:

```sh
gh api \
  --method PUT \
  repos/mrhussamahmed/ProjectGenesis/branches/main/protection \
  --input - <<'JSON'
{
  "required_status_checks": null,
  "enforce_admins": false,
  "required_pull_request_reviews": null,
  "restrictions": null,
  "required_linear_history": false,
  "allow_force_pushes": false,
  "allow_deletions": false,
  "block_creations": false,
  "required_conversation_resolution": false,
  "lock_branch": false,
  "allow_fork_syncing": true
}
JSON
```

`enforce_admins` is set to `false` so admins can recover from misconfiguration
without being locked out.

After `.github/workflows/bootstrap-validation.yml` exists on `main`, tighten
the protection to require the validator status check while keeping
`required_pull_request_reviews` disabled:

```sh
gh api \
  --method PUT \
  repos/mrhussamahmed/ProjectGenesis/branches/main/protection \
  --input - <<'JSON'
{
  "required_status_checks": {
    "strict": true,
    "contexts": ["validate"]
  },
  "enforce_admins": false,
  "required_pull_request_reviews": null,
  "restrictions": null,
  "required_linear_history": false,
  "allow_force_pushes": false,
  "allow_deletions": false,
  "block_creations": false,
  "required_conversation_resolution": false,
  "lock_branch": false,
  "allow_fork_syncing": true
}
JSON
```

If required reviews were previously enabled and need to be removed:

```sh
gh api -X DELETE \
  repos/mrhussamahmed/ProjectGenesis/branches/main/protection/required_pull_request_reviews
```

## Verify Protection

Check branch protection:

```sh
gh api repos/mrhussamahmed/ProjectGenesis/branches/main/protection
```

Expected protection behavior:

- direct pushes to `main` by non-admin collaborators are blocked
- the `validate` workflow must pass before merge once that status check is added to branch protection
- no approving review is required
- no Code Owner review is required
- no required conversation resolution gate is enforced

If `required_pull_request_reviews` is present, the validator regression guard
and `PR_MERGE_POLICY.md` consider it an external enforcement mismatch that
must be removed.

## Publication Flow

Recommended flow:

1. Commit scaffold changes on a feature branch.
2. Push the branch to `origin`.
3. Open a pull request into `main`.
4. Wait for `Bootstrap Validation` to pass.
5. Run fresh-context adversarial review per `PR_REVIEW_POLICY.md`.
6. Merge when required CI/status checks pass, required local validation passes, scope is clean, and no P0/P1/blocking P2 findings remain. No human, maintainer, or Code Owner approval is required.

## Residual Risks

- GitHub settings are not fully represented by repository files. Confirm
  branch protection in the GitHub UI or API after any repository transfer or
  settings change.
- If the required status check name changes, update the branch protection
  context from `validate` to the new check name.
- `.github/CODEOWNERS` is informational only; do not re-enable
  `require_code_owner_reviews` or `required_approving_review_count` on
  protected branches.

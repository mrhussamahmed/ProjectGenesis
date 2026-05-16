artifact_id: ART-GITHUB-REPOSITORY-SETUP
title: GitHub Repository Setup
type: repository-setup
status: active
version: v1.0
created: 2026-05-13
updated: 2026-05-13
owner: ProjectGenesis Maintainers
source: Public repository publication request
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# GitHub Repository Setup

This guide records the GitHub settings needed to publish ProjectGenesis while
keeping changes to `main` under maintainer review.

## Target Repository

- Repository: `mrhussamahmed/ProjectGenesis`
- URL: `https://github.com/mrhussamahmed/ProjectGenesis`
- Visibility: public
- License: GNU Affero General Public License v3.0

## Required Repository Controls

Configure the `main` branch so changes go through pull requests:

- require pull requests before merging
- require at least one approving review
- require review from Code Owners
- dismiss stale approvals when new commits are pushed
- require conversation resolution before merge
- disallow force pushes
- disallow branch deletion
- after `.github/workflows/bootstrap-validation.yml` exists on `main`, require
  the `validate` status check from GitHub Actions

The repository includes `.github/CODEOWNERS`:

```text
* @mrhussamahmed
```

That means every file is owned by the maintainer account when GitHub branch
protection enables Code Owner review.

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

Protect `main` with the classic branch protection API before the first scaffold
PR is merged:

```sh
gh api \
  --method PUT \
  repos/mrhussamahmed/ProjectGenesis/branches/main/protection \
  --input - <<'JSON'
{
  "required_status_checks": null,
  "enforce_admins": false,
  "required_pull_request_reviews": {
    "dismiss_stale_reviews": true,
    "require_code_owner_reviews": true,
    "required_approving_review_count": 1,
    "require_last_push_approval": true
  },
  "restrictions": null,
  "required_linear_history": false,
  "allow_force_pushes": false,
  "allow_deletions": false,
  "block_creations": false,
  "required_conversation_resolution": true,
  "lock_branch": false,
  "allow_fork_syncing": true
}
JSON
```

`enforce_admins` is set to `false` to avoid locking out the sole maintainer
during initial publication. If multiple trusted maintainers are available and
you want even admins blocked from direct pushes, set `enforce_admins` to `true`.

After `.github/workflows/bootstrap-validation.yml` exists on `main`, tighten
the protection to require the validator status check:

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
  "required_pull_request_reviews": {
    "dismiss_stale_reviews": true,
    "require_code_owner_reviews": true,
    "required_approving_review_count": 1,
    "require_last_push_approval": true
  },
  "restrictions": null,
  "required_linear_history": false,
  "allow_force_pushes": false,
  "allow_deletions": false,
  "block_creations": false,
  "required_conversation_resolution": true,
  "lock_branch": false,
  "allow_fork_syncing": true
}
JSON
```

## Verify Protection

Check branch protection:

```sh
gh api repos/mrhussamahmed/ProjectGenesis/branches/main/protection
```

Expected protection behavior:

- direct pushes to `main` by non-admin collaborators are blocked
- PRs require review
- Code Owner review is required after `.github/CODEOWNERS` is on `main`
- the `validate` workflow must pass before merge after that status check is
  added to branch protection

## Publication Flow

Recommended flow:

1. Commit scaffold changes on a feature branch.
2. Push the branch to `origin`.
3. Open a pull request into `main`.
4. Wait for `Bootstrap Validation` to pass.
5. Review the diff as maintainer.
6. Merge only after review requirements are satisfied or intentionally bypassed
   by the repository owner for initial publication.

## Residual Risks

- GitHub settings are not fully represented by repository files. Confirm branch
  protection in the GitHub UI or API after any repository transfer or settings
  change.
- Code Owner review depends on `.github/CODEOWNERS` existing on the protected
  branch.
- If the required status check name changes, update the branch protection
  context from `validate` to the new check name.

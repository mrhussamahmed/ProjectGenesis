#!/usr/bin/env bash
# strict-gate-paths.sh: single source of truth for the strict-gate path
# pattern consumed by .githooks/pre-commit, .githooks/pre-push, and
# .github/workflows/bootstrap-validation.yml.
#
# A strict-gate path is any file whose change must always run strict
# validation and the full CI suite regardless of the recorded operation
# profile: validators, CI, hooks, governance, role instructions, policies,
# context packs, commands, reusable templates, template starters, and the
# maintainer archive.
#
# Usage:
#   strict-gate-paths.sh --regex
#       Print the ERE pattern (for `grep -E`) on stdout and exit 0.
#   strict-gate-paths.sh --match <path>...
#       Exit 0 if any given path matches the pattern, 1 if none match.
#   strict-gate-paths.sh --match
#       Read newline-separated paths from stdin (e.g. piped from
#       `git diff --name-only`); exit 0 if any path matches, 1 otherwise.
#
# Read-only helper; bash 3.2 compatible (macOS /bin/bash and Linux).

set -euo pipefail

strict_gate_pattern='^(SCRIPTS/|\.github/workflows/|\.githooks/|memory/ai/|PR_REVIEW_POLICY\.md|PR_MERGE_POLICY\.md|RISK_MODEL\.md|BRANCH_AND_WORKTREE_GUIDE\.md|GOVERNANCE\.md|OPERATION_ROUTING\.md|CONTEXT_PACKS/|COMMANDS/|REVIEWS/templates/|SPECS/templates/|ADR/templates/|BACKLOG/templates/|TEMPLATE_MANIFEST\.md|TEMPLATE_STARTERS/|HOOKS_AND_GUARDRAILS\.md|SECURITY_AND_PRIVACY\.md|CI_CD_GUIDE\.md|GITHUB_REPOSITORY_SETUP\.md|MAINTAINER_ARCHIVE/)'

mode="${1:-}"

case "$mode" in
  --regex)
    printf '%s\n' "$strict_gate_pattern"
    ;;
  --match)
    shift
    if [[ "$#" -gt 0 ]]; then
      printf '%s\n' "$@" | grep -Eq "$strict_gate_pattern"
    else
      grep -Eq "$strict_gate_pattern"
    fi
    ;;
  *)
    echo "usage: strict-gate-paths.sh --regex | --match [<path>...]" >&2
    echo "  --match with no paths reads newline-separated paths from stdin." >&2
    exit 2
    ;;
esac

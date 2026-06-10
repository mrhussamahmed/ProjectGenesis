#!/usr/bin/env bash
set -euo pipefail

repo_root="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
tmp_root="$(mktemp -d "${TMPDIR:-/tmp}/bootstrap-red-checks.XXXXXX")"

cleanup() {
  rm -rf "$tmp_root"
}
trap cleanup EXIT

failures=0

copy_repo() {
  local name="$1"
  local dest="$tmp_root/$name"
  local current_branch
  # On GitHub Actions `pull_request` events the checkout is often detached.
  # Use the current branch when available and otherwise initialize fixtures
  # on `main`; canonical state no longer needs to match the fixture branch.
  current_branch="$(git -C "$repo_root" branch --show-current 2>/dev/null || true)"
  [[ -z "$current_branch" ]] && current_branch="main"
  mkdir -p "$dest"
  rsync -a \
    --exclude '.git' \
    --exclude '.claude' \
    --exclude '.ai' \
    --exclude '/research' \
    "$repo_root/" "$dest/"
  git -C "$dest" init -q
  git -C "$dest" symbolic-ref HEAD "refs/heads/$current_branch"
  printf '%s\n' "$dest"
}

expect_failure() {
  local name="$1"
  local expected="$2"
  local dir="$3"
  local output

  set +e
  output="$(cd "$dir" && bash SCRIPTS/validate-bootstrap.sh 2>&1)"
  local status=$?
  set -e

  if [[ "$status" -eq 0 ]]; then
    echo "FAIL: $name unexpectedly passed" >&2
    failures=$((failures + 1))
    return
  fi

  if ! grep -Fq "$expected" <<<"$output"; then
    echo "FAIL: $name did not include expected failure text: $expected" >&2
    echo "$output" >&2
    failures=$((failures + 1))
  fi
}

expect_success() {
  local name="$1"
  local dir="$2"
  local output

  set +e
  output="$(cd "$dir" && bash SCRIPTS/validate-bootstrap.sh 2>&1)"
  local status=$?
  set -e

  if [[ "$status" -ne 0 ]]; then
    echo "FAIL: $name unexpectedly failed:" >&2
    echo "$output" >&2
    failures=$((failures + 1))
  fi
}

expect_command_output() {
  local name="$1"
  local dir="$2"
  local expected="$3"
  shift 3
  local output

  set +e
  output="$(cd "$dir" && "$@" 2>&1)"
  local status=$?
  set -e

  if [[ "$status" -ne 0 ]]; then
    echo "FAIL: $name command failed:" >&2
    echo "$output" >&2
    failures=$((failures + 1))
    return
  fi

  if [[ "$output" != "$expected" ]]; then
    echo "FAIL: $name expected '$expected' but got:" >&2
    echo "$output" >&2
    failures=$((failures + 1))
  fi
}

expect_no_failure_mentioning() {
  local name="$1"
  local dir="$2"
  local needle="$3"
  local output

  set +e
  output="$(cd "$dir" && bash SCRIPTS/validate-bootstrap.sh 2>&1)"
  set -e

  if grep -Fq "$needle" <<<"$output"; then
    echo "FAIL: $name — validator output mentioned '$needle' (it should not):" >&2
    grep -F "$needle" <<<"$output" >&2
    failures=$((failures + 1))
  fi
}

case_approved_spec_missing_source() {
  local dir
  dir="$(copy_repo approved-spec-missing-source)"
  mkdir -p "$dir/SPECS"
  cat >"$dir/SPECS/SPEC-RED-001.md" <<'EOF'
artifact_id: ART-SPEC-RED-001
title: Red Check Spec
type: spec
status: approved
version: v1.0
created: 2026-05-13
updated: 2026-05-13
owner: AI Bootstrap Maintainers
source: red check
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# SPEC-RED-001: Red Check Spec

## Metadata

- Spec ID: SPEC-RED-001
- Status: approved
- Version: v1.0

## Functional Requirements

| ID | Requirement | Requirement IDs | Source IDs | Confidence | Status | Priority |
|----|-------------|-----------------|------------|------------|--------|----------|
| FR-RED-001 | Invalid approved requirement. | REQ-RED-001 | none | high | confirmed | P1 |
EOF
  expect_failure "approved spec missing source IDs" "approved spec missing source IDs" "$dir"
}

case_approved_spec_empty_source() {
  local dir
  dir="$(copy_repo approved-spec-empty-source)"
  mkdir -p "$dir/SPECS"
  cat >"$dir/SPECS/SPEC-RED-002.md" <<'EOF'
artifact_id: ART-SPEC-RED-002
title: Red Check Spec Empty Source
type: spec
status: approved
version: v1.0
created: 2026-05-13
updated: 2026-05-13
owner: AI Bootstrap Maintainers
source: red check
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# SPEC-RED-002: Red Check Spec Empty Source

## Metadata

- Spec ID: SPEC-RED-002
- Status: approved
- Version: v1.0

## Functional Requirements

| ID | Requirement | Requirement IDs | Source IDs | Confidence | Status | Priority |
|----|-------------|-----------------|------------|------------|--------|----------|
| FR-RED-002 | Invalid approved requirement. | REQ-RED-002 |  | high | confirmed | P1 |
EOF
  expect_failure "approved spec empty source IDs" "approved spec missing source IDs" "$dir"
}

case_active_backlog_missing_spec() {
  local dir
  dir="$(copy_repo active-backlog-missing-spec)"
  printf '\n' >>"$dir/BACKLOG/BACKLOG_INDEX.md"
  cat >>"$dir/BACKLOG/BACKLOG_INDEX.md" <<'EOF'
| RED-001 | Invalid active backlog item | `BACKLOG/RED-001-fixture.md` | ready | P1 | medium | medium | none | sequential |
EOF
  expect_failure "active backlog missing linked spec" "active backlog item missing linked spec" "$dir"
}

case_command_missing_required_reads() {
  local dir
  dir="$(copy_repo command-missing-required-reads)"
  mkdir -p "$dir/COMMANDS"
  cat >"$dir/COMMANDS/bad-command.md" <<'EOF'
artifact_id: ART-COMMAND-BAD
title: Bad Command
type: command
status: active
version: v1.0
created: 2026-05-13
updated: 2026-05-13
owner: AI Bootstrap Maintainers
source: red check
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: false

# Bad Command

## Purpose

Invalid command fixture.
EOF
  expect_failure "command missing required reads" "command missing section: ## Required Files To Read" "$dir"
}

case_source_registry_missing_status() {
  local dir
  dir="$(copy_repo source-registry-missing-status)"
  printf '\n' >>"$dir/00_intake/SOURCE_REGISTRY.md"
  cat >>"$dir/00_intake/SOURCE_REGISTRY.md" <<'EOF'
| SRC-999 | `00_intake/raw/example.md` | note | User | 2026-05-13 |  | pending | internal | none |  |
EOF
  expect_failure "source registry missing freshness" "source registry row missing freshness" "$dir"
}

case_source_registry_missing_processing_state() {
  local dir
  dir="$(copy_repo source-registry-missing-processing-state)"
  printf '\n' >>"$dir/00_intake/SOURCE_REGISTRY.md"
  cat >>"$dir/00_intake/SOURCE_REGISTRY.md" <<'EOF'
| SRC-998 | `00_intake/raw/example.md` | note | User | 2026-05-13 | active |  | internal | none |  |
EOF
  expect_failure "source registry missing processing state" "source registry row missing processing state" "$dir"
}

case_assumption_missing_expiry() {
  local dir
  dir="$(copy_repo assumption-missing-expiry)"
  printf '\n' >>"$dir/02_requirements/ASSUMPTIONS_REGISTER.md"
  cat >>"$dir/02_requirements/ASSUMPTIONS_REGISTER.md" <<'EOF'
| ASM-999 | Invalid assumption | low | Product Analyst | proposed |  | none | REQ-999 | SPEC-999 |  |
EOF
  expect_failure "assumption missing expiry" "assumption row missing expiry" "$dir"
}

case_approved_assumption_missing_evidence() {
  local dir
  dir="$(copy_repo approved-assumption-missing-evidence)"
  printf '\n' >>"$dir/02_requirements/ASSUMPTIONS_REGISTER.md"
  cat >>"$dir/02_requirements/ASSUMPTIONS_REGISTER.md" <<'EOF'
| ASM-998 | Invalid approved assumption | low | Product Analyst | approved | 2026-06-13 | none | REQ-998 | SPEC-998 |  |
EOF
  expect_failure "approved assumption missing approval evidence" "approved assumption missing approval evidence" "$dir"
}

case_approved_assumption_self_approved() {
  local dir
  dir="$(copy_repo approved-assumption-self-approved)"
  printf '\n' >>"$dir/02_requirements/ASSUMPTIONS_REGISTER.md"
  cat >>"$dir/02_requirements/ASSUMPTIONS_REGISTER.md" <<'EOF'
| ASM-997 | Invalid self-approved assumption | high | Product Analyst | approved | 2026-06-13 | self-approved by author | REQ-997 | SPEC-997 |  |
EOF
  expect_failure "approved assumption self-approved" "approved assumption has disallowed approval evidence" "$dir"
}

case_approved_assumption_unsupported_evidence() {
  local dir
  dir="$(copy_repo approved-assumption-unsupported-evidence)"
  printf '\n' >>"$dir/02_requirements/ASSUMPTIONS_REGISTER.md"
  cat >>"$dir/02_requirements/ASSUMPTIONS_REGISTER.md" <<'EOF'
| ASM-996 | Invalid weak approval evidence | medium | Product Analyst | approved | 2026-06-13 | looks reasonable | REQ-996 | SPEC-996 |  |
EOF
  expect_failure "approved assumption unsupported evidence" "approved assumption missing allowed approval evidence" "$dir"
}

case_operation_routing_missing_profile() {
  local dir
  dir="$(copy_repo operation-routing-missing-profile)"
  perl -0pi -e 's/`strict-protected`/`strict-protected-removed`/g' "$dir/OPERATION_ROUTING.md"
  expect_failure "operation routing missing profile" "OPERATION_ROUTING.md missing operation profile: strict-protected" "$dir"
}

case_operation_routing_missing_validation_mode() {
  local dir
  dir="$(copy_repo operation-routing-missing-validation-mode)"
  perl -0pi -e 's/\| strict \|/[removed-mode]/' "$dir/OPERATION_ROUTING.md"
  expect_failure "operation routing missing validation mode" "OPERATION_ROUTING.md missing validation mode: strict" "$dir"
}

case_operation_routing_missing_context_reference() {
  local dir
  dir="$(copy_repo operation-routing-missing-context-reference)"
  perl -0pi -e 's/`OPERATION_ROUTING.md`/`OPERATION_ROUTING_REMOVED.md`/g' "$dir/CONTEXT_INDEX.md"
  expect_failure "operation routing missing context reference" "CONTEXT_INDEX.md does not reference OPERATION_ROUTING.md" "$dir"
}

case_research_dir_does_not_trip_validator() {
  local dir
  dir="$(copy_repo research-dir-ignored)"
  mkdir -p "$dir/research/phase-0-fixture"
  cat >"$dir/research/phase-0-fixture/note.md" <<'EOF'
# Research Note

This file deliberately has no metadata block and contains a placeholder
token like TODO to verify the validator does not trip on `research/`
contents. After Phase 0, validation must not mention this path.
EOF
  expect_no_failure_mentioning "research dir does not trip validator" "$dir" "research/phase-0-fixture/note.md"
}

case_raw_intake_md_does_not_trip_validator() {
  # GEN-06: messy product input under 00_intake/raw/ must never fail
  # validation (no metadata block, placeholder-like words allowed).
  local dir
  dir="$(copy_repo raw-intake-ignored)"
  cat >"$dir/00_intake/raw/messy-idea.md" <<'EOF'
rough idea dump with no metadata block.
TODO figure out pricing. TBD competitor scan.
EOF
  expect_no_failure_mentioning "raw intake md does not trip validator" "$dir" "00_intake/raw/messy-idea.md"
}

case_backlog_index_item_status_mismatch_fails() {
  # GEN-08: index row status must match the item file frontmatter status.
  local dir
  dir="$(copy_repo backlog-status-mismatch)"
  printf '\n' >>"$dir/BACKLOG/BACKLOG_INDEX.md"
  cat >>"$dir/BACKLOG/BACKLOG_INDEX.md" <<'EOF'
| RED-MM-1 | Mismatch fixture row | `BACKLOG/BOOT-STATE-001-split-state-handoff.md` | in-review | P1 | low | low | SPEC- exempt fixture | sequential |
EOF
  expect_failure "backlog index item status mismatch" "backlog status mismatch" "$dir"
}

case_template_starter_ai_handoff_passes_section_check() {
  # GEN-07: the shipped starter must satisfy the live AI_HANDOFF section
  # contract so a fresh fork validates green.
  local dir
  dir="$(copy_repo starter-handoff-contract)"
  cp "$dir/TEMPLATE_STARTERS/AI_HANDOFF.md" "$dir/AI_HANDOFF.md"
  expect_no_failure_mentioning "starter AI_HANDOFF satisfies section contract" "$dir" "AI_HANDOFF.md missing section"
}

case_claude_worktree_does_not_trip_validator() {
  local dir
  dir="$(copy_repo claude-worktree-ignored)"
  mkdir -p "$dir/.claude/worktrees/phase-0-fixture"
  cat >"$dir/.claude/worktrees/phase-0-fixture/note.md" <<'EOF'
# Worktree Note

This file deliberately has no metadata block and contains a placeholder
token like FIXME to verify the validator does not trip on `.claude/`
contents. After Phase 0, validation must not mention this path.
EOF
  expect_no_failure_mentioning ".claude worktree does not trip validator" "$dir" ".claude/worktrees/phase-0-fixture/note.md"
}

case_canonical_active_state_rejects_volatile_session_text() {
  local dir
  dir="$(copy_repo canonical-active-state-rejects-volatile-session-text)"
  perl -0pi -e 's/(## Next Recommended Action\n+)[^\n]+/$1Resume work in .claude\/worktrees\/example/' "$dir/AI_HANDOFF.md"
  expect_failure "canonical active state rejects volatile session text" "canonical state contains active volatile session text" "$dir"
}

case_local_session_ignored_by_validator() {
  local dir
  dir="$(copy_repo local-session-ignored-by-validator)"
  mkdir -p "$dir/.ai"
  cat >"$dir/.ai/SESSION.md" <<'EOF'
# Local Session

operation_profile: docs-trivial
branch: local-only
updated_at_epoch: 1
note: TODO this ignored local scratch lacks artifact metadata by design.
EOF
  expect_success "local session ignored by validator" "$dir"
}

case_local_session_profile_routes_shape_only() {
  local dir fixture_branch now_epoch
  dir="$(copy_repo local-session-profile-routes-shape-only)"
  fixture_branch="$(git -C "$dir" branch --show-current)"
  now_epoch="$(date +%s)"
  mkdir -p "$dir/.ai"
  cat >"$dir/.ai/SESSION.md" <<EOF
operation_profile: docs-trivial
branch: $fixture_branch
updated_at_epoch: $now_epoch
worktree: local scratch
EOF
  expect_command_output "local session profile routes shape-only" "$dir" "shape-only" bash SCRIPTS/operation-profile.sh --validator-level
}

case_no_local_session_profile_routes_strict() {
  local dir
  dir="$(copy_repo no-local-session-profile-routes-strict)"
  rm -rf "$dir/.ai"
  expect_command_output "no local session profile routes strict" "$dir" "strict" bash SCRIPTS/operation-profile.sh --validator-level
}

case_stale_local_session_profile_routes_strict() {
  local dir fixture_branch
  dir="$(copy_repo stale-local-session-profile-routes-strict)"
  fixture_branch="$(git -C "$dir" branch --show-current)"
  mkdir -p "$dir/.ai"
  cat >"$dir/.ai/SESSION.md" <<EOF
operation_profile: docs-trivial
branch: $fixture_branch
updated_at_epoch: 1
EOF
  expect_command_output "stale local session profile routes strict" "$dir" "strict" env BOOTSTRAP_SESSION_TTL_SECONDS=60 bash SCRIPTS/operation-profile.sh --validator-level
}

case_branch_mismatch_local_session_profile_routes_strict() {
  local dir now_epoch
  dir="$(copy_repo branch-mismatch-local-session-profile-routes-strict)"
  now_epoch="$(date +%s)"
  mkdir -p "$dir/.ai"
  cat >"$dir/.ai/SESSION.md" <<EOF
operation_profile: docs-trivial
branch: different-branch
updated_at_epoch: $now_epoch
EOF
  expect_command_output "branch mismatch local session profile routes strict" "$dir" "strict" bash SCRIPTS/operation-profile.sh --validator-level
}

case_canonical_allowed_split_state_wording_passes() {
  local dir
  dir="$(copy_repo canonical-allowed-split-state-wording-passes)"
  perl -0pi -e 's/(## Current In-Progress Task\n\n).*?(\n\n## Files Changed)/$1Branch-specific session state belongs outside this committed file per the\nsplit-state rules.$2/s' "$dir/AI_HANDOFF.md"
  expect_success "canonical allowed split-state wording passes" "$dir"
}

case_handoff_without_classification_passes() {
  local dir
  dir="$(copy_repo handoff-without-classification-passes)"
  perl -0pi -e 's/\n## .*Pre-Change Classification.*?(?=\n## |\z)//sg' "$dir/AI_HANDOFF.md"
  perl -0pi -e 's/^.*Operation profile:.*\n//mg' "$dir/AI_HANDOFF.md"
  expect_success "handoff without classification passes" "$dir"
}

case_role_unconditional_committed_state_rule_fails() {
  local dir
  dir="$(copy_repo role-unconditional-committed-state-rule-fails)"
  perl -0pi -e 's/(## Required Updates Before Stopping\n\n).*?(- `TEST_RESULTS\.md`)/$1- `CURRENT_STATE.md`\n- `AI_HANDOFF.md`\n$2/s' "$dir/memory/ai/ROLE_IMPLEMENTATION_AGENT.md"
  expect_failure "role unconditional committed-state rule fails" "contains unconditional committed-state stopping rule" "$dir"
}

case_policy_unconditional_committed_state_rule_fails() {
  local dir
  dir="$(copy_repo policy-unconditional-committed-state-rule-fails)"
  perl -0pi -e 's/- canonical `AI_HANDOFF\.md` and `CURRENT_STATE\.md` are updated only when\n  durable project truth changed and the update should remain true on `main`\n  after merge/- `AI_HANDOFF.md` is updated\n- `CURRENT_STATE.md` is updated/' "$dir/PR_MERGE_POLICY.md"
  perl -0pi -e 's/missing required PR evidence or durable handoff\/state update in the correct\n  split-state location after significant work/missing AI handoff after significant work/' "$dir/PR_REVIEW_POLICY.md"
  expect_failure "policy unconditional committed-state rule fails" "PR policy contains unconditional committed-state handoff requirement" "$dir"
}

case_policy_reintroduces_required_human_approval_fails() {
  # BOOT-GREEN-MERGE-001: active authoritative policy must NOT reintroduce
  # required human, maintainer, or Code Owner approval as a merge gate.
  # This fixture appends a positive requirement clause to PR_MERGE_POLICY.md
  # and expects the validator regression guard to flag it.
  local dir
  dir="$(copy_repo policy-reintroduces-required-human-approval-fails)"
  cat >>"$dir/PR_MERGE_POLICY.md" <<'EOF'

## Reintroduced Approval Gate (Red Check Fixture)

- A PR requires at least one approving review from a Code Owner before merge.
EOF
  expect_failure "policy reintroduces required human approval fails" "reintroduces required human/maintainer/Code Owner approval as a merge gate" "$dir"
}

case_role_reintroduces_required_human_approval_fails() {
  # BOOT-GREEN-MERGE-001: the regression guard also covers active role
  # files. A role file that says merge requires maintainer approval must
  # trip the validator.
  local dir
  dir="$(copy_repo role-reintroduces-required-human-approval-fails)"
  cat >>"$dir/memory/ai/ROLE_IMPLEMENTATION_AGENT.md" <<'EOF'

## Reintroduced Approval Gate (Red Check Fixture)

- Maintainer approval is required before merge.
EOF
  expect_failure "role reintroduces required human approval fails" "reintroduces required human/maintainer/Code Owner approval as a merge gate" "$dir"
}

case_policy_negation_phrasing_passes() {
  # BOOT-GREEN-MERGE-001: lines that explicitly say a gate is NOT required
  # or is informational only must not be flagged. The validator must remain
  # silent on the as-shipped policy phrasings. We append a redundant negation
  # clause to confirm the guard treats negation correctly.
  local dir
  dir="$(copy_repo policy-negation-phrasing-passes)"
  cat >>"$dir/PR_MERGE_POLICY.md" <<'EOF'

## Negation Phrasing Fixture (Red Check Fixture)

- A maintainer approval is not required to merge a PR; Code Owner review is
  informational only.
EOF
  expect_no_failure_mentioning "policy negation phrasing passes" "$dir" "reintroduces required human/maintainer/Code Owner approval as a merge gate"
}

case_setup_guide_reintroduces_required_approving_review_count_fails() {
  # BOOT-GREEN-MERGE-001 / Codex blocking P2: the regression guard must
  # also catch GitHub enforcement keys in `GITHUB_REPOSITORY_SETUP.md`.
  # A `required_approving_review_count` of 1+ reintroduces a required
  # approving review gate at the GitHub enforcement layer.
  local dir
  dir="$(copy_repo setup-guide-reintroduces-required-approving-review-count-fails)"
  cat >>"$dir/GITHUB_REPOSITORY_SETUP.md" <<'EOF'

## Reintroduced GitHub Key Fixture (Red Check Fixture)

```json
{
  "required_approving_review_count": 1
}
```
EOF
  expect_failure "setup guide reintroduces required approving review count fails" "GitHub branch-protection key" "$dir"
}

case_setup_guide_reintroduces_require_code_owner_reviews_fails() {
  # BOOT-GREEN-MERGE-001 / Codex blocking P2: `require_code_owner_reviews:
  # true` reintroduces a required Code Owner review gate.
  local dir
  dir="$(copy_repo setup-guide-reintroduces-require-code-owner-reviews-fails)"
  cat >>"$dir/GITHUB_REPOSITORY_SETUP.md" <<'EOF'

## Reintroduced GitHub Key Fixture (Red Check Fixture)

```json
{
  "require_code_owner_reviews": true
}
```
EOF
  expect_failure "setup guide reintroduces require code owner reviews fails" "GitHub branch-protection key" "$dir"
}

case_setup_guide_reintroduces_require_last_push_approval_fails() {
  # BOOT-GREEN-MERGE-001 / Codex blocking P2: `require_last_push_approval:
  # true` reintroduces a required human re-approval after the last push.
  local dir
  dir="$(copy_repo setup-guide-reintroduces-require-last-push-approval-fails)"
  cat >>"$dir/GITHUB_REPOSITORY_SETUP.md" <<'EOF'

## Reintroduced GitHub Key Fixture (Red Check Fixture)

```json
{
  "require_last_push_approval": true
}
```
EOF
  expect_failure "setup guide reintroduces require last push approval fails" "GitHub branch-protection key" "$dir"
}

case_setup_guide_disabled_github_keys_pass() {
  # BOOT-GREEN-MERGE-001: disabled forms of the GitHub enforcement keys
  # (count = 0, false, null) must NOT be flagged. The validator must remain
  # silent on the as-shipped setup guidance, which uses null for
  # `required_pull_request_reviews` and references the disabled forms.
  local dir
  dir="$(copy_repo setup-guide-disabled-github-keys-pass)"
  cat >>"$dir/GITHUB_REPOSITORY_SETUP.md" <<'EOF'

## Disabled GitHub Key Fixture (Red Check Fixture)

```json
{
  "required_approving_review_count": 0,
  "require_code_owner_reviews": false,
  "require_last_push_approval": false
}
```
EOF
  expect_no_failure_mentioning "setup guide disabled github keys pass" "$dir" "GitHub branch-protection key"
}

case_policy_reintroduces_required_human_approval_wrapped_fails() {
  # BOOT-GREEN-MERGE-001 / second Codex re-review blocking P2: a wrapped
  # Markdown bullet must not bypass the regression guard. The text
  # "- A PR requires" on one line and "  maintainer approval before merge."
  # on the next line is a single logical bullet in rendered Markdown, and
  # the validator must treat it that way for pattern matching.
  local dir
  dir="$(copy_repo policy-reintroduces-required-human-approval-wrapped-fails)"
  cat >>"$dir/PR_MERGE_POLICY.md" <<'EOF'

## Reintroduced Approval Gate (Wrapped Red Check Fixture)

- A PR requires
  maintainer approval before merge.
EOF
  expect_failure "policy reintroduces required human approval wrapped fails" "reintroduces required human/maintainer/Code Owner approval as a merge gate" "$dir"
}

case_setup_guide_reintroduces_non_null_required_pull_request_reviews_fails() {
  # BOOT-GREEN-MERGE-001 / fifth Codex re-review blocking P2: GitHub's
  # branch-protection API enables PR review protection whenever
  # `required_pull_request_reviews` is a non-null object, even when no
  # inner field is set. A red-check fixture must catch this regression
  # path because checking only the inner keys leaves the parent object
  # as an open path back to required reviews.
  local dir
  dir="$(copy_repo setup-guide-reintroduces-non-null-required-pull-request-reviews-fails)"
  cat >>"$dir/GITHUB_REPOSITORY_SETUP.md" <<'EOF'

## Reintroduced GitHub Parent-Object Fixture (Red Check Fixture)

```json
{
  "required_pull_request_reviews": {
    "dismiss_stale_reviews": true
  }
}
```
EOF
  expect_failure "setup guide reintroduces non-null required pull request reviews fails" "GitHub branch-protection key" "$dir"
}

case_setup_guide_null_required_pull_request_reviews_passes() {
  # BOOT-GREEN-MERGE-001: the disabled form
  # `"required_pull_request_reviews": null` is the green-merge-aligned
  # value and must NOT trip the parent-object guard. The validator must
  # stay silent on the as-shipped setup guidance, which uses this form
  # in both PUT examples.
  local dir
  dir="$(copy_repo setup-guide-null-required-pull-request-reviews-passes)"
  cat >>"$dir/GITHUB_REPOSITORY_SETUP.md" <<'EOF'

## Disabled GitHub Parent-Object Fixture (Red Check Fixture)

```json
{
  "required_pull_request_reviews": null
}
```
EOF
  expect_no_failure_mentioning "setup guide null required pull request reviews passes" "$dir" "GitHub branch-protection key"
}

case_scaffold_extract_golden_validates() {
  # Golden fixture: extracting the scaffold into a fresh temp target and then
  # running `bash SCRIPTS/validate-bootstrap.sh` inside the target must exit 0.
  # This is the BOOT-031 acceptance check that the extracted scaffold is a
  # valid downstream starting point.
  local target="$tmp_root/scaffold-extract-golden"
  rm -rf "$target"
  local output
  set +e
  output="$(cd "$repo_root" && bash SCRIPTS/scaffold-extract.sh --apply "$target" 2>&1)"
  local status=$?
  set -e
  if [[ "$status" -ne 0 ]]; then
    echo "FAIL: scaffold-extract.sh --apply did not exit 0:" >&2
    echo "$output" >&2
    failures=$((failures + 1))
    return
  fi
  set +e
  output="$(cd "$target" && bash SCRIPTS/validate-bootstrap.sh 2>&1)"
  status=$?
  set -e
  if [[ "$status" -ne 0 ]]; then
    echo "FAIL: extracted scaffold did not validate:" >&2
    echo "$output" >&2
    failures=$((failures + 1))
  fi
}

case_scaffold_extract_dry_run_writes_nothing() {
  # Default behavior is dry-run; the script must not create the target
  # directory when invoked without --apply.
  local target="$tmp_root/scaffold-extract-dry-run"
  rm -rf "$target"
  set +e
  ( cd "$repo_root" && bash SCRIPTS/scaffold-extract.sh "$target" >/dev/null 2>&1 )
  local status=$?
  set -e
  if [[ "$status" -ne 0 ]]; then
    echo "FAIL: scaffold-extract.sh dry-run exited non-zero" >&2
    failures=$((failures + 1))
    return
  fi
  if [[ -e "$target" ]]; then
    echo "FAIL: scaffold-extract.sh dry-run created target directory: $target" >&2
    failures=$((failures + 1))
  fi
}

case_scaffold_extract_refuses_source_as_target() {
  # Safety: the script must refuse when the target equals the source root.
  local output
  set +e
  output="$(cd "$repo_root" && bash SCRIPTS/scaffold-extract.sh --apply "$repo_root" 2>&1)"
  local status=$?
  set -e
  if [[ "$status" -eq 0 ]]; then
    echo "FAIL: scaffold-extract.sh accepted source as target" >&2
    failures=$((failures + 1))
    return
  fi
  if ! grep -Fq "target equals source repository" <<<"$output"; then
    echo "FAIL: scaffold-extract.sh refused source-as-target for wrong reason:" >&2
    echo "$output" >&2
    failures=$((failures + 1))
  fi
}

case_scaffold_extract_refuses_nonempty_without_force() {
  # Safety: the script must refuse to overwrite a non-empty target unless
  # --force is passed.
  local target="$tmp_root/scaffold-extract-nonempty"
  rm -rf "$target"
  mkdir -p "$target"
  printf 'existing\n' >"$target/keepme.txt"
  local output
  set +e
  output="$(cd "$repo_root" && bash SCRIPTS/scaffold-extract.sh --apply "$target" 2>&1)"
  local status=$?
  set -e
  if [[ "$status" -eq 0 ]]; then
    echo "FAIL: scaffold-extract.sh accepted non-empty target without --force" >&2
    failures=$((failures + 1))
    return
  fi
  if ! grep -Fq "target directory exists and is non-empty" <<<"$output"; then
    echo "FAIL: scaffold-extract.sh refused non-empty target for wrong reason:" >&2
    echo "$output" >&2
    failures=$((failures + 1))
  fi
  if [[ ! -f "$target/keepme.txt" ]]; then
    echo "FAIL: scaffold-extract.sh modified the non-empty target before refusing" >&2
    failures=$((failures + 1))
  fi
}

case_scaffold_extract_registry_includes_kept_framework_paths() {
  # Coverage: the extracted ARTIFACT_REGISTRY.md must mention every kept
  # framework/GitHub config path that the validator does not already check.
  # This guards against silent registry drift relative to the extraction
  # contract. Paths that the reuse-boundary slice removed from extracted
  # output (GITHUB_REPOSITORY_SETUP.md, GOVERNANCE_PERFORMANCE.md,
  # .github/CODEOWNERS, SCRIPTS/run-seeded-defect-bench.sh,
  # SCRIPTS/scaffold-extract.sh, TESTS/ACCEPTANCE_CRITERIA_MAP.md,
  # TESTS/ADVERSARIAL_SEED_BENCHMARK.md, BOOTSTRAP_AUDIT.md,
  # PARALLEL_EXECUTION_PLAN.md, SCAFFOLD_FORK_CHECKLIST.md,
  # STALE_ITEMS.md) are intentionally absent from the registry.
  local target="$tmp_root/scaffold-extract-registry-coverage"
  rm -rf "$target"
  local output
  set +e
  output="$(cd "$repo_root" && bash SCRIPTS/scaffold-extract.sh --apply --no-validate "$target" 2>&1)"
  local status=$?
  set -e
  if [[ "$status" -ne 0 ]]; then
    echo "FAIL: scaffold-extract.sh --apply did not exit 0 during registry coverage check:" >&2
    echo "$output" >&2
    failures=$((failures + 1))
    return
  fi
  local path
  for path in \
    "README.md" \
    ".gitignore" \
    "COMMANDS/start-requirement-breakdown.md" \
    "00_intake/raw/.gitkeep" \
    "00_intake/summaries/.gitkeep" \
    "ARTIFACTS/.gitkeep" \
    "ARTIFACTS/ARCHIVE/.gitkeep"; do
    if ! grep -Fq "\`$path\`" "$target/ARTIFACT_REGISTRY.md"; then
      echo "FAIL: extracted ARTIFACT_REGISTRY.md does not register kept framework path: $path" >&2
      failures=$((failures + 1))
    fi
  done
  # Reuse-boundary contract: maintainer-only paths must NOT appear in the
  # extracted registry. Drift here would silently reintroduce upstream
  # attribution in a downstream scaffold.
  for path in \
    "BOOTSTRAP_AUDIT.md" \
    "GITHUB_REPOSITORY_SETUP.md" \
    "GOVERNANCE_PERFORMANCE.md" \
    "PARALLEL_EXECUTION_PLAN.md" \
    "SCAFFOLD_FORK_CHECKLIST.md" \
    "STALE_ITEMS.md" \
    "TESTS/ACCEPTANCE_CRITERIA_MAP.md" \
    "TESTS/ADVERSARIAL_SEED_BENCHMARK.md" \
    "SCRIPTS/scaffold-extract.sh" \
    "SCRIPTS/run-seeded-defect-bench.sh" \
    ".github/CODEOWNERS"; do
    if grep -Fq "\`$path\`" "$target/ARTIFACT_REGISTRY.md"; then
      echo "FAIL: extracted ARTIFACT_REGISTRY.md still registers maintainer-only path: $path" >&2
      failures=$((failures + 1))
    fi
  done
}

case_unregistered_src_id_fails() {
  # Coverage: a backlog item that cites a canonical SRC-NNN ID must trip the
  # validator if that ID is not registered in `00_intake/SOURCE_REGISTRY.md`.
  local dir
  dir="$(copy_repo unregistered-src-id)"
  cat >"$dir/BACKLOG/BOOT-RED-100-unregistered-src.md" <<'EOF'
artifact_id: ART-BACKLOG-BOOT-RED-100
title: BOOT-RED-100 Unregistered Source Citation
type: backlog-item
status: active
version: v1.0
created: 2026-05-16
updated: 2026-05-16
owner: AI Bootstrap Maintainers
source: red check
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# BOOT-RED-100: Unregistered Source Citation

## Purpose

Red-check fixture: cite an unregistered `SRC-*` ID and expect the validator
to fail.

## Links

- Linked spec: none
- Source IDs: SRC-99901
EOF
  expect_failure "unregistered src id fails" "cites unregistered source ID: SRC-99901" "$dir"
}

case_unregistered_spec_id_fails() {
  # Coverage: a backlog item that cites a canonical SPEC-* ID must trip the
  # validator if that ID is not registered in `SPECS/SPEC_INDEX.md` and no
  # matching `SPECS/SPEC-*-*.md` file exists.
  local dir
  dir="$(copy_repo unregistered-spec-id)"
  cat >"$dir/BACKLOG/BOOT-RED-200-unregistered-spec.md" <<'EOF'
artifact_id: ART-BACKLOG-BOOT-RED-200
title: BOOT-RED-200 Unregistered Spec Citation
type: backlog-item
status: active
version: v1.0
created: 2026-05-16
updated: 2026-05-16
owner: AI Bootstrap Maintainers
source: red check
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# BOOT-RED-200: Unregistered Spec Citation

## Purpose

Red-check fixture: cite an unregistered `SPEC-*` ID and expect the validator
to fail.

## Links

- Linked spec: SPEC-RED-9999
- Source IDs: none
EOF
  expect_failure "unregistered spec id fails" "cites unregistered spec ID: SPEC-RED-9999" "$dir"
}

case_registered_src_id_passes() {
  # Coverage: a backlog item that cites a freshly registered SRC-* ID must
  # not trip the validator (no FAIL line mentioning the ID).
  local dir
  dir="$(copy_repo registered-src-id)"
  cat >>"$dir/00_intake/SOURCE_REGISTRY.md" <<'EOF'
| SRC-99902 | `00_intake/raw/red.md` | note | red | 2026-05-16 | active | pending | internal | none |  |
EOF
  cat >"$dir/BACKLOG/BOOT-RED-300-registered-src.md" <<'EOF'
artifact_id: ART-BACKLOG-BOOT-RED-300
title: BOOT-RED-300 Registered Source Citation
type: backlog-item
status: active
version: v1.0
created: 2026-05-16
updated: 2026-05-16
owner: AI Bootstrap Maintainers
source: red check
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# BOOT-RED-300: Registered Source Citation

## Purpose

Red-check fixture: cite a registered `SRC-*` ID and expect the validator
to remain silent about it.

## Links

- Linked spec: none
- Source IDs: SRC-99902
EOF
  expect_no_failure_mentioning "registered src id passes" "$dir" "cites unregistered source ID: SRC-99902"
}

case_provisional_src_id_passes() {
  # Coverage: a backlog item that cites a `provisional:SRC-*` placeholder
  # must not require registration. The validator treats the prefix as an
  # explicit escape hatch.
  local dir
  dir="$(copy_repo provisional-src-id)"
  cat >"$dir/BACKLOG/BOOT-RED-400-provisional-src.md" <<'EOF'
artifact_id: ART-BACKLOG-BOOT-RED-400
title: BOOT-RED-400 Provisional Source Citation
type: backlog-item
status: active
version: v1.0
created: 2026-05-16
updated: 2026-05-16
owner: AI Bootstrap Maintainers
source: red check
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# BOOT-RED-400: Provisional Source Citation

## Purpose

Red-check fixture: cite a `provisional:SRC-*` placeholder and expect the
validator to skip registration enforcement.

## Links

- Linked spec: none
- Source IDs: provisional:SRC-99903
EOF
  expect_no_failure_mentioning "provisional src id passes" "$dir" "cites unregistered source ID: SRC-99903"
}

case_provisional_spec_id_passes() {
  # Coverage: a backlog item that cites a `pending:SPEC-*` placeholder must
  # not require registration either.
  local dir
  dir="$(copy_repo provisional-spec-id)"
  cat >"$dir/BACKLOG/BOOT-RED-500-provisional-spec.md" <<'EOF'
artifact_id: ART-BACKLOG-BOOT-RED-500
title: BOOT-RED-500 Provisional Spec Citation
type: backlog-item
status: active
version: v1.0
created: 2026-05-16
updated: 2026-05-16
owner: AI Bootstrap Maintainers
source: red check
linked_specs: []
linked_tickets: []
linked_adrs: []
replaces:
replaced_by:
authoritative: true

# BOOT-RED-500: Provisional Spec Citation

## Purpose

Red-check fixture: cite a `pending:SPEC-*` placeholder and expect the
validator to skip registration enforcement.

## Links

- Linked spec: pending:SPEC-RED-1234
- Source IDs: none
EOF
  expect_no_failure_mentioning "provisional spec id passes" "$dir" "cites unregistered spec ID: SPEC-RED-1234"
}

case_scaffold_extract_contract_detects_forbidden_string_contamination() {
  # Reuse-boundary slice: the extractor's post-Phase-3 contract check must
  # detect forbidden paths or upstream owner strings in the extracted
  # target. We extract once into a temp target with --no-validate, then
  # inject a forbidden path (.github/CODEOWNERS) which rsync's exclude
  # list skips on re-extraction. Re-extracting with --force preserves the
  # injection because rsync does not delete excluded files; the contract
  # check then runs and must fail with a CONTRACT FAIL line naming the
  # path.
  local target="$tmp_root/scaffold-extract-contract-contamination"
  rm -rf "$target"
  local output
  set +e
  output="$(cd "$repo_root" && bash SCRIPTS/scaffold-extract.sh --apply --no-validate "$target" 2>&1)"
  local status=$?
  set -e
  if [[ "$status" -ne 0 ]]; then
    echo "FAIL: scaffold-extract.sh --apply did not exit 0 during contamination setup:" >&2
    echo "$output" >&2
    failures=$((failures + 1))
    return
  fi
  # Inject a forbidden path. .github/CODEOWNERS is in FORBIDDEN_PATHS and
  # rsync excludes it on subsequent mirrors, so the file persists across
  # re-extraction and the contract check must catch it.
  mkdir -p "$target/.github"
  printf '* @leaked-owner\n' >"$target/.github/CODEOWNERS"
  set +e
  output="$(cd "$repo_root" && bash SCRIPTS/scaffold-extract.sh --apply --force --no-validate "$target" 2>&1)"
  status=$?
  set -e
  if [[ "$status" -eq 0 ]]; then
    echo "FAIL: scaffold-extract.sh contract check did not detect forbidden path contamination:" >&2
    echo "$output" >&2
    failures=$((failures + 1))
    return
  fi
  if ! grep -Fq "CONTRACT FAIL: forbidden path present: .github/CODEOWNERS" <<<"$output"; then
    echo "FAIL: scaffold-extract.sh contract check did not name the contaminated path:" >&2
    echo "$output" >&2
    failures=$((failures + 1))
  fi
}

case_scaffold_extract_reset_files_use_header_only_tables() {
  # Coverage: the extracted shared-state reset files must match the
  # header-only table contract for ADR/ADR_INDEX.md and
  # HANDOFFS/HANDOFF_INDEX.md. STALE_ITEMS.md was previously checked here
  # but is excluded from extracted output in the reuse-boundary slice
  # because it is maintainer-only history.
  local target="$tmp_root/scaffold-extract-reset-shapes"
  rm -rf "$target"
  local output
  set +e
  output="$(cd "$repo_root" && bash SCRIPTS/scaffold-extract.sh --apply --no-validate "$target" 2>&1)"
  local status=$?
  set -e
  if [[ "$status" -ne 0 ]]; then
    echo "FAIL: scaffold-extract.sh --apply did not exit 0 during reset-shape check:" >&2
    echo "$output" >&2
    failures=$((failures + 1))
    return
  fi
  # STALE_ITEMS.md must be absent in extracted output (reuse-boundary slice).
  if [[ -e "$target/STALE_ITEMS.md" ]]; then
    echo "FAIL: STALE_ITEMS.md must be excluded from extracted output" >&2
    failures=$((failures + 1))
  fi
  # ADR/ADR_INDEX.md: table header but no body row (no `none none` row).
  if grep -Fq "| none | none | none |" "$target/ADR/ADR_INDEX.md"; then
    echo "FAIL: ADR/ADR_INDEX.md still contains a 'none' body row instead of header-only table" >&2
    failures=$((failures + 1))
  fi
  if ! grep -Fq "| ADR ID | Title | File | Status | Date | Owner | Linked Specs | Linked Backlog Items | Supersedes | Superseded By |" "$target/ADR/ADR_INDEX.md"; then
    echo "FAIL: ADR/ADR_INDEX.md missing ADR table header row" >&2
    failures=$((failures + 1))
  fi
  # HANDOFFS/ was removed from the scaffold (GEN-09); extracted output must
  # not recreate it.
  if [[ -e "$target/HANDOFFS" ]]; then
    echo "FAIL: HANDOFFS/ must be absent from extracted output" >&2
    failures=$((failures + 1))
  fi
}

case_stale_next_safe_action_historical_fails() {
  # BOOT-034: two unmarked `Next safe action:` envelope fields must
  # trip the staleness guard regardless of the base file's current
  # active envelope, because at most one unmarked field is allowed.
  local dir
  dir="$(copy_repo stale-next-safe-action-historical-fails)"
  cat >>"$dir/AI_HANDOFF.md" <<'EOF'

## Stale Next Action Fixture A

- Next safe action: apply the residual handoff fix and request re-review.

## Stale Next Action Fixture B

- Next safe action: push this commit to origin and request a fresh adversarial review.
EOF
  expect_failure "stale next safe action historical fails" "unmarked 'Next safe action:' entries" "$dir"
}

case_next_safe_action_marked_completed_passes() {
  # BOOT-034: a historical envelope whose `Next safe action:` payload
  # starts with `completed` is treated as marked. Validator must still
  # exit 0 overall.
  local dir
  dir="$(copy_repo next-safe-action-marked-completed-passes)"
  cat >>"$dir/AI_HANDOFF.md" <<'EOF'

## Marked Completed Fixture

- Next safe action: completed by PR #12 merge; superseded by the active envelope above.
EOF
  expect_success "next safe action marked completed passes" "$dir"
}

case_next_safe_action_marked_superseded_passes() {
  # BOOT-034: `superseded` at the start of payload marks an envelope
  # as historical.
  local dir
  dir="$(copy_repo next-safe-action-marked-superseded-passes)"
  cat >>"$dir/AI_HANDOFF.md" <<'EOF'

## Marked Superseded Fixture

- Next safe action: superseded by the post-merge cleanup envelope below.
EOF
  expect_success "next safe action marked superseded passes" "$dir"
}

case_next_safe_action_marked_historical_passes() {
  # BOOT-034: a `(historical)` parenthetical at the start of the
  # payload marks an envelope as no longer forward-looking.
  local dir
  dir="$(copy_repo next-safe-action-marked-historical-passes)"
  cat >>"$dir/AI_HANDOFF.md" <<'EOF'

## Marked Historical Fixture

- Next safe action: (historical) commit the fix, push, and request fresh-context Codex review.
EOF
  expect_success "next safe action marked historical passes" "$dir"
}

case_next_safe_action_marked_delegated_passes() {
  # BOOT-034: `delegated` at the start of payload marks an envelope
  # as historical.
  local dir
  dir="$(copy_repo next-safe-action-marked-delegated-passes)"
  cat >>"$dir/AI_HANDOFF.md" <<'EOF'

## Marked Delegated Fixture

- Next safe action: delegated to the BOOT-035 post-merge cleanup envelope below.
EOF
  expect_success "next safe action marked delegated passes" "$dir"
}

case_next_recommended_action_heading_passes() {
  # BOOT-034: the active `## Next Recommended Action` section heading
  # in `CURRENT_STATE.md` is the canonical live next-action location
  # and must not be consumed by the structured-field staleness check.
  # Appending such a heading plus narrative prose into a fresh
  # CURRENT_STATE.md section must not trip the validator and the
  # validator must exit 0 overall.
  local dir
  dir="$(copy_repo next-recommended-action-heading-passes)"
  cat >>"$dir/CURRENT_STATE.md" <<'EOF'

## Next Recommended Action (Red Check Fixture)

Confirm the latest `main` GitHub Actions `Bootstrap Validation` is green,
then proceed with the next Phase 2 backlog item. The validator must not
treat this active heading as a stale `Next safe action:` envelope field.
EOF
  expect_success "next recommended action heading passes" "$dir"
}

case_next_safe_action_prose_not_overmatched() {
  # BOOT-034: prose that mentions the phrase `Next safe action:` inside
  # backticks, inline code, or as a narrative reference must not be
  # treated as a structured envelope field. Only list-item lines that
  # begin with `- Next safe action:` or `* Next safe action:` count.
  local dir
  dir="$(copy_repo next-safe-action-prose-not-overmatched)"
  cat >>"$dir/AI_HANDOFF.md" <<'EOF'

## Prose Mentioning Next Safe Action

This paragraph discusses the structured `Next safe action:` field but
does so as narrative prose, not as a list-item envelope field. The
validator's BOOT-034 guard must ignore this paragraph because it
contains no `- Next safe action:` line.

It is also legal to write `Next safe action:` inside inline code without
the list bullet, since reviewers commonly reference the field name when
they describe what they checked.
EOF
  expect_success "next safe action prose not over-matched" "$dir"
}

case_current_state_stale_next_safe_action_fails() {
  # BOOT-034: the staleness guard applies to `CURRENT_STATE.md` too.
  # Two unmarked structured fields there must trip the validator.
  local dir
  dir="$(copy_repo current-state-stale-next-safe-action-fails)"
  cat >>"$dir/CURRENT_STATE.md" <<'EOF'

## Stale Current State Next Action Fixture

- Next safe action: apply the residual fix and request re-review.
- Next safe action: push the cleanup commit and confirm CI is green.
EOF
  expect_failure "current state stale next safe action fails" "unmarked 'Next safe action:' entries" "$dir"
}

case_marker_word_mid_payload_is_not_marker() {
  # BOOT-034: marker words appearing later in the payload (not at the
  # start of the trimmed payload and not in a leading parenthetical)
  # MUST NOT count as marked. This guards against false negatives like
  # "Next safe action: confirm delegated authority before pushing" or
  # "Next safe action: ensure work is completed before merge", which
  # are legitimate active instructions that happen to mention a marker
  # word in unrelated context. Two such bullets must trip the staleness
  # guard because they are both unmarked.
  local dir
  dir="$(copy_repo marker-word-mid-payload-is-not-marker)"
  cat >>"$dir/AI_HANDOFF.md" <<'EOF'

## Marker Word Mid-Payload Fixture A

- Next safe action: confirm delegated authority before pushing.

## Marker Word Mid-Payload Fixture B

- Next safe action: ensure work is completed before merge.
EOF
  expect_failure "marker word mid payload is not marker" "unmarked 'Next safe action:' entries" "$dir"
}

case_empty_next_safe_action_payload_is_unmarked() {
  # BOOT-034: a bullet with `Next safe action:` and an empty payload
  # (no continuation lines either) is structurally incomplete and
  # must count as unmarked. Two such bullets must trip the staleness
  # guard.
  local dir
  dir="$(copy_repo empty-next-safe-action-payload-is-unmarked)"
  cat >>"$dir/AI_HANDOFF.md" <<'EOF'

## Empty Payload Fixture A

- Next safe action:

## Empty Payload Fixture B

- Next safe action:
EOF
  expect_failure "empty next safe action payload is unmarked" "unmarked 'Next safe action:' entries" "$dir"
}

case_multiline_marked_next_safe_action_passes() {
  # BOOT-034: multiline bullets where the marker is on the first line
  # (typical case) must still pass. The validator stitches
  # continuation lines into the same payload, but marker detection
  # looks only at the start of the trimmed payload, which is the
  # marker word here.
  local dir
  dir="$(copy_repo multiline-marked-next-safe-action-passes)"
  cat >>"$dir/AI_HANDOFF.md" <<'EOF'

## Multiline Marked Fixture

- Next safe action: completed by PR #12 merge; superseded by the
  active envelope above. Confirmed by GitHub Actions run 25960081829
  succeeding on `main` at `f116f85`.
EOF
  expect_success "multiline marked next safe action passes" "$dir"
}

case_fenced_code_next_safe_action_ignored() {
  # BOOT-034: bullets inside fenced Markdown code blocks (``` or ~~~)
  # are illustrative examples, not real envelope fields. They must
  # not be counted toward the unmarked-entry total. Two unmarked
  # bullets inside a code fence plus zero outside must keep the
  # validator passing.
  local dir
  dir="$(copy_repo fenced-code-next-safe-action-ignored)"
  cat >>"$dir/AI_HANDOFF.md" <<'EOF'

## Fenced Code Block Fixture

Documenting examples of the envelope field for reviewers:

```text
- Next safe action: apply the fix and request re-review.
- Next safe action: push the cleanup commit and confirm CI is green.
```

The examples above are illustrative only and must not count as
unmarked envelope fields.
EOF
  expect_success "fenced code next safe action ignored" "$dir"
}

case_approved_spec_missing_source
case_approved_spec_empty_source
case_active_backlog_missing_spec
case_command_missing_required_reads
case_source_registry_missing_status
case_source_registry_missing_processing_state
case_assumption_missing_expiry
case_approved_assumption_missing_evidence
case_approved_assumption_self_approved
case_approved_assumption_unsupported_evidence
case_operation_routing_missing_profile
case_operation_routing_missing_validation_mode
case_operation_routing_missing_context_reference
case_research_dir_does_not_trip_validator
case_raw_intake_md_does_not_trip_validator
case_backlog_index_item_status_mismatch_fails
case_template_starter_ai_handoff_passes_section_check
case_claude_worktree_does_not_trip_validator
case_canonical_active_state_rejects_volatile_session_text
case_local_session_ignored_by_validator
case_local_session_profile_routes_shape_only
case_no_local_session_profile_routes_strict
case_stale_local_session_profile_routes_strict
case_branch_mismatch_local_session_profile_routes_strict
case_canonical_allowed_split_state_wording_passes
case_handoff_without_classification_passes
case_role_unconditional_committed_state_rule_fails
case_policy_unconditional_committed_state_rule_fails
case_policy_reintroduces_required_human_approval_fails
case_role_reintroduces_required_human_approval_fails
case_policy_negation_phrasing_passes
case_setup_guide_reintroduces_required_approving_review_count_fails
case_setup_guide_reintroduces_require_code_owner_reviews_fails
case_setup_guide_reintroduces_require_last_push_approval_fails
case_setup_guide_disabled_github_keys_pass
case_policy_reintroduces_required_human_approval_wrapped_fails
case_setup_guide_reintroduces_non_null_required_pull_request_reviews_fails
case_setup_guide_null_required_pull_request_reviews_passes
case_scaffold_extract_golden_validates
case_scaffold_extract_dry_run_writes_nothing
case_scaffold_extract_refuses_source_as_target
case_scaffold_extract_refuses_nonempty_without_force
case_scaffold_extract_registry_includes_kept_framework_paths
case_scaffold_extract_reset_files_use_header_only_tables
case_scaffold_extract_contract_detects_forbidden_string_contamination
case_unregistered_src_id_fails
case_unregistered_spec_id_fails
case_registered_src_id_passes
case_provisional_src_id_passes
case_provisional_spec_id_passes
case_stale_next_safe_action_historical_fails
case_next_safe_action_marked_completed_passes
case_next_safe_action_marked_superseded_passes
case_next_safe_action_marked_historical_passes
case_next_safe_action_marked_delegated_passes
case_next_recommended_action_heading_passes
case_next_safe_action_prose_not_overmatched
case_current_state_stale_next_safe_action_fails
case_marker_word_mid_payload_is_not_marker
case_empty_next_safe_action_payload_is_unmarked
case_multiline_marked_next_safe_action_passes
case_fenced_code_next_safe_action_ignored

if [[ "$failures" -ne 0 ]]; then
  echo "Bootstrap red checks failed with $failures issue(s)." >&2
  exit 1
fi

echo "Bootstrap red checks passed."

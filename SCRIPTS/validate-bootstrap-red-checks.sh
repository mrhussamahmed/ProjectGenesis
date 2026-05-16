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
  # On GitHub Actions `pull_request` events the checkout is a detached
  # HEAD so `git branch --show-current` succeeds but returns an empty
  # string; that empty value would make `symbolic-ref HEAD refs/heads/`
  # fail and leave the temp repo on the implicit `master` default,
  # which then trips the validator's `AI_HANDOFF.md` branch-mismatch
  # check inside every red-check fixture. Fall back to reading the
  # branch name out of `AI_HANDOFF.md` itself (the validator's source
  # of truth for the current branch) so the temp repo's HEAD always
  # matches what the fixture's `AI_HANDOFF.md` declares.
  current_branch="$(git -C "$repo_root" branch --show-current 2>/dev/null || true)"
  if [[ -z "$current_branch" ]]; then
    current_branch="$(awk '
      /^## Current Branch$/ {
        getline
        getline
        gsub(/`/, "")
        gsub(/^[ \t]+|[ \t]+$/, "")
        print
        exit
      }
    ' "$repo_root/AI_HANDOFF.md" 2>/dev/null)"
  fi
  [[ -z "$current_branch" ]] && current_branch="main"
  mkdir -p "$dest"
  rsync -a --exclude '.git' "$repo_root/" "$dest/"
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
  printf '\n' >>"$dir/BACKLOG.md"
  cat >>"$dir/BACKLOG.md" <<'EOF'
| RED-001 | Invalid active backlog item | Missing linked spec evidence. | P1 | medium | medium | none | ready | sequential | Implementation Agent |
EOF
  expect_failure "active backlog missing linked spec" "active backlog item missing linked spec" "$dir"
}

init_fixture_git_history_on_main() {
  local dir="$1"

  git -C "$dir" config user.email "bootstrap-red-check@example.invalid"
  git -C "$dir" config user.name "Bootstrap Red Check"
  git -C "$dir" symbolic-ref HEAD refs/heads/main
  git -C "$dir" add -A
  git -C "$dir" commit -qm "Initial red-check fixture"
}

set_handoff_branch() {
  local dir="$1"
  local handoff_branch="$2"

  HANDOFF_BRANCH="$handoff_branch" perl -0pi -e 's/(## Current Branch\n\n)`[^`]+`/$1 . chr(96) . $ENV{HANDOFF_BRANCH} . chr(96)/e' "$dir/AI_HANDOFF.md"
}

case_handoff_branch_mismatch() {
  local dir
  dir="$(copy_repo handoff-branch-mismatch)"
  set_handoff_branch "$dir" "red-mismatch-branch"
  expect_failure "handoff branch mismatch" "AI_HANDOFF.md branch does not match git branch" "$dir"
}

create_github_merge_fixture() {
  local dir="$1"
  local handoff_branch="$2"
  local merge_source_branch="$3"
  local merge_subject="${4:-Merge pull request #999 from red/$merge_source_branch}"

  init_fixture_git_history_on_main "$dir"
  git -C "$dir" checkout -qb "$handoff_branch"
  set_handoff_branch "$dir" "$handoff_branch"
  git -C "$dir" add AI_HANDOFF.md
  git -C "$dir" commit -qm "Set handoff branch to $handoff_branch"
  git -C "$dir" checkout -q main
  git -C "$dir" merge --no-ff "$handoff_branch" -m "$merge_subject" >/dev/null
}

case_main_non_merge_handoff_branch_mismatch() {
  local dir
  dir="$(copy_repo main-non-merge-handoff-branch-mismatch)"
  init_fixture_git_history_on_main "$dir"
  set_handoff_branch "$dir" "codex/red-main-stale-branch"
  expect_failure "main non-merge handoff branch mismatch" "AI_HANDOFF.md branch does not match git branch" "$dir"
}

case_main_github_merge_source_handoff_branch_passes() {
  local dir
  dir="$(copy_repo main-github-merge-source-handoff-branch-passes)"
  create_github_merge_fixture "$dir" "codex/red-merge-source" "codex/red-merge-source"
  expect_success "main GitHub merge source handoff branch passes" "$dir"
}

case_main_github_merge_shallow_checkout_passes() {
  local dir
  local shallow_dir="$tmp_root/main-github-merge-shallow-checkout-passes"
  dir="$(copy_repo main-github-merge-shallow-source)"
  create_github_merge_fixture "$dir" "codex/red-merge-shallow-source" "codex/red-merge-shallow-source"
  git clone --depth=1 --branch main "file://$dir" "$shallow_dir" >/dev/null 2>&1
  expect_success "main GitHub merge shallow checkout passes" "$shallow_dir"
}

case_main_github_merge_mismatched_handoff_branch_fails() {
  local dir
  dir="$(copy_repo main-github-merge-mismatched-handoff-branch-fails)"
  create_github_merge_fixture "$dir" "codex/red-merge-handoff" "codex/red-merge-source"
  expect_failure "main GitHub merge mismatched handoff branch" "AI_HANDOFF.md branch does not match git branch" "$dir"
}

case_main_unparseable_merge_handoff_branch_fails() {
  local dir
  dir="$(copy_repo main-unparseable-merge-handoff-branch-fails)"
  create_github_merge_fixture "$dir" "codex/red-merge-source" "codex/red-merge-source" "Merge branch 'codex/red-merge-source'"
  expect_failure "main unparseable merge handoff branch" "AI_HANDOFF.md branch does not match git branch" "$dir"
}

case_main_octopus_merge_handoff_branch_fails() {
  local dir
  dir="$(copy_repo main-octopus-merge-handoff-branch-fails)"
  init_fixture_git_history_on_main "$dir"
  git -C "$dir" checkout -qb codex/red-octopus-a
  set_handoff_branch "$dir" "codex/red-octopus-a"
  git -C "$dir" add AI_HANDOFF.md
  git -C "$dir" commit -qm "Set handoff branch to octopus source"
  git -C "$dir" checkout -q main
  git -C "$dir" checkout -qb codex/red-octopus-b
  printf '\nRed-check octopus side branch.\n' >>"$dir/TEST_RESULTS.md"
  git -C "$dir" add TEST_RESULTS.md
  git -C "$dir" commit -qm "Add octopus side branch fixture"
  git -C "$dir" checkout -q main
  git -C "$dir" merge --no-ff codex/red-octopus-a codex/red-octopus-b \
    -m "Merge pull request #999 from red/codex/red-octopus-a" >/dev/null
  expect_failure "main octopus merge handoff branch" "AI_HANDOFF.md branch does not match git branch" "$dir"
}

case_main_github_merge_other_handoff_failures_still_fail() {
  local dir
  dir="$(copy_repo main-github-merge-other-handoff-failures-still-fail)"
  create_github_merge_fixture "$dir" "codex/red-merge-source" "codex/red-merge-source"
  perl -0pi -e 's/^## Tests Run$/## Removed Tests Run/m' "$dir/AI_HANDOFF.md"
  expect_failure "main GitHub merge other handoff failures still fail" "AI_HANDOFF.md missing section: ## Tests Run" "$dir"
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

case_protected_mechanics_misclassified() {
  # Slice 3 trimmed AI_HANDOFF.md to active state only, so the old in-place
  # perl substitution had no source to mutate. Append a self-contained
  # fixture classification block that mimics the misclassification we want
  # the validator to flag.
  local dir
  dir="$(copy_repo protected-mechanics-misclassified)"
  cat >>"$dir/AI_HANDOFF.md" <<'EOF'

## Pre-Change Classification (red-check fixture mechanics misclassified)

- Target files: `SCRIPTS/validate-bootstrap.sh`, `.githooks/pre-commit`,
  `memory/ai/SHARED_AGENT_RULES.md`, `GOVERNANCE.md`,
  `OPERATION_ROUTING.md`
- Operation profile: `planning-governance`
- Protected files touched: true
- Reason: Red-check fixture mechanics misclassified; touching validator,
  hooks, role files, governance, and routing should escalate to
  strict-protected.
EOF
  expect_failure "protected mechanics misclassified" "protected mechanics classification must be strict-protected" "$dir"
}

case_protected_planning_misclassified() {
  # Slice 3 trimmed AI_HANDOFF.md's old BOOT-019-024 classification block
  # away. Append a self-contained fixture block that mimics the
  # misclassification we want the validator to flag (planning artifacts
  # touched, but profile lower than planning-governance).
  local dir
  dir="$(copy_repo protected-planning-misclassified)"
  cat >>"$dir/AI_HANDOFF.md" <<'EOF'

## Pre-Change Classification (red-check fixture planning misclassified)

- Target files: `SPECS/SPEC_INDEX.md`, `BACKLOG.md`,
  `TRACEABILITY_MATRIX.md`, `ARTIFACT_REGISTRY.md`
- Operation profile: `docs-trivial`
- Protected files touched: false
- Reason: Red-check fixture planning misclassified; touching specs,
  backlog, traceability, and registry should escalate to
  planning-governance.
EOF
  expect_failure "protected planning misclassified" "protected planning classification must be planning-governance or strict-protected" "$dir"
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

case_protected_planning_misclassified_in_second_block() {
  local dir
  dir="$(copy_repo protected-planning-misclassified-second-block)"
  cat >>"$dir/AI_HANDOFF.md" <<'EOF'

## Pre-Change Classification (red-check fixture second block)

- Operation profile: `docs-trivial`
- Target files: `SPECS/`, `BACKLOG.md`, `TRACEABILITY_MATRIX.md`,
  `ARTIFACT_REGISTRY.md`
- Protected files touched: false
- Reason: Red-check fixture second block; this profile should escalate
  to planning-governance because target_files include planning artifacts.
EOF
  expect_failure "protected planning misclassified in second block" "protected planning classification must be planning-governance or strict-protected" "$dir"
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
  # This guards against silent registry drift relative to
  # SCAFFOLD_FORK_CHECKLIST.md "Framework Files To Keep".
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
    "GITHUB_REPOSITORY_SETUP.md" \
    "GOVERNANCE_PERFORMANCE.md" \
    ".github/CODEOWNERS" \
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

case_scaffold_extract_reset_files_use_header_only_tables() {
  # Coverage: the extracted shared-state reset files must match the
  # SCAFFOLD_FORK_CHECKLIST.md header-only table contract for STALE_ITEMS.md,
  # ADR/ADR_INDEX.md, and HANDOFFS/HANDOFF_INDEX.md.
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
  # STALE_ITEMS.md: header table row but no body row.
  if ! grep -Fq "| Item | Type | Detected | Status | Resolution |" "$target/STALE_ITEMS.md"; then
    echo "FAIL: STALE_ITEMS.md missing header-only stale-items table header" >&2
    failures=$((failures + 1))
  fi
  if grep -Eq '^\| [^|]+\| [^|]+\| [^|]+\| [^|]+\| [^|]+\|$' "$target/STALE_ITEMS.md" \
       | grep -v "Item " | grep -v "----" >/dev/null 2>&1; then
    : # placeholder so set -e does not trip
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
  # HANDOFFS/HANDOFF_INDEX.md: must contain a header-only handoff table.
  if ! grep -Fq "| Date | Agent | Role | Branch | Worktree | File |" "$target/HANDOFFS/HANDOFF_INDEX.md"; then
    echo "FAIL: HANDOFFS/HANDOFF_INDEX.md missing header-only handoff table header" >&2
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

case_copy_repo_recovers_handoff_branch_when_source_is_detached() {
  # BOOT-034 v1.6: in GitHub Actions `pull_request` events the
  # source repo is checked out in detached HEAD, so
  # `git branch --show-current` returns empty. The previous
  # `copy_repo` then ran `symbolic-ref HEAD refs/heads/` with an
  # empty branch, which left the temp repo on the implicit `master`
  # default and tripped the validator's branch-mismatch check inside
  # every BOOT-034 pass fixture. The fix falls back to reading the
  # branch from `AI_HANDOFF.md` itself. This fixture exercises the
  # detached HEAD recovery directly.
  local detached_src="$tmp_root/detached-head-source"
  rm -rf "$detached_src"
  git clone --no-local "$repo_root" "$detached_src" >/dev/null 2>&1
  git -C "$detached_src" checkout --detach >/dev/null 2>&1
  local handoff_branch
  handoff_branch="$(awk '
    /^## Current Branch$/ {
      getline
      getline
      gsub(/`/, "")
      gsub(/^[ \t]+|[ \t]+$/, "")
      print
      exit
    }
  ' "$detached_src/AI_HANDOFF.md")"
  local saved_root="$repo_root"
  repo_root="$detached_src"
  local copy_dir
  copy_dir="$(copy_repo detached-head-copy)"
  repo_root="$saved_root"
  local got
  got="$(git -C "$copy_dir" symbolic-ref --short HEAD 2>/dev/null || true)"
  if [[ "$got" != "$handoff_branch" ]]; then
    echo "FAIL: copy_repo did not recover handoff branch under detached HEAD" >&2
    echo "  expected: $handoff_branch" >&2
    echo "  got:      $got" >&2
    failures=$((failures + 1))
  fi
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
case_handoff_branch_mismatch
case_main_non_merge_handoff_branch_mismatch
case_main_github_merge_source_handoff_branch_passes
case_main_github_merge_shallow_checkout_passes
case_main_github_merge_mismatched_handoff_branch_fails
case_main_unparseable_merge_handoff_branch_fails
case_main_octopus_merge_handoff_branch_fails
case_main_github_merge_other_handoff_failures_still_fail
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
case_protected_mechanics_misclassified
case_protected_planning_misclassified
case_research_dir_does_not_trip_validator
case_claude_worktree_does_not_trip_validator
case_protected_planning_misclassified_in_second_block
case_scaffold_extract_golden_validates
case_scaffold_extract_dry_run_writes_nothing
case_scaffold_extract_refuses_source_as_target
case_scaffold_extract_refuses_nonempty_without_force
case_scaffold_extract_registry_includes_kept_framework_paths
case_scaffold_extract_reset_files_use_header_only_tables
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
case_copy_repo_recovers_handoff_branch_when_source_is_detached

if [[ "$failures" -ne 0 ]]; then
  echo "Bootstrap red checks failed with $failures issue(s)." >&2
  exit 1
fi

echo "Bootstrap red checks passed."

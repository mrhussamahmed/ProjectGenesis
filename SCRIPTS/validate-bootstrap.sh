#!/usr/bin/env bash
set -euo pipefail

repo_root="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
cd "$repo_root"

# Validator profile (slice 4 adaptive routing).
#
#   strict (default)     — run all checks.
#   state-sync           — run shape + AI_HANDOFF sections + registry path
#                          registration checks; skip cross-validation and
#                          deep awk-based content checks.
#   shape-only           — run only required-files / required-dirs and
#                          YAML metadata checks. Used for docs-trivial
#                          and process-light-exception operations.
#
# The default remains strict; non-strict levels are only used when the
# hook layer explicitly opts in via BOOTSTRAP_VALIDATE_PROFILE, AND the
# hook has confirmed that no strict-gate path is in the staged file set.
BOOTSTRAP_VALIDATE_PROFILE="${BOOTSTRAP_VALIDATE_PROFILE:-strict}"

# Scaffold context detection (reuse-boundary slice).
#
# The validator runs in one of two contexts:
#
#   maintainer (default) — the source/maintainer ProjectGenesis repository.
#                          Strict source-repository checks apply, including
#                          maintainer-only required files such as
#                          BOOTSTRAP_AUDIT.md and TESTS/ADVERSARIAL_SEED_BENCHMARK.md.
#
#   downstream            — a scaffold extracted with `SCRIPTS/scaffold-extract.sh`.
#                          A positive marker file `.bootstrap-scaffold-mode` whose
#                          exact content is `downstream` selects this mode. The
#                          extractor writes this marker. Downstream mode skips
#                          maintainer-only required files because they are
#                          excluded by the extraction contract.
#
# The marker is positive: absence of the marker keeps the validator in
# maintainer mode, so a source checkout cannot be misdetected as downstream
# by deleting files. `.bootstrap-scaffold-mode` is listed in `.gitignore` in
# the source repository to prevent accidental commits.
if [[ -f .bootstrap-scaffold-mode ]] && \
   [[ "$(cat .bootstrap-scaffold-mode)" == "downstream" ]]; then
  scaffold_context="downstream"
else
  scaffold_context="maintainer"
fi

failures=0

fail() {
  echo "FAIL: $*" >&2
  failures=$((failures + 1))
}

check_file() {
  local path="$1"
  [[ -f "$path" ]] || fail "missing required file: $path"
}

check_dir() {
  local path="$1"
  [[ -d "$path" ]] || fail "missing required directory: $path"
}

# Mixed-mode guard: a downstream scaffold must not contain the upstream-only
# extraction script. Catches the case where a maintainer accidentally created
# `.bootstrap-scaffold-mode` in the source repo, and the case where a
# downstream consumer copied the extraction script into their tree.
if [[ "$scaffold_context" == "downstream" ]] && \
   [[ -f SCRIPTS/scaffold-extract.sh ]]; then
  fail "Invalid scaffold mode: downstream marker present with maintainer-only source files (SCRIPTS/scaffold-extract.sh)"
fi

# Required files for every scaffold (maintainer + downstream).
common_required_files=(
  "AI_PROJECT_BOOTSTRAP.md"
  "BOOTSTRAP_USAGE.md"
  "NEW_PROJECT_INITIALIZATION.md"
  "CLAUDE.md"
  "AGENTS.md"
  "GOVERNANCE.md"
  "OPERATION_ROUTING.md"
  "CURRENT_STATE.md"
  "AI_HANDOFF.md"
  "CONTEXT_INDEX.md"
  "ARCHITECTURE.md"
  "DECISIONS.md"
  "OPEN_QUESTIONS.md"
  "BACKLOG.md"
  "IMPLEMENTATION_PLAN.md"
  "BRANCH_AND_WORKTREE_GUIDE.md"
  "ARTIFACT_REGISTRY.md"
  "TRACEABILITY_MATRIX.md"
  "TEST_STRATEGY.md"
  "TEST_RESULTS.md"
  "PR_REVIEW_POLICY.md"
  "PR_MERGE_POLICY.md"
  "AI_REVIEW_PROMPTS.md"
  "00_intake/SOURCE_REGISTRY.md"
  "00_intake/INTAKE_INDEX.md"
  "00_intake/research/RESEARCH_NOTE_TEMPLATE.md"
  "00_intake/summaries/SUMMARY_TEMPLATE.md"
  "01_context/PROJECT_BRIEF.md"
  "01_context/PROJECT_CHARTER.md"
  "01_context/GLOSSARY.md"
  "01_context/CONSTRAINTS.md"
  "02_requirements/REQUIREMENTS_INDEX.md"
  "02_requirements/ASSUMPTIONS_REGISTER.md"
  "02_requirements/RISK_REGISTER.md"
  "CONTEXT_PACKS/README.md"
  "CONTEXT_PACKS/product-intake.md"
  "CONTEXT_PACKS/spec-authoring.md"
  "CONTEXT_PACKS/architecture.md"
  "CONTEXT_PACKS/implementation.md"
  "CONTEXT_PACKS/review.md"
  "CONTEXT_PACKS/resume.md"
  "COMMANDS/COMMAND_INDEX.md"
  "COMMANDS/COMMAND_TEMPLATE.md"
  "memory/ai/SHARED_AGENT_RULES.md"
  "memory/ai/ROLE_PRODUCT_ANALYST.md"
  "memory/ai/ROLE_SPEC_AUTHOR.md"
  "memory/ai/ROLE_ARCHITECT.md"
  "memory/ai/ROLE_BACKLOG_PLANNER.md"
  "memory/ai/ROLE_IMPLEMENTATION_AGENT.md"
  "memory/ai/ROLE_QA_REVIEWER.md"
  "memory/ai/ROLE_SECURITY_REVIEWER.md"
  "memory/ai/ROLE_DEVOPS_RELEASE_REVIEWER.md"
  "memory/ai/ROLE_DOCUMENTATION_CURATOR.md"
  "memory/ai/ROLE_ADVERSARIAL_PR_REVIEWER.md"
  "RISK_MODEL.md"
  "HOOKS_AND_GUARDRAILS.md"
  "RELEASE_READINESS.md"
  "SECURITY_AND_PRIVACY.md"
  "OBSERVABILITY.md"
  "CI_CD_GUIDE.md"
  "CONTRIBUTING.md"
  "SPECS/SPEC_INDEX.md"
  "SPECS/templates/SPEC_TEMPLATE.md"
  "ADR/ADR_INDEX.md"
  "ADR/templates/ADR_TEMPLATE.md"
  "BACKLOG/BACKLOG_INDEX.md"
  "BACKLOG/templates/BACKLOG_ITEM_TEMPLATE.md"
  "REVIEWS/REVIEW_INDEX.md"
  "REVIEWS/templates/ADVERSARIAL_PR_REVIEW_TEMPLATE.md"
  "REVIEWS/templates/PR_REVIEW_PACKAGE_TEMPLATE.md"
  "TESTS/MANUAL_TEST_CHECKLIST.md"
  "WORKLOG/WORKLOG_INDEX.md"
  "COMMANDS/validate-idea.md"
  "COMMANDS/start-architecture-design.md"
  "COMMANDS/implement-next-story.md"
  "COMMANDS/resume-work.md"
  "COMMANDS/export-backlog-to-linear.md"
  "SPECS/templates/TECH_DESIGN_TEMPLATE.md"
  "TEMPLATE_STARTERS/SESSION.md"
  "TEMPLATE_STARTERS/ACCEPTANCE_CRITERIA_MAP.md"
  "SCRIPTS/start-claude.sh"
  "SCRIPTS/operation-profile.sh"
  "SCRIPTS/session.sh"
  "SCRIPTS/doctor.sh"
  "SCRIPTS/strict-gate-paths.sh"
  "SCRIPTS/validate-bootstrap.sh"
  "SCRIPTS/validate-bootstrap-red-checks.sh"
  "SCRIPTS/metric-evidence-coverage.sh"
  "SCRIPTS/metric-traceability-completeness.sh"
  ".githooks/pre-commit"
  ".githooks/commit-msg"
  ".githooks/pre-push"
  ".github/workflows/bootstrap-validation.yml"
)

# Required files only in the maintainer/source scaffold. These are excluded
# from extracted downstream scaffolds because they carry ProjectGenesis-
# specific history, owner attribution, or maintainer-only tooling.
maintainer_only_required_files=(
  "BOOTSTRAP_AUDIT.md"
  "GOVERNANCE_PERFORMANCE.md"
  "PARALLEL_EXECUTION_PLAN.md"
  "STALE_ITEMS.md"
  "TESTS/ACCEPTANCE_CRITERIA_MAP.md"
  "SCRIPTS/metric-acceptance-coverage.sh"
  "TESTS/ADVERSARIAL_SEED_BENCHMARK.md"
  "SCRIPTS/scaffold-extract.sh"
  "SCRIPTS/run-seeded-defect-bench.sh"
)

common_required_dirs=(
  "SPECS"
  "SPECS/templates"
  "ADR"
  "ADR/templates"
  "BACKLOG"
  "BACKLOG/templates"
  "REVIEWS"
  "REVIEWS/templates"
  "TESTS"
  "WORKLOG"
  "00_intake"
  "00_intake/raw"
  "00_intake/research"
  "00_intake/summaries"
  "01_context"
  "02_requirements"
  "CONTEXT_PACKS"
  "COMMANDS"
  "memory"
  "memory/ai"
  "SCRIPTS"
  ".githooks"
  ".github/workflows"
)

maintainer_only_required_dirs=(
  "MAINTAINER_ARCHIVE"
  "MAINTAINER_ARCHIVE/ARTIFACTS"
  "MAINTAINER_ARCHIVE/ARTIFACTS/ARCHIVE"
)

required_files=("${common_required_files[@]}")
required_dirs=("${common_required_dirs[@]}")
if [[ "$scaffold_context" == "maintainer" ]]; then
  required_files+=("${maintainer_only_required_files[@]}")
  required_dirs+=("${maintainer_only_required_dirs[@]}")
fi

# Downstream scaffolds must carry the positive marker file with exact content.
if [[ "$scaffold_context" == "downstream" ]]; then
  if [[ -f .bootstrap-scaffold-mode ]]; then
    marker_content="$(cat .bootstrap-scaffold-mode)"
    if [[ "$marker_content" != "downstream" ]]; then
      fail ".bootstrap-scaffold-mode must contain exactly 'downstream' (found: '$marker_content')"
    fi
  else
    fail "downstream scaffold missing required marker: .bootstrap-scaffold-mode"
  fi
fi

for path in "${required_files[@]}"; do
  check_file "$path"
done

for path in "${required_dirs[@]}"; do
  check_dir "$path"
done

while IFS= read -r file; do
  case "$file" in
    ./AGENTS.md|./CLAUDE.md|./README.md|./SPECS/templates/*|./ADR/templates/*|./BACKLOG/templates/*|./REVIEWS/templates/*|./00_intake/raw/*) continue ;;
  esac
  file="${file#./}"
  grep -Eq '^artifact_id: .+' "$file" || fail "$file missing non-empty artifact_id metadata"
  grep -Eq '^status: .+' "$file" || fail "$file missing status metadata"
  grep -Eq '^version: .+' "$file" || fail "$file missing version metadata"
  grep -Eq '^authoritative: (true|false)$' "$file" || fail "$file missing authoritative metadata"
done < <(find . \
  \( -path './.git' -o -path './.claude' -o -path './.ai' -o -path './research' \) -prune \
  -o -type f -name '*.md' -print)

# Fast-path early-exit for shape-only profile (slice 4).
if [[ "$BOOTSTRAP_VALIDATE_PROFILE" == "shape-only" ]]; then
  if (( failures > 0 )); then
    echo "Bootstrap validation failed with $failures issue(s) (shape-only profile)." >&2
    exit 1
  fi
  echo "Bootstrap validation passed (shape-only profile; deep checks skipped per BOOTSTRAP_VALIDATE_PROFILE=shape-only)."
  exit 0
fi

for section in \
  "## Baseline" \
  "## Last Validated" \
  "## Next Recommended Action" \
  "## Known Risks" \
  "## Open Threads" \
  "## Read First"; do
  grep -Fq "$section" AI_HANDOFF.md || fail "AI_HANDOFF.md missing section: $section"
done

check_canonical_active_state_sections() {
  local target="$1"
  [[ -f "$target" ]] || return 0
  awk '
    function active_section(name) {
      return name == "## Next Recommended Action" ||
        name == "## Open Threads" ||
        name == "## Active Branch" ||
        name == "## Active Backlog Focus" ||
        name == "## Active Implementation Phase" ||
        name == "## Current Blockers"
    }
    function emit(reason) {
      print FILENAME ":" NR ": " reason ": " $0
    }
    /^## / {
      section = $0
      in_active = active_section(section)
      next
    }
    in_active {
      lower = tolower($0)
      if ($0 ~ /\.claude\/worktrees\//) {
        emit("canonical state contains active volatile session text")
      }
      if ($0 ~ /`?(claude|codex)\/[A-Za-z0-9._-]+`?/) {
        emit("canonical state contains active volatile session text")
      }
      if (lower ~ /awaiting .*merge/ || lower ~ /push .*cleanup/ || lower ~ /verify .*ci/) {
        emit("canonical state contains active volatile session text")
      }
      if ((lower ~ /\.ai\/session\.md/ && lower ~ /(canonical source of truth|durable evidence|shared review evidence)/) ||
          (lower ~ /(canonical source of truth|durable evidence|shared review evidence)/ && lower ~ /\.ai\/session\.md/)) {
        emit("canonical state incorrectly treats local session as durable evidence")
      }
    }
  ' "$target"
}

for canonical_state_file in AI_HANDOFF.md CURRENT_STATE.md; do
  canonical_state_hits="$(check_canonical_active_state_sections "$canonical_state_file")"
  if [[ -n "$canonical_state_hits" ]]; then
    printf '%s\n' "$canonical_state_hits" >&2
    fail "$canonical_state_file canonical state contains active volatile session text"
  fi
done

placeholder_pattern='TODO|TBD|FIXME|REPLACE_ME|YOUR_|NEEDS CLARIFICATION'
while IFS= read -r file; do
  case "$file" in
    SPECS/templates/*|ADR/templates/*|BACKLOG/templates/*|REVIEWS/templates/*|00_intake/raw/*) continue ;;
  esac
  # Capture grep output in a shell variable instead of writing through /tmp;
  # earlier behavior wrote to /tmp/bootstrap-placeholder-hit.$$ and silently
  # degraded in restricted environments where /tmp was not writable.
  placeholder_hits="$(grep -En "$placeholder_pattern" "$file" 2>/dev/null || true)"
  if [[ -n "$placeholder_hits" ]]; then
    echo "Potential unresolved placeholder in $file:" >&2
    printf '%s\n' "$placeholder_hits" >&2
    fail "$file contains unresolved placeholder-like text"
  fi
done < <(find . \
  \( -path './.git' -o -path './.claude' -o -path './.ai' -o -path './research' \) -prune \
  -o -type f -name '*.md' -print | sed 's#^\./##')

while IFS= read -r file; do
  if grep -Eq '^status: (approved|active)$' "$file"; then
    while IFS= read -r requirement_id; do
      [[ -n "$requirement_id" ]] && fail "$file approved spec missing source IDs: $requirement_id"
    done < <(awk -F'|' '
      function trim(value) {
        gsub(/^[ \t]+|[ \t]+$/, "", value)
        return value
      }
      /^\|/ {
        first = trim($2)
        if (first == "ID") {
          source_col = 0
          for (i = 2; i < NF; i++) {
            header = tolower(trim($i))
            if (header == "source" || header == "source ids") {
              source_col = i
            }
          }
          next
        }
        if (first ~ /(^|-)FR-[A-Za-z0-9]/ || first ~ /(^|-)NFR-[A-Za-z0-9]/) {
          if (source_col == 0) {
            print first
            next
          }
          source_value = trim($(source_col))
          if (source_value == "" || tolower(source_value) == "none") {
            print first
          }
        }
      }
    ' "$file")
  fi
done < <(find SPECS -maxdepth 1 -type f -name '*.md' -print)

while IFS= read -r id; do
  [[ -n "$id" ]] && fail "BACKLOG/BACKLOG_INDEX.md active backlog item missing linked spec: $id"
done < <(awk -F'|' '
  function trim(value) {
    gsub(/^[ \t]+|[ \t]+$/, "", value)
    return value
  }
  /^\| [^|-]/ && $2 !~ /Item ID/ {
    id = trim($2)
    status = trim($5)
    linked_spec = trim($9)
    if (id !~ /^BOOT-/ && status ~ /^(ready|in-progress|in-review|done)$/ && linked_spec !~ /(SPEC-|discovery exception|bootstrap-governance exception)/) {
      print id
    }
  }
' BACKLOG/BACKLOG_INDEX.md)

# Backlog status single-truth check: each index row status must match the
# item file frontmatter (readiness: preferred, status: fallback).
while IFS= read -r mismatch; do
  [[ -n "$mismatch" ]] && fail "backlog status mismatch (index vs item frontmatter): $mismatch"
done < <(awk -F'|' '
  function trim(value) {
    gsub(/^[ \t]+|[ \t]+$/, "", value)
    return value
  }
  /^\| [^|-]/ && $2 !~ /Item ID/ {
    id = trim($2)
    file = trim($4)
    gsub(/`/, "", file)
    status = trim($5)
    if (file != "" && status != "") {
      print id "\t" file "\t" status
    }
  }
' BACKLOG/BACKLOG_INDEX.md | while IFS=$'\t' read -r item_id item_file index_status; do
  if [[ ! -f "$item_file" ]]; then
    echo "$item_id index row references missing file $item_file"
    continue
  fi
  item_status="$(awk '
    NR > 20 { exit }
    /^readiness:[[:space:]]*[^[:space:]]/ && readiness == "" { sub(/^readiness:[[:space:]]*/, ""); readiness = $0 }
    /^status:[[:space:]]*[^[:space:]]/ && status == "" { sub(/^status:[[:space:]]*/, ""); status = $0 }
    END { if (readiness != "") print readiness; else print status }
  ' "$item_file" | tr -d ' ')"
  [[ -z "$item_status" ]] && continue
  if [[ "$item_status" != "$index_status" ]]; then
    echo "$item_id index=$index_status item=$item_status"
  fi
done)

if [[ -d COMMANDS ]]; then
  while IFS= read -r file; do
    case "$file" in
      COMMANDS/COMMAND_INDEX.md) continue ;;
    esac
    for section in \
      "## Purpose" \
      "## Required Role" \
      "## Required Files To Read" \
      "## Inputs" \
      "## Outputs" \
      "## Stop Conditions" \
      "## Validation" \
      "## Authority Limit"; do
      grep -Fq "$section" "$file" || fail "$file command missing section: $section"
    done
  done < <(find COMMANDS -maxdepth 1 -type f -name '*.md' -print)
fi

if [[ -d CONTEXT_PACKS ]]; then
  while IFS= read -r file; do
    for section in \
      "## Files To Read First" \
      "## Files To Read If Relevant" \
      "## Files Not To Scan Unless Needed" \
      "## Expected Outputs" \
      "## Stop Conditions" \
      "## Authority Limit"; do
      grep -Fq "$section" "$file" || fail "$file context pack missing section: $section"
    done
    grep -Fq "cannot" "$file" || fail "$file context pack missing explicit authority limit"
  done < <(find CONTEXT_PACKS -maxdepth 1 -type f -name '*.md' ! -name 'README.md' -print)
fi

if [[ -f "00_intake/SOURCE_REGISTRY.md" ]]; then
  while IFS='|' read -r kind id; do
    case "$kind" in
      freshness) fail "00_intake/SOURCE_REGISTRY.md source registry row missing freshness: $id" ;;
      processing) fail "00_intake/SOURCE_REGISTRY.md source registry row missing processing state: $id" ;;
    esac
  done < <(awk -F'|' '
    function trim(value) {
      gsub(/^[ \t]+|[ \t]+$/, "", value)
      return value
    }
    /^\| SRC-/ {
      id = trim($2)
      freshness = trim($7)
      processing = trim($8)
      if (freshness == "" || freshness == "none") {
        print "freshness|" id
      }
      if (processing == "" || processing == "none") {
        print "processing|" id
      }
    }
  ' 00_intake/SOURCE_REGISTRY.md)
fi

if [[ -f "02_requirements/ASSUMPTIONS_REGISTER.md" ]]; then
  while IFS='|' read -r kind id; do
    case "$kind" in
      expiry) fail "02_requirements/ASSUMPTIONS_REGISTER.md assumption row missing expiry: $id" ;;
      evidence) fail "02_requirements/ASSUMPTIONS_REGISTER.md approved assumption missing approval evidence: $id" ;;
      disallowed-evidence) fail "02_requirements/ASSUMPTIONS_REGISTER.md approved assumption has disallowed approval evidence: $id" ;;
      unsupported-evidence) fail "02_requirements/ASSUMPTIONS_REGISTER.md approved assumption missing allowed approval evidence: $id" ;;
    esac
  done < <(awk -F'|' '
    function trim(value) {
      gsub(/^[ \t]+|[ \t]+$/, "", value)
      return value
    }
    /^\| ASM-/ {
      id = trim($2)
      status = trim($6)
      expiry = trim($7)
      evidence = trim($8)
      evidence_lc = tolower(evidence)
      if (expiry == "" || expiry == "none") {
        print "expiry|" id
      }
      if (status == "approved") {
        if (evidence == "" || evidence == "none") {
          print "evidence|" id
        } else if (evidence_lc ~ /(self-approved|self approved|self approval|same agent|by author|author-only)/) {
          print "disallowed-evidence|" id
        } else if (evidence !~ /(explicit user approval|user approval|approved spec|active spec|accepted ADR|maintainer-approved|verified external|SPEC-[A-Z0-9-]+|ADR-[A-Z0-9-]+|SRC-[0-9]+)/) {
          print "unsupported-evidence|" id
        }
      }
    }
  ' 02_requirements/ASSUMPTIONS_REGISTER.md)
fi

# BOOT-033 SRC/SPEC cross-validation.
#
# Verify that cited SRC-* and SPEC-* identifiers in `BACKLOG/BOOT-*.md`
# files exist in their respective registers. Provisional placeholders
# prefixed with `provisional:` or `pending:` are allowed without
# registration; "none" or "n/a" values are treated as no-citation and
# skipped. Bare canonical IDs must be registered:
#
# - `SRC-[0-9]+` must appear in `00_intake/SOURCE_REGISTRY.md` as a
#   table row (`| SRC-NNN |`).
# - `SPEC-[A-Z][A-Z0-9-]*-[0-9]+` must appear in `SPECS/SPEC_INDEX.md`
#   as a table row (`| SPEC-XXX-NNN |`) or as an existing spec file in
#   `SPECS/` named `SPEC-XXX-NNN-*.md`.
#
# The validator only inspects citations in `BACKLOG/BOOT-*.md` so
# downstream product intake and existing planning narratives are not
# disturbed. Future work can extend the scope to other files when the
# downstream source/spec catalog grows.

src_registered() {
  local id="$1"
  [[ -z "$id" ]] && return 0
  if [[ -f 00_intake/SOURCE_REGISTRY.md ]]; then
    grep -qE "^\| $id +\|" 00_intake/SOURCE_REGISTRY.md && return 0
  fi
  return 1
}

spec_registered() {
  local id="$1"
  [[ -z "$id" ]] && return 0
  if [[ -f SPECS/SPEC_INDEX.md ]]; then
    grep -qE "^\| $id +\|" SPECS/SPEC_INDEX.md && return 0
  fi
  if find SPECS -maxdepth 1 -type f -name "${id}-*.md" -print 2>/dev/null | grep -q .; then
    return 0
  fi
  return 1
}

# Strip provisional/pending prefixes from each token so the canonical
# `SRC-N` / `SPEC-X-N` ID is the only thing the validator checks.
extract_ids() {
  local line="$1"
  local pattern="$2"
  printf '%s' "$line" \
    | grep -oE "(provisional:|pending:)?$pattern" \
    | grep -vE '^(provisional:|pending:)' \
    || true
}

if [[ -d BACKLOG ]]; then
  while IFS= read -r file; do
    src_line="$(awk 'tolower($0) ~ /^- source ids:/ { sub(/^[^:]*:[ ]*/, ""); print; exit }' "$file")"
    if [[ -n "$src_line" ]]; then
      lower="$(printf '%s' "$src_line" | tr '[:upper:]' '[:lower:]')"
      if [[ "$lower" != none* ]] && [[ "$lower" != "n/a" ]]; then
        while IFS= read -r id; do
          [[ -z "$id" ]] && continue
          src_registered "$id" || fail "$file cites unregistered source ID: $id"
        done < <(extract_ids "$src_line" 'SRC-[0-9]+')
      fi
    fi
    spec_line="$(awk 'tolower($0) ~ /^- linked spec:/ { sub(/^[^:]*:[ ]*/, ""); print; exit }' "$file")"
    if [[ -n "$spec_line" ]]; then
      lower="$(printf '%s' "$spec_line" | tr '[:upper:]' '[:lower:]')"
      if [[ "$lower" != none* ]] && [[ "$lower" != "n/a" ]]; then
        while IFS= read -r id; do
          [[ -z "$id" ]] && continue
          spec_registered "$id" || fail "$file cites unregistered spec ID: $id"
        done < <(extract_ids "$spec_line" 'SPEC-[A-Z][A-Z0-9-]*-[0-9]+')
      fi
    fi
  done < <(find BACKLOG -maxdepth 1 -type f -name '*-*.md' -not -name 'BACKLOG_INDEX.md' -print 2>/dev/null)
fi

# BOOT-034 Next Safe Action Staleness Guard.
#
# Committed handoff and state evidence in `AI_HANDOFF.md` and
# `CURRENT_STATE.md` may carry one or more `Next safe action:` envelope
# fields. After an envelope's action is complete, the line goes stale and
# must not keep instructing the next agent to redo work that already
# happened. The PR #10 / BOOT-033 v1.0 through v1.5 review loop is the
# canonical incident: successive fresh-context reviews each surfaced an
# older, unmarked `Next safe action:` line that was misread as still
# active.
#
# The check is narrow and fail-closed:
#
# - It scans only `AI_HANDOFF.md` and `CURRENT_STATE.md`.
# - It only matches Markdown list-item bullets that start (after optional
#   leading whitespace) with `-` or `*`, then `Next safe action:` (case
#   insensitive). Section headings such as `## Next Recommended Action`
#   start with `#` and are skipped. Narrative prose mentioning
#   `Next safe action:` inside backticks is skipped because it does not
#   begin with a list bullet.
# - Multiline bullets are stitched together: any indented continuation
#   line is appended to the bullet's payload until the next bullet,
#   blank line, or section heading.
# - Lines inside fenced code blocks (` ``` ` or `~~~`) are ignored so
#   illustrative `Next safe action:` examples in code fences do not trip
#   the rule.
# - A bullet is "marked" (historical) when its trimmed payload starts
#   with one of the canonical marker words (`completed`, `superseded`,
#   `historical`, `delegated`) or with a leading parenthetical such as
#   `(historical)` containing one of those words. The marker must be at
#   the start of the payload; marker words appearing later in the
#   payload (for example, "confirm delegated authority" or "ensure work
#   is completed before merge") do NOT count as marked, so the rule
#   stays fail-closed on legitimately active instructions that happen to
#   mention a marker word.
# - Empty payloads (a bullet with `Next safe action:` and no content on
#   the same line or any continuation line) count as unmarked. They
#   indicate a structurally incomplete envelope and should be flagged.
# - At most one unmarked `Next safe action:` field is allowed per file.
#   That single line represents the current/active envelope. All other
#   envelopes are historical and must carry one of the explicit markers
#   at the start of the payload.
#
# The marker set is intentionally small: `completed`, `superseded`,
# `historical`, `delegated`. If a maintainer wants to describe a
# different historical state (for example a merged PR), the canonical
# pattern is `Next safe action: completed by PR #N merge; ...` which
# already matches the `completed` marker.
#
# The rule deliberately does not police general prose; it only inspects
# the structured `Next safe action:` envelope field used by
# `OPERATION_ROUTING.md`.

count_unmarked_next_safe_actions() {
  local target="$1"
  [[ -f "$target" ]] || { echo 0; return; }
  awk '
    function has_start_marker(payload,    lower) {
      lower = tolower(payload)
      sub(/^[ \t]+/, "", lower)
      if (lower == "") return 0
      # Parenthetical marker at the very start, optionally with extra
      # text inside the parens: e.g. "(historical)", "(completed; see X)".
      if (lower ~ /^\([^)]*(completed|superseded|historical|delegated)[^)]*\)/) return 1
      # Direct marker word at the very start of the payload, terminated
      # by a non-letter (whitespace, punctuation, end of line).
      if (lower ~ /^(completed|superseded|historical|delegated)([^a-z]|$)/) return 1
      return 0
    }
    function finalize(    payload) {
      if (!in_bullet) return
      payload = bullet_payload
      gsub(/^[ \t]+|[ \t]+$/, "", payload)
      # Empty payloads are structurally incomplete -- count as unmarked
      # so the staleness guard flags them.
      if (!has_start_marker(payload)) count += 1
      in_bullet = 0
      bullet_payload = ""
    }
    BEGIN {
      in_fence = 0
      in_bullet = 0
      bullet_payload = ""
    }
    # Toggle Markdown fence state on lines starting with ``` or ~~~.
    /^[ \t]*(```|~~~)/ {
      finalize()
      in_fence = !in_fence
      next
    }
    in_fence { next }
    # Section headings end any open bullet.
    /^#/ { finalize(); next }
    # Blank lines end any open bullet.
    /^[ \t]*$/ { finalize(); next }
    # New list bullet (either a new `Next safe action:` field or a
    # different bullet). Finalize the previous bullet first.
    /^[ \t]*[-*][ \t]/ {
      finalize()
      if (tolower($0) ~ /^[ \t]*[-*][ \t]+next safe action:/) {
        idx = index(tolower($0), "next safe action:")
        bullet_payload = substr($0, idx + length("next safe action:"))
        in_bullet = 1
      }
      next
    }
    # Continuation line for the open bullet.
    in_bullet { bullet_payload = bullet_payload " " $0 }
    END { finalize(); print count + 0 }
  ' "$target"
}

for stale_target in AI_HANDOFF.md CURRENT_STATE.md; do
  if [[ -f "$stale_target" ]]; then
    unmarked_count="$(count_unmarked_next_safe_actions "$stale_target")"
    if [[ "$unmarked_count" -gt 1 ]]; then
      fail "$stale_target has $unmarked_count unmarked 'Next safe action:' entries; only the current envelope may be unmarked. Mark historical entries with one of: completed, superseded, historical, delegated."
    fi
  fi
done

grep -Fq "ARTIFACT_REGISTRY.md" CONTEXT_INDEX.md || fail "CONTEXT_INDEX.md does not reference ARTIFACT_REGISTRY.md"
grep -Fq "TRACEABILITY_MATRIX.md" CONTEXT_INDEX.md || fail "CONTEXT_INDEX.md does not reference TRACEABILITY_MATRIX.md"
grep -Fq "SPECS/SPEC_INDEX.md" CONTEXT_INDEX.md || fail "CONTEXT_INDEX.md does not reference SPECS/SPEC_INDEX.md"
grep -Fq "memory/ai/SHARED_AGENT_RULES.md" CONTEXT_INDEX.md || fail "CONTEXT_INDEX.md does not reference memory/ai/SHARED_AGENT_RULES.md"
grep -Fq "memory/ai/ROLE_*.md" CONTEXT_INDEX.md || fail "CONTEXT_INDEX.md does not reference memory/ai/ROLE_*.md"
grep -Fq "OPERATION_ROUTING.md" CONTEXT_INDEX.md || fail "CONTEXT_INDEX.md does not reference OPERATION_ROUTING.md"
grep -Fq "OPERATION_ROUTING.md" memory/ai/SHARED_AGENT_RULES.md || fail "shared agent rules do not reference OPERATION_ROUTING.md"
grep -Fq "OPERATION_ROUTING.md" GOVERNANCE.md || fail "GOVERNANCE.md does not reference OPERATION_ROUTING.md"
grep -Fq "Default mode is orientation-only" SCRIPTS/start-claude.sh || fail "SCRIPTS/start-claude.sh does not document default orientation-only behavior"
grep -Fq "default orientation-only mode" CLAUDE.md || fail "CLAUDE.md does not document default orientation-only behavior"
grep -Fq "default orientation-only" BOOTSTRAP_USAGE.md || fail "BOOTSTRAP_USAGE.md does not document default orientation-only behavior"

for section in \
  "## Operation Profiles" \
  "## Escalation Precedence" \
  "## Protected Artifacts" \
  "## Read Tiers" \
  "## Token Budgets" \
  "## Write Plan" \
  "## Impact Map" \
  "## Validation Modes" \
  "## Evidence Envelope" \
  "## Handoff And Current State" \
  "## Claim Evidence" \
  "## Measurement"; do
  grep -Fq "$section" OPERATION_ROUTING.md || fail "OPERATION_ROUTING.md missing section: $section"
done

for profile in \
  "review-only" \
  "docs-trivial" \
  "docs-non-authoritative" \
  "docs-public-claim" \
  "state-sync" \
  "planning-governance" \
  "strict-protected"; do
  grep -Fq "\`$profile\`" OPERATION_ROUTING.md || fail "OPERATION_ROUTING.md missing operation profile: $profile"
done

for mode in fast standard strict; do
  grep -Eq "\| $mode \|" OPERATION_ROUTING.md || fail "OPERATION_ROUTING.md missing validation mode: $mode"
done

for field in \
  "Operation profile:" \
  "Target files:" \
  "Protected files touched:" \
  "Expected risk:" \
  "Branch requirement:" \
  "Required validation:" \
  "Required review:" \
  "Traceability impact:" \
  "Registry impact:" \
  "Handoff/state impact:" \
  "Dirty worktree status:" \
  "Escalation triggers checked:"; do
  grep -Fq "$field" OPERATION_ROUTING.md || fail "OPERATION_ROUTING.md missing pre-change field: $field"
done

for field in \
  "Classification confidence:" \
  "Files read:" \
  "Files changed:" \
  "Files intentionally not read:" \
  "Artifacts not impacted:" \
  "Validation run:" \
  "Validation skipped:" \
  "Review required:" \
  "Next safe action:"; do
  grep -Fq "$field" OPERATION_ROUTING.md || fail "OPERATION_ROUTING.md missing evidence envelope field: $field"
done

grep -Fq "OPERATION_ROUTING.md" REVIEWS/templates/PR_REVIEW_PACKAGE_TEMPLATE.md || fail "PR review package template missing operation routing section"
grep -Fq "Operation Routing Review" REVIEWS/templates/ADVERSARIAL_PR_REVIEW_TEMPLATE.md || fail "adversarial review template missing operation routing review"
grep -Fq "## Branch-Specific State" REVIEWS/templates/PR_REVIEW_PACKAGE_TEMPLATE.md || fail "PR review package template missing branch-specific state fields"
grep -Fq "## Split-State Review" REVIEWS/templates/ADVERSARIAL_PR_REVIEW_TEMPLATE.md || fail "adversarial review template missing split-state review checks"
grep -Fq ".ai/SESSION.md" OPERATION_ROUTING.md || fail "OPERATION_ROUTING.md missing local session routing language"
grep -Fq "not durable operation evidence" OPERATION_ROUTING.md || fail "OPERATION_ROUTING.md must state local session is not durable evidence"
grep -Fq "PR body, PR comment" OPERATION_ROUTING.md || fail "OPERATION_ROUTING.md missing PR durable evidence locations"
grep -Fq "committed PR review package" OPERATION_ROUTING.md || fail "OPERATION_ROUTING.md missing committed review package evidence location"
grep -Fq "committed review record" OPERATION_ROUTING.md || fail "OPERATION_ROUTING.md missing committed review record evidence location"
if grep -Fxq -- "- \`AI_HANDOFF.md\` is updated" PR_MERGE_POLICY.md ||
   grep -Fxq -- "- \`CURRENT_STATE.md\` is updated" PR_MERGE_POLICY.md ||
   grep -Fq "missing AI handoff after significant work" PR_REVIEW_POLICY.md; then
  fail "PR policy contains unconditional committed-state handoff requirement"
fi

# BOOT-GREEN-MERGE-001 regression guard.
#
# Active authoritative policy must NOT reintroduce required human, maintainer,
# or Code Owner approval as a merge gate. The contract is described in
# PR_MERGE_POLICY.md and PR_REVIEW_POLICY.md: AI may merge after required
# CI/status checks pass, required local validation passes, scope is clean,
# and no P0/P1/blocking P2 findings remain.
#
# The check is fail-closed and scoped to a small set of active authoritative
# policy/role files so it does not false-positive on historical/archived
# material under `MAINTAINER_ARCHIVE/`, committed review records under
# `REVIEWS/`, backlog items that describe this work, or the validator and
# red-check fixtures themselves.
#
# The check looks for assertive merge-gate language only, not plain mentions
# of these terms. Lines that explicitly say a gate is NOT required (e.g.
# "approval is not required", "is informational only", "must not be
# reintroduced", "do not require") are not flagged. The forbidden patterns
# describe positive assertions that approval is required.
#
# Before pattern matching, each scoped file is normalized by joining
# indented Markdown continuation lines onto their preceding top-level
# line. This catches wrapped regressions such as
# "- A PR requires\n  maintainer approval before merge." that would
# otherwise slip past a line-by-line grep.
#
# Patterns flagged (case-insensitive, regex; `[[:space:]]+` matches the
# spaces produced by the wrap-normalization pre-pass as well as plain
# spaces):
#
# - "require[s|d] [<modifier>] approving review"
# - "require[s|d] [<modifier>] (human|maintainer|code owner) (approval|review)"
# - "(human|maintainer|code owner) (approval|review) (is|are|must be|shall
#   be) (required|needed|enforced|a [required ]merge gate)"
# - "must be approved by (a|the) (human|maintainer|code owner)"
# - "self-approve" or "self approve" used as a positive directive

green_merge_active_policy_files=(
  "PR_MERGE_POLICY.md"
  "PR_REVIEW_POLICY.md"
  "GOVERNANCE.md"
  "AI_PROJECT_BOOTSTRAP.md"
  "GITHUB_REPOSITORY_SETUP.md"
  "README.md"
  "memory/ai/SHARED_AGENT_RULES.md"
  "memory/ai/ROLE_IMPLEMENTATION_AGENT.md"
  "memory/ai/ROLE_ADVERSARIAL_PR_REVIEWER.md"
  "memory/ai/ROLE_QA_REVIEWER.md"
  "memory/ai/ROLE_SECURITY_REVIEWER.md"
  "memory/ai/ROLE_DEVOPS_RELEASE_REVIEWER.md"
  "memory/ai/ROLE_DOCUMENTATION_CURATOR.md"
  "memory/ai/ROLE_PRODUCT_ANALYST.md"
  "memory/ai/ROLE_SPEC_AUTHOR.md"
  "memory/ai/ROLE_ARCHITECT.md"
  "memory/ai/ROLE_BACKLOG_PLANNER.md"
)

# GitHub branch-protection key patterns. Setup guidance must not configure
# these keys to positive enforcement values: doing so would reintroduce a
# required human/maintainer/Code Owner approval gate at the GitHub
# enforcement layer even if the prose policy stays compliant.
#
# `required_approving_review_count: <1+>` enforces approving reviews.
# `require_code_owner_reviews: true` enforces Code Owner reviews.
# `require_last_push_approval: true` enforces a human re-approval after the
# last push.
# `required_pull_request_reviews: { ... }` (any non-null object value)
# enables PR-review protection on GitHub even if no inner field is set, so
# a non-null parent object is itself a positive enforcement value. Only the
# `null` disabled form is allowed.
# All four are forbidden in setup guidance for the green-merge model.
green_merge_github_key_patterns=(
  '"required_approving_review_count"[[:space:]]*:[[:space:]]*[1-9][0-9]*'
  '"require_code_owner_reviews"[[:space:]]*:[[:space:]]*true'
  '"require_last_push_approval"[[:space:]]*:[[:space:]]*true'
  '"required_pull_request_reviews"[[:space:]]*:[[:space:]]*\{'
)

# Assertive gate-language patterns. Each pattern is anchored to verbs that
# describe an active requirement (require, must, shall, is/are required).
green_merge_assertive_patterns=(
  '[Rr]equire[ds]?[[:space:]]+(at[[:space:]]+least[[:space:]]+(one|[0-9]+)[[:space:]]+)?approving[[:space:]]+review'
  '[Rr]equire[ds]?[[:space:]]+review[[:space:]]+from[[:space:]]+[Cc]ode[[:space:]]+[Oo]wners?'
  '[Rr]equire[ds]?[[:space:]]+(a[[:space:]]+|the[[:space:]]+|an[[:space:]]+)?(human|maintainer|[Cc]ode[[:space:]]+[Oo]wner)[[:space:]]+(approval|review)'
  '(human|maintainer|[Cc]ode[[:space:]]+[Oo]wner)[[:space:]]+(approval|review)[[:space:]]+(is|are|must[[:space:]]+be|shall[[:space:]]+be)[[:space:]]+(required|needed|enforced)'
  '[Mm]ust[[:space:]]+be[[:space:]]+approved[[:space:]]+by[[:space:]]+(a[[:space:]]+|the[[:space:]]+|an[[:space:]]+)?(human|maintainer|[Cc]ode[[:space:]]+[Oo]wner)'
  '[Aa]pproving[[:space:]]+review[[:space:]]+(is|are|must[[:space:]]+be|shall[[:space:]]+be)[[:space:]]+(required|needed|enforced)'
  '(implementers|implementer|the[[:space:]]+implementer)[[:space:]]+(must[[:space:]]+not[[:space:]]+|do[[:space:]]+not[[:space:]]+|cannot[[:space:]]+)?self[-[:space:]]?approve'
)

# Negation context: if the surrounding line says the gate is NOT required or
# is informational only, skip it. These patterns describe the line's stance
# toward the gate, not a global escape hatch.
green_merge_negation_re='([Nn]ot[[:space:]]+required|[Nn]ot[[:space:]]+a[[:space:]]+(required[[:space:]]+|merge[[:space:]]+)?gate|[Nn]ot[[:space:]]+a[[:space:]]+human[-[:space:]]style|[Mm]ust[[:space:]]+not[[:space:]]+be[[:space:]]+reintroduc|[Mm]ust[[:space:]]+not[[:space:]]+be[[:space:]]+required|[Nn]o[[:space:]]+longer[[:space:]]+(required|a[[:space:]]+(required[[:space:]]+|merge[[:space:]]+)gate)|[Pp]reviously[[:space:]]+required|[Rr]emoved|[Rr]eintroduc[a-z]*[[:space:]]+required|[Ii]nformational[[:space:]]+only|[Dd]oes[[:space:]]+not[[:space:]]+block|[Dd]oes[[:space:]]+not[[:space:]]+gate|[Dd]o[[:space:]]+not[[:space:]]+require|[Oo]ptional|[Ww]ithout[[:space:]]+(waiting[[:space:]]+for[[:space:]]+)?(any[[:space:]]+)?(human|maintainer|[Cc]ode[[:space:]]+[Oo]wner)|approval[[:space:]]+(is|are)[[:space:]]+not[[:space:]]+required|[Nn]ever[[:space:]]+required|[Nn]o[[:space:]]+(human|maintainer|[Cc]ode[[:space:]]+[Oo]wner|approving)[[:space:]]+(approval|review)[[:space:]]+(is|are|must[[:space:]]+be|shall[[:space:]]+be)[[:space:]]+(required|needed|enforced)|[Nn]o[[:space:]]+[^.]{0,100}(approval|review)[[:space:]]+(is|are|must[[:space:]]+be|shall[[:space:]]+be)[[:space:]]+(required|needed|enforced))'

green_merge_check_file() {
  local file="$1"
  [[ -f "$file" ]] || return 0
  local pattern
  # Normalize wrapped Markdown bullets/paragraphs before pattern matching.
  # Markdown allows a bullet or paragraph to span multiple physical lines:
  # the first line starts unindented (or with a bullet marker), and each
  # wrapped continuation line is indented to align with the bullet text.
  # A line-by-line grep cannot catch an approval-gate regression that is
  # split across the wrap boundary (e.g. `- A PR requires\n  maintainer
  # approval before merge.`).
  #
  # The awk pre-pass joins each top-level line with all of its indented
  # continuation lines into a single logical line. Blank lines flush the
  # buffer. Each emitted line is then scanned by the existing assertive
  # patterns and negation logic, so a wrapped regression is detected just
  # like a single-line regression. Line numbers from `grep -n` would no
  # longer align with the original file after normalization, so we report
  # the matched logical line as evidence instead.
  local normalized
  normalized="$(awk '
    BEGIN { buf = "" }
    /^[[:space:]]+[^[:space:]]/ {
      if (buf == "") buf = $0
      else buf = buf " " $0
      next
    }
    /^[[:space:]]*$/ {
      if (buf != "") { print buf; buf = "" }
      next
    }
    {
      if (buf != "") print buf
      buf = $0
    }
    END { if (buf != "") print buf }
  ' "$file")"
  for pattern in "${green_merge_assertive_patterns[@]}"; do
    while IFS= read -r line; do
      # Negation must appear in the same sentence segment as the gate
      # phrase. A whole-line check is bypassable by co-occurrence, e.g.
      # "Maintainer approval is required before merge; this gate is not
      # optional." — the negation word sits in a different clause. Split
      # the logical line on sentence boundaries and require the negation
      # next to the assertive phrase it claims to negate.
      gate_segment=""
      while IFS= read -r segment; do
        [[ -z "${segment//[[:space:]]/}" ]] && continue
        if printf '%s' "$segment" | grep -Eiq "$pattern"; then
          if ! printf '%s' "$segment" | grep -Eiq "$green_merge_negation_re"; then
            gate_segment="$segment"
            break
          fi
        fi
      done < <(printf '%s\n' "$line" | sed 's/[.;][[:space:]]/\n/g')
      if [[ -n "$gate_segment" ]]; then
        fail "$file reintroduces required human/maintainer/Code Owner approval as a merge gate: $line"
      fi
    done < <(printf '%s\n' "$normalized" | grep -iE "$pattern" 2>/dev/null || true)
  done
  # GitHub branch-protection keys are unconditional: positive enforcement
  # values are not negated by surrounding prose. Any active occurrence in
  # the scoped setup guidance reintroduces the gate at the enforcement
  # layer.
  for pattern in "${green_merge_github_key_patterns[@]}"; do
    while IFS= read -r line; do
      fail "$file reintroduces required human/maintainer/Code Owner approval as a merge gate via GitHub branch-protection key: $line"
    done < <(printf '%s\n' "$normalized" | grep -E "$pattern" 2>/dev/null || true)
  done
}

for green_merge_file in "${green_merge_active_policy_files[@]}"; do
  green_merge_check_file "$green_merge_file"
done

while IFS= read -r role_file; do
  if awk '
    /^## Required Updates Before Stopping/ { in_section = 1; next }
    /^## / { in_section = 0 }
    in_section && ($0 == "- `CURRENT_STATE.md`" || $0 == "- `AI_HANDOFF.md`") {
      bad = 1
    }
    END { exit bad ? 0 : 1 }
  ' "$role_file"; then
    fail "$role_file contains unconditional committed-state stopping rule"
  fi
done < <(find memory/ai -maxdepth 1 -type f -name 'ROLE_*.md' -print)

for path in "${required_files[@]}"; do
  grep -Fq "\`$path\`" ARTIFACT_REGISTRY.md || fail "ARTIFACT_REGISTRY.md does not register $path"
done

[[ -x "SCRIPTS/start-claude.sh" ]] || fail "SCRIPTS/start-claude.sh is not executable"

for mode in default product spec architecture backlog implementation qa security devops docs review handoff; do
  grep -Eq "^[[:space:]]*$mode\\)" SCRIPTS/start-claude.sh || fail "SCRIPTS/start-claude.sh missing allowlisted mode: $mode"
done

if [[ "$failures" -ne 0 ]]; then
  echo "Bootstrap validation failed with $failures issue(s)." >&2
  exit 1
fi

echo "Bootstrap validation passed."

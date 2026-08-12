#!/usr/bin/env bash
#
# check-ad-tape-drift.sh — fail if an ad tape types a Homebrew formula that does
# not exist.
#
# Why this exists, and why it checks ONLY the formula name
# -------------------------------------------------------
# T4 verified every `##` command in the ten ad tapes against the rysh-cli
# dispatcher; they all live (see AD-TAPE-DRIFT.md §5-§12). The one thing that had
# drifted was not a subcommand but a package name: `story-ad10-remote-reach:24`
# types `brew install rysh-ai/rysh/rysh`, and that formula was retired at 0.1.28.
# The tap ships `ry` (.goreleaser.yml `brews: - name: ry`), so the typed line
# installs nothing current no matter which build the video depicts.
#
# This check deliberately does NOT flag a bare `rysh` invocation. Per
# `new_roadmap/05-decisions.md:47` (decision of 2026-07-27) the CLOSED build ships
# as `ry` and the OPEN build ships as `rysh`, so `rysh` is correct for the OSS
# build. Which build a tutorial depicts is founder gate **D-8**
# (`05-decisions.md:25`), which is STILL OPEN. Encoding a preference here would
# preempt it. AD-TAPE-DRIFT.md §4 lists the affected lines under both branches so
# the edit list is ready whichever way D-8 lands.
#
# So: this check FAILS TODAY on exactly one line, on purpose. It is the red test
# for a fix that is unconditionally safe to make. It goes green when that formula
# name is corrected, and it stays silent about everything D-8 owns.
#
# Source of truth is rysh-cli's own release config, read at run time, so this
# cannot drift from the build the way a hardcoded string would.
#
# Usage:  bash tapes/check-ad-tape-drift.sh
# Exit:   0 clean · 1 drift found · 2 cannot verify (source of truth missing)

set -uo pipefail

# Derive the monorepo root by walking up until rysh-cli's release config appears,
# rather than hardcoding a depth: this file is read both from the main checkout
# (video-tutorials/tapes) and from a worktree (worktrees/<name>/tapes), which sit
# at different depths below the root.
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GORELEASER=""
dir="$HERE"
while [ "$dir" != "/" ]; do
  if [ -f "$dir/rysh-cli/.goreleaser.yml" ]; then
    GORELEASER="$dir/rysh-cli/.goreleaser.yml"
    break
  fi
  dir="$(dirname "$dir")"
done
TAPE_DIR="$HERE/tape"

if [ -z "$GORELEASER" ]; then
  echo "cannot verify: no rysh-cli/.goreleaser.yml found above $HERE" >&2
  echo "this check reads the shipping formula name from rysh-cli's release config" >&2
  exit 2
fi

# The Homebrew formula name: `name:` under the `brews:` block.
FORMULA="$(awk '/^brews:/{f=1;next} f && /name:/{print $NF; exit}' "$GORELEASER")"
if [ -z "$FORMULA" ]; then
  echo "cannot verify: could not read the brew formula name from $GORELEASER" >&2
  exit 2
fi

echo "shipping brew formula: $FORMULA   ($GORELEASER)"
echo "note: bare 'rysh' invocations are NOT checked — that is founder gate D-8"
echo "      (new_roadmap/05-decisions.md:25). See AD-TAPE-DRIFT.md section 4."
echo

fail=0
while IFS= read -r hit; do
  [ -n "$hit" ] || continue
  typed="$(printf '%s' "$hit" | sed -E 's|.*brew install ([^"]*).*|\1|')"
  echo "DRIFT retired brew formula '$typed' (tap ships '$FORMULA'): $hit"
  fail=1
done < <(grep -nE '^Type(@[0-9]+ms)? "brew install ' "$TAPE_DIR"/*ad*.tape 2>/dev/null \
         | grep -vE "/${FORMULA}\"")

echo
if [ "$fail" -eq 0 ]; then
  echo "PASS: every ad tape that installs via brew names the '$FORMULA' formula"
else
  echo "FAIL: an ad tape installs a Homebrew formula the tap does not ship."
  echo "      This is wrong under BOTH branches of D-8: the formula is named"
  echo "      '$FORMULA' whether the video depicts the open or the closed build."
  echo "      Every '##' command in these tapes was separately verified as live —"
  echo "      see tapes/AD-TAPE-DRIFT.md."
fi
exit "$fail"

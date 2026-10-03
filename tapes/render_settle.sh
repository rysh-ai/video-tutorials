#!/usr/bin/env bash
#
# render_settle.sh — the E5 settling experiment (E5 §2 T3, §6.3 hypothesis).
#
# Hypothesis: vhs emits a frame when the screen CHANGES, so a render's length
# tracks screen motion, not the tape's Sleep budget.
#
# Two tapes with the same 20.0 s budget (tape_budget.py), identical terminal
# settings, vhs-default framerate:
#   settle/settle-sleep.tape  one short Type, then Sleep    (screen still)
#   settle/settle-type.tape   continuous Type for 20.0 s    (screen moving)
# rendered back to back, alternating A B A B ... so load drift hits both arms.
#
# Every number in the TSV is an ffprobe reading or a clock reading — nothing
# here is modelled except budget_s, which is labelled as the model it is.
# Renders land in out/settle/ (gitignored: *.mp4); cite them by path + sha256.
#
# Usage:
#   ./render_settle.sh            # n=3 each, ABABAB
#   N=5 ./render_settle.sh
#   SUFFIX=-40 ./render_settle.sh # the 40 s pair, settle/settle-{sleep,type}-40.tape (WO-2b)
#
# Rows are APPENDED; the header is written only when the TSV is empty, so a
# second budget never overwrites the first one's evidence.
set -uo pipefail

TAPES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUT_DIR="$TAPES_DIR/out/settle"
RESULTS="${RESULTS:-$TAPES_DIR/settle-results.tsv}"
N="${N:-3}"
SUFFIX="${SUFFIX:-}"
mkdir -p "$OUT_DIR"

VHS="$(command -v vhs)" || { echo "FATAL: vhs not on PATH"; exit 1; }
vhs_sha=$(shasum -a 256 "$(readlink -f "$VHS")" | cut -d' ' -f1)
vhs_ver=$(vhs --version 2>&1 | head -1)

load1() { sysctl -n vm.loadavg | awk '{print $2}'; }
now()   { python3 -c 'import time;print(f"{time.time():.3f}")'; }

[ -s "$RESULTS" ] || printf 'tape\trun\tbudget_s\tnb_frames\tduration_s\tratio\tr_frame_rate\tavg_frame_rate\twall_s\tload_before\tvhs_version\tvhs_sha256\tmp4_path\tmp4_sha256\n' > "$RESULTS"

for run in $(seq 1 "$N"); do
  for arm in sleep type; do
    tape="$TAPES_DIR/settle/settle-$arm$SUFFIX.tape"
    out="$OUT_DIR/settle-$arm$SUFFIX-run$run.mp4"
    rm -f "$out"
    budget=$(python3 "$TAPES_DIR/tape_budget.py" "$tape" --tsv | awk 'NR==2{print $5}')
    lb=$(load1)
    t0=$(now)
    ( cd "$OUT_DIR" && vhs -o "$out" "$tape" ) >"$OUT_DIR/settle-$arm$SUFFIX-run$run.log" 2>&1
    rc=$?
    t1=$(now)
    wall=$(python3 -c "print(f'{$t1-$t0:.1f}')")
    if [ "$rc" -ne 0 ] || [ ! -s "$out" ]; then
      echo "FAIL: $arm run$run rc=$rc (log: $OUT_DIR/settle-$arm$SUFFIX-run$run.log)"
      printf '%s\t%s\t%s\tFAIL\t\t\t\t\t%s\t%s\t%s\t%s\t%s\t\n' "settle-$arm$SUFFIX" "$run" "$budget" "$wall" "$lb" "$vhs_ver" "$vhs_sha" "$out" >> "$RESULTS"
      continue
    fi
    # nb_frames counted by decoding (-count_frames), not read from the header.
    read -r rfr afr nbf < <(ffprobe -v error -select_streams v:0 -count_frames \
      -show_entries stream=r_frame_rate,avg_frame_rate,nb_read_frames -of csv=p=0 "$out" | tr ',' ' ')
    dur=$(ffprobe -v error -show_entries format=duration -of csv=p=0 "$out")
    ratio=$(python3 -c "print(f'{$dur/$budget:.3f}')")
    sha=$(shasum -a 256 "$out" | cut -d' ' -f1)
    printf '%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n' \
      "settle-$arm$SUFFIX" "$run" "$budget" "$nbf" "$dur" "$ratio" "$rfr" "$afr" "$wall" "$lb" "$vhs_ver" "$vhs_sha" "$out" "$sha" >> "$RESULTS"
    echo "settle-$arm$SUFFIX run$run: frames=$nbf duration=${dur}s ratio=$ratio wall=${wall}s load=$lb"
  done
done
echo "results: $RESULTS"

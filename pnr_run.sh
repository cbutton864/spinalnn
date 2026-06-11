#!/usr/bin/env bash
# pnr_run.sh <benchmark_dir> <label>
#
# Runs MAP + PNR for a benchmark directory, archives the outflow, and appends
# a summary row to pnr_results.tsv at the project root.
#
# Example:
#   ./pnr_run.sh benchmark_squeezenet_perLayer "N16_singleclock"

set -euo pipefail
trap '' PIPE   # stdout pipe may close early when run as a background task; ignore SIGPIPE

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
BENCH_DIR="$1"
LABEL="${2:-unlabeled}"
EFINITY_SETUP="/home/curtis-button/eda/efinity/2025.2/bin/setup.sh"
RESULTS_TSV="${SCRIPT_DIR}/pnr_results.tsv"

if [[ -z "$BENCH_DIR" ]]; then
  echo "Usage: $0 <benchmark_dir> <label>" >&2
  exit 1
fi

BENCH_ABS="$(cd "${SCRIPT_DIR}/${BENCH_DIR}" && pwd)"
OUTFLOW="${BENCH_ABS}/outflow"
DATE=$(date +%Y-%m-%d_%H%M)
ARCHIVE="${BENCH_ABS}/runs/${LABEL}_${DATE}"

RUNMAP=$(ls "${BENCH_ABS}"/RUNMAP_* 2>/dev/null | head -1)
RUNPNR=$(ls "${BENCH_ABS}"/RUNPNR_* 2>/dev/null | head -1)

if [[ -z "$RUNMAP" || -z "$RUNPNR" ]]; then
  echo "ERROR: RUNMAP_* or RUNPNR_* not found in ${BENCH_ABS}" >&2
  exit 1
fi

# Source Efinity environment (needed by both MAP and PNR).
# setup.sh references PYTHONPATH unconditionally, so disable nounset around it.
set +u
# shellcheck disable=SC1090
source "${EFINITY_SETUP}"
set -u
cd "${BENCH_ABS}"

echo "==> [${LABEL}] MAP: $(basename "$RUNMAP")"
bash "$RUNMAP" > "${OUTFLOW}/run_map.log" 2>&1

echo "==> [${LABEL}] PNR: $(basename "$RUNPNR")"
# efx_map only generates interface.csv when a peri.xml is present; stub it if missing
IFACE_CSV=$(grep -oP '(?<=--sync_file )\S+' "$RUNPNR" || true)
if [[ -n "$IFACE_CSV" && ! -f "${BENCH_ABS}/${IFACE_CSV}" ]]; then
  printf '# Efinity Interface Configuration\n# (no peripheral constraints)\n' \
    > "${BENCH_ABS}/${IFACE_CSV}"
fi
bash "$RUNPNR" > "${OUTFLOW}/run_pnr.log" 2>&1

# ── Extract metrics ────────────────────────────────────────────────────────────
RAM_BLOCKS=$(grep -m1 'EFX_RAM10[[:space:]]*:' "${OUTFLOW}/run_map.log" \
             | awk '{print $NF}')
FMAX=$(grep -m1 'group_data name="clk"' "${OUTFLOW}"/*.route.rpt.xml 2>/dev/null \
       | grep -oP 'value="\K[\d.]+')
FMAX="${FMAX:-N/A}"

# ── Archive ────────────────────────────────────────────────────────────────────
mkdir -p "${ARCHIVE}"
cp -r "${OUTFLOW}"/* "${ARCHIVE}/"
echo "${LABEL}" > "${ARCHIVE}/label.txt"
echo "==> Archived to runs/${LABEL}_${DATE}/"

# ── Append to results ledger ───────────────────────────────────────────────────
if [[ ! -f "$RESULTS_TSV" ]]; then
  printf 'date\tlabel\tbenchmark\tram_blocks\tfmax_mhz\n' > "$RESULTS_TSV"
fi
printf '%s\t%s\t%s\t%s\t%s\n' \
  "${DATE}" "${LABEL}" "$(basename "${BENCH_DIR}")" \
  "${RAM_BLOCKS}" "${FMAX}" >> "$RESULTS_TSV"

echo "==> Done: RAM=${RAM_BLOCKS} blocks, fmax=${FMAX} MHz"
echo "==> Logged to pnr_results.tsv"

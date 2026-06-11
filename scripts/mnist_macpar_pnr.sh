#!/usr/bin/env bash
# Run P&R for MNIST MacPar comparison: N1 baseline vs MacParPerLayer(conv2->8) vs MacParFixed(8)
# Results: DSP count, RAM10K count, logic util, and max achievable frequency.
#
# Prerequisites:
#   - rtl/mnist_macpar/{N1,perLayer_N8,fixed_N8}/SpinalNNTop.v generated via GenMnistMacPar
#   - Efinity 2025.2 installed at /home/curtis-button/eda/efinity/2025.2
#
# Usage:
#   cd /home/curtis-button/projects/spinalnn
#   bash scripts/mnist_macpar_pnr.sh

set -euo pipefail
export PATH="/home/curtis-button/eda/efinity/2025.2/bin:$PATH"

BENCH_DIR="$(cd "$(dirname "$0")/.." && pwd)/benchmark_mnist_macpar"
PROJECTS=(mnist_N1 mnist_perLayer_N8 mnist_fixed_N8)

echo ""
echo "=== MNIST MacParallelism P&R Sweep (Ti180M484 C4, 150 MHz) ==="
echo ""

# Run full compile (syn + pnr + bitstream) for each project
for proj in "${PROJECTS[@]}"; do
  proj_dir="$BENCH_DIR/$proj"
  echo "--- $proj ---"
  (cd "$proj_dir" && efx_run --prj -f compile "${proj}.xml") 2>&1 | tail -5
  echo ""
done

# Parse results
echo ""
echo "=== Resource & Timing Summary ==="
echo ""
printf "  %-22s  %6s  %6s  %8s  %10s  %10s\n" \
  "Config" "Logic%" "DSP" "RAM10K" "MaxFreq(MHz)" "Slack(ns)"
printf "  %s\n" "$(python3 -c "print('-'*75)")"

for proj in "${PROJECTS[@]}"; do
  proj_dir="$BENCH_DIR/$proj"
  res="$proj_dir/outflow/${proj}.res.csv"
  timing="$proj_dir/outflow/${proj}.timing.rpt"

  if [[ ! -f "$res" ]]; then
    printf "  %-22s  %s\n" "$proj" "FAILED (no .res.csv)"
    continue
  fi

  # Parse utilisation from tab-separated CSV (fields: Module FFs SRLs ADDs LUTs COMB4s RAMs DSP/MULTs)
  data_line=$(grep "^SpinalNNTop" "$res" 2>/dev/null || echo "")
  dsp_used=$(echo "$data_line" | awk -F'\t' '{v=$8; gsub(/^[[:space:]]+/,"",v); sub(/\(.*/,"",v); print v}')
  ram_used=$(echo "$data_line" | awk -F'\t' '{v=$7; gsub(/^[[:space:]]+/,"",v); sub(/\(.*/,"",v); print v}')
  lut_used=$(echo "$data_line" | awk -F'\t' '{v=$5; gsub(/^[[:space:]]+/,"",v); sub(/\(.*/,"",v); print v}')
  logic_pct="${lut_used}LUT"

  # Parse timing from report
  max_freq="?"
  slack="?"
  if [[ -f "$timing" ]]; then
    max_freq=$(awk '/Clock Frequency Summary \(begin\)/,/Clock Frequency Summary \(end\)/{
      if (/\(R-R\)/) { print $3; exit }
    }' "$timing" 2>/dev/null || echo "?")
    slack=$(grep -oP 'Slack\s*:\s*\K[0-9.-]+(?= \(required time - arrival)' "$timing" 2>/dev/null | head -1 || echo "?")
  fi

  printf "  %-22s  %6s  %6s  %8s  %10s  %10s\n" \
    "$proj" "$logic_pct" "$dsp_used" "$ram_used" "$max_freq" "$slack"
done

echo ""
echo "Expected: perLayer_N8 and fixed_N8 should have identical DSP count"
echo "         (both assign conv2 -> N=8, conv1 -> N=1)"
echo "         N1 baseline should show fewer DSPs."

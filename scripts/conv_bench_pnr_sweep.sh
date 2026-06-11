#!/usr/bin/env bash
# conv_bench_pnr_sweep.sh
#
# Runs Efinity P&R for ConvEngineBench at N=1,2,4,8,16 and prints a
# resource + timing comparison table.
#
# Prerequisites:
#   - sbt "runMain spinalnn.bench.GenConvBenchSweep" already run (produces rtl/bench/conv_N*/ConvEngineBench.v)
#   - efx_run is on PATH (Efinity toolchain)
#
# Usage (from project root):
#   bash scripts/conv_bench_pnr_sweep.sh [N...]
#   bash scripts/conv_bench_pnr_sweep.sh          # sweeps 1 2 4 8 16
#   bash scripts/conv_bench_pnr_sweep.sh 4 8      # only N=4 and N=8

set -e
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT="$SCRIPT_DIR/.."
BENCH_DIR="$ROOT/benchmark_conv_bench"

export PATH="/home/curtis-button/eda/efinity/2025.2/bin:$PATH"

NS="${@:-1 2 4 8 16}"

mkdir -p "$BENCH_DIR"

# ── SDC (same 150 MHz clock constraint for all runs) ──────────────────────────
cat > "$BENCH_DIR/timing.sdc" <<'EOF'
create_clock -name clk -period 6.667 [get_ports clk]
set_false_path -from [get_ports reset]
EOF

# ── Generate Efinity project XML for one N value ─────────────────────────────
make_project_xml() {
  local N=$1
  local PROJ="conv_bench_N${N}"
  local RTL_REL="../../rtl/bench/conv_N${N}/ConvEngineBench.v"
  cat <<EOF
<efx:project xmlns:efx="http://www.efinixinc.com/enf_proj"
             xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
             name="${PROJ}"
             description="ConvEngineBench macParallelism=N=${N}"
             sw_version="2025.2.288.2.10"
             xsi:schemaLocation="http://www.efinixinc.com/enf_proj enf_proj.xsd">
    <efx:device_info>
        <efx:family name="Titanium" />
        <efx:device name="Ti180M484" />
        <efx:timing_model name="C4" />
    </efx:device_info>
    <efx:design_info def_veri_version="verilog_2k" def_vhdl_version="vhdl_2008" unified_flow="false">
        <efx:top_module name="ConvEngineBench" />
        <efx:design_file name="${RTL_REL}" version="verilog_2k" library="default" />
        <efx:top_vhdl_arch name="" />
    </efx:design_info>
    <efx:constraint_info>
        <efx:sdc_file name="../timing.sdc" />
        <efx:inter_file name="" />
    </efx:constraint_info>
    <efx:sim_info />
    <efx:misc_info />
    <efx:ip_info />
    <efx:synthesis tool_name="efx_map">
        <efx:param name="work_dir" value="work_syn" value_type="e_string" />
        <efx:param name="write_efx_verilog" value="on" value_type="e_bool" />
        <efx:param name="mode" value="speed" value_type="e_option" />
        <efx:param name="max_ram" value="-1" value_type="e_integer" />
        <efx:param name="max_mult" value="-1" value_type="e_integer" />
        <efx:param name="retiming" value="1" value_type="e_option" />
        <efx:param name="dsp-mac-packing" value="1" value_type="e_option" />
        <efx:param name="dsp-output-regs-packing" value="1" value_type="e_option" />
        <efx:param name="dsp-input-regs-packing" value="1" value_type="e_option" />
        <efx:param name="optimize-zero-init-rom" value="1" value_type="e_option" />
        <efx:param name="max_threads" value="-1" value_type="e_integer" />
    </efx:synthesis>
    <efx:place_and_route tool_name="efx_pnr">
        <efx:param name="work_dir" value="work_pnr" value_type="e_string" />
        <efx:param name="verbose" value="off" value_type="e_bool" />
        <efx:param name="seed" value="1" value_type="e_integer" />
        <efx:param name="placer_effort_level" value="2" value_type="e_option" />
        <efx:param name="max_threads" value="-1" value_type="e_integer" />
        <efx:param name="print_critical_path" value="5" value_type="e_integer" />
    </efx:place_and_route>
    <efx:bitstream_generation tool_name="efx_pgm">
        <efx:param name="mode" value="active" value_type="e_option" />
        <efx:param name="width" value="1" value_type="e_option" />
        <efx:param name="enable_roms" value="smart" value_type="e_option" />
        <efx:param name="bitstream_compression" value="on" value_type="e_bool" />
    </efx:bitstream_generation>
</efx:project>
EOF
}

# ── Parse resource count from .res.csv ────────────────────────────────────────
parse_res() {
  local f=$1
  # Format: Module  FFs  SRLs  ADDs  LUTs  COMB4s  RAMs  DSP/MULTs
  awk -F'\t' 'NR>7 && NF>6 {
    gsub(/\([^)]*\)/, "", $0)  # strip (N) annotations
    printf "LUTs=%s DSPs=%s RAMs=%s", $5+0, $8+0, $7+0
    exit
  }' "$f" 2>/dev/null || echo "parse_err"
}

# ── Parse setup slack and max freq from .timing.rpt ──────────────────────────
parse_timing() {
  local f=$1
  # Look for lines like "Setup slack: +0.965 ns" or "Clock period: 6.667 ns"
  local slack max_freq
  slack=$(grep -i "setup slack" "$f" 2>/dev/null | head -1 | grep -oP '[+-]?\d+\.\d+' | head -1 || echo "?")
  # Max frequency line: "Maximum frequency: 175.24 MHz"
  max_freq=$(grep -i "maximum frequency\|max freq" "$f" 2>/dev/null | head -1 | grep -oP '\d+\.\d+' | head -1 || echo "?")
  echo "slack=${slack}ns maxFreq=${max_freq}MHz"
}

# ── Run all ───────────────────────────────────────────────────────────────────
echo ""
echo "conv_bench_pnr_sweep: running N=${NS}"
echo ""

for N in $NS; do
  PROJ="conv_bench_N${N}"
  PROJ_DIR="$BENCH_DIR/$PROJ"
  XML="$PROJ_DIR/${PROJ}.xml"

  if [ ! -f "$ROOT/rtl/bench/conv_N${N}/ConvEngineBench.v" ]; then
    echo "  N=$N: SKIP (rtl/bench/conv_N${N}/ConvEngineBench.v not found — run GenConvBenchSweep first)"
    continue
  fi

  mkdir -p "$PROJ_DIR"
  make_project_xml "$N" > "$XML"

  echo "  N=$N: running efx_run..."
  cd "$PROJ_DIR"
  if efx_run --prj -f compile "${PROJ}.xml" > run.log 2>&1; then
    echo "  N=$N: PASS"
  else
    echo "  N=$N: FAIL (see $PROJ_DIR/run.log)"
  fi
  cd "$ROOT"
done

# ── Print comparison table ────────────────────────────────────────────────────
echo ""
echo "================================================================"
echo "  ConvEngineBench macParallelism P&R sweep  (Ti180M484, C4, 150 MHz)"
echo "================================================================"
printf "  %-4s  %-30s  %-30s\n" "N" "Resources" "Timing"
printf "  %-4s  %-30s  %-30s\n" "----" "------------------------------" "------------------------------"

for N in $NS; do
  PROJ="conv_bench_N${N}"
  RES_CSV="$BENCH_DIR/$PROJ/outflow/${PROJ}.res.csv"
  TIMING_RPT="$BENCH_DIR/$PROJ/outflow/${PROJ}.timing.rpt"
  if [ -f "$RES_CSV" ]; then
    res=$(parse_res "$RES_CSV")
    timing=$(parse_timing "$TIMING_RPT")
    printf "  %-4s  %-30s  %-30s\n" "$N" "$res" "$timing"
  else
    printf "  %-4s  %-30s\n" "$N" "(not run or failed)"
  fi
done
echo "================================================================"
echo ""

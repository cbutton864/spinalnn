"""
vcd_fc_inputs.py — Extract FC input buffer contents and output logits from
the OnnxLogitInspectionTest VCD to diagnose which stage is wrong.

The VCD records:
  - activation_out_valid / activation_out_data : final outputs
  - linear1_inputBuf_spinal_port0 : FC input buffer RAM read-port

We capture:
1. The 10 logit outputs per inference (from activation_out)
2. The 256 FC input values right before each output run
"""

import sys
import struct

VCD_PATH = "simWorkspace/OnnxLogitInspectionTest/SpinalNNTop/onnx_logit_inspection/wave.vcd"

# Signal IDs we care about (from VCD header)
# We'll parse the header to find them
TARGET_SIGNALS = {
    "activation_out_valid": None,
    "activation_out_data":  None,
    "activation_in_valid":  None,
    "activation_in_data":   None,
    "linear1_inputBuf_spinal_port0": None,
    "conv1_stateReg": None,
    "conv2_stateReg": None,
    "pool2_stateReg": None,
    "linear1_stateReg": None,
}

# Also capture stateReg signals for context
EXTRA_TARGET = [
    "stateReg",
]

print("Parsing VCD header...")
sig_map  = {}    # symbol -> (name, width)
cur_scope = []

with open(VCD_PATH, "r", errors="replace") as f:
    in_header = True
    for line in f:
        line = line.rstrip()
        if "$enddefinitions" in line:
            in_header = False
            break
        if "$scope" in line:
            parts = line.split()
            if len(parts) >= 3:
                cur_scope.append(parts[2])
        elif "$upscope" in line:
            if cur_scope:
                cur_scope.pop()
        elif "$var" in line:
            parts = line.split()
            if len(parts) >= 5:
                width  = int(parts[2])
                sym    = parts[3]
                name   = parts[4]
                full   = ".".join(cur_scope) + "." + name if cur_scope else name
                sig_map[sym] = (full, width)

print(f"Found {len(sig_map)} signals in VCD header.")

# Find the symbols we care about
target_syms = {}
for sym, (name, width) in sig_map.items():
    short = name.split(".")[-1] if "." in name else name
    for t in TARGET_SIGNALS:
        if t == short or t == name:
            target_syms[sym] = t
    for t in EXTRA_TARGET:
        if t in short and "stateReg" in short:
            target_syms[sym] = short

print("Target symbol map:")
for sym, name in target_syms.items():
    full_name = sig_map[sym][0]
    print(f"  {sym!r} -> {name!r} (full: {full_name!r})")

# Now stream through the VCD value-change data
print("\nStreaming VCD changes...")
sys.stdout.flush()

# We'll collect:
# - All (time, value) pairs for activation_out_valid and activation_out_data
# - All (time, value) pairs for linear1_inputBuf_spinal_port0
# - All stateReg transitions

out_valid_times  = []   # (time, value)
out_data_times   = []   # (time, value)
in_valid_times   = []
in_data_times    = []
inputbuf_times   = []   # (time, value)
state_times      = {}   # name -> [(time, value)]

cur_time = 0
line_count = 0

def parse_vcd_value(token):
    """Parse b/B prefix or single-bit char."""
    if token[0] in ('b', 'B'):
        return int(token[1:], 2) if 'x' not in token[1:].lower() else None
    if token == 'x' or token == 'X':
        return None
    return int(token)

MAX_LINES = 50_000_000  # safety cap

with open(VCD_PATH, "r", errors="replace") as f:
    past_header = False
    pending_vector = None  # (value_str,) waiting for symbol

    for raw_line in f:
        line_count += 1
        if line_count > MAX_LINES:
            print(f"  [Stopping at {MAX_LINES} lines to avoid OOM]")
            break

        line = raw_line.rstrip()

        if not past_header:
            if "$enddefinitions" in line:
                past_header = True
            continue

        if not line:
            continue

        # Timestamp
        if line.startswith('#'):
            cur_time = int(line[1:])
            continue

        # Single-bit value change: [01xzXZ]<symbol>
        if len(line) >= 2 and line[0] in ('0','1','x','z','X','Z') and line[1:] in sig_map:
            sym = line[1:]
            val = 0 if line[0] == '0' else (1 if line[0] == '1' else None)
            if sym in target_syms:
                tname = target_syms[sym]
                if tname == "activation_out_valid":
                    out_valid_times.append((cur_time, val))
                elif tname == "activation_out_data":
                    out_data_times.append((cur_time, val))
                elif tname == "activation_in_valid":
                    in_valid_times.append((cur_time, val))
                elif tname == "linear1_inputBuf_spinal_port0":
                    inputbuf_times.append((cur_time, val))
                elif "stateReg" in tname:
                    state_times.setdefault(tname, []).append((cur_time, val))
            continue

        # Vector value: b<value> <symbol> OR next line has symbol
        if line.startswith('b') or line.startswith('B'):
            parts = line.split()
            if len(parts) == 2:
                sym   = parts[1]
                vstr  = parts[0][1:]
                if sym in sig_map:
                    if sym in target_syms:
                        val = int(vstr, 2) if ('x' not in vstr.lower()) else None
                        tname = target_syms[sym]
                        width = sig_map[sym][1]
                        if val is not None and val >= (1 << (width-1)):
                            val -= (1 << width)   # sign-extend
                        if tname == "activation_out_data":
                            out_data_times.append((cur_time, val))
                        elif tname == "activation_in_data":
                            in_data_times.append((cur_time, val))
                        elif tname == "linear1_inputBuf_spinal_port0":
                            inputbuf_times.append((cur_time, val))
                        elif "stateReg" in tname:
                            state_times.setdefault(tname, []).append((cur_time, val))
            elif len(parts) == 1:
                pending_vector = parts[0]
            continue

        # Pending vector symbol
        if pending_vector is not None:
            sym = line.strip()
            if sym in sig_map and sym in target_syms:
                vstr  = pending_vector[1:]
                val   = int(vstr, 2) if ('x' not in vstr.lower()) else None
                tname = target_syms[sym]
                width = sig_map[sym][1]
                if val is not None and val >= (1 << (width-1)):
                    val -= (1 << width)
                if tname == "activation_out_data":
                    out_data_times.append((cur_time, val))
                elif tname == "activation_in_data":
                    in_data_times.append((cur_time, val))
                elif tname == "linear1_inputBuf_spinal_port0":
                    inputbuf_times.append((cur_time, val))
                elif "stateReg" in tname:
                    state_times.setdefault(tname, []).append((cur_time, val))
            pending_vector = None
            continue

print(f"\nParsed {line_count} lines.")
print(f"Output valid transitions: {len(out_valid_times)}")
print(f"Output data transitions:  {len(out_data_times)}")
print(f"Input buf transitions:    {len(inputbuf_times)}")

# Build a lookup for the actual output values at each activation_out_valid high cycle
# Clock period = 10ps, rising edge at t=5, 15, 25, ...
# A valid output fires when activation_out_valid=1 at a rising edge
#
# Correlate valid and data: find rising edges where valid=1

# Reconstruct piecewise-constant valid/data signals
def build_signal(changes, default=0):
    return sorted(changes)  # already sorted by time

out_valid_sig = build_signal(out_valid_times, 0)
out_data_sig  = build_signal(out_data_times,  0)

# Find all rising clock edges where both valid=1 and ready=1 (ready is always 1 in test)
# Rising edges: times 5, 15, 25, ... (t % 10 == 5)
# We need to find the value of valid and data AT each rising edge

def value_at(sig_changes, t, default=0):
    """Return the last value before or at time t."""
    val = default
    for (ct, cv) in sig_changes:
        if ct <= t:
            val = cv if cv is not None else val
        else:
            break
    return val

# Find all output fires
print("\nFinding output fires (valid=1 at each rising edge)...")
output_fires = []  # list of (time, data_value)

if out_valid_times:
    # Scan only over the time range where we have data
    min_t = out_valid_times[0][0]
    max_t = out_valid_times[-1][0]

    # Use a pointer approach for efficiency
    vi = 0  # index into out_valid_sig
    di = 0  # index into out_data_sig

    cur_valid = 0
    cur_data  = 0

    # Merge and scan
    all_events = sorted(out_valid_times + out_data_times, key=lambda x: x[0])

    # Step through rising clock edges
    vi = 0
    di = 0
    vchanges = sorted(out_valid_times)
    dchanges = sorted(out_data_times)

    cur_valid = 0
    cur_data  = 0
    vptr = 0
    dptr = 0

    # Find first rising edge after min data
    start_t = min_t
    first_edge = (start_t // 10) * 10 + 5
    if first_edge < start_t:
        first_edge += 10

    end_t = max_t + 100

    t = first_edge
    while t <= end_t:
        # Advance valid pointer
        while vptr < len(vchanges) and vchanges[vptr][0] <= t:
            cur_valid = vchanges[vptr][1] if vchanges[vptr][1] is not None else cur_valid
            vptr += 1
        # Advance data pointer
        while dptr < len(dchanges) and dchanges[dptr][0] <= t:
            cur_data = dchanges[dptr][1] if dchanges[dptr][1] is not None else cur_data
            dptr += 1

        if cur_valid == 1:
            output_fires.append((t, cur_data))

        t += 10

print(f"Total output fires: {len(output_fires)}")

# Group into inferences of 10 logits each
inferences = []
for i in range(0, len(output_fires), 10):
    batch = output_fires[i:i+10]
    if len(batch) == 10:
        inferences.append(batch)

print(f"Inferences found: {len(inferences)}")
for i, batch in enumerate(inferences[:6]):
    times  = [t for t, v in batch]
    logits = [v for t, v in batch]
    argmax = logits.index(max(logits))
    print(f"  Inference {i}: logits={logits}  argmax={argmax}")
    print(f"    times: {times[0]}ps .. {times[-1]}ps")

# For each inference, find what was in the inputBuf right before the first logit output
# The FC layer reads from inputBuf during compute (before the first emit)
# The inputBuf was written during sReceive (before compute begins)
#
# We look at inputBuf reads in the ~256-cycle window before each inference's first logit
SCALE = 16.0 / 127.0
print("\n=== FC Input Buffer Contents Per Inference ===")
print("(Showing what was fed into the FC from pool2)")
ibchanges = sorted(inputbuf_times)

for i, batch in enumerate(inferences[:5]):
    first_logit_t = batch[0][0]  # time of first logit output

    # FC compute happens 256 * ~2 cycles (approx) before first emit
    # Let's look at inputBuf reads in the 1000 cycles before first_logit_t
    search_start = first_logit_t - 300_000   # generous window
    search_end   = first_logit_t

    buf_reads = [(t, v) for (t, v) in ibchanges
                 if search_start <= t <= search_end and v is not None]

    # Group consecutive reads — the inputBuf is read once per MAC step per output neuron
    # For 10 output neurons × 256 inputs = 2560 reads
    # We want the WRITE phase (256 writes before compute)
    # Actually the RAM read port mirrors the write port value during write
    # Let's just take the last 256 distinct values before compute

    # Better: find the 256 writes to inputBuf (the sReceive phase fills addresses 0..255)
    # These appear as 256 sequential inputBuf changes before compute
    # Let's take the last 256 inputBuf changes before the first logit
    last_256 = buf_reads[-256:] if len(buf_reads) >= 256 else buf_reads
    values = [v for t, v in last_256]

    logits = [v for t, v in batch]
    argmax = logits.index(max(logits))

    print(f"\n[Inference {i}] logits={logits}  argmax={argmax}")
    print(f"  FC input buf (last {len(last_256)} reads before first logit):")
    if values:
        print(f"    min={min(values)}, max={max(values)}, mean={sum(values)/len(values):.2f}")
        print(f"    first 16: {values[:16]}")
        print(f"    last  16: {values[-16:]}")
    else:
        print("    (no reads found in window)")

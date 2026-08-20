# MCA Timestamp Design (`mca_timestamp_1ch`)

Full MCA chain + **continuous event timestamp logger** + **full-resolution CDMA
histogram**. Every in-band peak is logged with a microsecond timestamp and a
channel-B digital tag; the live spectrum is drained by CDMA instead of
register-peek.

```
ADC ─┬─ chA ─► IIR1 ─► FIR9 ─► peak_detector ─┬─► peak_height_binning_cdma ─► BRAM(32b) ─┐
     │                                        │        └─► band_detected ─► DAC          │
     └─ chB (tdata[31:16]) ──────────────┐    └─► event_logger ─► BRAM(64b) ─┐           │
                                         └──────────────► chb_raw            │           │
                                                                    AXI BRAM Ctrl   AXI BRAM Ctrl
                                                                          └──── CDMA ────┘──► DDR ──► PC
```

## Event record (64-bit, little-endian)

| bits | field | notes |
|---|---|---|
| `[46:0]`  | timestamp | microseconds since `clear_ts`; 47-bit ⇒ 4.5-yr wrap (16× a 100-day run) |
| `[61:47]` | energy | 15-bit peak height |
| `[62]`    | chb | channel-B input, 1 if `chB ≥ chb_threshold` |
| `[63]`    | veto | 1 if the event fell inside a chB-transition veto window |

**Layout changed** — the timestamp is 47 bits, not 48; bit 63 became the veto tag
and chb moved 63→62. The pre-veto build packed the record as
`ts[47:0] | energy[62:48] | chb[63]` with no veto bit at all; those files do not
parse and are not supported. The failure is silent — `veto` comes back holding
chb and energy reads as `2×(energy & 0x3FFF)`, always even with the top bit lost.
`veto_ms` writes to such a bitstream land in an unused spare register and are
ignored without error, so the run looks healthy until you unpack it.

Time base = one free-running counter incremented every `presc` clocks
(`presc=125` ⇒ 1 µs at 125 MHz). **Never reset per day** — software slices by
time offline.

## Data paths

- **Histogram** — bins in an external `bram_interface` (32768 × 32-bit),
  incremented by a 3-cycle read-modify-write on Port-B. Port-A → AXI BRAM Ctrl →
  CDMA. Read the whole spectrum in one burst (register-peek of 32768 bins would
  take ~30 s).
- **Event logger** — ping-pong double buffer (2 × 4096 × 64-bit). Fills buffer A
  while the PS drains B; swaps on full or on `flush_ticks` timeout, so capture
  never stops. `dropped` counts events lost only if *both* buffers fill.
- **chB veto** — every transition of the chB digital bit (either direction) opens
  a `veto_ms` window; events inside it are **logged and tagged** (`[63]=1`), not
  discarded, so you filter them offline and `dropped` keeps its single meaning
  (both buffers full). Forward-only and not retriggerable — edges inside an active
  window are ignored, so a burst of chB chatter costs one window, not one each.
  Windows only open while armed, which discards the phantom edge produced when
  the host first writes `chb_threshold` (it resets to 0). Nothing else is gated:
  the µs counter, flush timer and buffer swaps run unchanged.

## Register maps (base + 4·index)

**event_logger** @ `0x40004000`
| off | reg | fields |
|---|---|---|
| 0x00 | control | `[0]`arm `[1]`clear_ts `[2]`reset `[3]`snap `[4]`ack |
| 0x04 | presc | µs divider (125) |
| 0x08 | frame_len | records/buffer |
| 0x0C | flush_ticks | µs before partial-buffer swap (0=never) |
| 0x10 / 0x14 | band_low / band_high | log window (signed) |
| 0x18 | chb_threshold | signed (resets to 0 = ADC mid-scale) |
| 0x1C | veto_ms | `[15:0]` chB-transition veto window, ms (0=off, max 65535) |
| 0x20 | status (ro) | `[0]`ready `[1]`ready_buf `[2]`dropped≠0 |
| 0x24 / 0x28 | ready_count / dropped | ro |
| 0x2C / 0x30 | ts_snap_lo / hi | ro (tie-point read; hi = ts`[46:32]`, 15 bits) |
| 0x34 / 0x38 | events_lo / hi | ro |

**peak_height_binning_cdma** @ `0x40003000`
| off | reg | fields |
|---|---|---|
| 0x00 | offset | signed |
| 0x04 | gain | unity = 256 |
| 0x08 / 0x0C | band_low / band_high | DAC trigger (signed) |
| 0x10 | control | `[0]`clear_bins `[1]`counting_enable `[2]`reset |
| 0x14 | pulse_width | DAC pulse (clk cycles) |
| 0x1C | status (ro) | `[0]`overflow `[1]`clearing_active |

## Memory map

| region | address | size |
|---|---|---|
| logger BRAM | `0x41000000` | 64 KB |
| histogram BRAM | `0x42000000` | 128 KB (32768 × 4) |
| CDMA control | `0x7E200000` | 64 KB |
| DDR scratch | `0x10000000` | — |

BRAM cost: histogram 32 tiles + logger 16 tiles = **48 / 60** on the xc7z010.

## Build

**First time — seed the project from the MCA design.** `make_project.tcl` only
rebuilds from a recipe at `projects/mca_timestamp_1ch/bd.tcl`; that file doesn't
exist yet, so copy the MCA one first (the recipe is portable — its BD is named
`system`, not tied to the old project):

```bash
mkdir -p projects/mca_timestamp_1ch
cp projects/mca_simple_1ch/bd.tcl projects/mca_timestamp_1ch/bd.tcl
vivado -mode batch -source scripts/make_project.tcl -tclargs mca_timestamp_1ch
```

This creates `projects/mca_timestamp_1ch/build/mca_timestamp_1ch.xpr` — an exact
copy of `mca_simple_1ch`. Open that `.xpr` in Vivado and edit the block design
(see "Block-design wiring" below). The `build/` folder is disposable/gitignored;
only `bd.tcl` is tracked, so **save your edits back to the recipe** when done:

```
# in the Vivado Tcl console:
write_bd_tcl -force -include_layout projects/mca_timestamp_1ch/bd.tcl
```

**Build the bitstream and deploy:**

```bash
vivado -mode batch -source scripts/build.tcl -tclargs mca_timestamp_1ch
cp projects/mca_timestamp_1ch/mca_timestamp_1ch.bit ../redpitaya_control/bitfiles/
```

> **After editing `rtl/event_logger.v` (or any RTL behind a module-reference
> block), run `make_project.tcl` first — `build.tcl` alone is not enough.**
> `build.tcl` only does `reset_run impl_1`. That re-runs the top synth, but the
> module's own out-of-context run stays "current", so the top synth black-boxes
> the stub and impl links the *stale* `.dcp`. The result is a bitstream with old
> module logic and no warning. `make_project.tcl` wipes `build/`, forcing the IP
> to be regenerated. Verify with:
>
> ```bash
> ls -ld projects/mca_timestamp_1ch/build/mca_timestamp_1ch.runs/{synth_1,system_event_logger_0_0_synth_1}
> ```
>
> If the `system_event_logger_0_0_synth_1` directory is older than the RTL file,
> the bitstream does not contain your changes.

Block-design wiring: histogram/logger each need a `bram_interface` + `axi_bram_ctrl`
(Port-B ↔ module, incl. `doutb → bram_dout` for the histogram RMW); one shared
`axi_cdma` reaches both BRAM controllers + a PS HP port via smartconnect. Fan the
peak_detector outputs to both modules; slice ADC `tdata[31:16]` → logger `chb_raw`.

## Host usage (`redpitaya_control`)

```python
from redpitaya_control.redpitaya_base import redpitaya_base
from redpitaya_control.event_logger import EventLogger, load_run, fit_clock, counter_to_unix, unpack
import numpy as np

rp = redpitaya_base("<ip>", "bitfiles/mca_timestamp_1ch.bit"); rp.connect(); rp.load_bitfile()

# --- live spectrum: one CDMA burst (reuses read_bram_fast) ---
raw = rp.read_bram_fast(0x42000000, 0x7E200000, 0x10000000, 131072)
spectrum = np.frombuffer(raw, dtype='<u4')          # 32768 bins

# --- continuous event logging ---
log = EventLogger(rp, base=0x40004000, bram_addr=0x41000000,
                  cdma_addr=0x7E200000, ddr_addr=0x10000000, frame_len=4096)
log.configure(presc=125, band_low=-32768, band_high=32767, chb_thr=0, flush_ms=100,
              veto_ms=100)                           # tag events within 100 ms of a chB edge
log.run(3600, output_dir="run1")                    # -> run1/events_YYYYMMDD_HH.bin + tiepoints.csv

# --- offline: drift-corrected absolute time ---
ts, energy, chb, veto = unpack(load_run("run1/events_*.bin"))
good = veto == 0                                    # drop chB-transition events
a, b, ppm = fit_clock("run1/tiepoints.csv")         # b = measured ns/tick; ppm = crystal error
t_unix = counter_to_unix(ts, a, b)
```

## Files & rotation

- **PC**, not the RP: `events_YYYYMMDD_HH.bin` (hourly, raw 8-B records) +
  one continuous `tiepoints.csv`. RP DDR is transient CDMA scratch.
- Durability: each buffer is `fsync`'d **before** `ack` (at-least-once); a crash
  re-drains rather than loses. `load_run()` drops exact-duplicate records.

## Absolute time

The ADC and timestamps share the crystal, so relative timing is exact. Absolute
time comes from ~1 Hz NTP tie-points `(host_time, counter)`; `fit_clock()` fits
`host = a + b·counter`, correcting the crystal's ±25–50 ppm drift (~7 min / 100
days) down to NTP (~ms). For µs-absolute, feed a GPS PPS into a DIO and log it as
a sync record — no external-clock hardware mod needed.

## Gotchas

- **Rate ceiling** 100k/s ⇒ 0.8 MB/s = 2.9 GB/hour = 69 GB/day. Scales with real
  rate. Host must drain continuously; a stalled link → `dropped` events.
- **Histogram counters** (32-bit) can overflow on very long high-rate runs;
  periodic read+clear, or rebuild histograms offline from the event log.
- **Shared CDMA** serves both drains — serialize on the host (don't issue a
  histogram read mid-logger-drain). A second CDMA removes the contention.
- **RMW** relies on MCA dead time (events never < 3 clk apart).
- `write_bd_tcl` can mangle CDMA/BRAM IP config — do the round-trip diff.
- **Stale OOC IP** — an energy scale that is off by 2× and always even, with chB
  showing up in the `veto` column, means the bitstream predates the veto change.
  Rebuild it (see Build); the old records cannot be recovered as veto-tagged.
```

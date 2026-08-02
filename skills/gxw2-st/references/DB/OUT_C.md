# OUT_C — OUT_C, OUT_C_32

Manual section: **4.3 / 4.4**, pages **66 / 68**. Index names: OUT_C, OUT_C_32.

## Purpose
Starts a hardware counter with a preset value. Direct hardware counter access — no FB declaration needed.

- `OUT_C` — 16-bit hardware counter (C0–C199)
- `OUT_C_32` — 32-bit hardware counter (C200–C255)

## ST Syntax (GX Works 2)
- `OUT_C(EN,CCx,Preset);`
- `OUT_C_32(EN,CCx,Preset);`

## Operands
- **EN**: Execution condition [Bit]
- **CCx**: Hardware counter device (e.g. CC0 for 16-bit, CC235 for 32-bit)
- **Preset**: Preset value (e.g. K200)

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
```iecst
OUT_C(TRUE, CC0, K200);       // Start 16-bit counter, preset 200
OUT_C_32(TRUE, CC235, K200);  // Start 32-bit counter, preset 200
RST(TRUE, CC235);             // Reset counter to 0
```

## Key Rules
- `CNx` — current counter value (e.g. `CN0` for 16-bit, `CN235` for 32-bit)
- `CSx` — counter contact, TRUE when count ≥ preset
- No CSV declaration needed for `OUT_C`/`OUT_C_32`, `CNx`, `CSx`
- `OUT_C` for 16-bit counters (C0–C199); `OUT_C_32` for 32-bit counters (C200–C255)
- Reset a counter with `RST(TRUE, CCx);` (see [SET.md](SET.md))

## Counter Types and Ranges (FX3U)

| Type | Range | Points | Counting Range |
|------|-------|--------|----------------|
| General up counter (16-bit) | C0–C15 | 16 | 0 to 32,767 |
| EEPROM hold up counter (16-bit) | C16–C199 | 184 | 0 to 32,767 |
| General bi-direction (32-bit) | C200–C219 | 20 | ±2,147,483,647 |
| EEPROM hold bi-direction (32-bit) | C220–C234 | 15 | ±2,147,483,647 |
| High-speed single-phase (32-bit, EEPROM hold) | C235–C245 | 11 | ±2,147,483,647 |
| High-speed single-phase dual input (32-bit, EEPROM hold) | C246–C250 | 5 | ±2,147,483,647 |
| High-speed dual-phase (32-bit, EEPROM hold) | C251–C255 | 5 | ±2,147,483,647 |

> High-speed counter notes: single-phase up to 60 kHz (6 channels max). Dual-phase: 1× frequency up to 30 kHz (2–3 channels), 4× frequency up to 24 kHz (2 channels). M8198 enables 4× for C251/C252; M8199 enables 4× for C253/C255.

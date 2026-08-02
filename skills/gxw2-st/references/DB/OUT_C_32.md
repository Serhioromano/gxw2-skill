# OUT_C_32 — OUT_C_32 / Hardware Counter Start (32-bit)

Manual section: **4.4**, page **68**. Index names: OUT_C_32.

## Purpose
This instruction starts a 32-bit hardware counter with a preset value. Direct hardware counter access — no FB declaration needed.

## ST Syntax (GX Works 2)
- `OUT_C_32(EN,CCx,Preset);`

## Operands
- **EN**: Execution condition [Bit]
- **CCx**: Hardware counter device (e.g. CC235)
- **Preset**: Preset value (e.g. K200)

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
```iecst
OUT_C_32(TRUE, CC235, K200);  // Start 32-bit counter, preset 200
RST(TRUE, CC235);             // Reset counter to 0
```

## Key Rules
- `CNx` — current counter value (e.g. `CN235`)
- `CSx` — counter contact, TRUE when count ≥ preset
- No CSV declaration needed for `OUT_C_32`, `CNx`, `CSx`
- `OUT_C_32` for 32-bit counters (C200–C255); use `OUT_C` for 16-bit (C0–C199)
- See [38_Function_Blocks.md](38_Function_Blocks.md) for the full hardware counter type/range table

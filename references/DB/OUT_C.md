# OUT_C — OUT_C / Hardware Counter Start (16-bit)

Manual section: **4.3**, page **66**. Index names: OUT_C.

## Purpose
This instruction starts a 16-bit hardware counter with a preset value. Direct hardware counter access — no FB declaration needed.

## ST Syntax (GX Works 2)
- `OUT_C(EN,CCx,Preset);`

## Operands
- **EN**: Execution condition [Bit]
- **CCx**: Hardware counter device (e.g. CC0)
- **Preset**: Preset value (e.g. K200)

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
```iecst
OUT_C(TRUE, CC0, K200);       // Start 16-bit counter, preset 200
```

## Key Rules
- `CNx` — current counter value (e.g. `CN0`)
- `CSx` — counter contact, TRUE when count ≥ preset
- No CSV declaration needed for `OUT_C`, `CNx`, `CSx`
- `OUT_C` for 16-bit counters (C0–C199); use `OUT_C_32` for 32-bit (C200–C255)
- See [38_Function_Blocks.md](38_Function_Blocks.md) for the full hardware counter type/range table

# OUT_T — OUT_T / Hardware Timer Start

Manual section: **4.2**, page **62**. Index names: OUT_T.

## Purpose
This instruction starts a hardware timer with a preset value. Direct hardware timer access — no FB declaration needed.

## ST Syntax (GX Works 2)
- `OUT_T(EN,TCx,Preset);`

## Operands
- **EN**: Execution condition [Bit]
- **TCx**: Hardware timer device (e.g. TC1)
- **Preset**: Preset value in 100ms units (e.g. K20 = 2s)

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
```iecst
OUT_T(TRUE, TC1, K20);    (* Start timer TC1: 20 × 100ms = 2s preset *)
```

## Key Rules
- `TN1` — current timer value (elapsed, 100ms units)
- `TS1` — timer contact, TRUE when timer done
- No CSV declaration needed for `OUT_T`, `TNx`, `TSx`
- See [38_Function_Blocks.md](38_Function_Blocks.md) for the full hardware timer type/range table

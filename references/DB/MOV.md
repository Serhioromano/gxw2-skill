# MOV — MOV / Move

Manual section: **8.3**, page **139**. Index names: MOV.

## Purpose
This instruction transfers (copies) the contents of a device to another device.

## ST Syntax (GX Works 2)
- `MOV(EN,s,d);`
- `MOVP(EN,s,d);`
- `DMOV(EN,s,d);`
- `DMOVP(EN,s,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s**: Data or device of transfer source [ANY16/ANY32]
- **ENO**: Execution state [Bit]
- **d**: Transfer destination device [ANY16/ANY32]

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
```iecst
MOV(X001, TN0, D20);
MOV(X002, K100, D10);
MOV(NOT X002, K50, D10);
MOV(M8000, K1X000, K1Y000);
```

## Key Rules
- EN is always the first parameter. Unconditional: use `TRUE` as EN: `MOV(TRUE, K100, wOut);`
- Conditional: EN controls execution: `MOV(xEnable, K100, wOut);`
- `MOVP` — pulse (one-shot on rising edge); `DMOV` — 32-bit (DINT/DWORD); `DMOVP` — 32-bit pulse
- `MOV_E` not available; use `MOV(EN, S, D)` with a BOOL EN
- For block/fill operations use `BMOV` (copy N words) or `FMOV` (fill N words with same value)
- No CSV declaration needed

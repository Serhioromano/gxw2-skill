# INC — INC / Increment

Manual section: **9.5**, page **181**. Index names: INC.

## Purpose
This instruction increments the data of a specified device by "1" (+1 addition).

## ST Syntax (GX Works 2)
- `INC(EN,d);`
- `INCP(EN,d);`
- `DINC(EN,d);`
- `DINCP(EN,d);`

## Operands
- **EN**: Execution condition [Bit]
- **ENO**: Execution state [Bit]
- **d**: Word device storing data to be incremented by "1" [ANY16/ANY32]

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
```iecst
INC(TRUE, iCount);             // iCount := iCount + 1 (always)
INC(xTrig, iCount);            // iCount := iCount + 1 when xTrig TRUE
INCP(xTrig, iCount);           // Pulse: one-shot
DINC(TRUE, diPosition);        // 32-bit increment
DINCP(xTrig, diPosition);
```

## Key Rules
- No `_E` variant. No CSV declaration needed.

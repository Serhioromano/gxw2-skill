# DEC — DEC / Decrement

Manual section: **9.6**, page **183**. Index names: DEC.

## Purpose
This instruction decrements the data of a specified device by "1" (-1 addition).

## ST Syntax (GX Works 2)
- `DEC(EN,d);`
- `DECP(EN,d);`
- `DDEC(EN,d);`
- `DDECP(EN,d);`

## Operands
- **EN**: Execution condition [Bit]
- **ENO**: Execution state [Bit]
- **d**: Device storing data to be decremented by "1" [ANY16/ANY32]

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
```iecst
DEC(TRUE, wRemaining);         // wRemaining := wRemaining - 1 (always)
DEC(xTrig, wRemaining);        // when xTrig TRUE
DECP(xTrig, wRemaining);       // Pulse: one-shot
DDEC(TRUE, diTotal);           // 32-bit decrement
DDECP(xTrig, diTotal);         // 32-bit pulse
```

## Key Rules
- No `_E` variant. No CSV declaration needed.

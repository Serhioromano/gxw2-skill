# TTMR — TTMR / Teaching Timer

Manual section: **13.5**, page **334**. Index names: TTMR.

## Purpose
This is a command for measuring the ON duration of TTMR command. This is used when adjusting the timer setting time by pushbutton.

## ST Syntax (GX Works 2)
- `TTMR(EN,n,d);`

## Operands
- **EN**: Execution condition [Bit]
- **n**: variable Multiplying factor number to be applied to teaching data [ANY16]
- **ENO**: Execution state [Bit]

## Support
- FX3U: ✓
- FX3G: —

## Examples (ST, from the manual)
```iecst
TTMR(X010, D300, K0);
```

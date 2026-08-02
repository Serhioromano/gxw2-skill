# DLOG10 — DLOG10 / Floating Point Common Logarithm

Manual section: **18.14**, page **475**. Index names: DLOG10.

## Purpose
Processing) (High Speed  Applied Instructions This instruction executes common logarithm operation. → As for handling of floating decimal point, refer to FX Structured Programming Manual [Device & Common].

## ST Syntax (GX Works 2)
- `DLOG10(EN,s,d);`
- `DLOG10P(EN,s,d);`

## Operands
- **EN**: Execution condition [Bit]
- **ENO**: Execution state [Bit]

## Support
- FX3U: ✓
- FX3G: —

## Examples (ST, from the manual)
```iecst
DLOG10(X000,D40,D30);
```

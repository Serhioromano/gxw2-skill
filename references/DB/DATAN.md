# DATAN — DATAN / Floating Point Arc Tangent

Manual section: **18.23**, page **490**. Index names: DATAN.

## Purpose
This instruction executes TAN-1 operation. → As for handling of floating decimal point, refer to FX Structured Programming Manual [Device & Common].

## ST Syntax (GX Works 2)
- `DATAN(EN,s,d);`
- `DATANP(EN,s,d);`

## Operands
- **EN**: Execution condition [Bit]
- **ENO**: Execution state [Bit]

## Support
- FX3U: ✓
- FX3G: —

## Examples (ST, from the manual)
```iecst
DATAN(X000,D0,D10);
```

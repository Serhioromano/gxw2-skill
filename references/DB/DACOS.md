# DACOS — DACOS / Floating Point Arc Cosine

Manual section: **18.22**, page **488**. Index names: DACOS.

## Purpose
This instruction executes COS-1 operation. → As for handling of floating decimal point, refer to FX Structured Programming Manual [Device & Common].

## ST Syntax (GX Works 2)
- `DACOS(EN,s,d);`
- `DACOSP(EN,s,d);`

## Operands
- **EN**: Execution condition [Bit]
- **ENO**: Execution state [Bit]

## Support
- FX3U: ✓
- FX3G: —

## Examples (ST, from the manual)
```iecst
DACOS(X000,D0,D10);
```

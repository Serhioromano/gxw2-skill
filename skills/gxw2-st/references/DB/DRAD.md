# DRAD — DRAD / Floating Point Degrees to Radians Conversion

Manual section: **18.24**, page **492**. Index names: DRAD.

## Purpose
This instruction converts the value of angle unit to the radian unit. → As for handling of floating decimal point, refer to FX Structured Programming Manual [Device & Common].

## ST Syntax (GX Works 2)
- `DRAD(EN,s,d);`
- `DRADP(EN,s,d);`

## Operands
- **EN**: Execution condition [Bit]
- **ENO**: Execution state [Bit]

## Support
- FX3U: ✓
- FX3G: —

## Examples (ST, from the manual)
```iecst
DRAD(X000,D10,D20);
```

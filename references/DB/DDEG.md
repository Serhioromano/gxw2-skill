# DDEG — DDEG / Floating Point Radians to Degrees Conversion

Manual section: **18.25**, page **494**. Index names: DDEG.

## Purpose
This instruction converts the radian unit value into the angle (DEG) unit. → As for handling of floating decimal point, refer to FX Structured Programming Manual [Device & Common].

## ST Syntax (GX Works 2)
- `DDEG(EN,s,d);`
- `DDEG_P(EN,s,d);`

## Operands
- **EN**: Execution condition [Bit]
- **ENO**: Execution state [Bit]

## Support
- FX3U: —
- FX3G: —

## Examples (ST, from the manual)
```iecst
DDEG(X000,D20,D10);
```

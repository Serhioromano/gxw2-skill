# SQR — SQR / Square Root

Manual section: **11.9**, page **248**. Index names: SQR.

## Purpose
This instruction obtains the square root. The DESQR instruction obtains the square root in floating point operation. → For DESQR instruction, refer to Section 18.15.

## ST Syntax (GX Works 2)
- `SQR(EN,s,d);`
- `SQRP(EN,s,d);`
- `DSQR(EN,s,d);`
- `DSQRP(EN,s,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s**: Word device storing data whose square root is obtained. [ANY16/ANY32]
- **ENO**: Execution state [Bit]
- **d**: variable Data register storing the square root operation result [ANY16/ANY32]

## Support
- FX3U: ✓
- FX3G: —

## Examples (ST, from the manual)
```iecst
SQR(X000, D10, D12);
```

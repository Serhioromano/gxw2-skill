# SUM — SUM / Sum of Active Bits

Manual section: **11.4**, page **236**. Index names: SUM.

## Purpose
This instruction counts the number of "1" (ON) bits in the data of a specified device.

## ST Syntax (GX Works 2)
- `SUM(EN,s,d);`
- `SUMP(EN,s,d);`
- `DSUM(EN,s,d);`
- `DSUMP(EN,s,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s**: Word device storing the data [ANY16/ANY32]
- **ENO**: Execution state [Bit]
- **d**: Word device storing the result data [ANY16/ANY32]

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
```iecst
SUM(X000, D0, D2);
```

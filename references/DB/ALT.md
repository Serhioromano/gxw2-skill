# ALT — ALT / Alternate State

Manual section: **13.7**, page **340**. Index names: ALT.

## Purpose
This is the command for inverting the bit device (ON to OFF, OFF to ON) when the input is turned ON.

## ST Syntax (GX Works 2)
- `ALT(EN,d);`
- `ALTP(EN,d);`

## Operands
- **EN**: Execution condition [Bit]
- **ENO**: Execution state [Bit]
- **d**: Bit device to be output alternately [Bit]

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
```iecst
ALT(X006 AND TS2,Y007);
```

# LEN — LEN / Character String Length Detection

Manual section: **26.4**, page **631**. Index names: LEN.

## Purpose
(External Device) Applied Instructions This instruction detects the number of characters (bytes) of a specified character string.

## ST Syntax (GX Works 2)
- `LEN(EN,s,d);`
- `LENP(EN,s,d);`

## Operands
- **EN**: Execution condition [Bit]
- **ENO**: Execution state [Bit]
- **s**: variable Device storing the detected character string length (number of bytes) [ANY16]

## Support
- FX3U: ✓
- FX3G: —

## Examples (ST, from the manual)
```iecst
LEN(X000,D0,D10);
```

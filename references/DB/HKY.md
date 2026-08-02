# HKY — HKY / Hexadecimal Input

Manual section: **14.2**, page **357**. Index names: HKY.

## Purpose
Processing) (High Speed  Applied Instructions This is a command for setting the input data of numerical value (0 to 9) or operation condition (function keys A to F), by the input of keys from 0 to F (16 keys). When the extension function is turned ON, the key input is entered in hexadecimal notation by keys 0 to F.

## ST Syntax (GX Works 2)
- `HKY(EN,s,d1,d2);`
- `DHKY(EN,s,d1,d2);`

## Operands
- **EN**: Execution condition [Bit]
- **ENO**: Execution state [Bit]
- **s**: Device for storing numerical value entered from 16 keys [ANY16/ANY32]
- **d1**: ARRAY [0..7] OF [Bit]

## Support
- FX3U: ✓
- FX3G: —

## Examples (ST, from the manual)
```iecst
HKY(X004, X000, Y000, D0, M0);
```

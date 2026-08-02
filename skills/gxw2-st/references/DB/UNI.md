# UNI — UNI / 4-bit Linking of Word Data

Manual section: **19.4**, page **506**. Index names: UNI.

## Purpose
This instruction couples lower 4 bits of continuous 16-bit data.

## ST Syntax (GX Works 2)
- `UNI(EN,s,n,d);`
- `UNIP(EN,s,n,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s**: Head device for storing the data to be coupled. [ANY16]
- **n**: Number of couples [0 to 4](When "n" is "0", UNI instruction is not executed.) [ANY16]
- **ENO**: Execution state [Bit]
- **d**: Head device for storing the coupled data. [ANY16]

## Support
- FX3U: —
- FX3G: —

## Examples (ST, from the manual)
_not extracted_

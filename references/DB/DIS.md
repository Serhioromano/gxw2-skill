# DIS — DIS / 4-bit Grouping of Word Data

Manual section: **19.5**, page **508**. Index names: DIS.

## Purpose
This instruction separates 16-bit data in 4-bit unit.

## ST Syntax (GX Works 2)
- `DIS(EN,s,n,d);`
- `DISP(EN,s,n,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s**: Device for storing the data to be separated. [ANY16]
- **n**: Number of separates [0 to 4](When "n" is "0", UNI instruction is not executed.) [ANY16]
- **ENO**: Execution state [Bit]
- **d**: Head device for storing the separated data. [ANY16]

## Support
- FX3U: —
- FX3G: —

## Examples (ST, from the manual)
_not extracted_

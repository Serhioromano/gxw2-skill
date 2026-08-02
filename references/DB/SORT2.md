# SORT2 — SORT2 / Sort Tabulated Data 2

Manual section: **19.7**, page **512**. Index names: SORT2.

## Purpose
This instruction sorts the data table composed of data (rows) and group data (columns) in the ascending order/descending order in row unit on the basis of the specified group data (rows). In this instruction, data (row direction) is stored in continuous devices, and it is easy to add the data (row). In SORT, sorting is in ascending order only, and data composition is different (data is composed in devices

## ST Syntax (GX Works 2)
- `SORT2(EN,s,n,d);`
- `DSORT2(EN,s,n,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s**: Head device for storing data table [m1 × m2 points occupied] [ANY16/ANY32]
- **n**: Number of data (rows) [1 to 32] [ANY16/ANY32]
- **d**: Number of group data (columns) [1 to 6] [ANY16/ANY32]
- **?**: Columns of group data (columns) as reference for sorting [1 to m2] [ANY16/ANY32]
- **ENO**: Execution state [Bit]
- **?**: variable Head device for storing operation result [m1 × m2 points occupied] [ANY16/ANY32]

## Support
- FX3U: ✓
- FX3G: —

## Examples (ST, from the manual)
_not extracted_

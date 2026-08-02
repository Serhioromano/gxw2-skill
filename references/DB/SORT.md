# SORT — SORT / SORT Tabulated Data

Manual section: **13.10**, page **349**. Index names: SORT.

## Purpose
Processing) (High Speed  Applied Instructions This command reshuffles the data table composed of data (columns) and group data (rows) in the ascending order in column unit on the basis of designated group data (rows). In this command, the group data (rows) is stored in continuous devices. Similarly, in SORT2 command, data (columns) is stored in continuous devices,

## ST Syntax (GX Works 2)
- `SORT(EN,s,n,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s**: Beginning device storing data table (m1xm2 points occupied) [ANY16]
- **n**: Number of data (columns) [ANY16]
- **d**: Number of group data (rows) [ANY16]
- **?**: Row of group data (rows) as basis of reshuffling [ANY16]
- **ENO**: Execution state [Bit]
- **?**: variable Beginning device storing arithmetic results (m1 × m2 points occupied) [ANY16]

## Support
- FX3U: ✓
- FX3G: —

## Examples (ST, from the manual)
_not extracted_

# DHSCT — DHSCT / High Speed Counter Compare With Data Table

Manual section: **32.1**, page **738**. Index names: DHSCT.

## Purpose
This instruction compares the current value of a high speed counter with a data table of comparison points, and then sets or resets up to 16 output devices.

## ST Syntax (GX Works 2)
- `DHSCT(EN,s1,s2,n,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s1**: Head device storing the data table [ANY32]
- **s2**: Number of comparison points in data table (1 ≤ m ≤ 128) [ANY32]
- **n**: High speed counter (C235 to C255) [ANY32]
- **d**: Number of devices to which the operation status is output [ANY32]
- **ENO**: Execution state [Bit]
- **?**: variable Head device to which the operation status is output [Bit]

## Support
- FX3U: ✓
- FX3G: —

## Examples (ST, from the manual)
```iecst
DHSCT(M8000,R0,K5,CN235,K4,Y010);
```

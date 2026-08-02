# ANWR — ANWR / Write to F2-6A

Manual section: **16.3**, page **423**. Index names: ANWR.

## Purpose
Processing) (High Speed  Applied Instructions This instruction writes data from the PLC in the F2-6A type analog input and output unit, and issues as analog data.

## ST Syntax (GX Works 2)
- `ANWR(EN,s1,s2,n,d);`
- `ANWRP(EN,s1,s2,n,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s1**: Device for storing analog output data (8-bit binary) [ANY16]
- **s2**: variable Head input number of FX2-24EI connected to F2-6A 16 [Bit]
- **n**: Channel number of analog output [ANY16]
- **ENO**: Execution state [Bit]
- **d**: variable Head output number of FX2-24EI connected to F2-6A [Bit]

## Support
- FX3U: —
- FX3G: —

## Examples (ST, from the manual)
_not extracted_

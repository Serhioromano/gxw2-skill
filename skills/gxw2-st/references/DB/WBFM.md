# WBFM — WBFM / Divided BFM Write

Manual section: **31.2**, page **735**. Index names: WBFM.

## Purpose
Processing 2) (High Speed  Applied Instructions This instruction writes data to continuous buffer memories (BFM) in a special function block and unit over several operation cycles by the time division method.  This instruction is convenient for writing send data, etc. to buffer memories in a special function block and unit for communication by the time division method.

## ST Syntax (GX Works 2)
- `WBFM(EN,s);`

## Operands
- **EN**: Execution condition [Bit]
- **s**: Unit number [ANY16]
- **?**: Head buffer memory (BFM) number [ANY16]
- **?**: variable Head device storing data to be written to buffer memory (BFM) [ANY16]
- **?**: Number of all buffer memories (BFM) to be written [ANY16]
- **?**: Number of points transferred in one operation cycle [ANY16]
- **ENO**: Execution state [ANY16]

## Support
- FX3U: —
- FX3G: —

## Examples (ST, from the manual)
_not extracted_

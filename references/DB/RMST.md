# RMST — RMST / F2-32RM start

Manual section: **16.4**, page **424**. Index names: RMST.

## Purpose
This instruction gives start signal from the PLC or receives status information, in the F2-32RM type programmable cam switch.

## ST Syntax (GX Works 2)
- `RMST(EN,s,n,d1,d2);`

## Operands
- **EN**: Execution condition [Bit]
- **s**: Program (bank) number of F2-32RM (n = 0, 1). [ANY16]
- **ENO**: Execution state [Bit]
- **Head**: output
- **n**: Head of device storing status information (8 points occupied) [Bit]

## Support
- FX3U: —
- FX3G: —

## Examples (ST, from the manual)
_not extracted_

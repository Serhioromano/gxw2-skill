# FLSTRD — FLSTRD / FX3U-CF-ADP status read

Manual section: **34.6**, page **789**. Index names: FLSTRD.

## Purpose
Processing 2) (High Speed  Applied Instructions The FLSTRD instruction reads the status (including the error information and file information) of the FX3U- CFADP. → As for explanation of the instruction, see the FX3U-CF-ADP User's Manual.

## ST Syntax (GX Works 2)
- `FLSTRD(EN,s,n,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s**: Used channel number [contents of setting : K1 = ch1, K2 = ch2] [ANY16]
- **ENO**: Execution state [Bit]

## Support
- FX3U: —
- FX3G: —

## Examples (ST, from the manual)
_not extracted_

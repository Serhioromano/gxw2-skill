# FLRD — FLRD / Data read

Manual section: **34.4**, page **785**. Index names: FLRD.

## Purpose
Processing 2) (High Speed  Applied Instructions The FLRD instruction reads data from the CompactFlashTM card. → As for explanation of the instruction, see the FX3U-CF-ADP User's Manual.

## ST Syntax (GX Works 2)
- `FLRD(EN,s1,s2,n,d1,d2);`

## Operands
- **EN**: Execution condition [Bit]
- **s1**: File ID (Refer to Detailed explanation of setting data) 35 [ANY16]
- **s2**: variable Data read parameter (Refer to Detailed explanation of setting data) ARRAY [0..3] OF [ANY16]
- **n**: Used channel number [contents of setting : K1 = ch1, K2 = ch2] [ANY16]
- **ENO**: Execution state [Bit]
- **d1**: Number of data points existing in the specified line A [ANY16]

## Support
- FX3U: —
- FX3G: —

## Examples (ST, from the manual)
_not extracted_

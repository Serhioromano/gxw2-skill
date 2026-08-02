# FLCRT — FLCRT / File create • check

Manual section: **34.1**, page **775**. Index names: FLCRT.

## Purpose
Processing 2) (High Speed  Applied Instructions The FLCRT instruction creates a file inside the CompactFlashTM card mounted in the FX3U-CF-ADP. When executed after creation of a new file, the FLCRT instruction checks the association with the file ID, and evaluates it.

## ST Syntax (GX Works 2)
- `FLCRT(EN,s1,s2,n);`

## Operands
- **EN**: Execution condition [Bit]
- **s1**: File ID (Refer to Detailed explanation of setting data) [ANY16]
- **s2**: File name (Refer to Detailed explanation of setting data) [String]
- **n**: File creation parameter (Refer to Detailed explanation of setting data) ARRAY [0..3] OF [ANY16]
- **?**: Used channel number [contents of setting : K1 = ch1, K2 = ch2] and addresses between devices Relationships [ANY16]
- **ENO**: Execution state [Bit]

## Support
- FX3U: —
- FX3G: —

## Examples (ST, from the manual)
_not extracted_

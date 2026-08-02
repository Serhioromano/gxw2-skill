# FLDEL — FLDEL / File delete • CF card format

Manual section: **34.2**, page **779**. Index names: FLDEL.

## Purpose
Processing 2) (High Speed  Applied Instructions The FLDEL instruction deletes files stored in the CompactFlashTM card, or formats the CompactFlashTM card. → As for explanation of the instruction, see the FX3U-CF-ADP User's Manual.

## ST Syntax (GX Works 2)
- `FLDEL(EN,s1,s2,n);`

## Operands
- **EN**: Execution condition [Bit]
- **s1**: File ID (Refer to Detailed explanation of setting data) Function and Pulse Catch Interrupt Function [ANY16]
- **s2**: variable File delete method (Refer to Detailed explanation of setting data) [ANY16]
- **n**: Used channel number [contents of setting : K1 = ch1, K2 = ch2] [ANY16]
- **ENO**: Execution state [Bit]

## Support
- FX3U: —
- FX3G: —

## Examples (ST, from the manual)
_not extracted_

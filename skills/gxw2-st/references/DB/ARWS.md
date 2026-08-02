# ARWS — ARWS / Arrow Switch

Manual section: **14.6**, page **372**. Index names: ARWS.

## Purpose
This instruction enters data by arrow switches for digit move and increase and decrease of numerical value of each digit.

## ST Syntax (GX Works 2)
- `ARWS(EN,s,n,d1,d2);`

## Operands
- **EN**: Execution condition [Bit]
- **s**: Digit number specification of 7-segment display [ANY16]
- **ENO**: Execution state [Bit]
- **n**: device in which BCD converted data is stored [Word/ANY16]
- **d1**: ARRAY [0..7] OF [Bit]

## Support
- FX3U: ✓
- FX3G: —

## Examples (ST, from the manual)
_not extracted_

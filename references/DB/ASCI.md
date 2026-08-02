# ASCI — ASCI / Hexadecimal to ASCII Conversion

Manual section: **15.3**, page **395**. Index names: ASCI.

## Purpose
Processing) (High Speed  Applied Instructions This instruction converts HEX code into ASCII code. Also available are BINDA instruction for converting BIN data into ASCII code, and DESTR instruction for converting binary floating decimal point data into ASCII code.

## ST Syntax (GX Works 2)
- `ASCI(EN,s,n,d);`
- `ASCIP(EN,s,n,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s**: Head device in which HEX code to be converted is stored [ANY16]
- **n**: Number of characters in HEX code to be converted (number of digits) [ANY16]
- **d**: ENO Execution state (External Device) Applied Instructions [Bit]
- **?**: Head device for storing converted ASCII code [ANY16]

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
_not extracted_

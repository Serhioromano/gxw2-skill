# HEX — HEX / ASCII to Hexadecimal Conversion

Manual section: **15.4**, page **399**. Index names: HEX.

## Purpose
Processing) (High Speed  Applied Instructions This instruction converts ASCII code into HEX code. Also available are DABIN instruction for converting ASCII code into BIN data, and DEVAL instruction for converting ASCII code into binary floating decimal point data.

## ST Syntax (GX Works 2)
- `HEX(EN,s,n,d);`
- `HEXP(EN,s,n,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s**: Head device in which ASCII code to be converted is stored 16 [ANY16]
- **n**: Number of characters in ASCII code to be converted (number of bytes) [ANY16]
- **ENO**: Execution state [Bit]
- **d**: Head device for storing converted HEX code [ANY16]

## Support
- FX3U: —
- FX3G: —

## Examples (ST, from the manual)
_not extracted_

# INT — INT / Floating Point to Integer Conversion

Manual section: **18.17**, page **480**. Index names: INT.

## Purpose
This instruction converts the binary floating decimal point into BIN integer in normal data type in the PLC. (From binary floating decimal point data to BIN integer) → As for program example of floating decimal point operation, refer to section 11.10. → As for handling of floating decimal point, refer to FX Structured Programming Manual [Device &

## ST Syntax (GX Works 2)
- `INT(EN,s,d);`
- `INTP(EN,s,d);`
- `DINT(EN,s,d);`
- `DINTP(EN,s,d);`

## Operands
- **EN**: Execution condition [Bit]
- **ENO**: Execution state [Bit]
- **s**: variable Device for storing the converted BIN integer. [ANY16/ANY32]

## Support
- FX3U: ✓
- FX3G: —

## Examples (ST, from the manual)
_not extracted_

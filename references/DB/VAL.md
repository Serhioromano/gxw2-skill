# VAL — VAL / Character String to BIN Conversion

Manual section: **26.2**, page **622**. Index names: VAL.

## Purpose
This instruction converts a character string (ASCII codes) into binary data. On the other hand, EVAL instruction converts a character string (ASCII codes) into floating point data.

## ST Syntax (GX Works 2)
- `VAL(EN,s,d1,d2);`
- `VALP(EN,s,d1,d2);`
- `DVAL(EN,s,d1,d2);`
- `DVALP(EN,s,d1,d2);`

## Operands
- **EN**: Execution condition [Bit]
- **ENO**: Execution state [Bit]
- **s**: ARRAY [0..1] OF [ANY16]
- **d1**: Head device storing the binary data acquired by conversion. [ANY16/ANY32]

## Support
- FX3U: —
- FX3G: —

## Examples (ST, from the manual)
_not extracted_

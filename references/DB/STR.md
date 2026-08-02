# STR — STR / BIN to Character String Conversion

Manual section: **26.1**, page **617**. Index names: STR.

## Purpose
(External Device) Applied Instructions This instruction converts binary data into character strings (ASCII codes). On the other hand, the ESTR instruction converts floating point data into character strings.

## ST Syntax (GX Works 2)
- `STR(EN,s1,s2,d);`
- `STRP(EN,s1,s2,d);`
- `DSTR(EN,s1,s2,d);`
- `DSTRP(EN,s1,s2,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s1**: ARRAY [0..1] OF [ANY16]
- **converted**: converted (2 points occupied)
- **s2**: Device storing binary data to be converted [ANY16/ANY32]
- **ENO**: Execution state [Bit]
- **d**: variable Head device storing converted character string [String]

## Support
- FX3U: —
- FX3G: —

## Examples (ST, from the manual)
_not extracted_

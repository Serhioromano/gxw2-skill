# MIDR — MIDR / Random Selection of Character Strings

Manual section: **26.7**, page **640**. Index names: MIDR.

## Purpose
This instruction extracts a specified number of characters from arbitrary positions of a specified character string.

## ST Syntax (GX Works 2)
- `MIDR(EN,s1,s2,d);`
- `MIDRP(EN,s1,s2,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s1**: Head device storing a character string [String]
- **s2**: ARRAY [1..2] OF [ANY16]
- **ENO**: Execution state [Bit]
- **d**: variable Head device storing extracted character string [String]

## Support
- FX3U: —
- FX3G: —

## Examples (ST, from the manual)
```iecst
MIDR(X000,D10,R0,D0);
```

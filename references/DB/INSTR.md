# INSTR — INSTR / Character string search

Manual section: **26.9**, page **647**. Index names: INSTR.

## Purpose
(External Device) Applied Instructions This instruction  searches a specified character string within another character string.

## ST Syntax (GX Works 2)
- `INSTR(EN,s1,s2,n,d);`
- `INSTRP(EN,s1,s2,n,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s1**: Head device storing a character string to search for [String]
- **s2**: variable Head device storing a character string to be searched [String]
- **n**: Search start position [ANY16]
- **d**: Control) (Character Applied Instructions [String]
- **ENO**: Execution state [Bit]
- **?**: Head device storing search result [ANY16]

## Support
- FX3U: ✓
- FX3G: —

## Examples (ST, from the manual)
```iecst
INSTR(X000,D0,R0,K5,D100);
```

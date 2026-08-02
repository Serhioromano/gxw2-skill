# MIDW — MIDW / Random Replacement of Character Strings

Manual section: **26.8**, page **643**. Index names: MIDW.

## Purpose
(External Device) Applied Instructions This instruction replaces the characters in arbitrary positions inside designated character string with a specified character string. → For handling of character strings, refer to "FX Structured Programming Manual [Device &

## ST Syntax (GX Works 2)
- `MIDW(EN,s1,s2,d);`
- `MIDWP(EN,s1,s2,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s1**: Head device storing a character string used in overwriting [String]
- **s2**: be overwritten (2 points occupied) Control) (Character Applied Instructions [String]
- **d**: ARRAY [1..2] OF [ANY16]
- **ENO**: Execution state [Bit]
- **?**: variable Head device storing a character string overwritte [String]

## Support
- FX3U: —
- FX3G: —

## Examples (ST, from the manual)
```iecst
MIDW(X010,D0,R0,D100);
```

# POP — POP / Shift Last Data Read [FILO Control]

Manual section: **27.3**, page **660**. Index names: POP.

## Purpose
This instruction reads the last data written by the shift write (SFWR) instruction for the first-in first-out and first- in last-out control

## ST Syntax (GX Works 2)
- `POP(EN,s,n,d);`
- `POPP(EN,s,n,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s**: Head device storing first-in data (including pointer data) [ANY16]
- **ENO**: Execution state [Bit]
- **n**: Device storing last-out data [ANY16]

## Support
- FX3U: —
- FX3G: —

## Examples (ST, from the manual)
```iecst
POP(LDP(TRUE,X000),D100,K7,D10);
```

# SMOV — SMOV / Shift Move

Manual section: **8.4**, page **143**. Index names: SMOV.

## Purpose
This instruction distributes and composes data in units of digit (4 bits).

## ST Syntax (GX Works 2)
- `SMOV(EN,s,n,d);`
- `SMOVP(EN,s,n,d);`

## Operands
- **EN**: Execution condition [Bit]
- **?**: Word device storing data whose digits will be moved. [ANY16]
- **?**: Head digit position to be moved [ANY16]
- **?**: Number of digits to be moved [ANY16]
- **?**: Head digit position of movement destination [ANY16]
- **ENO**: Execution state [Bit]
- **?**: variable device storing data whose digits are moved 7 [Word/ANY16]
- **Operand**: Operand
- **SMOV**: Command input
- **s**: Digit transfer
- **m2**: Number of digits
- **n**: Digit position at
- **d**: stored to
- **X010**: M8168

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
```iecst
SMOV(M8000, D1, K1, K1, K3, D2);
```

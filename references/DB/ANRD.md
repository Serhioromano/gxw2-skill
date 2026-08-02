# ANRD — ANRD / Read from F2-6A

Manual section: **16.2**, page **421**. Index names: ANRD.

## Purpose
Processing) (High Speed  Applied Instructions This instruction writes the analog input of F2-6A type analog input and output unit.

## ST Syntax (GX Works 2)
- `ANRD(EN,s,n,d1,d2);`
- `ANRDP(EN,s,n,d1,d2);`

## Operands
- **EN**: Execution condition [Bit]
- **s**: Head input number of FX2-24EI connected to F2-6A (16 points occupied) [Bit]
- **n**: Channel number of analog input (n=10,11,12,13) [ANY16]
- **ENO**: Execution state [Bit]
- **d1**: Head output number of FX2-24EI connected to F2-6A (8 points occupied) [Bit]
- **d2**: Device storing analog input value (8-bit binary) [ANY16]

## Support
- FX3U: —
- FX3G: —

## Examples (ST, from the manual)
```iecst
ANRD(M8000, X040, K10, Y030, D20);
```

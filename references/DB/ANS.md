# ANS — ANS / Timed Annunciator Set

Manual section: **11.7**, page **244**. Index names: ANS.

## Purpose
This instruction sets a state relay as an annunciator.

## ST Syntax (GX Works 2)
- `ANS(EN,s,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s**: Timer for evaluation time (100 ms timer) [ANY16]
- **d**: Evaluation time [m=1 to 32,767] (unit: 100 ms) [ANY16]
- **ENO**: Execution state [Bit]
- **?**: Annunciator device to be set [Bit]

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
```iecst
ANS(Y005 AND NOT X000, T0, K10, S900);
ANS(NOT X001 AND NOT X002,T1, K20, S901);
ANS(X003 AND NOT X004, T2, K100, S902);
```

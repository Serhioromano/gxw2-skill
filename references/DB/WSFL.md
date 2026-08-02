# WSFL — WSFL / Word Shift Left

Manual section: **10.8**, page **216**. Index names: WSFL.

## Purpose
This instruction shifts the word data information leftward by the specified number of words.

## ST Syntax (GX Works 2)
- `WSFL(EN,s,d);`
- `WSFLP(EN,s,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s**: Head device to be stored to the shift data after leftward shift [ANY16]
- **d**: Word data length of the shift data (n2 ≤ n1 ≤ 512) [ANY16]
- **?**: Number of words to be shifted leftward (n2 ≤ n1 ≤ 512) [ANY16]
- **ENO**: Execution state [Bit]
- **?**: variable Head word device storing data to be shifted leftward [ANY16]

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
```iecst
WSFL(X000, K1X000, K4, K2, K1Y000);
```

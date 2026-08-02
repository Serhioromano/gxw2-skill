# WSFR — WSFR / Word Shift Right

Manual section: **10.7**, page **213**. Index names: WSFR.

## Purpose
This instruction shifts word devices with "n1" data length rightward by "n2" words.

## ST Syntax (GX Works 2)
- `WSFR(EN,s,d);`
- `WSFRP(EN,s,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s**: Head device to be stored to the shift data after rightward shift [ANY16]
- **d**: Word data length of the shift data (n2 ≤ n1 ≤ 512) [ANY16]
- **?**: Number of words to be shifted rightward (n2 ≤ n1 ≤ 512) [ANY16]
- **ENO**: Execution state [Bit]
- **?**: variable Head word device storing data to be shifted rightward [ANY16]

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
```iecst
WSFR(X000, K1X000, K4, K2, K1Y000);
```

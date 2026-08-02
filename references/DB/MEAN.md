# MEAN — MEAN / Mean

Manual section: **11.6**, page **242**. Index names: MEAN.

## Purpose
This instruction obtains the mean value of data.

## ST Syntax (GX Works 2)
- `MEAN(EN,s,n,d);`
- `MEANP(EN,s,n,d);`
- `DMEAN(EN,s,n,d);`
- `DMEANP(EN,s,n,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s**: Head word device storing data to be averaged [ANY16/ANY32]
- **n**: Number of data to be averaged (n=1 to 64) [ANY16]
- **ENO**: Execution state [Bit]
- **d**: variable device storing the mean value result [Word/ANY16/ANY32]

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
```iecst
MEAN(X000, D0, K3, D10);
```

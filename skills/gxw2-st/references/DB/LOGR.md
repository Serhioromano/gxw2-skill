# LOGR — LOGR / Logging R and ER

Manual section: **33.4**, page **761**. Index names: LOGR.

## Purpose
Processing 2) (High Speed  Applied Instructions This instruction logs specified devices, and stores the logged data to extension registers (R) and extension file registers (ER) in a memory cassette.

## ST Syntax (GX Works 2)
- `LOGR(EN,s,n,d1,d2);`
- `LOGRP(EN,s,n,d1,d2);`

## Operands
- **EN**: Execution condition [Bit]
- **s**: Head device to be logged [ANY16]
- **n**: Number of devices to be logged (1≤ m ≤ 8000) [ANY16]
- **d1**: Number of sectors of devices used in logging (1 ≤ n ≤ 16) [ANY16]
- **ENO**: Execution state [Bit]
- **d2**: Head device used in logging [ANY16]
- **?**: Number of pieces of logged data [ANY16]

## Support
- FX3U: ✓
- FX3G: —

## Examples (ST, from the manual)
```iecst
LOGR(X001,D1,K2,K2,R2048,D100);
```

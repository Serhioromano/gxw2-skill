# TSUB — TSUB / RTC Data Subtraction

Manual section: **21.4**, page **549**. Index names: TSUB.

## Purpose
(External Device) Applied Instructions Two time data are subtracted and stored in the word device.

## ST Syntax (GX Works 2)
- `TSUB(EN,s1,s2,d);`
- `TSUBP(EN,s1,s2,d);`

## Operands
- **EN**: EN Execution condition Operation) (Block Data Applied Instructions [Bit]
- **ENO**: Execution state [Bit]

## Support
- FX3U: —
- FX3G: —

## Examples (ST, from the manual)
```iecst
TSUB(X000,D10,D20,D30);
```

# TADD — TADD / RTC Data Addition

Manual section: **21.3**, page **547**. Index names: TADD.

## Purpose
(External Device) Applied Instructions Two time data are added and stored in the word device.

## ST Syntax (GX Works 2)
- `TADD(EN,s1,s2,d);`
- `TADDP(EN,s1,s2,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s1**: Device for storing "hour" of addition time data (hour, minute, second) (3 points occupied) OF [ANY16]
- **ENO**: Execution state [Bit]
- **s2**: variable Device for storing the added result of two time data (hour, minute, second) (3 points ARRAY [0..2] Control) (Character Applied Instructions [String]

## Support
- FX3U: —
- FX3G: —

## Examples (ST, from the manual)
```iecst
TADD(X000,D10,D20,D30);
```

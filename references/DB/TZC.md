# TZC — TZCP / RTC Data Zone Compare

Manual section: **21.2**, page **544**. Index names: TZCP.

## Purpose
The comparison time of higher and lower points and the time data are compared, and the bit device is turned ON or OFF depending on the magnitude of difference.

## ST Syntax (GX Works 2)
- `TZCP(EN,s1,s2,s,d);`
- `TZCPP(EN,s1,s2,s,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s1**: data (hour, minute, second) "hour" (3 points occupied) [Time]
- **ENO**: Execution state [Bit]

## Support
- FX3U: —
- FX3G: —

## Examples (ST, from the manual)
```iecst
TZCP(X000,D20,D30,D0,M3);
```

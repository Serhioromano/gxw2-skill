# TCM — TCMP / RTC Data Compare

Manual section: **21.1**, page **541**. Index names: TCMP.

## Purpose
(External Device) Applied Instructions The comparison time and the time data are compared, and the bit device is turned ON or OFF depending on the magnitude of difference.

## ST Syntax (GX Works 2)
- `TCMP(EN,s1,s2,s,d);`
- `TCMPP(EN,s1,s2,s,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s1**: Comparison time "hour" (Setting range: 0 to 23) Control) (Character Applied Instructions [String/ANY16]
- **s2**: Comparison time "minute" (Setting range: 0 to 59) [ANY16]
- **s**: Comparison time "second" (Setting range: 0 to 59) [ANY16]
- **d**: data (hour, minute, second) "hour" (3 points occupied) [Time]
- **ENO**: Execution state [Bit]

## Support
- FX3U: —
- FX3G: —

## Examples (ST, from the manual)
```iecst
TCMP(X000,K10,K30,K50,D0,M0);
```

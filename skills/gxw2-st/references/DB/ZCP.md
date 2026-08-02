# ZCP — ZCP / Zone Compare

Manual section: **8.2**, page **136**. Index names: ZCP.

## Purpose
This instruction compares two values (zone) with the comparison source, and outputs the result (upper, equal or lower) to bit devices (3 points).

## ST Syntax (GX Works 2)
- `ZCP(EN,s1,s2,s3,d);`
- `ZCPP(EN,s1,s2,s3,d);`
- `DZCP(EN,s1,s2,s3,d);`
- `DZCPP(EN,s1,s2,s3,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s1**: Data or device handled as lower comparison value [ANY16/ANY32]
- **s2**: Data or device handled as upper comparison value [ANY16/ANY32]
- **s3**: Data or device number handled as comparison source [ANY16/ANY32]
- **ENO**: Execution state [Bit]
- **d**: Head bit device to which comparison result is output (3 consecutive bits)

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
```iecst
ZCP(TRUE, K0, K100, wTemp, M10);
// M10: wTemp < 0
// M11: 0 ≤ wTemp ≤ 100
// M12: wTemp > 100
```

## Key Rules
- Zone compare S vs [Lower, Upper], results in 3 consecutive bits: D+0 = S < Lower, D+1 = Lower ≤ S ≤ Upper, D+2 = S > Upper
- Variants: `DZCP` (32-bit), `DZCPP` (32-bit pulse), `EZCP` (floating point)
- No CSV declaration needed

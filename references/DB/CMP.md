# CMP — CMP / Compare

Manual section: **8.1**, page **133**. Index names: CMP.

## Purpose
This instruction compares two values, and outputs the result (smaller, equal or larger) to bit devices (3 points).

## ST Syntax (GX Works 2)
- `CMP(EN,s1,s2,d);`
- `CMPP(EN,s1,s2,d);`
- `DCMP(EN,s1,s2,d);`
- `DCMPP(EN,s1,s2,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s1**: Data or device number handled as comparison value [ANY16/ANY32]
- **s2**: Data or device number handled as comparison source [ANY16/ANY32]
- **ENO**: Execution state [Bit]
- **d**: Head bit device to which comparison result is output (3 consecutive bits)

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
```iecst
CMP(X000, K100, CN20, M0);
CMP(TRUE, wValue, K100, M0);
// M0: wValue > 100
// M1: wValue = 100
// M2: wValue < 100
```

## Key Rules
- Results written to 3 consecutive bit devices: D+0 = S1 > S2, D+1 = S1 = S2, D+2 = S1 < S2
- Variants: `DCMP` (32-bit), `DCMPP` (32-bit pulse), `ECMP` (floating point)
- In ST, native `IF` with `=`, `<`, `>`, `<=`, `>=`, `<>` is usually cleaner. Use CMP/ZCP when all three comparison results are needed simultaneously
- No CSV declaration needed

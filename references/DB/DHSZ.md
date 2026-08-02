# DHSZ — DHSZ / High Speed Counter Zone Compare

Manual section: **12.6**, page **279**. Index names: DHSZ.

## Purpose
Processing) (High Speed  Applied Instructions This instruction compares the current value of a high speed counter with two values (one zone), and outputs the comparison result to three bit devices (refresh).

## ST Syntax (GX Works 2)
- `DHSZ(EN,s1,s2,s,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s1**: Data to be compared with the current value of a high-speed counter or word [ANY32]
- **s2**: Device of a high speed counter [ANY32]
- **ENO**: Execution state [Bit]
- **s**: ARRAY [0..2] OF [Bit]

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
```iecst
DHSZ(X010,K1000,K1200,CN235,Y010);
```

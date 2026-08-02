# DSW — DSW / Digital Switch (Thumbwheel Input)

Manual section: **14.3**, page **361**. Index names: DSW.

## Purpose
Processing) (High Speed  Applied Instructions This is a command for reading in the set value of digital switch. You can read in the data of 4 digits and 1 set (n=K1), or 4 digits and 2 sets (n=K2).

## ST Syntax (GX Works 2)
- `DSW(EN,s,n,d1,d2);`

## Operands
- **EN**: Execution condition [Bit]
- **s**: Beginning device for connecting digital switch (X) (4 points occupied) [Bit]
- **n**: Number of sets of digital switch (4 digits/1 set) [n=1 or 2] [ANY16]
- **ENO**: Execution state [Bit]
- **d1**: Beginning device of output of strobe signal (Y) (4 points occupied) ARRAY [0..3] OF [Bit]
- **d2**: Device for storing numerical value of digital switch (n points occupied) [ANY16]

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
```iecst
DSW(X000, X10, K1, Y10, D0);
DSW(M0, X010, K1, Y010, D0);
```

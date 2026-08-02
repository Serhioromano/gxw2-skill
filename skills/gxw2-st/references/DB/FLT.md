# FLT — FLT / Conversion to Floating Point

Manual section: **11.10**, page **250**. Index names: FLT.

## Purpose
This instruction converts a binary integer into a binary floating point (real number).

## ST Syntax (GX Works 2)
- `FLT(EN,s,d);`
- `FLTP(EN,s,d);`
- `DFLT(EN,s,d);`
- `DFLTP(EN,s,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s**: Data register storing binary integer [ANY_SIMPLE]
- **ENO**: Execution state [Bit]
- **d**: Data register storing binary floating point (real number) [ANY_SIMPLE]

## Support
- FX3U: ✓
- FX3G: —

## Examples (ST, from the manual)
```iecst
FLT(M8000, D0, D20);
FLT(M8000, D22, D24);
FLT(M8000, D50, D51);
FLT(M8000, D53, D54);
```

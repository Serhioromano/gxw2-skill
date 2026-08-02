# SFR — SFR / Bit Shift Right with Carry

Manual section: **27.4**, page **664**. Index names: SFR.

## Purpose
This instruction shifts 16 bits stored in a word device rightward by "n" bits.

## ST Syntax (GX Works 2)
- `SFR(EN,n,d);`
- `SFRP(EN,n,d);`

## Operands
- **EN**: Execution condition [Bit]
- **n**: Number of times of shift (0 ≤ n ≤ 15) [ANY16]
- **ENO**: Execution state [Bit]
- **d**: Device storing data to be shifted. [ANY16]

## Support
- FX3U: ✓
- FX3G: —

## Examples (ST, from the manual)
_not extracted_

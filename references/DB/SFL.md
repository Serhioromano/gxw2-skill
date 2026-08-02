# SFL — SFL / Bit Shift Left with Carry

Manual section: **27.5**, page **666**. Index names: SFL.

## Purpose
This instruction shifts 16 bits stored in a word device leftward by "n" bits.

## ST Syntax (GX Works 2)
- `SFL(EN,n,d);`
- `SFLP(EN,n,d);`

## Operands
- **EN**: Execution condition [Bit]
- **n**: Number of times of shift [ANY16]
- **d**: Device storing data to be shifted. [ANY16]

## Support
- FX3U: ✓
- FX3G: —

## Examples (ST, from the manual)
_not extracted_

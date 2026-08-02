# RCL — RCL / Rotation Left with Carry

Manual section: **10.4**, page **205**. Index names: RCL.

## Purpose
This instruction shifts and rotates the bit information leftward by the specified number of bits together with the carry flag.

## ST Syntax (GX Works 2)
- `RCL(EN,n,d);`
- `RCLP(EN,n,d);`
- `DRCL(EN,n,d);`
- `DRCLP(EN,n,d);`

## Operands
- **EN**: Execution condition [Bit]
- **ENO**: Execution state [Bit]
- **n**: Word device storing data to be rotated leftward [ANY16/ANY32]

## Support
- FX3U: ✓
- FX3G: —

## Examples (ST, from the manual)
_not extracted_

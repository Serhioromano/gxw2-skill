# RCR — RCR / Rotation Right with Carry

Manual section: **10.3**, page **202**. Index names: RCR.

## Purpose
This instruction shifts and rotates the bit information rightward by the specified number of bits together with the carry flag.

## ST Syntax (GX Works 2)
- `RCR(EN,n,d);`
- `RCRP(EN,n,d);`
- `DRCR(EN,n,d);`
- `DRCRP(EN,n,d);`

## Operands
- **EN**: Execution condition [Bit]
- **ENO**: Execution state [Bit]
- **n**: variable device storing data to be rotated rightward [Word/ANY16/ANY32]

## Support
- FX3U: ✓
- FX3G: —

## Examples (ST, from the manual)
_not extracted_

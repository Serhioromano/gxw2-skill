# DSZR — DSZR / Dog Search Zero Return

Manual section: **20.1**, page **518**. Index names: DSZR.

## Purpose
This instruction matches the mechanical position and the current value register in the PLC by zero return. This instruction can perform following operation which is not supported by ZRN. • Corresponding action of DOG search function • Zero return is possible by using near-point DOG and zero-point signal.

## ST Syntax (GX Works 2)
- `DSZR(EN,s1,s2,d1,d2);`

## Operands
- **EN**: Execution condition [Bit]
- **s1**: Device for entering the near-point signal (DOG) [Bit]
- **s2**: Device for entering zero-point signal [Bit]
- **ENO**: Execution state [Bit]
- **d1**: Device for issuing pulse (Y) [Bit]
- **d2**: Device of rotating direction signal [Bit]

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
_not extracted_

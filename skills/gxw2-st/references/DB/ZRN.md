# ZRN — ZRN / Zero Return

Manual section: **20.5**, page **527**. Index names: ZRN.

## Purpose
Processing) (High Speed  Applied Instructions This instruction matches the mechanical position and the current value register in the PLC by zero return. Please use DSZR when DOG search function is necessary. → As for explanation of the instruction, see the positioning control manual.

## ST Syntax (GX Works 2)
- `ZRN(EN,s1,s2,d);`
- `DZRN(EN,s1,s2,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s1**: Speed when starting to zero return [ANY16/ANY32]
- **s2**: Creep speed [ANY16/ANY32]
- **d**: Device for entering the near-point signal (DOG) [Bit]
- **ENO**: Execution state [Bit]
- **?**: variable Device for issuing pulse (Data Transfer 2) Applied Instructions [Bit]

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
_not extracted_

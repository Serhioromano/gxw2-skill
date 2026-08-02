# DRVI — DRVI / Drive to Increment

Manual section: **20.7**, page **534**. Index names: DRVI.

## Purpose
This instruction performs one-speed positioning by relative drive. The moving distance from the present position is specified together with plus or minus sign, and this is also called increment (relative) driving method. → As for explanation of the instruction, see the positioning control manual.

## ST Syntax (GX Works 2)
- `DRVI(EN,s1,s2,d1,d2);`
- `DDRVI(EN,s1,s2,d1,d2);`

## Operands
- **EN**: Execution condition [Bit]
- **s1**: Number of output pulses (relative address) [ANY16/ANY32]
- **s2**: Output pulse frequency [ANY16/ANY32]
- **ENO**: Execution state [Bit]
- **d1**: Device for issuing pulse (Y) [Bit]
- **d2**: Device of rotating direction signal [Bit]

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
_not extracted_

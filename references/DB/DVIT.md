# DVIT — DVIT / Interrupt Positioning

Manual section: **20.2**, page **520**. Index names: DVIT.

## Purpose
This instruction executes one-speed interrupt inching. → As for explanation of the instruction, see the positioning control manual. → As for cautions of use of high speed output special adapter, see the positioning control manual.

## ST Syntax (GX Works 2)
- `DVIT(EN,s1,s2,d1,d2);`
- `DDVIT(EN,s1,s2,d1,d2);`

## Operands
- **EN**: Execution condition [Bit]
- **s1**: Number of output pulses after interrupt (relative address) [ANY16/ANY32]
- **s2**: Output pulse frequency [ANY16/ANY32]
- **ENO**: Execution state [Bit]
- **d1**: Device for issuing pulse (Y) [Bit]
- **d2**: Device of rotating direction signal [Bit]

## Support
- FX3U: ✓
- FX3G: —

## Examples (ST, from the manual)
_not extracted_

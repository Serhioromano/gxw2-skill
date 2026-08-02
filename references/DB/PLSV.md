# PLSV — PLSV / Variable Speed Pulse Output

Manual section: **20.6**, page **531**. Index names: PLSV.

## Purpose
Processing) (High Speed  Applied Instructions This instruction issues a variable speed pulse with the rotating direction. → As for explanation of the instruction, see the positioning control manual. → As for cautions of use of high speed output special adapter, see the positioning control manual.

## ST Syntax (GX Works 2)
- `PLSV(EN,s,d1,d2);`
- `DPLSV(EN,s,d1,d2);`

## Operands
- **EN**: Execution condition [Bit]
- **s**: Output pulse frequency [ANY16/ANY32]
- **d1**: ENO Execution state (External Device) Applied Instructions [Bit]
- **d2**: Device for issuing pulse (Y) [Bit]
- **?**: Device of rotating direction signal [Bit]

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
_not extracted_

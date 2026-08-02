# ABSD — ABSD / Absolute Drum Sequencer

Manual section: **13.3**, page **327**. Index names: ABSD.

## Purpose
Processing High Speed Applied Instructions This is a command for creating multiple output patterns corresponding to the present value of the counter.

## ST Syntax (GX Works 2)
- `ABSD(EN,s1,s2,n,d);`
- `DABSD(EN,s1,s2,n,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s1**: Beginning device for storing table data (rise point, fall point) [ANY16/ANY16]
- **s2**: variable Counter for present value monitor to compare with table data (External Device) Applied Instructions [ANY16]
- **ENO**: Execution state [Bit]
- **n**: Beginning bit device to be output [Bit]

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
_not extracted_

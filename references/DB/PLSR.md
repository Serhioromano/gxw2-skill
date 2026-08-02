# PLSR — PLSR / Acceleration/Deceleration Setup

Manual section: **12.10**, page **306**. Index names: PLSR.

## Purpose
This pulse output instruction has the acceleration/deceleration function.

## ST Syntax (GX Works 2)
- `PLSR(EN,s1,s2,d);`
- `DPLSR(EN,s1,s2,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s1**: Maximum frequency data (Hz) or the word device storing the data [ANY16/ANY32]
- **s2**: Acceleration/deceleration time (ms) data or word device storing the [ANY16/ANY32]
- **ENO**: Execution state [Bit]
- **d**: Device (Y) from which pulses are to be output [Bit]

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
_not extracted_

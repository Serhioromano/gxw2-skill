# PLSY — PLSY / Pulse Y Output

Manual section: **12.8**, page **296**. Index names: PLSY.

## Purpose
This instruction generates a pulse signal.

## ST Syntax (GX Works 2)
- `PLSY(EN,s1,s2,d);`
- `DPLSY(EN,s1,s2,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s1**: Frequency data (Hz) or the word device storing the data [ANY16/ANY32]
- **s2**: Pulse quantity data or the word device storing the data [ANY16/ANY32]
- **EN0**: Execution state [Bit]
- **d**: Bit device (Y) from which pulses are output [Bit]

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
_not extracted_

# DABS — DABS / Absolute Current Value Read

Manual section: **20.4**, page **525**. Index names: DABS.

## Purpose
Processing) (High Speed  Applied Instructions This instruction connects with our company's MR-J4(cid:133)A, MR-J3(cid:133)A, MR-J2(S)(cid:133)A, or MR-H(cid:133)A type servo amplifier (with absolute position detecting function), and reads out the absolute position (ABS) data. The data is read out in pulse converted value.

## ST Syntax (GX Works 2)
- `DABS(EN,s,d1,d2);`

## Operands
- **EN**: Execution condition [Bit]
- **ENO**: Execution state [Bit]
- **s**: Head device for issuing the control signal for absolute value (ABS) data to [Bit]
- **d1**: Storing destination device of absolute value (ABS) data (32-bit value) [ANY32]

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
_not extracted_

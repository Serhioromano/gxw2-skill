# MCDE — MCDE / F2-30GM code

Manual section: **16.9**, page **432**. Index names: MCDE.

## Purpose
This instruction sends the M code numbers M0 to M77 to the PLC from the F2-30GM type pulse output unit.

## ST Syntax (GX Works 2)
- `MCDE(EN,s,d1,d2);`
- `MCDEP(EN,s,d1,d2);`

## Operands
- **EN**: Execution condition [Bit]
- **s**: variable Head input number of FX2-24EI connected to F2-30GM [Bit]
- **ENO**: Execution state [Bit]
- **d1**: Head output number of FX2-24EI connected to F2-30GM [Bit]
- **d2**: Bit device for issuing M code number (78 points occupied) [Bit]

## Support
- FX3U: —
- FX3G: —

## Examples (ST, from the manual)
_not extracted_

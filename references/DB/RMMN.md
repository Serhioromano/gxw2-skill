# RMMN — RMMN / F2-32RM monitor

Manual section: **16.7**, page **429**. Index names: RMMN.

## Purpose
Processing) (High Speed  Applied Instructions This instruction reads out the rotating speed (rpm) or present angle of the resolver connected to the F2-32RM type programmable cam switch to the PLC.

## ST Syntax (GX Works 2)
- `RMMN(EN,s,d1,d2);`
- `RMMNP(EN,s,d1,d2);`

## Operands
- **EN**: Execution condition [Bit]
- **s**: Head input number of FX2-24EI connected to F2-32RM. [Bit]
- **ENO**: Execution state [Bit]
- **d1**: Head output number of FX2-24EI connected to F2-32RM. 16 [Bit]
- **d2**: (External Device) Applied Instructions [ANY16]

## Support
- FX3U: —
- FX3G: —

## Examples (ST, from the manual)
_not extracted_

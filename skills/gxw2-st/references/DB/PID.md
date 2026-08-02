# PID — PID / PID Control Loop

Manual section: **15.9**, page **414**. Index names: PID.

## Purpose
This instruction executes PID control for changing the output values depending on the change value of the input. → As for the detail, refer to the analog control manual.

## ST Syntax (GX Works 2)
- `PID(EN,s1,s2,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s1**: Data register for storing the target value (SV) [ANY16]
- **s2**: Data register for storing the measured value (PV). [ANY16]
- **d**: Data register for storing the parameter [29 points occupied]*1 [ANY16]
- **ENO**: Execution state [Bit]
- **?**: variable Data register for storing the output value (MV) [ANY16]

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
_not extracted_

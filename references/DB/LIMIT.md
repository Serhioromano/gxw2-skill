# LIMIT — LIMIT / Limit Control

Manual section: **29.1**, page **679**. Index names: LIMIT.

## Purpose
(External Device) Applied Instructions This instruction provides the upper limit value and lower limit value for an input numeric value, and control the output value using these limit values.

## ST Syntax (GX Works 2)
- `LIMIT(EN,s1,s2,d);`
- `LIMITP(EN,s1,s2,d);`
- `DLIMIT(EN,s1,s2,d);`
- `DLIMITP(EN,s1,s2,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s1**: Lower limit value (minimum output value) [ANY16/ANY32]
- **s2**: variable Upper limit value (maximum output value) (Data Comparison) Applied Instructions [ANY16/ANY32]
- **d**: Input value controlled by the upper and lower limit values [ANY16/ANY32]
- **ENO**: Execution state [Bit]

## Support
- FX3U: ✓
- FX3G: —

## Examples (ST, from the manual)
_not extracted_

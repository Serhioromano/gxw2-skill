# ZONE — ZONE / Zone Control

Manual section: **29.3**, page **687**. Index names: ZONE.

## Purpose
(External Device) Applied Instructions Depending on whether the input value is positive or negative, the output value is controlled by the bias value specified.

## ST Syntax (GX Works 2)
- `ZONE(EN,s1,s2,d);`
- `ZONEP(EN,s1,s2,d);`
- `DZONE(EN,s1,s2,d);`
- `DZONEP(EN,s1,s2,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s1**: Negative bias value to be added to the input value 28 [ANY16/ANY32]
- **s2**: variable Positive bias value to be added to the input value [ANY16/ANY32]
- **d**: Input value controlled by the zone [ANY16/ANY32]
- **ENO**: Execution state [Bit]
- **?**: Head device storing the output value controlled by the zone [ANY16/ANY32]

## Support
- FX3U: ✓
- FX3G: —

## Examples (ST, from the manual)
_not extracted_

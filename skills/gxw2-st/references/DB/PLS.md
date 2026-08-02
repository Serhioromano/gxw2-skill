# PLS — PLS, PLF

Manual section: **5.11**, page **85**. Index names: PLS, PLF.

## Purpose
PLS sets a destination bit device TRUE for one scan on the rising edge of EN. PLF sets a destination bit device TRUE for one scan on the falling edge of EN.

## ST Syntax (GX Works 2)
- `PLS(EN,d);`
- `PLF(EN,d);`

## Operands
- **EN**: Execution condition [Bit]
- **ENO**: Execution state [Bit]
- **d**: Applicable device or variable [Bit]

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
```iecst
PLS(xStartButton, M50);          (* M50 pulses ON for 1 scan when button pressed *)
PLF(xStopButton, M51);           (* M51 pulses ON for 1 scan when button released *)
```

## Key Rules
- `PLS`/`PLF` write a one-scan pulse to a destination variable
- Unlike `MEP`/`MEF` (which return a BOOL for inline use), PLS/PLF set a specified bit device — useful when the pulse must be referenced in multiple places or across POU boundaries
- No CSV declaration needed

# PWM — PWM / Pulse Width Modulation

Manual section: **12.9**, page **303**. Index names: PWM.

## Purpose
This instruction outputs pulses with a specified period and ON duration.

## ST Syntax (GX Works 2)
- `PWM(EN,s1,s2,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s1**: Pulse width (ms) data or word device storing the data [ANY16]
- **s2**: Period data (ms) or word device storing the data [ANY16]
- **ENO**: Execution state [Bit]
- **d**: Device (Y) from which pulses are to be output [Bit]

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
```iecst
PWM(X0, D10, K50, Y000);
PWM(TRUE, K500, K1000, Y0);
// Y0 outputs PWM: 500ms ON, 500ms OFF (50% duty, 1s period)
```

## Key Rules
- D must be a transistor output (Y0–Y4 for FX3U)
- Period and pulse width units depend on PLC model
- PWM runs continuously once started — use `RST` to stop the output
- No `_E`, `P`, or `D` variants
- PWM parameters (S1, S2) and output availability vary by FX model — consult the FX3U Hardware Manual
- No CSV declaration needed

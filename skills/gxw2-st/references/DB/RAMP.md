# RAM — RAMP / Ramp Variable Value

Manual section: **13.8**, page **343**. Index names: RAMP.

## Purpose
This instruction gradually changes a value from current to target with configurable step size and interval. Useful for soft-start, setpoint ramping.

## ST Syntax (GX Works 2)
- `RAMP(EN,s1,s2,n,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s1**: Target value (final desired value) [ANY16]
- **s2**: Step size (amount to change per interval) [ANY16]
- **n**: Number of transfer scan times of ramp [ANY16]
- **ENO**: Execution state [Bit]
- **d**: Current value + flags (2 consecutive word devices): D[0] = current ramp value, D[1] = status flags (b0 = ramp complete)

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
```iecst
RAMP(TRUE, K1000, K10, K5, D200);
(* Ramps D200 from current value toward 1000, *)
(* changing by ±10 every 5 scans *)

(* Check if ramp complete *)
IF (D201 AND H0001) <> WORD#0 THEN
    xRampDone := TRUE;
END_IF;
```

## Key Rules
- D occupies 2 consecutive word devices: D[0] = current value, D[1] = flags (b0 = ramp complete)
- No `_E`, `P`, or `D` variants
- Ramp stops when current value reaches target
- Works with signed values (positive and negative steps)
- No CSV declaration needed

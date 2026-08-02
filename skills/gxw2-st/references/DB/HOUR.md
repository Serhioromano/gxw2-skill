# HOUR — HOUR / Hour Meter

Manual section: **21.9**, page **563**. Index names: HOUR.

## Purpose
This instruction adds and measures the ON time duration of an input contact in one-hour units. Useful for run-time tracking, maintenance scheduling.

## ST Syntax (GX Works 2)
- `HOUR(EN,s,d1,d2);`
- `HOURP(EN,s,d1,d2);`
- `DHOUR(EN,s,d1,d2);`
- `DHOURP(EN,s,d1,d2);`

## Operands
- **EN**: Execution condition [Bit]
- **s**: Input signal (BOOL, monitored for ON time)
- **ENO**: Execution state [Bit]
- **d1**: Accumulated hours (2 consecutive word devices, 32-bit value in hours)
- **d2**: Overflow flag (BOOL, TRUE when D1 exceeds 32-bit range)

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
```iecst
HOUR(TRUE, xMotorRun, D100, M50);      (* Track motor run hours → D100–D101, overflow → M50 *)
HOURP(xTrig, xMotorRun, D100, M50);    (* Pulse *)
DHOUR(TRUE, xMotorRun, D200, M51);     (* 32-bit (DINT accumulator) *)
DHOURP(xTrig, xMotorRun, D200, M51);   (* 32-bit pulse *)
```

## Key Rules
- D1 occupies 2 consecutive word devices (e.g., D100–D101)
- Accumulated value is in **hours**
- Overflow flag D2 stays ON once set — use `RST` to clear
- No CSV declaration needed

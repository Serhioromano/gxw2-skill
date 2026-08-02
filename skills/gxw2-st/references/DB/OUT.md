# OUT — OUT (Excluding timers and counters)

Manual section: **5.3**, page **62**. Index names: OUT.

## Purpose
This instruction outputs the operation result up to the execution of the OUT instruction to the specified device.

## ST Syntax (GX Works 2)
- `OUT(EN,d);`

## Operands
- **EN**: Execution condition [Bit]
- **ENO**: Execution state [Bit]
- **d**: Target variable [ANY_SIMPLE]

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
```iecst
OUT(X006,Y034);
OUT(X006,Y035);
OUT(X005,D0.5);
OUT(X006,D0.6);
OUT(X006,D0.7);
```

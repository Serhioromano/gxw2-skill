# REFF — REFF / Refresh and Filter Adjust

Manual section: **12.2**, page **259**. Index names: REFF.

## Purpose
Processing) (High Speed  Applied Instructions The digital input filter time of the inputs can be changed using this instruction or D8020. Using this instruction, the status of inputs can be refreshed at an arbitrary step in the program for the specified input filter time, and then transferred to the image memory.

## ST Syntax (GX Works 2)
- `REF(EN,n);`
- `REFP(EN,n);`

## Operands
- **EN**: Execution condition [Bit]
- **n**: Digital input filter time (1 ms increment) [ANY16]
- **ENO**: Output variable [Bit]

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
```iecst
REFF(X010,K1);
REFF(M8000,K20);
```

# ZPUSH — ZPUSH / Batch Store of Index Register

Manual section: **17.1**, page **434**. Index names: ZPUSH.

## Purpose
This instruction temporarily retracts the present values of index registers V0 to V7, Z0 to Z7. To return the retracted present values to the original values, use the ZPOP instruction. → As for ZPOP instruction, refer to section 17.2.

## ST Syntax (GX Works 2)
- `ZPUSH(EN,d);`
- `ZPUSHP(EN,d);`

## Operands
- **EN**: Execution condition [Bit]
- **ENO**: Execution state [Bit]

## Support
- FX3U: ✓
- FX3G: —

## Examples (ST, from the manual)
```iecst
ZPUSH(M8000, D0);
```

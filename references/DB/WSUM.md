# WSUM — WSUM / Sum of Word Data

Manual section: **19.1**, page **497**. Index names: WSUM.

## Purpose
Processing) (High Speed  Applied Instructions This instruction calculates the total value of continuous 16-bit data or 32-bit data. Please use the CCD when calculating the sum data (total value) in byte (8-bit) unit. → As for the CCD, refer to section 15.5.

## ST Syntax (GX Works 2)
- `WSUM(EN,s,n,d);`
- `WSUMP(EN,s,n,d);`
- `DWSUM(EN,s,n,d);`
- `DWSUMP(EN,s,n,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s**: Number of data (0<n) [ANY16]
- **ENO**: Execution state [Bit]
- **n**: variable Head device for storing the total value. ARRAY [1..4] 18 [ANY32]

## Support
- FX3U: —
- FX3G: —

## Examples (ST, from the manual)
_not extracted_

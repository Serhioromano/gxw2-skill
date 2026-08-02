# DHSCR — DHSCR / High Speed Counter Reset

Manual section: **12.5**, page **275**. Index names: DHSCR.

## Purpose
Processing) (High Speed  Applied Instructions This instruction compares the value counted by a high speed counter with a specified value at each count, and immediately resets an external output (Y) when both values become equivalent to each other.

## ST Syntax (GX Works 2)
- `DHSCR(EN,s1,s2,d);`

## Operands
_not extracted_

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
```iecst
DHSCR(M8000,K400,CN255,CC255);
```

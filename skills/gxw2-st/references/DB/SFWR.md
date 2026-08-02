# SFWR — SFWR / Shift Write [FIFO/FILO Control]

Manual section: **10.9**, page **219**. Index names: SFWR.

## Purpose
This instruction writes data for first-in first-out (FIFO) and first-in last-out (FILO) control.

## ST Syntax (GX Works 2)
- `SFWR(EN,s,n,d);`
- `SFWRP(EN,s,n,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s**: Word device storing data to be put in first [ANY16]
- **ENO**: Execution state [Bit]
- **n**: Head word device storing and shifting data. [ANY16]

## Support
- FX3U: —
- FX3G: —

## Examples (ST, from the manual)
_not extracted_

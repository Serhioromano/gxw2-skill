# COMRD — COMRD / Read Device Comment Data

Manual section: **24.1**, page **584**. Index names: COMRD.

## Purpose
This instruction reads the comment data for registered devices written to the PLC by programming software such as GX Works2.

## ST Syntax (GX Works 2)
- `COMRD(EN,s,d);`
- `COMRDP(EN,s,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s**: Device for which comment to be read is registered [ANY_SIMPLE]
- **ENO**: Execution state [Bit]
- **d**: Head device storing read comment [String]

## Support
- FX3U: —
- FX3G: —

## Examples (ST, from the manual)
_not extracted_

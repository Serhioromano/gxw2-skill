# CCD — CCD / Check Code

Manual section: **15.5**, page **403**. Index names: CCD.

## Purpose
Processing) (High Speed  Applied Instructions This instruction calculates the horizontal parity value or check sum value of error check method used in communication or the like. The error check method also includes cyclic redundancy check (CRC). Use the CRC instruction when determining the CRC value.

## ST Syntax (GX Works 2)
- `CCD(EN,s,n,d);`
- `CCDP(EN,s,n,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s**: Head object device [ANY16]
- **n**: Number of data (n=1 to 256) [ANY16]
- **ENO**: Execution state [Bit]

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
_not extracted_

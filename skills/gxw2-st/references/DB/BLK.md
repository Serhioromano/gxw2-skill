# BLK — BLK / Specify F2-30GM

Manual section: **16.8**, page **430**. Index names: BLK.

## Purpose
This instruction specifies the block number for the F2-30GM type pulse output unit from the PLC.

## ST Syntax (GX Works 2)
- `BLK(EN,s1,s2,d);`
- `BLKP(EN,s1,s2,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s1**: Block number (K0 to K31) [ANY16]
- **s2**: Head input number of FX2-24EI connected to F2-30GM [Bit]
- **ENO**: Execution state [Bit]
- **d**: variable Head output number of FX2-24EI connected to F2-30GM [Bit]

## Support
- FX3U: —
- FX3G: —

## Examples (ST, from the manual)
_not extracted_

# FROM — FROM / Read From A Special Function Block

Manual section: **14.9**, page **381**. Index names: FROM.

## Purpose
Processing) (High Speed  Applied Instructions This instruction reads out the content of buffer memory (BFM) of special extension unit/block to the PLC. If a large quantity of buffer memory (BFM) data is read out in batch by using this instruction, a watchdog timer error may occur. When there is no bad influence for the control if the data is divided and read out, you can use

## ST Syntax (GX Works 2)
- `FROM(EN,d);`
- `FROMP(EN,d);`
- `DFROM(EN,d);`
- `DFROMP(EN,d);`

## Operands
- **EN**: Execution condition [Bit]
- **d**: Unit No. of special extension unit/block [ANY16]
- **?**: variable Transfer origin buffer memory (BFM) number *1 [ANY16/ANY32]
- **?**: Number of transfer points [ANY16]
- **ENO**: Execution state [Bit]
- **?**: 32-bit operation is . [ANY16]

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
```iecst
FROM(X001, K0, K4, K1, D0);
```

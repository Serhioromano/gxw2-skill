# MC — MC, MCR

Manual section: **5.12**, page **87**. Index names: MC, MCR.

## Purpose
When MC instruction is executed, instructions from MC to MCR are executed. Thereby, efficient ladder switching sequence programs can be created.

## ST Syntax (GX Works 2)
- `MC(EN,n,d);`
- `MCR(EN,n);`

## Operands
- **EN**: Execution condition
- **ENO**: Execution state [Bit]
- **n**: variable Device number to be turned ON when executing the MC [Bit]

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
```iecst
MC(X000,0,M100);
MCR(TRUE,0);
MC(X003,0,M150);
MC(X002,1,M101);
MC(X004,2,M102);
MCR(TRUE,2);
```

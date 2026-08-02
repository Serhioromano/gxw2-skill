# SAVER — SAVER / Save to ER

Manual section: **33.2**, page **748**. Index names: SAVER.

## Purpose
This instruction writes the current values of extension registers (R) stored in the PLC's built-in RAM to extension file registers (ER) stored in a memory cassette (flash memory) in units of sector (2048 points). RWER instruction provided in FX3UC PLCs Ver. 1.30 or later and FX3U PLCs writes (transfers) only arbitrary number of points. It is not necessary to execute INITR or INITER instruction every time when RWER

## ST Syntax (GX Works 2)
- `SAVER(EN,s,n,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s**: Number of points written (transferred) in one operation cycle. [ANY16]
- **ENO**: Execution state [Bit]
- **n**: Device storing the number of already written points [ANY16]

## Support
- FX3U: ✓
- FX3G: —

## Examples (ST, from the manual)
```iecst
SAVER(M0,R0,K128,D0);
```

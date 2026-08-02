# LOADR — LOADR / Load From ER

Manual section: **33.1**, page **744**. Index names: LOADR.

## Purpose
This instruction reads the current values of extension file registers (ER) stored in a memory cassette (flash memory and EEPROM) or the file registers (ER) in the PLC's built-in EEPROM, and transfers them to extension registers (R) stored in the PLC's built-in RAM.

## ST Syntax (GX Works 2)
- `LOADR(EN,s,n);`
- `LOADRP(EN,s,n);`

## Operands
- **EN**: Execution condition [Bit]
- **ENO**: Execution state [Bit]

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
```iecst
LOADR(LDP(TRUE,M0),R1,K4000);
```

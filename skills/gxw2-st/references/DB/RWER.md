# RWER — RWER / Rewrite to ER

Manual section: **33.5**, page **765**. Index names: RWER.

## Purpose
Processing 2) (High Speed  Applied Instructions This instruction writes the current values of an arbitrary number of extension registers (R) in the PLC's built-in RAM to extension file registers (ER) in a memory cassette (flash memory or EEPROM) or to the extension file registers (ER) in the PLC's built-in EEPROM.

## ST Syntax (GX Works 2)
- `RWER(EN,s,n);`
- `RWERP(EN,s,n);`

## Operands
- **EN**: Execution condition [Bit]
- **s**: Device of extension register storing data [ANY16]
- **ENO**: Execution state [Bit]

## Support
- FX3U: —
- FX3G: ✓

## Examples (ST, from the manual)
```iecst
RWER(M0,R10,K10);
```

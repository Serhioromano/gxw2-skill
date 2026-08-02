# INITER — INITER / Initialize ER

Manual section: **33.6**, page **770**. Index names: INITER.

## Purpose
This instruction initializes extension file registers (ER) to "HFFFF" (<K-1>) in a memory cassette (flash memory) before executing the SAVER instruction. Because INITER instruction is not provided in the FX3UC PLC earlier than Ver. 1.30, use INITR instruction instead.

## ST Syntax (GX Works 2)
- `INITER(EN,s,n);`
- `INITERP(EN,s,n);`

## Operands
- **EN**: Execution condition [Bit]
- **ENO**: Execution state [Bit]

## Support
- FX3U: —
- FX3G: —

## Examples (ST, from the manual)
```iecst
INITER(LDP(TRUE,X000),R0,K1);
```

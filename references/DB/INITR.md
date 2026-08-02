# INITR — INITR / Initialize R and ER

Manual section: **33.3**, page **757**. Index names: INITR.

## Purpose
Processing 2) (High Speed  Applied Instructions This instruction initializes (to "HFFFF <K-1>") extension registers (R) in the RAM built in a PLC and extension file registers in a memory cassette (flash memory) before data logging by LOGR instruction. In FX3UC PLCs former than Ver. 1.30, use this instruction to initialize extension file registers (ER) before

## ST Syntax (GX Works 2)
- `INITR(EN,s,n);`
- `INITRP(EN,s,n);`

## Operands
- **EN**: Execution condition [Bit]
- **s**: It is possible to specify only the head device in a sector of extension [ANY16]
- **ENO**: Execution state [Bit]

## Support
- FX3U: ✓
- FX3G: —

## Examples (ST, from the manual)
```iecst
INITR(LDP(TRUE,X000),R0,K1);
```

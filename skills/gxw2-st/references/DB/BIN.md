# BIN — BIN / Conversion to Binary

Manual section: **8.10**, page **163**. Index names: BIN.

## Purpose
This instruction converts binary-coded decimal (BCD) data into binary (BIN) data. Use it to convert a BCD value (such as a value set by a digital switch) into binary data so that the data can be handled in operations in PLCs.

## ST Syntax (GX Works 2)
- `BIN(EN,s,d);`
- `BINP(EN,s,d);`
- `DBIN(EN,s,d);`
- `DBINP(EN,s,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s**: Device storing the conversion source [Word]
- **ENO**: Execution state [Bit]
- **d**: Device of the conversion destination (binary) [Word/ANY16/ANY32]

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
```iecst
BIN(X000, K1X000, D0);
BIN(X000, K2X000, D0);
BIN(TRUE, wBcdIn, iResult);     (* iResult := decimal value of BCD *)
BINP(xTrig, wBcdIn, iResult);   (* Pulse *)
DBIN(TRUE, dwBcdIn, diResult);  (* 32-bit BIN *)
```

## Key Rules
- BCD → Binary (e.g., H0123 → 123)
- For ST with no BCD peripherals, prefer `INT_TO_BCD`/`BCD_TO_INT` function blocks or keep values in native binary
- No CSV declaration needed

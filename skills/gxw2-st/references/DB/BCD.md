# BCD — BCD / Conversion to Binary Coded Decimal

Manual section: **8.9**, page **159**. Index names: BCD.

## Purpose
This instruction converts binary (BIN) data into binary-coded decimal (BCD) data. Use it to display numeric values on seven-segment displays equipped with BCD decoder.

## ST Syntax (GX Works 2)
- `BCD(EN,s,d);`
- `BCDP(EN,s,d);`
- `DBCD(EN,s,d);`
- `DBCDP(EN,s,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s**: Device storing the conversion source (binary) data [Word/ANY16/ANY32]
- **ENO**: Execution state [Bit]
- **d**: Device of the conversion destination [Word]

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
```iecst
BCD(X000, D0, K1Y000);
BCD(X000, D0, K2Y000);
BCD(TRUE, iCount, wBcdOut);     (* wBcdOut := BCD of iCount *)
BCDP(xTrig, iCount, wBcdOut);   (* Pulse *)
DBCD(TRUE, diCount, dwBcdOut);  (* 32-bit BCD *)
```

## Key Rules
- Binary → BCD (e.g., 123 → H0123)
- BCD is used for thumbwheel switches, 7-segment displays, and legacy devices
- For ST with no BCD peripherals, prefer `INT_TO_BCD`/`BCD_TO_INT` function blocks or keep values in native binary
- No CSV declaration needed

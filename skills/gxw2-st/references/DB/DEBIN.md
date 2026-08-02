# DEBIN — DEBIN / Scientific Notation to Floating Point Conversion

Manual section: **18.7**, page **461**. Index names: DEBIN.

## Purpose
Processing) (High Speed  Applied Instructions This instruction converts the decimal floating decimal point in the device into binary floating decimal point. → As for handling of floating decimal point, refer to FX Structured Programming Manual [Device & Common].

## ST Syntax (GX Works 2)
- `DEBIN(EN,s,d);`
- `DEBINP(EN,s,d);`

## Operands
- **ENO**: Execution condition [Bit]
- **EN**: Device for storing decimal floating decimal point data. [ANY32]

## Support
- FX3U: —
- FX3G: —

## Examples (ST, from the manual)
```iecst
DEBIN(Y002,D0,D10);
```

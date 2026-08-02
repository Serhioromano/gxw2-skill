# BINDA — BINDA / BIN to Decimal ASCII Conversion

Manual section: **29.6**, page **698**. Index names: BINDA.

## Purpose
This instruction converts binary data into decimal ASCII codes (30H to 39H).

## ST Syntax (GX Works 2)
- `BINDA(EN,s,d);`
- `BINDAP(EN,s,d);`
- `DBINDA(EN,s,d);`
- `DBINDAP(EN,s,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s**: variable Device storing binary data to be converted into ASCII codes [ANY16/ANY32]
- **ENO**: Execution state [Bit]
- **d**: Head device storing conversion result [String/String]

## Support
- FX3U: —
- FX3G: —

## Examples (ST, from the manual)
```iecst
BINDA(X000,D1000,D0);
```

# CML — CML / Complement

Manual section: **8.5**, page **146**. Index names: CML.

## Purpose
This instruction inverts data in units of bit, and then transfers (copies) the inverted data.

## ST Syntax (GX Works 2)
- `CML(EN,s,d);`
- `CMLP(EN,s,d);`
- `DCML(EN,s,d);`
- `DCMLP(EN,s,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s**: variable Data to be inverted or word device storing the data [ANY16/ANY32]
- **ENO**: Execution state [Bit]
- **d**: Destination word device storing inverted data [ANY16/ANY32]

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
```iecst
CML(M8000, K1X000, K1M0);
CML(X000, D0, K1Y000);
```

# RBFM — RBFM / Divided BFM Read

Manual section: **31.1**, page **729**. Index names: RBFM.

## Purpose
Processing 2) (High Speed  Applied Instructions This instruction reads data from continuous buffer memories (BFM) in a special function block and unit over several operation cycles by the time division method. This instruction is convenient for reading received data, etc. stored in buffer memories in a special function block and unit for communication by the time division

## ST Syntax (GX Works 2)
- `BFM(EN,d);`

## Operands
_not extracted_

## Support
- FX3U: —
- FX3G: —

## Examples (ST, from the manual)
```iecst
RBFM(M5,K2,K2001,K80,K16,D200);
```

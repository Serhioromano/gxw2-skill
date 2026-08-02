# ZRST — ZRST / Zone Reset

Manual section: **11.1**, page **225**. Index names: ZRST.

## Purpose
Processing) (High Speed  Applied Instructions This instruction resets devices located in a zone between two specified devices at one time. Use this instruction for restarting operation from the beginning after pause or after resetting control data.

## ST Syntax (GX Works 2)
- `ZRST(EN,d1,d2);`
- `ZRSTP(EN,d1,d2);`

## Operands
_not extracted_

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
```iecst
ZRST(M8002, M500, M599);
ZRST(M8002, CN235, CN255);
ZRST(M8002, S500, S599);
```

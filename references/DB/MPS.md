# MPS — MPS, MRD, MPP

Manual section: **5.7**, page **73**. Index names: MPS, MRD, MPP.

## Purpose
These PLCs have 11 memories called "Stack" which store the intermediate result (ON or OFF) of operations.

## ST Syntax (GX Works 2)
- `MPS(EN);`
- `MRD(EN);`
- `MPP(EN);`

## Operands
- **EN**: Execution condition
- **ENO**: Execution state [Bit]

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
```iecst
Y001:= MPP(TRUE);
MPS(X000) AND (X001 OR X002);
Y002:= MPP(TRUE);
Y003:= MPP(TRUE);
Y004:= MPP(TRUE);
```

# MUL — MUL / Multiplication

Manual section: **9.3**, page **174**. Index names: MUL.

## Purpose
This instruction executes multiplication by two values to obtain the result (A × B = C). For floating point multiplication, see `DEMUL`.

## ST Syntax (GX Works 2)
- `MUL(EN,s1,s2,d);`
- `MULP(EN,s1,s2,d);`
- `DMUL(EN,s1,s2,d);`
- `DMULP(EN,s1,s2,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s1**: Data for multiplication or word device storing data [ANY16/ANY32]
- **s2**: Data for multiplication or word device storing data [ANY16/ANY32]
- **ENO**: Execution state [Bit]
- **d**: Word device storing the multiplication result [ANY16/ANY32]

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
```iecst
MUL(TRUE, wVal1, wVal2, wResult);      (* unconditional *)
MUL_E(xTrig, wVal1, wVal2, wResult);   (* triggered (returns only ENO flag) *)
MULP(xTrig, wVal1, wVal2, wResult);    (* pulse *)
DMUL(TRUE, dwVal1, dwVal2, dwResult);  (* 32-bit *)
DMULP(xTrig, dwVal1, dwVal2, dwResult);(* 32-bit pulse *)
```

## Key Rules
- Four variants: base, `_E` (triggered), `P` (pulse), `D` (32-bit), `DP` (32-bit pulse)
- Used for WORD/DWORD arithmetic. For INT/DINT prefer native ST operators: `iProd := iA * iB;`
- With `_E` the function returns only the ENO flag; result goes to the last parameter `d`
- No CSV declaration needed

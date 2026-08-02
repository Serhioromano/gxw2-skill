# SUB — SUB / Subtraction

Manual section: **9.2**, page **171**. Index names: SUB.

## Purpose
This instruction executes subtraction using two values to obtain the result (A − B = C). For floating point subtraction, see `DESUB`.

## ST Syntax (GX Works 2)
- `SUB(EN,s1,s2,d);`
- `SUBP(EN,s1,s2,d);`
- `DSUB(EN,s1,s2,d);`
- `DSUBP(EN,s1,s2,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s1**: Data for subtraction or word device storing data [ANY16/ANY32]
- **s2**: Data for subtraction or word device storing data [ANY16/ANY32]
- **ENO**: Execution state [Bit]
- **d**: Word device storing the subtraction result [ANY16/ANY32]

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
```iecst
SUB(TRUE, wVal1, wVal2, wResult);      (* unconditional *)
SUB_E(xTrig, wVal1, wVal2, wResult);   (* triggered (returns only ENO flag) *)
SUBP(xTrig, wVal1, wVal2, wResult);    (* pulse *)
DSUB(TRUE, dwVal1, dwVal2, dwResult);  (* 32-bit *)
DSUBP(xTrig, dwVal1, dwVal2, dwResult);(* 32-bit pulse *)
```

## Key Rules
- Four variants: base, `_E` (triggered), `P` (pulse), `D` (32-bit), `DP` (32-bit pulse)
- Used for WORD/DWORD arithmetic. For INT/DINT prefer native ST operators: `iDiff := iA - iB;`
- With `_E` the function returns only the ENO flag; result goes to the last parameter `d`
- No CSV declaration needed

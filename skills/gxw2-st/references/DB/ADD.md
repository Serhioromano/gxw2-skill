# ADD — ADD / Addition

Manual section: **9.1**, page **168**. Index names: ADD.

## Purpose
This instruction executes addition by two values to obtain the result (A + B = C). For floating point addition, see `DEADD`.

## ST Syntax (GX Works 2)
- `ADD(EN,s1,s2,d);`
- `ADDP(EN,s1,s2,d);`
- `DADD(EN,s1,s2,d);`
- `DADDP(EN,s1,s2,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s1**: Data for addition or word device storing data [ANY16/ANY32]
- **s2**: Data for addition or word device storing data [ANY16/ANY32]
- **ENO**: Execution state [Bit]
- **d**: Word device storing the addition result [ANY16/ANY32]

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
```iecst
ADD(TRUE, wVal1, wVal2, wResult);      (* unconditional *)
ADD_E(xTrig, wVal1, wVal2, wResult);   (* triggered (returns only ENO flag) *)
ADDP(xTrig, wVal1, wVal2, wResult);    (* pulse *)
DADD(TRUE, dwVal1, dwVal2, dwResult);  (* 32-bit *)
DADDP(xTrig, dwVal1, dwVal2, dwResult);(* 32-bit pulse *)
```

## Key Rules
- Four variants: base, `_E` (triggered), `P` (pulse), `D` (32-bit), `DP` (32-bit pulse)
- Used for WORD/DWORD arithmetic. For INT/DINT prefer native ST operators: `iSum := iA + iB;`
- With `_E` the function returns only the ENO flag; result goes to the last parameter `d`
- No CSV declaration needed

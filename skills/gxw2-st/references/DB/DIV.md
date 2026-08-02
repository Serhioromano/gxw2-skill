# DIV — DIV / Division

Manual section: **9.4**, page **178**. Index names: DIV.

## Purpose
This instruction executes division by two values to obtain the result [A ÷ B = C ...(remainder)]. For floating point division, see `DEDIV`.

## ST Syntax (GX Works 2)
- `DIV(EN,s1,s2,d);`
- `DIVP(EN,s1,s2,d);`
- `DDIV(EN,s1,s2,d);`
- `DDIVP(EN,s1,s2,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s1**: Data for division or word device storing the data (dividend) [ANY16/ANY32]
- **s2**: Data for division or word device storing the data (divisor) [ANY16/ANY32]
- **ENO**: Execution state [Bit]
- **d**: Word device storing the division result [ANY16/ANY32]

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
```iecst
DIV(TRUE, wVal1, wVal2, wResult);      (* unconditional *)
DIV_E(xTrig, wVal1, wVal2, wResult);   (* triggered (returns only ENO flag) *)
DIVP(xTrig, wVal1, wVal2, wResult);    (* pulse *)
DDIV(TRUE, dwVal1, dwVal2, dwResult);  (* 32-bit *)
DDIVP(xTrig, dwVal1, dwVal2, dwResult);(* 32-bit pulse *)
```

## Key Rules
- Outputs the quotient (remainder is discarded; use `MOD` for remainder)
- Four variants: base, `_E` (triggered), `P` (pulse), `D` (32-bit), `DP` (32-bit pulse)
- Used for WORD/DWORD arithmetic. For INT/DINT prefer native ST operators: `iQuot := iA / iB;`
- With `_E` the function returns only the ENO flag; result goes to the last parameter `d`
- No CSV declaration needed

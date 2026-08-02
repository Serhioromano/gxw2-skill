# Arithmetic Functions (Numeric + Arithmetic)

Functions from the [Application Functions] manual (doc2), sections **6–7**. Index names: `ABS(_E)`, `ADD(_E)`, `SUB(_E)`, `MUL(_E)`, `DIV(_E)`, `MOD(_E)`, `EXPT(_E)`.

## The idea

| Function | Operation |
|----------|-----------|
| `ABS` | Absolute value |
| `ADD` | Addition (A + B = C) |
| `SUB` | Subtraction (A − B = C) |
| `MUL` | Multiplication (A × B = C) |
| `DIV` | Division, outputs quotient (A ÷ B = C … remainder) |
| `MOD` | Division, outputs remainder |
| `EXPT` | Exponentiation |

These functions exist for arithmetic on **WORD / DWORD** (unsigned) operands. For **INT / DINT** variables use native ST operators instead — `+`, `-`, `*`, `/`, `MOD` — no function call needed.

## Variants

Every function has the full set of variants. Example for `DIV`:

| Variant | Meaning |
|---------|---------|
| `DIV`   | Base form |
| `DIVP`  | Pulse execution (one scan) |
| `DIV_E` | Function with `_E` trigger |
| `DDIV`  | 32-bit (DINT/DWORD/REAL) |
| `DDIVP` | 32-bit + pulse |

Same pattern for `ADD`/`ADDP`/`ADD_E`/`DADD`/`DADDP`, `SUB`/`SUBP`/`SUB_E`/`DSUB`/`DSUBP`, `MUL`/`MULP`/`MUL_E`/`DMUL`/`DMULP`. `ABS`, `MOD`, `EXPT` are documented as `_E` functions.

## Syntax (GX Works 2)

All functions share the same signature:

```iecst
ADD_E(EN, s1, s2, d);
```

- `EN`: Execution condition [Bit]
- `s1`, `s2`: Operands [ANY_NUM / ANY_INT]
- `ENO`: Execution status [Bit]
- `d`: Result [ANY_NUM]

> With the `_E` form the function returns **only the ENO flag** (executed or not); the result is written to the last parameter `d`. `D` prefix = 32-bit, `P` suffix = pulse.

## Support

- FX3U: ✓ (all)
- FX3G: ✓ (except `EXPT`: —)

## Examples (ST, from the manual)

```iecst
g_int2  := ABS(g_int1);
g_bool3 := ABS_E(g_bool1, g_int1, g_int2);
g_bool3 := ADD_E(g_bool1, g_dint1, g_dint2, g_dint3);
g_bool3 := DIV_E(g_bool1, g_dint1, g_dint2, g_dint3);
g_real2 := EXPT(g_real1, g_int1);               (* no _E, returns directly *)
```

> For INT/DINT prefer native operators: `iSum := iA + iB;`. Use `ADD_E`/`DADD` etc. for WORD/DWORD arithmetic.

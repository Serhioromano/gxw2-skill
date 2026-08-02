# Selection Functions (Selection)

Functions from the [Application Functions] manual (doc2), section **10**. Index names: `SEL(_E)`, `MAXIMUM(_E)`, `MINIMUM(_E)`, `LIMITATION(_E)`, `MUX(_E)`.

## The idea

| Function | Operation |
|----------|-----------|
| `SEL`       | Selects one of two data by a BOOL condition |
| `MAXIMUM`   | Outputs the maximum value among data |
| `MINIMUM`   | Outputs the minimum value among data |
| `LIMITATION`| Clamps data to [lower, upper] range |
| `MUX`       | Selects one of N data by an index |

> Mitsubishi names: `MAXIMUM` (not `MAX`), `MINIMUM` (not `MIN`), `LIMITATION` (not `LIMIT`).

## Syntax (GX Works 2)

All functions share the same `_E` pattern — first parameter is the condition (`EN`), result goes to the last parameter:

```iecst
SEL_E(EN, G, IN0, IN1, d);          (* G = FALSE → IN0, G = TRUE → IN1 *)
MAXIMUM_E(EN, IN1, IN2, d);         (* max *)
MINIMUM_E(EN, IN1, IN2, d);         (* min *)
LIMITATION_E(EN, MN, IN, MX, d);    (* clamp IN to [MN, MX] *)
MUX_E(EN, K, IN1, IN2, ..., d);     (* K = index, selects INk *)
```

- `EN`: Execution condition [Bit]
- Operands: data or word devices [ANY_SIMPLE]
- `ENO`: Execution status [Bit]
- `d`: Selection/operation result [ANY_SIMPLE]

> With the `_E` form the function returns **only the ENO flag** (executed or not); the result is written to the last parameter `d`. Without `_E` — returns the result directly: `g := SEL(G, IN0, IN1);`

## Support

- FX3U: ✓ (all)
- FX3G: ✓ (all)

## Examples (ST, from the manual)

```iecst
g_word3 := SEL(g_bool1, g_word1, g_word2);
g_bool3 := SEL_E(g_bool1, g_bool2, g_word1, g_word2, g_word3);
g_int3 := MAXIMUM(g_int1, g_int2);
g_bool3 := MAXIMUM_E(g_bool1, g_int1, g_int2, g_int3);
g_int4 := LIMITATION(g_int1, g_int2, g_int3);
g_int4 := MUX(g_int1, g_int2, g_int3);
```

> For `LIMITATION`/`MUX`, the non-`_E` form returns the result directly; the `_E` form writes to the last parameter and returns only ENO.

# Comparison Functions

Functions from the [Application Functions] manual (doc2), section **11**. Index names: `GT(_E)`, `GE(_E)`, `EQ(_E)`, `LE(_E)`, `LT(_E)`, `NE(_E)`.

## The idea

All 6 comparison functions share the same signature — only the name (and operator) differs:

| Function | Operator | Function | Operator |
|----------|----------|----------|----------|
| `GT` | `>` | `LE` | `<=` |
| `GE` | `>=` | `LT` | `<` |
| `EQ` | `=` | `NE` | `<>` |

## Syntax (GX Works 2)

All functions compare two values and output a bit result:

```iecst
GT_E(EN, s1, s2, d);
```

- `EN`: Execution condition [Bit]
- `s1`, `s2`: Compared data [ANY_SIMPLE]
- `ENO`: Execution status [Bit]
- `d`: Comparison result [Bit]

## Common rules

- `_E` variant = triggered execution: first parameter is the condition (`EN`), result goes to the last parameter (`d`); the return value is **only the ENO flag**, not the result.
- Without `_E` — returns the result directly: `b := GT(s1, s2);`
- Support: FX3U ✓, FX3G ✓ (all 6 functions).

## Examples (ST, from the manual)

`g_bool3` holds the ENO flag; the comparison result goes to `d` (`g_bool2`):

```iecst
g_bool3 := GT_E(g_bool1, g_int1, g_int2, g_bool2);
g_bool3 := NE_E(g_bool1, g_int1, g_int2, g_bool2);
```

> In ST, native `IF` with `=`, `<>`, `<`, `>`, `<=`, `>=` is usually cleaner. Use `CMP`/`ZCP` when all three comparison results are needed at once (see [00_Instruction_List.md](00_Instruction_List.md)).

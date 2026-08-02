# Type Conversion Functions

Functions from the [Application Functions] manual (doc2), section **5**. Index names: `<SRC>_TO_<DST>(_E)`.

## The idea

GX Works 2 (FX) supports **8 data types**: BOOL, INT, DINT, WORD, DWORD, REAL, STRING, TIME.
Full type reference, literals, and conversion tables — see [data-types.md](../data-types.md).

Conversion is simply a combination of "any type → any other type" via `_TO_`: `<SOURCE>_TO_<TARGET>`.
Examples: `INT_TO_REAL`, `DINT_TO_STR`, `WORD_TO_BOOL`, `TIME_TO_DINT`, `BCD_TO_INT`.

Not every combination is supported: the actual function set is listed in
[data-types.md](../data-types.md) (section "Type Casting Functions").

## Common rule for `_E` (triggered execution)

Every conversion function has a `_E` postfix variant — execution on condition:

- Without `_E` — returns the result directly: `r := INT_TO_REAL(i);`
- With `_E` — first parameter is the condition (EN), result goes to the last parameter; the return value is **only the ENO flag** (executed or not), not the result:

```iecst
bFlag := INT_TO_REAL_E(EN, i, r);   (* r = result, bFlag = ENO *)
```

Examples and nuances — see [data-types.md](../data-types.md).

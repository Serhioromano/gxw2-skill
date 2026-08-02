# Bit Operations (Bitwise Boolean + Shift/Rotate)

Functions/instructions from the [Application Functions] manual (doc2). Two groups: bitwise operators and shift/rotate.

## Group 1 — Bitwise operators: AND, OR, XOR

| Function | Operation |
|----------|-----------|
| `AND`    | Logical product (AND)   |
| `OR`     | Logical sum (OR)        |
| `XOR`    | Exclusive logical sum (XOR) |

Syntax (all share the same signature, `_E` = triggered):

```iecst
AND_E(EN, s1, s2, ..., d);
```

- `EN`: Execution condition [Bit]
- `s1`, `s2`, ...: Operands [ANY_BIT]
- `ENO`: Execution status [Bit]
- `d`: Result [ANY_BIT]

> With the `_E` form the function returns **only the ENO flag** (executed or not); the result is written to the last parameter `d`.

Support: FX3U ✓, FX3G ✓.

Example (ST, from the manual) — `g_bool3` holds the ENO flag, result goes to `g_word3`:

```iecst
g_bool3 := AND_E(g_bool1, g_word1, g_word2, g_word3);
g_bool3 := OR_E(g_bool1, g_word1, g_word2, g_word3);
g_bool3 := XOR_E(g_bool1, g_word1, g_word2, g_word3);
```

> In ST these are also native infix operators — no function call needed. They work on BOOL, WORD, and DWORD operands and return the value directly:

```iecst
bResult := bA AND bB;        (* BOOL *)
wResult := wA OR wB;         (* WORD: bitwise *)
dwResult := dwA XOR dwB;     (* DWORD: bitwise *)
```

> `NOT` is listed in the manual but not supported on FX series (FX3U: —, FX3G: —). Invert a word via `XOR` with `HFFFF`. For word-level AND/OR/XOR use the basic instructions `WAND`/`WOR`/`WXOR` (with `P` pulse and `D` 32-bit variants, see [00_Instruction_List.md](00_Instruction_List.md)).

## Group 2 — Shift and Rotate: SHL, SHR, ROL, ROR

| Function | Operation |
|----------|-----------|
| `SHL`    | Shift left  |
| `SHR`    | Shift right |
| `ROL`    | Rotate left (without carry)  |
| `ROR`    | Rotate right (without carry) |

Syntax (shift functions have `_E`; rotate instructions use `P`/`D` variants):

```iecst
SHL_E(EN, s, n, d);        (* shift: use the _E form with output label *) 
ROL(EN, s, n, d);          (* rotate: instruction, no _E; ROLP/ DROL / DROLP for pulse/32-bit *)
```

- `EN`: Execution condition [Bit]
- `s`: Data to be shifted/rotated [ANY_BIT / ANY16 / ANY32]
- `n`: Number of bits [ANY_BIT]
- `ENO`: Execution status [Bit]
- `d`: Result [ANY_BIT]

> SHL/SHR in the manual are shown as `SHL(s, n)` without an output, so the non-`_E` form does **not** return the result. Use the `_E` form with an output label: `SHL_E(EN, s, n, d)` — the return value is the ENO flag, the result goes to `d`.

Support: FX3U ✓, FX3G ✓.

Examples (ST, from the manual) — `g_bool3` holds the ENO flag, result goes to `g_word2`:

```iecst
g_bool3 := SHL_E(g_bool1, g_word1, g_const_word1, g_word2);
g_bool3 := SHR_E(g_bool1, g_word1, g_const_word1, g_word2);
ROL(TRUE, D0, K4, D0);              (* rotate 16-bit D0 left by 4 bits *)
DROL(TRUE, g_dword1, K8, g_dword1); (* 32-bit rotate left: pass a 32-bit variable *)
```

> 32-bit rotate instructions (`DROL`, `DROR`) require a 32-bit variable (DINT/DWORD/REAL) — passing a raw 16-bit device like `D10` gives "invalid data format". Declare the variable in the label editor and use it as both source and destination.

> Difference: SHIFT discards bits pushed out; ROTATE wraps them to the other end. Use `D` prefix for 32-bit data (`DROL`, `DROR`), `P` suffix for pulse execution (`ROLP`, `RORP`).

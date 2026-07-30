# Data Types — GX Works 2 ST (FX Series)

Load when declaring variables, choosing types, or casting between types.

---

## Elementary Types

| Type     | Size    | Range                          | Literal Examples              |
|----------|---------|--------------------------------|-------------------------------|
| `BOOL`   | 1 bit   | `FALSE`, `TRUE`                | `TRUE`, `FALSE`, `0`, `1`     |
| `INT`    | 16-bit  | -32,768 to 32,767              | `K100`, `K-456`, `123`        |
| `DINT`   | 32-bit  | ±2.14×10⁹                      | `K123456789`                  |
| `WORD`   | 16-bit  | 0 to 65,535                    | `HFF`, `HABCD`, `16#FF`       |
| `DWORD`  | 32-bit  | 0 to 4.29×10⁹                  | `HDEADBEEF`, `16#DEADBEEF`    |
| `REAL`   | 32-bit  | ±1.175e-38 to ±3.402e+38       | `E3.14`, `1.5e2`, `REAL#1.5` |
| `STRING` | N+1 bytes | Max 255 chars               | `'Hello'` (escape `''` for single quote) |
| `TIME`   | 32-bit  | T#0ms to ~T#24d               | `T#10s`, `T#1h30m500ms`       |

---

## Mitsubishi Literal Notation

| Prefix/Notation | Type              | Example            |
|-----------------|-------------------|--------------------|
| `K`             | Decimal (INT/DINT)| `K100`, `K-456`    |
| `H`             | Hexadecimal (WORD/DWORD) | `HFF`, `HABCD` |
| `16#`           | Hexadecimal (alt) | `16#FF`, `16#DEADBEEF` |
| `E`             | REAL (scientific) | `E3.14`, `E1.5e2`  |
| `REAL#`         | REAL (decimal)    | `REAL#1.5`          |
| `T#`            | TIME              | `T#10s`, `T#1h30m`  |

> **FX note:** `K` prefix = decimal integer. `H` prefix = hexadecimal. `E` prefix = REAL (scientific notation). These are Mitsubishi-specific literal notations that must be used where applicable.

---

## Unsupported Types (FX Series)

| Type     | Status | Notes                                    |
|----------|--------|------------------------------------------|
| `LREAL`  | ❌     | 64-bit float not available               |
| `WSTRING`| ❌     | Wide string not available                |
| `LDATE`  | ❌     | Date type not available                  |
| `LTIME`  | ❌     | 64-bit time not available                |
| `REF_TO` | ❌     | Pointers not available                   |
| `ARRAY[*]` | ❌   | Variable-length arrays not supported     |

---

## WORD and DWORD Arithmetic Considerations

WORD and DWORD are unsigned. When arithmetic is needed, cast to INT/DINT first, or use the dedicated `ADD_E`/`DADD` etc. instructions (see `instructions.md`).

---

## Memory Consumption

| Type     | D Registers Consumed | Notes                    |
|----------|----------------------|--------------------------|
| BOOL     | 0 (use bit device)   | Cannot store in D directly |
| INT      | 1                    |                          |
| WORD     | 1                    |                          |
| DINT     | 2                    | Uses Dn and Dn+1         |
| DWORD    | 2                    | Uses Dn and Dn+1         |
| REAL     | 2                    | Uses Dn and Dn+1 (IEEE 754) |
| STRING   | N/2+1 (rounded up)   | 1 byte per char + null   |
| TIME     | 2                    | Milliseconds as DINT     |

> **Critical for GVL.csv address planning:** `REAL`, `DINT`, and `DWORD` each consume 2 consecutive D registers. Ensure no overlap when assigning sequential addresses.

---

## Type Casting Functions

All casting functions support the `_E` postfix for triggered execution. Non-`_E` form returns the value directly.

### Integer ↔ Real

| Function        | Description          | `_E` Variant          |
|-----------------|----------------------|------------------------|
| `INT_TO_REAL`   | INT → REAL           | `INT_TO_REAL_E`        |
| `REAL_TO_INT`   | REAL → INT (truncates)| `REAL_TO_INT_E`       |
| `DINT_TO_REAL`  | DINT → REAL          | `DINT_TO_REAL_E`       |
| `REAL_TO_DINT`  | REAL → DINT          | `REAL_TO_DINT_E`       |

### Integer Width Conversions

| Function        | Description  | `_E` Variant      |
|-----------------|--------------|-------------------|
| `INT_TO_DINT`   | INT → DINT   | `INT_TO_DINT_E`   |
| `DINT_TO_INT`   | DINT → INT   | `DINT_TO_INT_E`   |
| `WORD_TO_DWORD` | WORD → DWORD | `WORD_TO_DWORD_E` |
| `DWORD_TO_WORD` | DWORD → WORD | `DWORD_TO_WORD_E` |

### BOOL / WORD ↔ INT

| Function        | Description    | `_E` Variant       |
|-----------------|----------------|--------------------|
| `BOOL_TO_INT`   | BOOL → INT     | `BOOL_TO_INT_E`    |
| `BOOL_TO_WORD`  | BOOL → WORD    | `BOOL_TO_WORD_E`   |
| `WORD_TO_INT`   | WORD → INT     | `WORD_TO_INT_E`    |
| `INT_TO_WORD`   | INT → WORD     | `INT_TO_WORD_E`    |

### String Conversions

| Function          | Description     | `_E` Variant         |
|-------------------|-----------------|----------------------|
| `INT_TO_STRING`   | INT → STRING    | `INT_TO_STRING_E`    |
| `STR_TO_INT`      | STRING → INT    | `STR_TO_INT_E`       |
| `STR_TO_REAL`     | STRING → REAL   | `STR_TO_REAL_E`      |
| `STR_TO_DINT`     | STRING → DINT   | `STR_TO_DINT_E`      |
| `REAL_TO_STRING`  | REAL → STRING   | `REAL_TO_STRING_E`   |
| `DINT_TO_STRING`  | DINT → STRING   | `DINT_TO_STRING_E`   |

### TIME Conversions

| Function        | Description  | `_E` Variant      |
|-----------------|--------------|-------------------|
| `TIME_TO_DINT`  | TIME → DINT  | `TIME_TO_DINT_E`  |
| `DINT_TO_TIME`  | DINT → TIME  | `DINT_TO_TIME_E`  |

---

## `_E` Postfix Pattern

For all casting functions, the `_E` variant adds a trigger as the first parameter and stores the result in the **last** parameter:

```iecst
(* Non-triggered: returns value directly *)
rResult := INT_TO_REAL(iValue);

(* Triggered: only converts when xTrig is TRUE *)
INT_TO_REAL_E(xTrig, iValue, rResult);
```


---
name: gxw2-st
description: >
  Generates Structured Text (ST) code and CSV variable import files for
  Mitsubishi Electric FX series PLCs (FX3U, FX3G, FX3S, FX5U) in GX Works 2.
  Covers ST syntax, built-in FUN/FB, timers, counters, edge detection, type
  casting, and CSV-based label management.
triggers:
  - "GX Works 2"
  - "Mitsubishi FX"
  - "FX3U" / "FX3G" / "FX3S" / "FX5U"
  - ST code for Mitsubishi PLC
  - Device addresses: X, Y, M, D, T, C
  - Mitsubishi ST syntax or built-in functions
  - Factory automation / industrial control ST code
version: 1.0.0
compatibility: GX Works 2, FX series (FX3U, FX3G, FX3S, FX5U)
---

# GX Works 2 Structured Text — FX Series

Generate ST code and CSV variable import files for Mitsubishi FX series PLCs
in GX Works 2. Every code output must include both `.st` code files and `.csv`
variable files for the Label Editor.

## Reference Loading

### Always Load (mandatory for every code generation)

| File | Contents |
|------|----------|
| [references/common-rules.md](references/common-rules.md) | Forbidden constructs, naming conventions, literal prefixes, project structure, state machine pattern, edge detection preference |
| [references/csv-variables.md](references/csv-variables.md) | CSV file formats: IO.csv, GVL.csv, local POU CSV, structure CSV, FB/FUN CSV patterns, instance declaration rules |

Read `common-rules.md` first. Read `csv-variables.md` second. Then proceed to
code generation.

### On-Demand (load when the topic is needed)

| File | Load When |
|------|-----------|
| [references/devices.md](references/devices.md) | Code uses device addresses (X, Y, M, D, T, C, Z, V, R) or digit-specified addressing (`K4X0`) |
| [references/system-devices.md](references/system-devices.md) | Code uses M8000+ special relays or D8000+ special registers |
| [references/instructions.md](references/instructions.md) | Writing control flow (IF, CASE, FOR, WHILE, REPEAT), operators, SET/RST/PLS/PLF, or WORD/DWORD arithmetic variants |
| [references/data-types.md](references/data-types.md) | Declaring variables, choosing types, writing K/H/E literals, or type casting |
| [references/functions.md](references/functions.md) | Using built-in FUN/FB: timers, counters, edge detection, math, strings, selection, type casting, user-defined FB/FUN |
| [references/compatibility.md](references/compatibility.md) | Targeting a specific FX model and verifying feature availability (STRING support, D-register range, index register count) |

## Output Structure

Every code generation produces **two file sets**:

1. **`.st` files** — code body only. No `VAR...END_VAR` blocks, no inline
   variable declarations, no FB instance declarations.
2. **`.csv` files** — all variables for GX Works 2 Label Editor import.
   Exact column formats and rules in
   [references/csv-variables.md](references/csv-variables.md).

### File Map by POU Type

| POU Type | Files Required |
|----------|---------------|
| Program | `{Name}.st` + `{Name}.csv` |
| Function Block | `{Name}.st` + `{Name}.csv` |
| Function | `{Name}.st` + `{Name}.csv` |
| I/O binding (project-wide) | `IO.csv` |
| Global variables (project-wide) | `GVL.csv` |
| Structure definition | `{StructName}.csv` |

### FB Instance Declarations

FB instances (TON, CTU, R_TRIG, user-defined FBs) must be declared as `VAR`
in the CSV of the POU that uses them.

## Critical Constraints

These are the most frequently violated rules. Full details in
`references/common-rules.md`.

### Forbidden Constructs

- `CONTINUE` — restructure with IF/ELSE
- `LREAL`, `WSTRING`, `LDATE`, `LTIME` — not on FX series
- `VAR_IN_OUT` — use separate VAR_INPUT + VAR_OUTPUT
- `SR`, `RS` bistable FBs — use SET/RST instructions
- Named or ranged CASE labels — integer values only
- Function overloading — each FUN/FB name must be unique
- `__NEW`, `__DELETE`, `REF_TO` — no dynamic memory or pointers
- `ARRAY[*]` variable-length — fixed-size only
- `LN`, `LOG`, `EXP`, `SIN`, `COS`, `TAN`, `ASIN`, `ACOS`, `ATAN`, `TRUNC` —
  not available on FX series math

### Naming: Mitsubishi vs IEC

| Correct (GX Works 2) | Wrong (standard IEC) |
|-----------------------|----------------------|
| `RND` | `ROUND` |
| `MAXIMUM` | `MAX` |
| `MINIMUM` | `MIN` |
| `LIMITATION` | `LIMIT` |
| `MEP` / `MEF` | (no IEC equivalent — use these, not R_TRIG for simple edges) |

### Postfix Patterns

| Postfix | Meaning | Example |
|---------|---------|---------|
| `_E` | Triggered execution (with underscore). First param = trigger, last param = result. | `ADD_E(xTrig, wA, wB, wResult)` |
| `P` | Pulse/rising-edge execution (no underscore). First param = trigger. | `ADDP(xTrig, wA, wB, wResult)`, `LEFTP(xTrig, sIn, 5, sOut)` |
| `D` prefix | 32-bit (DINT/DWORD). Combines with `_E` and `P`. | `DADD`, `DADD_E`, `DADDP` |

### FB Parameter Assignment

Use `:=` for **all** FB parameters, including outputs. Never use `=>`.

```iecst
(* Correct *)
tonDelay(IN := xStart, PT := T#5s, Q := xDone, ET := tElapsed);

(* Wrong *)
tonDelay(IN := xStart, PT := T#5s, Q => xDone, ET => tElapsed);
```

### Edge Detection Preference

Use `MEP`/`MEF` instructions over `R_TRIG`/`F_TRIG` FBs. MEP/MEF require no
CSV declaration and work inline in expressions:

```iecst
IF MEP(xStart) THEN
    iCount := iCount + 1;
END_IF;
```

### State Machine Pattern

All state machines use 3 mandatory initial states with integer values:

| State | Value | Purpose |
|-------|-------|---------|
| Init | 0 | Entered on first scan, sets defaults |
| Reset | 10 | Resets all outputs and intermediate values |
| Idle | 20 | Waiting for start condition |

Use integer comments for state names. Do not declare CONSTANT for state labels.

### Literal Prefixes

| Prefix | Type | Example |
|--------|------|---------|
| `K` | Decimal integer (INT/DINT) | `K100`, `K-456` |
| `H` | Hexadecimal (WORD/DWORD) | `HFF`, `HABCD` |
| `E` | REAL (scientific notation) | `E3.14`, `E1.5e2` |
| `T#` | TIME duration | `T#5s`, `T#1h30m`, `T#500ms` |

### Variable Naming Prefixes

| Prefix | Type | Example |
|--------|------|---------|
| `x` | BOOL | `xMotorRunning` |
| `i` | INT | `iCount` |
| `di` | DINT | `diPosition` |
| `w` | WORD | `wStatus` |
| `dw` | DWORD | `dwEncoder` |
| `r` | REAL | `rTemperature` |
| `s` | STRING | `sMessage` |
| `t` | TIME | `tDelay` |
| `g_` | Global scope | `g_xSystemReady` |
| `DI_` | Digital input (IO.csv) | `DI_Start` |
| `DO_` | Digital output (IO.csv) | `DO_Pump` |
| `AI_` | Analog input (IO.csv) | `AI_Pressure` |
| `AO_` | Analog output (IO.csv) | `AO_Valve` |

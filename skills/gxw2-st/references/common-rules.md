# Common Rules — GX Works 2 ST (Mandatory)

Always load this file. These constraints apply to every code generation for GX Works 2 FX series.

---

## Mandatory Constraints

1. **FX series only.** No Q-series, L-series, or iQ-R constructs. Target: FX3U, FX3G, FX3S, FX5U.
2. **No `CONTINUE`** — not supported in GX Works 2. Restructure with IF/ELSE.
3. **No `LREAL`, `WSTRING`, `LDATE`, `LTIME`** — not available on FX series.
4. **No `VAR_IN_OUT`** on FX series. Use separate VAR_INPUT + VAR_OUTPUT.
5. **No `SR`/`RS` bistable FBs.** Use `SET`/`RST` instructions instead.
6. **No named CASE labels** — integer values only. No ranges (`1..5`).
7. **No function overloading** — each FUN/FB must have a unique name.
8. **No dynamic memory** — `__NEW`/`__DELETE` not supported.
9. **No `REF_TO`** — pointers not available.
10. **Always generate CSV variable files** — never use inline `VAR...END_VAR` blocks.
11. **No `ARRAY[*]` variable-length arrays.
12. **Comments: `(* ... *)` only.** GX Works 2 ST does **not** support `//` line comments (nor `{ ... }` comments). Never generate `//` — use `(* ... *)` for inline and standalone comments.**

## Missing IEC Constructs (FX Series)

| Construct              | Status | Alternative                      |
|------------------------|--------|----------------------------------|
| `CONTINUE`             | ❌     | Restructure with IF/ELSE         |
| `JMP`/`LBL` in ST      | ❌     | Use IF or CASE                   |
| Named CASE labels      | ❌     | Integer labels + comments        |
| CASE ranges (`1..5`)   | ❌     | Individual integer labels        |
| `LREAL`                | ❌     | Use REAL                         |
| `WSTRING`              | ❌     | Use STRING                       |
| `SR`, `RS` FBs         | ❌     | Use SET/RST instructions         |
| `VAR_IN_OUT`           | ❌     | Separate VAR_INPUT + VAR_OUTPUT  |
| Function overloading   | ❌     | Unique FUN/FB names              |
| `__NEW`/`__DELETE`     | ❌     | Not applicable (no dynamic mem)  |
| `REF_TO`               | ❌     | Not available                    |
| `ARRAY[*]`             | ❌     | Fixed-size arrays only           |
| Bit-of-word (`D100.0`) | ❌     | Bit masking or M relays          |
| `//` line comments     | ❌     | `(* ... *)` block comments       |

## Always-Generate Rules

- Every code output = ST file(s) + CSV variable file(s).
- Programs, FBs, and FUNs all follow the 2-file rule: `.st` + `.csv` with the same base name.
- Direct device access in ST code is **discouraged** — use label variables from CSV instead.
- Include comment headers with POU purpose and I/O mapping.
- Write code in English. Write comments in English.

## Naming Conventions

| Prefix | Type   | Example            |
|--------|--------|--------------------|
| `x`    | BOOL   | `xMotorRunning`    |
| `i`    | INT    | `iCount`           |
| `di`   | DINT   | `diPosition`       |
| `w`    | WORD   | `wStatus`          |
| `dw`   | DWORD  | `dwEncoder`        |
| `r`    | REAL   | `rTemperature`     |
| `s`    | STRING | `sMessage`         |
| `t`    | TIME   | `tDelay`           |
| `g_`   | Global | `g_xSystemReady`   |
| `ai`   | ARR INT| `aiLookupTable`    |
| `ar`   | ARR REAL|`arCalibration`    |
| `fb`   | FB instance | `fbMotor`     |
| `f`    | FUN call    | `fScaleValue` |
| `c_`   | Constant    | `c_MAX_SPEED`  |

Global variable name prefix: `g_`. I/O variable name prefix: `DI_`, `DO_`, `AI_`, `AO_`.
FB instance names: prefix `fb` (e.g., `fbMotor`, `fbTimer`).
FUN names: prefix `f` (e.g., `fScaleValue`, `fToCelsius`).
Constant names: prefix `c_` with UPPER_SNAKE_CASE body (e.g., `c_MAX_SPEED`, `c_DEFAULT_TIMEOUT`).

## Comment Style

Only `(* ... *)` block comments are supported in GX Works 2 ST. `//` line comments and `{ ... }` comments are **not** supported and must never be generated.

```iecst
(* Motor control state machine *)
iState := 10;  (* Reset *)

(*
  Multi-line comment.
  POU purpose and I/O mapping go here.
*)
```

## Literal Prefixes (Mitsubishi-Specific)

| Prefix | Meaning          | Example           |
|--------|------------------|-------------------|
| `K`    | Decimal integer  | `K100`, `K-456`   |
| `H`    | Hexadecimal      | `HFF`, `HABCD`    |
| `E`    | REAL (scientific)| `E3.14`, `E1.5e2` |

## Postfix Patterns (Mitsubishi-Specific)

Function/instruction names carry optional suffixes that change execution and width.

| Postfix | Meaning | Example |
|---------|---------|---------|
| `_E`    | Triggered execution — first parameter is a BOOL condition (EN); result goes to the **last** parameter; the function returns **only the ENO flag**, not the result | `ADD_E(EN, s1, s2, d)` |
| `P`     | Pulse (rising-edge) execution — attaches directly without underscore | `ADDP(xTrig, s1, s2, d)` |
| `D`     | 32-bit (DWORD/DINT/REAL) — upgrades 16-bit WORD/INT operations | `DADD`, `DABS`, `DMOV` |

- Without `_E`/`P` a function returns the value directly: `rResult := MAXIMUM(rA, rB);`
- `D` combines with `_E`/`P`: `DABS_E` (32-bit + triggered), `DADDP` (32-bit + pulse).
- `_E`/`P` apply to functions/instructions only — **not** to FBs (TON/CTU/R_TRIG are used via an instance declared in CSV, never called directly).
- String functions have limited postfix support: `_E` only on INSERT, DELETE, REPLACE, FIND; `P` on LEN, LEFT, RIGHT, MID, CONCAT.

## Assignment Operator

GX Works 2 uses `:=` for **ALL** parameters, including FB outputs. Never use `=>`.

```iecst
tonDelay(IN := xStart, PT := T#5s, Q := xDone, ET := tElapsed);
```

## Selection

### IF Statement
```iecst
IF condition THEN
    (* statements *)
ELSIF other_condition THEN
    (* statements *)
ELSE
    (* statements *)
END_IF;
```

### CASE Statement
```iecst
CASE IntVar OF
    0: (* Init *)
        (* statements *)
    10: (* Reset *)
        (* statements *)
    20: (* Idle *)
        (* statements *)
ELSE
        (* statements *)
END_CASE;
```

**Restrictions:**
- Integer labels only — no named values, no ranges (`1..5`)
- Use comments to label states

## Iteration

### FOR Loop
```iecst
FOR i := start TO end BY step DO
    (* statements *)
END_FOR;
```
- `BY step` is optional (defaults to 1)
- `FOR` loops in ST have no scan time watchdog. Keep loops short to avoid scan time overrun.

### WHILE Loop
```iecst
WHILE condition DO
    (* statements *)
END_WHILE;
```

### REPEAT Loop
```iecst
REPEAT
    (* statements *)
UNTIL condition;
END_REPEAT;
```

### EXIT
```iecst
EXIT;  (* exits the innermost loop immediately *)
```

## Operators

| Category     | Operators                                |
|-------------|------------------------------------------|
| Arithmetic  | `+`, `-`, `*`, `/`, `MOD`               |
| Comparison  | `=`, `<>`, `<`, `>`, `<=`, `>=`          |
| Logical     | `NOT`, `AND`, `OR`, `XOR`                |

## 3-Program Structure

Every project should use these 3 programs:
1. **INIT** — runs once on first scan (M8002). Initializes variables, sets defaults.
2. **ROUTINE** — runs every 100ms on a timer. Non-critical tasks (HMI refresh, slow monitoring).
3. **MAIN** — runs every scan. All business logic.

## State Machine Pattern

All state machines must start with these 3 mandatory states:
- **Init** (state 0) — entered on first scan, sets defaults
- **Reset** (state 10) — resets all outputs and intermediate values
- **Idle** (state 20) — waiting for start condition

Use integer comments for state names. No `CONSTANT` declarations for state names.

## Edge Detection Preference

Prefer `MEP`/`MEF` instructions over `R_TRIG`/`F_TRIG` FBs — they require no CSV declaration and work inline:

```iecst
IF MEP(xStart) THEN
    iCount := iCount + 1;
END_IF;
```

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
| `F_`   | FUN name/call (ALL CAPS) | `F_SCALE_VALUE` |
| `FB_`  | FB POU/file name (ALL CAPS) | `FB_MOTOR` |
| `PRG_` | Program POU/file name (ALL CAPS) | `PRG_MAIN` |
| `c_`   | Constant    | `c_MAX_SPEED`  |

Global variable name prefix: `g_` and the body is **camelCase** (e.g., `g_xSystemReady`, `g_iCycleCount`, `g_rTemperature`). I/O variable name prefix: `DI_`, `DO_`, `AI_`, `AO_` (fixed uppercase prefix + CamelCase body: `DI_Start`, `AI_Pressure`).
FB instance names: prefix `fb` in CamelCase (e.g., `fbMotor`, `fbTimer`). The ALL-CAPS `FB_`/`F_`/`PRG_` prefixes are for POU **file names** only — never for instance declarations.
FUN names: prefix `F_` in ALL CAPS (e.g., `F_SCALE_VALUE`, `F_TO_CELSIUS`) — the FUN name is used both as the file name and as the call name.
Constant names: prefix `c_` with UPPER_SNAKE_CASE body (e.g., `c_MAX_SPEED`, `c_DEFAULT_TIMEOUT`).

**ALL CAPS is reserved for constructs only.** Variable names — global, local, FB/FUN I/O, and structure members — are **never** written in ALL CAPS:

| Category | Case | Examples |
|----------|------|----------|
| Constructs: POU **file names** (`FB_`, `F_`, `PRG_`), constants (`c_`), instructions | ALL CAPS / UPPER_SNAKE_CASE | `FB_MOTOR`, `F_SCALE_VALUE`, `PRG_MAIN`, `c_MAX_SPEED`, `MOV`, `DABS` |
| Global variables (`g_`) | **camelCase** — never ALL CAPS | `g_xSystemReady`, `g_iCycleCount`, `g_rTemperature`, `g_tCycleTimeout` |
| Local variables, FB/FUN I/O, structure members | camelCase | `xMotorRunning`, `iCount`, `rTemperature`, `iID` |
| I/O bindings | Fixed uppercase prefix + CamelCase body | `DI_Start`, `DO_Pump`, `AI_Pressure`, `AO_Valve` |

> **Global variables must be generated in camelCase — never in ALL CAPS.** `g_xSystemReady` is correct; `G_XSYSTEMREADY`, `G_SYSTEM_READY`, or `G_X_SYSTEM_READY` are **wrong**. ALL-CAPS names are used only for constructs (POU file names, constants, instructions), not for variables.

### FB/FUN/PRG POU and File Naming

POU file names carry an ALL-CAPS prefix so every file immediately reveals what it defines: a function block, a function, or a program.

| POU type | File name pattern | ALL CAPS | File pair | Example |
|----------|-------------------|----------|-----------|---------|
| Function Block | `FB_<NAME>` | yes | `FB_<NAME>.st` + `FB_<NAME>.csv` | `FB_MOTOR.st` / `FB_MOTOR.csv` |
| Function | `F_<NAME>` | yes | `F_<NAME>.st` + `F_<NAME>.csv` | `F_SCALE_VALUE.st` / `F_SCALE_VALUE.csv` |
| Program | `PRG_<NAME>` | yes | `PRG_<NAME>.st` + `PRG_<NAME>.csv` | `PRG_MAIN.st` / `PRG_MAIN.csv` |

Rules:
- `FB_`, `F_`, `PRG_` are **file-name prefixes** — the POU name in the definition area matches the file base name: `FB_MOTOR`, `F_SCALE_VALUE`, `PRG_MAIN` (never `MotorControl` or `ScaleValue` for files).
- FB **instances** are declared in CamelCase with the `fb` prefix: `"VAR" "fbMotor" "FB_MOTOR"` — instance `fbMotor` of type `FB_MOTOR`. Multiple instances of the same FB append a CamelCase suffix: `fbMotor1`, `fbMotor2`.
- FUNs are called by name — no instance declaration — so the caller uses the `F_` name directly: `rResult := F_SCALE_VALUE(...)`.
- Built-in FB instances (TON, TOF, TP, CTU, CTD, CTUD, R_TRIG, F_TRIG) keep lowercase type-prefixed names (`tonStart`, `ctParts`, `rtStart`) — they are standard library blocks with no project files, so the ALL-CAPS prefix is reserved for POU file names.

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

## 3-Program Structure (Default Project Layout)

Every project generates these **3 programs by default** (ALL-CAPS POU names, see Naming Conventions):

1. **`PRG_INIT`** — runs **once** after RUN (initialization). Contains every one-time startup action: default values, initial state, calibration data, retentive restore. **The ST body contains NO M8002 guard.** The "run once" behavior comes from the **program/task registration**: register `PRG_INIT` in the program/task settings (PLC Parameter → PLC System → Program) and set its execution condition to **M8002 (initial pulse)** — or configure the equivalent run-once task in the target setup — so the PLC itself executes the body on the first scan only. The body is just the statements to run once.
2. **`PRG_MAIN`** — runs every scan. All business logic: state machines, sequences, control algorithms, operator commands.
3. **`PRG_PROCESS`** — runs every scan (or on a slower cycle when needed). Actions that are **not** business logic but must be done anyway: error/diagnostic checks, alarm handling, data transfer, HMI/comm refresh, watchdog updates, sensor plausibility checks. It never changes business state directly — it sets flags/error codes and hands data to `PRG_MAIN` via global variables.

Rules:
- Always generate all 3 programs unless the user explicitly asks for fewer or for a different layout.
- **Do not wrap the `PRG_INIT` body in `IF M8002 THEN ... END_IF`.** M8002 is configured as the program's execution condition in the registration settings, not written in the code.
- Keep `PRG_INIT` one-time only — nothing that must run continuously.
- `PRG_MAIN` and `PRG_PROCESS` must not duplicate each other's work: MAIN owns the business flow, PROCESS owns support/housekeeping.
- Programs communicate only through global variables (GVL.csv) — locals of one program are invisible to the others.

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

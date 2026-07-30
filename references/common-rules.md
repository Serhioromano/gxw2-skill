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
11. **No `ARRAY[*]` variable-length arrays.**

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

Global variable name prefix: `g_`. I/O variable name prefix: `DI_`, `DO_`, `AI_`, `AO_`.

## Literal Prefixes (Mitsubishi-Specific)

| Prefix | Meaning          | Example           |
|--------|------------------|-------------------|
| `K`    | Decimal integer  | `K100`, `K-456`   |
| `H`    | Hexadecimal      | `HFF`, `HABCD`    |
| `E`    | REAL (scientific)| `E3.14`, `E1.5e2` |

## Assignment Operator

GX Works 2 uses `:=` for **ALL** parameters, including FB outputs. Never use `=>`.

```iecst
tonDelay(IN := xStart, PT := T#5s, Q := xDone, ET := tElapsed);
```

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

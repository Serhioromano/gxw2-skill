# GXW2-ST Skill — Feature Plan (v3)

## 1. Overview

**Goal:** Make the agent an expert in writing Structured Text (ST) code for Mitsubishi Electric **FX series PLCs** (FX3U, FX3G, FX3S, FX5U) using GX Works 2, accounting for dialect-specific quirks, compiler constraints, device addressing, and **CSV-based variable import for the label editor**.

**Target PLC series:** FX3U, FX3G, FX3S, FX5U only. No Q-series, no L-series.

---

## 2. Critical Concept: CSV-Based Variable Management

GX Works 2 does **not** use inline `VAR ... END_VAR` blocks for production code. Instead, variables are managed via the **Label Editor** and imported/exported as CSV files. The skill must generate these CSV files alongside ST code.

### 2.1 Three Variable List Types

| File Pattern | Class | Purpose |
|-------------|-------|---------|
| `IO.csv` | `VAR_GLOBAL` | Variables bound to physical I/O (X/Y). Prefixes: `DI_`, `DO_`, `AI_`, `AO_` |
| `GVL.csv` | `VAR_GLOBAL` | Global variables needing HMI access or exact addressing. One-per-address, sequential. Prefix: `g_` |
| `{POU_Name}.csv` | `VAR` | Local variables for a **program, function block, or function**. No device assignment. |

### 2.2 CSV Column Formats

First line is always the project name in quotes: `"My Project"`

**IO.csv and GVL.csv columns:**
```
Class, Label Name, Data Type, Constant, Device, Address, Comment, Remark, Relation with System Label, System Label Name, Attribute
```
- `Class`: `VAR_GLOBAL`
- `Device`: Direct device address (e.g., `X0`, `Y0`, `D100`)
- `Address`: IEC address format (e.g., `%IX0.0`, `%QX0.0`, `%MW100`)

**Local POU CSV columns (programs, FBs, FUNs):**
```
Class, Label Name, Data Type, Constant, Device, Address, Comment
```
- `Class`: `VAR`, `VAR_INPUT`, `VAR_OUTPUT`
- `Device` and `Address`: Left empty for local variables

**Structure CSV columns:**
```
Label Name, Data Type, Constant, Comment
```
- No `Class` column
- Each row is a structure member

### 2.3 Variable Generation Rules

1. **I/O variables** → `IO.csv`. Names: `DI_xxx` (X), `DO_xxx` (Y), `AI_xxx` (analog input D), `AO_xxx` (analog output D). Device column is mandatory.

2. **HMI-bound or exact-address variables** → `GVL.csv`. Names: `g_xxx`. Device column is mandatory. Addresses must be sequential (no gaps).

3. **Internal variables** → `{POU_Name}.csv`. No device, no address. Purely label-based.

4. **Direct device access in code is discouraged.** Always generate label variables and use them in code.

5. **Programs follow the same 2-file rule as FB/FUN:** `{ProgramName}.st` + `{ProgramName}.csv`.

### 2.4 Data Types Available in Label Editor

From GX Works 2 label editor (as exported in CSV):

| Type | Description |
|------|-------------|
| `BOOL` | Boolean / bit |
| `INT` | 16-bit signed integer |
| `DINT` | 32-bit signed integer |
| `WORD` | 16-bit unsigned |
| `DWORD` | 32-bit unsigned |
| `REAL` | 32-bit float (IEEE 754) |
| `TIME` | Duration |
| `STRING` | String (max 255 chars). **FX3U only.** Not supported on FX3G/FX3S. |

### 2.5 Structures

Structures are **not defined inline** (`TYPE ... END_TYPE`). Instead, create an importable CSV file (see `STRUCT.csv` example):
- Columns: `Label Name, Data Type, Constant, Comment`
- Members have prefixes: `i` for INT, `x` for BOOL, etc.
- Structure name = CSV filename
- Cannot be nested (FX limitation)

---

## 3. File Map (Simplified)

```
gxw2-skill/
├── README.md
├── SKILL.md                          # Main skill (triggers + lazy-load reference index)
├── plans/
│   └── feature-plan.md               # This file
├── references/
│   ├── common-rules.md               # Mandatory constraints (always loaded)
│   ├── devices.md                    # Device address space (X, Y, M, D, T, C, SM, SD)
│   ├── instructions.md               # Full ST instruction set
│   ├── data-types.md                 # Types, literals (K/H/E notation), casting
│   ├── functions.md                  # Built-in FUN/FB catalog (postfixes: _E, P, D)
│   ├── system-devices.md             # Special relays/registers (M8000+, D8000+)
│   ├── csv-variables.md              # CSV variable list format and generation rules
│   └── compatibility.md              # FX series feature matrix
└── examples/
    ├── io.csv                        # Example IO variable list
    ├── gvl.csv                       # Example global variable list
    ├── pou-local.csv                 # Example local variable list
    ├── structure.csv                 # Example structure definition
    ├── 01-io-assignment.st + .csv
    ├── 02-conditionals.st + .csv
    ├── 03-case-state-machine.st + .csv
    ├── 04-loops.st + .csv
    ├── 05-timers.st + .csv
    ├── 06-counters.st + .csv
    ├── 07-math.st + .csv
    ├── 08-strings.st + .csv
    ├── 09-bit-operations.st + .csv
    ├── 10-type-casting.st + .csv
    ├── 11-edge-detection.st + .csv
    ├── 12-function-block/
    │   ├── MotorControl.st           # FB code (no declaration)
    │   └── MotorControl.csv          # FB local + input/output variables
    └── 13-function/
        ├── ScaleValue.st             # FUN code (no declaration)
        └── ScaleValue.csv            # FUN input variables
```

---

## 4. SKILL.md Structure

### 4.1 Frontmatter
- `name`: `gxw2-st`
- `description`: ST code generation for GX Works 2 (Mitsubishi FX series PLCs)
- `version`: 1.0.0
- `compatibility`: GX Works 2, FX series (FX3U, FX3G, FX3S, FX5U)

### 4.2 Trigger Conditions
- User mentions: "GX Works 2", "Mitsubishi FX", "FX3U", "FX3G", "FX5U", "ST language"
- User asks for Structured Text code for Mitsubishi PLC
- User mentions device addresses: X, Y, M, D, T, C
- User asks about Mitsubishi ST syntax or built-in functions

### 4.3 Lazy-Load Reference System
SKILL.md contains a **reference index** — the agent loads only what is needed:
- `common-rules.md` — always loaded (contains mandatory constraints)
- `csv-variables.md` — always loaded (CSV generation is always required)
- `devices.md` — load when code uses device addresses
- `instructions.md` — load when writing control flow or operators
- `data-types.md` — load when declaring variables or casting types
- `functions.md` — load when using built-in FUN/FB
- `system-devices.md` — load when using special relays/registers
- `compatibility.md` — load when targeting a specific FX model

### 4.4 High-Level Instruction
> "common-rules.md contains mandatory constraints. Read it first. For every code generation, always produce: ST code file + CSV variable file(s). Type CSV exactly as GX Works 2 label editor expects."

---

## 5. Reference Files — Detailed Features

### 5.1 references/common-rules.md (Always Loaded)

#### Mandatory Constraints
1. **FX series only.** No Q-series, L-series, or iQ-R constructs.
2. **No `CONTINUE`** — not supported in GX Works 2. Restructure with IF.
3. **No `LREAL`, `WSTRING`, `LDATE`, `LTIME`** — not available.
4. **No `VAR_IN_OUT`** on FX series. Use separate VAR_INPUT + VAR_OUTPUT.
5. **No `SR`/`RS` bistable FBs.** Use `SET`/`RST` instructions instead.
6. **No named CASE labels** — integer values only. No ranges (`1..5`).
7. **No function overloading** — each FUN/FB has a unique name.
8. **No dynamic memory** — `__NEW`/`__DELETE` not supported.
9. **No `REF_TO`** — pointers not available.
10. **Always generate CSV variable files** — never use inline VAR...END_VAR.

#### Always-Generate Rules
- Every code output = ST file(s) + CSV variable file(s).
- Programs, FBs, and FUNs all follow the 2-file rule (`.st` + `.csv`, same name).
- Direct device access in code is discouraged — use label variables.
- Include comment headers with POU purpose and I/O mapping.
- Code in English. Comments in English.

---

### 5.2 references/csv-variables.md (Always Loaded)

**Purpose:** Rules for generating CSV variable import files for GX Works 2 label editor.

#### 5.2.1 IO.csv Generation
```
"My Project"
Class, Label Name, Data Type, Constant, Device, Address, Comment
VAR_GLOBAL, DI_Start, BOOL,, X0, %IX0.0, "Start pushbutton (NO)"
VAR_GLOBAL, DI_Stop, BOOL,, X1, %IX0.1, "Stop pushbutton (NC)"
VAR_GLOBAL, DO_Pump, BOOL,, Y0, %QX0.0, "Pump contactor output"
VAR_GLOBAL, AI_Pressure, INT,, D10, %MW10, "Pressure sensor (4-20mA scaled)"
VAR_GLOBAL, AO_Valve, INT,, D20, %MW20, "Valve position command (0-1000)"
```
- Prefixes: `DI_` (digital input), `DO_` (digital output), `AI_` (analog input), `AO_` (analog output)
- Device column is **required**
- Address uses IEC format: `%IX0.0` for X0, `%QX0.0` for Y0, `%MW100` for D100

#### 5.2.2 GVL.csv Generation
```
"My Project"
Class, Label Name, Data Type, Constant, Device, Address, Comment
VAR_GLOBAL, g_xPumpStart, BOOL,, X0, %IX0.0, "Pump start command"
VAR_GLOBAL, g_iCycleCount, INT,, D100, %MW100, "Cycle counter"
VAR_GLOBAL, g_rTemperature, REAL,, D102, %MW102, "Current temperature"
VAR_GLOBAL, g_xAlarmActive, BOOL,, M100,, "Alarm active flag"
```
- Prefix: `g_` for all global variables
- Addresses must be **sequential** (no gaps) when using D registers
- `REAL`/`DINT`/`DWORD` consume **2 consecutive D registers** — account for this

#### 5.2.3 Local Variable CSV ({POU_Name}.csv)
```
"My Project"
Class, Label Name, Data Type, Constant, Device, Address, Comment
VAR, iIndex, INT,,,, "Loop index"
VAR, rSetpoint, REAL,,,, "Target setpoint"
VAR, xDone, BOOL,,,, "Operation complete flag"
VAR, tDelay, TIME,,,, "Delay duration"
VAR_INPUT, iInputValue, INT,,,, "Raw input value"
VAR_OUTPUT, rScaledValue, REAL,,,, "Scaled output value"
```
- `Class`: `VAR` for local, `VAR_INPUT` for inputs, `VAR_OUTPUT` for outputs
- Device and Address columns are **left empty** for local variables
- No prefix requirement for local variables (but Hungarian prefixes recommended: see naming)

#### 5.2.4 Structure CSV
```
"My Project"
Label Name, Data Type, Constant, Comment
iID, INT,, "Recipe ID number"
sName, STRING,, "Recipe name"
rTargetTemp, REAL,, "Target temperature"
xEnabled, BOOL,, "Recipe enabled flag"
```
- No `Class` column (different format from variable lists)
- Structure name = CSV filename
- Cannot be nested (FX limitation)

#### 5.2.5 Function Block CSV Pattern
An FB requires **two files with the same name**:
- `{FBName}.st` — code only (no FB declaration, no VAR blocks)
- `{FBName}.csv` — local + input + output variables

`MotorControl.csv`:
```
"My Project"
Class, Label Name, Data Type, Constant, Device, Address, Comment
VAR_INPUT, xStart, BOOL,,,, "Start command"
VAR_INPUT, xStop, BOOL,,,, "Stop command"
VAR_INPUT, xFeedback, BOOL,,,, "Contactor feedback"
VAR_OUTPUT, xMotor, BOOL,,,, "Motor output"
VAR_OUTPUT, xFault, BOOL,,,, "Fault indication"
VAR, tonDelay, TIME,,,, "Start delay time"
VAR, rtStart, R_TRIG,,,, "Rising edge detector instance"
```

`MotorControl.st`:
```
(* Motor control with feedback monitoring *)
rtStart(CLK := xStart, Q := xRisingEdge);
...
```

#### 5.2.6 Function CSV Pattern
Same pattern: two files, same name. FUN has VAR_INPUT only (no VAR_OUTPUT — result is function return).

`ScaleValue.csv`:
```
"My Project"
Class, Label Name, Data Type, Constant, Device, Address, Comment
VAR_INPUT, iRawMin, INT,,,, "Raw minimum value"
VAR_INPUT, iRawMax, INT,,,, "Raw maximum value"
VAR_INPUT, rEngMin, REAL,,,, "Engineering minimum"
VAR_INPUT, rEngMax, REAL,,,, "Engineering maximum"
```

#### 5.2.7 Program CSV Pattern
Programs follow the **same 2-file rule**: `{ProgramName}.st` + `{ProgramName}.csv` with local, input, and output variables.

`MAIN.csv`:
```
"My Project"
Class, Label Name, Data Type, Constant, Device, Address, Comment
VAR, iState, INT,,,, "Current state"
VAR, tonDelay, TON,,,, "On-delay timer instance"
VAR_OUTPUT, xMotor1, BOOL,,,, "Motor 1 output"
```

---

### 5.3 references/devices.md (On-Demand)

**Purpose:** Complete device address space for FX series PLCs.

#### 5.3.1 Bit Devices (FX3U/FX3G)
| Device | Range | Access | Notes |
|--------|-------|--------|-------|
| X (Input) | X0–X377 (octal) | R | Physical inputs |
| Y (Output) | Y0–Y377 (octal) | R/W | Physical outputs |
| M (General) | M0–M7679 | R/W | General purpose internal relay |
| M (Latched) | M7680–M8511 | R/W | Battery-backed |
| S (Step relay) | S0–S4095 | R/W | For SFC / state machines |
| TS (Timer contact) | TS0–TS511 | R | Timer done/normal-open contact |
| CS (Counter contact) | CS0–CS255 | R | Counter done/normal-open contact |

#### 5.3.2 Word Devices (FX3U/FX3G)
| Device | Range | Size | Notes |
|--------|-------|------|-------|
| D (General) | D0–D7999 | 16-bit | General data register |
| D (Latched) | D8000–D8511 | 16-bit | Battery-backed |
| T (Timer current) | TN0–TN511 | 16/32-bit | Current timer value |
| C (Counter current) | CN0–CN255 | 16/32-bit | Current count value |
| R (File register) | R0–R32767 | 16-bit | Extended memory |
| Z (Index) | Z0–Z7 | 16-bit | Index addressing |
| V (Index) | V0–V7 | 16-bit | Index (paired with Z for 32-bit) |

#### 5.3.3 Addressing Modes
- Direct: `D100`, `X0`, `M100`
- Indexed: `D100Z0` — offset D100 by value in Z0
- Digit-specified: `K4X0` — read 4 nibbles from X0 (16 bits)
- **Bit-of-word (D100.0) — NOT supported on FX. Use bit masking or M relays.**

#### 5.3.4 Best Practice
> **Do not use direct device access in ST code.** Always create label variables in CSV files and reference labels in code. The only exception is special relays/registers.

---

### 5.4 references/system-devices.md (On-Demand)

**Purpose:** Special relays and registers for FX series.

> **Note:** This is a quick-reference subset. A full comprehensive list of all special relays (M8000+) and special registers (D8000+) will be provided separately.

#### 5.4.1 Frequently Used Special Relays (M8000+)
| Device | Name | Description |
|--------|------|-------------|
| M8000 | Always ON | TRUE during RUN |
| M8001 | Always OFF | FALSE during RUN |
| M8002 | First Scan ON | TRUE for first scan only |
| M8003 | First Scan OFF | FALSE for first scan only |
| M8011 | 10ms Clock | 5ms ON, 5ms OFF |
| M8012 | 100ms Clock | 50ms ON, 50ms OFF |
| M8013 | 1s Clock | 0.5s ON, 0.5s OFF |
| M8014 | 1min Clock | 30s ON, 30s OFF |

#### 5.4.2 Frequently Used Special Registers (D8000+)
| Device | Name | Description |
|--------|------|-------------|
| D8000 | Watchdog Timer | Default 200ms |
| D8010 | Current Scan Time | 0.1ms units |
| D8011 | Min Scan Time | 0.1ms units |
| D8012 | Max Scan Time | 0.1ms units |

---

### 5.5 references/instructions.md (On-Demand)

**Purpose:** Full ST instruction set as supported by GX Works 2 on FX series.

#### 5.5.1 Assignment
- `:=` — value assignment. **GX Works 2 uses `:=` for ALL parameters, including outputs.**
- `SET device;` — set bit device/label to TRUE (latching)
- `RST device;` — reset bit device/label to FALSE
- `PLS device;` — rising edge pulse on bit device
- `PLF device;` — falling edge pulse on bit device

#### 5.5.2 Selection
- `IF condition THEN ... ELSIF condition THEN ... ELSE ... END_IF;`
- `CASE IntVar OF value1: ... value2: ... ELSE ... END_CASE;`
  - Integer labels only, no ranges (`1..5`), no named values

#### 5.5.3 Iteration
- `FOR i := start TO end BY step DO ... END_FOR;` — BY optional (default 1)
- `WHILE condition DO ... END_WHILE;`
- `REPEAT ... UNTIL condition; END_REPEAT;`
- `EXIT;` — exits innermost loop
- **No `CONTINUE`** — restructure with IF/ELSE

#### 5.5.4 Operators
| Category | Operators |
|----------|-----------|
| Arithmetic | `+`, `-`, `*`, `/`, `MOD` |
| Comparison | `=`, `<>`, `<`, `>`, `<=`, `>=` |
| Logical | `NOT`, `AND`, `OR`, `XOR` |

#### 5.5.5 WORD/DWORD Arithmetic Instructions
For WORD and DWORD types, use dedicated arithmetic instructions with 4 variants each:

| Base | `_E` (triggered) | `P` (pulse) | `D` (32-bit) | `DP` (32-bit pulse) |
|------|-----------------|-------------|---------------|---------------------|
| `ADD` | `ADD_E` | `ADDP` | `DADD` | `DADDP` |
| `SUB` | `SUB_E` | `SUBP` | `DSUB` | `DSUBP` |
| `MUL` | `MUL_E` | `MULP` | `DMUL` | `DMULP` |
| `DIV` | `DIV_E` | `DIVP` | `DDIV` | `DDIVP` |

Usage:
```
ADD_E(xTrig, wVal1, wVal2, wResult);    (* wResult := wVal1 + wVal2 on trigger *)
ADDP(xTrig, wVal1, wVal2, wResult);     (* pulse: executes once on rising edge *)
DADD(dwVal1, dwVal2, dwResult);          (* 32-bit: dwResult := dwVal1 + dwVal2 *)
DADDP(xTrig, dwVal1, dwVal2, dwResult); (* 32-bit pulse *)
```

#### 5.5.6 Bit Shift (support `_E`)
| Function | `_E` Variant |
|----------|-------------|
| `SHL(IN, N)` | `SHL_E(Trigger, IN, N, Result)` |
| `SHR(IN, N)` | `SHR_E(Trigger, IN, N, Result)` |
| `ROL(IN, N)` | `ROL_E(Trigger, IN, N, Result)` |
| `ROR(IN, N)` | `ROR_E(Trigger, IN, N, Result)` |

#### 5.5.7 Missing IEC Constructs
| Construct | Status |
|-----------|--------|
| `CONTINUE` | ❌ |
| `JMP`/`LBL` in ST | ❌ |
| Named CASE / ranges | ❌ |
| `LREAL`, `WSTRING` | ❌ |
| `SR`, `RS` FBs | ❌ (use SET/RST) |
| `VAR_IN_OUT` | ❌ (FX) |
| Function overloading | ❌ |
| `__NEW`/`__DELETE` | ❌ |
| `REF_TO` | ❌ |
| `ARRAY[*]` variable-length | ❌ |

---

### 5.6 references/data-types.md (On-Demand)

**Purpose:** All data types, literal syntax, and casting rules.

#### 5.6.1 Elementary Types
| Type | Size | Range | Literal Examples |
|------|------|-------|-----------------|
| `BOOL` | 1 bit | `FALSE`, `TRUE` | `TRUE`, `FALSE`, `0`, `1` |
| `INT` | 16-bit | -32,768 to 32,767 | `K100`, `K-456`, `123` |
| `DINT` | 32-bit | ±2.14×10⁹ | `K123456789` |
| `WORD` | 16-bit | 0 to 65,535 | `HFF`, `HABCD`, `16#FF` |
| `DWORD` | 32-bit | 0 to 4.29×10⁹ | `HDEADBEEF`, `16#DEADBEEF` |
| `REAL` | 32-bit | ±1.175e-38 to ±3.402e+38 | `E3.14`, `1.5e2`, `REAL#1.5` |
| `STRING` | N+1 bytes | Max 255 chars | `'Hello'` (double `''` to escape) |
| `TIME` | 32-bit | T#0ms to ~T#24d | `T#10s`, `T#1h30m500ms` |

> **FX note:** `K` prefix = decimal integer. `H` prefix = hexadecimal. `E` prefix = REAL (scientific). These are Mitsubishi-specific literal notations.

#### 5.6.2 Type Casting (all support `_E` postfix)
| Function | Description |
|----------|-------------|
| `INT_TO_REAL` | INT → REAL |
| `REAL_TO_INT` | REAL → INT (truncates) |
| `INT_TO_DINT` | INT → DINT |
| `DINT_TO_INT` | DINT → INT (overflow risk) |
| `BOOL_TO_INT` | BOOL → INT (0 or 1) |
| `BOOL_TO_WORD` | BOOL → WORD |
| `WORD_TO_INT` | WORD → INT |
| `INT_TO_WORD` | INT → WORD |
| `DINT_TO_REAL` | DINT → REAL |
| `REAL_TO_DINT` | REAL → DINT |
| `INT_TO_STRING` | INT → STRING |
| `STR_TO_INT` | STRING → INT |
| `STR_TO_REAL` | STRING → REAL |
| `STR_TO_DINT` | STRING → DINT |
| `REAL_TO_STRING` | REAL → STRING |
| `DINT_TO_STRING` | DINT → STRING |
| `TIME_TO_DINT` | TIME → DINT |
| `DINT_TO_TIME` | DINT → TIME |
| `WORD_TO_DWORD` | WORD → DWORD |
| `DWORD_TO_WORD` | DWORD → WORD |

> **`_E` postfix pattern:** `INT_TO_REAL_E(Trigger, INT_Value, REAL_Output);` — first param is trigger condition, last param receives result. Non-`_E` version: `REAL_Output := INT_TO_REAL(INT_Value);`

#### 5.6.3 Naming Conventions
| Prefix | Type | Example |
|--------|------|---------|
| `x` | BOOL | `xMotorRunning`, `xStart` |
| `i` | INT | `iCount`, `iIndex` |
| `di` | DINT | `diPosition` |
| `w` | WORD | `wStatus` |
| `dw` | DWORD | `dwEncoder` |
| `r` | REAL | `rTemperature` |
| `s` | STRING | `sMessage` |
| `t` | TIME | `tDelay` |
| `g_` | Global prefix | `g_xSystemReady` |
| `ai` | Array of INT | `aiLookupTable` |
| `ar` | Array of REAL | `arCalibration` |

---

### 5.7 references/functions.md (On-Demand)

**Purpose:** All built-in FUN and FB, with correct Mitsubishi names and postfix variants.

#### 5.7.1 Postfix Patterns

##### `_E` Postfix (Triggered Execution)
Applies to: conversions, math, selection, timer/counter/edge FBs, bit shifts. **String functions do NOT support `_E`.**

| Aspect | Without `_E` | With `_E` |
|--------|-------------|-----------|
| Trigger | None (always executes) | First parameter: `Trigger` (BOOL) |
| Return | Function returns value | Last parameter: stores result |
| Usage | `rResult := MAXIMUM(rA, rB);` | `MAXIMUM_E(xTrig, rA, rB, rResult);` |

The `_E` form executes only when `Trigger` is TRUE.

##### `P` Postfix (Pulse / Rising-Edge Execution)
Applies to: some arithmetic (ADD/SUB/MUL/DIV), string functions, SQRT, RND. **Note:** `P` attaches directly without underscore: `ADDP`, `SQRTP`, `LEFTP`, `RNDP`.

| Aspect | Without `P` | With `P` |
|--------|------------|----------|
| Execution | Every scan | Once on rising edge of first parameter |
| Usage | `sOut := LEFT(sIn, 5);` | `LEFTP(xTrig, sIn, 5, sOut);` |

##### `D` Prefix (32-bit / Double-Word)
Applies to arithmetic and math functions. Upgrades operation from WORD/INT to DWORD/DINT.

| 16-bit | 32-bit |
|--------|--------|
| `ABS` | `DABS` |
| `ADD` | `DADD` |
| `SUB` | `DSUB` |
| `MUL` | `DMUL` |
| `DIV` | `DDIV` |

Combined forms: `DABS_E` (32-bit + triggered), `DADDP` (32-bit + pulse), etc.

---

#### 5.7.2 Arithmetic & Math Functions

| Function | Signature | `_E` | `P` | `D` (32-bit) | Notes |
|----------|-----------|------|-----|--------------|-------|
| `ABS` | `ABS(IN)` | ✅ `ABS_E` | — | ✅ `DABS`, `DABS_E` | Absolute value |
| `SQRT` | `SQRT(IN)` — REAL | — | ✅ `SQRTP` | — | Square root |
| `EXPT` | `EXPT(Base, Exp)` | ✅ `EXPT_E` | — | — | Base^Exp |
| `MOD` | `MOD(IN1, IN2)` | ✅ `MOD_E` | — | — | Modulo |
| `RND` | `RND(IN)` — REAL→INT | — | ✅ `RNDP` | — | Round (NOT `ROUND`) |

**NOT supported on FX series:** `LN`, `LOG`, `EXP`, `SIN`, `COS`, `TAN`, `ASIN`, `ACOS`, `ATAN`, `TRUNC`.

---

#### 5.7.3 String Functions

> **Note:** String functions support `_E` on INSERT, DELETE, REPLACE, FIND. `P` postfix on LEN, LEFT, RIGHT, MID, CONCAT.

| Function | Description | `P` variant | `_E` variant |
|----------|-------------|-------------|--------------|
| `LEN` | `LEN(IN)` — string length | `LENP` | — |
| `LEFT` | `LEFT(IN, L)` — leftmost L chars | `LEFTP` | — |
| `RIGHT` | `RIGHT(IN, L)` — rightmost L chars | `RIGHTP` | — |
| `MID` | `MID(IN, L, P)` — L chars at position P | `MIDP` | — |
| `CONCAT` | `CONCAT(IN1, IN2)` — concatenate | `CONCATP` | — |
| `INSERT` | `INSERT(IN1, IN2, P)` | — | ✅ `INSERT_E` |
| `DELETE` | `DELETE(IN, L, P)` | — | ✅ `DELETE_E` |
| `REPLACE` | `REPLACE(IN1, IN2, L, P)` | — | ✅ `REPLACE_E` |
| `FIND` | `FIND(IN1, IN2)` — returns position (0 = not found) | — | ✅ `FIND_E` |

`P` variant usage (pulse: first param is trigger, executes once on rising edge):
```
LENP(xTrig, sIn, iLength);           (* iLength := LEN(sIn) on rising edge *)
LEFTP(xTrig, sIn, 5, sOut);          (* sOut := LEFT(sIn, 5) on rising edge *)
RIGHTP(xTrig, sIn, 3, sOut);
MIDP(xTrig, sIn, 4, 2, sOut);
CONCATP(xTrig, sFirst, sLast, sFull);
```

`_E` variant usage (triggered: first param is enable, last param stores result):
```
INSERT_E(xTrig, sBase, sInsert, 3, sResult);
DELETE_E(xTrig, sBase, 5, 2, sResult);
REPLACE_E(xTrig, sBase, sNew, 4, 3, sResult);
FIND_E(xTrig, sBase, sSearch, iPosition);
```

---

#### 5.7.4 Timer Function Blocks & Instructions

##### IEC Timer FBs (TON/TOF/TP)
All timer FBs support `_E` postfix. **Must be declared as a VAR instance in CSV before use.**

| FB | `_E` Variant | Signature |
|----|-------------|-----------|
| `TON` | `TON_E` | On-delay. IN: trigger, PT: preset TIME, Q: output, ET: elapsed |
| `TOF` | `TOF_E` | Off-delay |
| `TP` | `TP_E` | Pulse (fixed-width) |

Usage — **GX Works 2 uses `:=` for ALL parameters, including outputs:**
```
(* Declare in CSV: VAR, tonDelay, TON *)
tonDelay(IN := xStart, PT := T#5s, Q := xDone, ET := tElapsed);

(* _E variant: first param is trigger *)
TON_E(xEnable, xStart, T#5s, xDone, tElapsed);
```

##### Hardware Timer Instructions (OUT_T)
For direct hardware timer access without FB declaration. Timer value is in **100ms units**.

```
OUT_T(TRUE, TC1, K20);    (* Start timer TC1 with 20 × 100ms = 2s preset *)
```

- `TN1` — current timer value (elapsed, in 100ms units)
- `TS1` — timer contact (TRUE when timer done)

> **No CSV declaration needed** for `OUT_T`, `TNx`, `TSx` — these are direct device instructions.

---

#### 5.7.5 Counter Function Blocks & Instructions

##### IEC Counter FBs (CTU/CTD/CTUD)
All counter FBs support `_E` postfix. **Must be declared as a VAR instance in CSV before use.**

| FB | `_E` Variant | Signature |
|----|-------------|-----------|
| `CTU` | `CTU_E` | Count-up. CU: count pulse, RESET: reset, PV: preset, Q: output, CV: current |
| `CTD` | `CTD_E` | Count-down. CD: count pulse, LOAD: load preset, PV: preset, Q: output, CV: current |
| `CTUD` | `CTUD_E` | Up-down. CU/CD: count pulses, RESET/LOAD, PV: preset, QU/QD: outputs, CV: current |

Usage (all parameters use `:=`):
```
(* Declare in CSV: VAR, ctParts, CTU *)
ctParts(CU := xPulse, RESET := xReset, PV := K100, Q := xFull, CV := iCount);

(* _E variant *)
CTU_E(xEnable, xPulse, xReset, K100, xFull, iCount);
```

##### Hardware Counter Instructions (OUT_C / OUT_C_32)
For direct hardware counter access without FB declaration.

```
OUT_C(TRUE, CC235, K200);      (* Start 16-bit counter CC235, preset 200 *)
OUT_C_32(TRUE, CC235, K200);   (* Start 32-bit counter CC235, preset 200 *)
```

- `CN235` — current counter value
- `CS235` — counter contact (TRUE when count >= preset)

Reset a hardware counter:
```
RST(TRUE, CC235);              (* Reset counter CC235 to 0 *)
```

> **No CSV declaration needed** for `OUT_C`, `OUT_C_32`, `CNx`, `CSx`, `RST` — these are direct device instructions.

---

#### 5.7.6 Edge Detection

##### IEC Edge Detection FBs (R_TRIG / F_TRIG)
All edge-detection FBs support `_E` postfix. **Must be declared as a VAR instance in CSV before use.**

| FB | `_E` Variant | Signature |
|----|-------------|-----------|
| `R_TRIG` | `R_TRIG_E` | Rising edge detect. CLK: input signal, Q: one-scan pulse on rising edge |
| `F_TRIG` | `F_TRIG_E` | Falling edge detect. CLK: input signal, Q: one-scan pulse on falling edge |

Usage (all parameters use `:=`):
```
(* Declare in CSV: VAR, rtStart, R_TRIG *)
rtStart(CLK := xSignal, Q := xRisingEdge);

(* _E variant *)
R_TRIG_E(xEnable, xSignal, xRisingEdge);
```

##### Edge Detection Instructions (MEP / MEF)
**More commonly used** — no declaration needed. Accept a single argument and can be used **inline in expressions**.

| Instruction | Description |
|-------------|-------------|
| `MEP(IN)` | Rising edge pulse. Returns TRUE for one scan on rising edge of IN. |
| `MEF(IN)` | Falling edge pulse. Returns TRUE for one scan on falling edge of IN. |

Usage (inline — no CSV declaration required):
```
IF MEP(xStart) THEN
    iCount := iCount + 1;       (* Increment once per rising edge *)
END_IF;

xPulse := MEP(xSensor);         (* Use directly in assignment *)

IF MEF(xStop) THEN
    xMotor := FALSE;            (* Stop on falling edge *)
END_IF;
```

> **Prefer MEP/MEF over R_TRIG/F_TRIG** — they are simpler, require no CSV declaration, and work inline.

---

#### 5.7.7 Selection Functions

| Function | Signature | `_E` |
|----------|-----------|------|
| `SEL` | `SEL(G, IN0, IN1)` — G=FALSE→IN0, G=TRUE→IN1 | ✅ `SEL_E` |
| `MAXIMUM` | `MAXIMUM(IN1, IN2, ...)` — max of up to 28 inputs | ✅ `MAXIMUM_E` |
| `MINIMUM` | `MINIMUM(IN1, IN2, ...)` — min of up to 28 inputs | ✅ `MINIMUM_E` |
| `LIMITATION` | `LIMITATION(MIN, IN, MAX)` — clamp value | ✅ `LIMITATION_E` |
| `MUX` | `MUX(K, IN0, IN1, ...)` — select K-th input (0-based) | ✅ `MUX_E` |

> **Critical naming note:** These are `MAXIMUM`, `MINIMUM`, `LIMITATION` — NOT `MAX`, `MIN`, `LIMIT` as in standard IEC.

`_E` examples:
```
MAXIMUM_E(xTrig, 10, 20, iResult);    (* stores max in iResult on trigger *)
iResult := MAXIMUM(10, 20);            (* returns max directly *)

SEL_E(xTrig, xSelector, iVal0, iVal1, iResult);
iResult := SEL(xSelector, iVal0, iVal1);

LIMITATION_E(xTrig, iMin, iInput, iMax, iResult);
iResult := LIMITATION(iMin, iInput, iMax);
```

---

#### 5.7.8 User-Defined Function Blocks (FB)

**Rule: No declaration in code.** Two files, same name:
- `{Name}.csv` — variables (VAR_INPUT, VAR_OUTPUT, VAR)
- `{Name}.st` — code body only

**Critical: GX Works 2 uses `:=` for ALL parameters, including outputs.**

Inside FB code:
```
xMotor := xStart AND NOT xStop AND NOT xFault;
```

Calling the FB (outputs also use `:=`):
```
fbMotor(xStart := DI_Start, xStop := DI_Stop, xMotor := DO_Pump);
```

---

#### 5.7.9 User-Defined Functions (FUN)

Same file pattern. FUN has VAR_INPUT only (no VAR_OUTPUT). Return via function result.
```
(* Inside FUN code: ScaleValue := result_expression; *)
ScaleValue := INT_TO_REAL(iRaw) * rGain + rOffset;
```

---

### 5.8 references/compatibility.md (On-Demand)

**Purpose:** Feature differences across FX series models.

#### 5.8.1 Feature Matrix
| Feature | FX3U | FX3G | FX3S | FX5U |
|---------|------|------|------|------|
| ST language | ✅ | ✅ | ✅ | ✅ |
| IEC timers (TON/TOF/TP) | ✅ | ✅ | ✅ | ✅ |
| TIME type | ✅ | ✅ | ✅ | ✅ |
| REAL type | ✅ | ✅ | ✅ | ✅ |
| DINT type | ✅ | ✅ | ✅ | ✅ |
| STRING type | ✅ | ❌ | ❌ | ✅ |
| 2D arrays | ✅ | ✅ | ✅ | ✅ |
| Structures (via CSV) | ✅ | ✅ | ✅ | ✅ |
| Index Z | 0–7 | 0–7 | 0–7 | 0–19 |
| Index V | 0–7 | 0–7 | 0–7 | ❌ |
| File registers (R) | ✅ | ✅ | ⚠️ | ✅ |
| D registers | 0–7999 | 0–7999 | 0–3999 | 0–7999 |
| M relays | 0–7679 | 0–7679 | 0–3839 | 0–7679 |

---

## 6. Example Files — Detailed Specifications

### 6.1 Project Structure Pattern

Every POU (program, FB, FUN) uses the **2-file rule**: `.st` code file + `.csv` label file with the same name.

Every project uses 3 programs:
1. **INIT** — runs once on first scan (M8002). Initializes variables, sets defaults.
   - Files: `INIT.st` + `INIT.csv`
2. **ROUTINE** — runs every 100ms on a timer. Handles non-critical tasks (HMI refresh, slow monitoring, logging).
   - Files: `ROUTINE.st` + `ROUTINE.csv`
3. **MAIN** — runs every scan. Contains all business logic.
   - Files: `MAIN.st` + `MAIN.csv`

### 6.2 State Machine Pattern
All state machines have these 3 mandatory initial states:
- **Init** (state 0) — entered on first scan, sets defaults
- **Reset** (state 10) — resets all outputs and intermediate values
- **Idle** (state 20) — waiting for start condition

**No CONSTANT declarations for state names** — use integer comments instead.

---

### 6.3 Basic Examples (each = .st file + .csv file)

1. **01-io-assignment** — Read DI_ input labels, write to DO_ output labels via IO.csv + GVL.csv
2. **02-conditionals** — IF/ELSIF/ELSE with comparison operators
3. **03-case-state-machine** — Init (0)/Reset (10)/Idle (20)/Run (30)/Fault (40) pattern
4. **04-loops** — FOR/WHILE/REPEAT with EXIT, scan-time awareness comment
5. **05-timers** — TON/TOF/TP with R_TRIG trigger, `_E` variant examples; `:=` for all params
6. **06-counters** — CTU/CTD/CTUD with reset, `_E` variants
7. **07-math** — ADD/SUB/MUL/DIV with 4 variants, ABS, SQRT, EXPT, MOD, RND, MAXIMUM/MINIMUM/LIMITATION
8. **08-strings** — CONCAT, LEN, LEFT/LEFTP, RIGHT/RIGHTP, MID/MIDP, FIND
9. **09-bit-operations** — SET/RST/PLS/PLF, SHL/SHR with `_E`, AND/OR/XOR masks
10. **10-type-casting** — All conversion functions, `_E` variants
11. **11-edge-detection** — R_TRIG/F_TRIG instances, `_E` variants, edge-triggered counters
12. **12-function-block** — FB with CSV + ST files, MotorControl pattern, `:=` for outputs
13. **13-function** — FUN with CSV + ST files, ScaleValue pattern

---

## 7. Implementation Phases

### Phase 1: Foundation (Always-Loaded References)
1. `references/common-rules.md`
2. `references/csv-variables.md`

### Phase 2: Core References (On-Demand)
3. `references/data-types.md`
4. `references/devices.md`
5. `references/instructions.md`
6. `references/functions.md`

### Phase 3: Supplementary References
7. `references/system-devices.md`
8. `references/compatibility.md`

### Phase 4: SKILL.md
9. Main skill file with lazy-load index

### Phase 5: Examples
10. All 13 example pairs (.st + .csv)

### Phase 6: Polish ✅ (COMPLETE)
11. ✅ Update README.md — full rewrite matching actual structure
12. ✅ Cross-reference validation — 5 issues found and fixed (see plans/validation.md)
13. ✅ Test with diverse prompts — 12 scenarios validated (see plans/validation.md)

---

## 8. Success Criteria

1. Agent generates CSV variable files alongside ST code — **always**
2. Agent uses correct prefixes: `DI_`/`DO_`/`AI_`/`AO_` for IO, `g_` for globals, `x`/`i`/`r`/etc. for locals
3. Agent never uses `CONITNUE`, `LREAL`, `SR`/`RS`, named CASE, or VAR_IN_OUT
4. Agent never uses unsupported math functions: `LN`, `LOG`, `EXP`, `SIN`, `COS`, `TAN`, `ASIN`, `ACOS`, `ATAN`, `TRUNC`
5. Agent uses correct Mitsubishi names: `RND` (not `ROUND`), `MAXIMUM`, `MINIMUM`, `LIMITATION`, `STR_TO_INT`
6. Agent applies postfixes correctly: `_E` (triggered), `P` without underscore (pulse), `D` prefix (32-bit)
7. Agent uses `:=` for ALL FB parameters including outputs (not `=>`)
8. Agent declares FB/FUN/timer/counter/edge instances in CSV before use
9. Agent generates FB/FUN/programs as 2-file pairs without inline declarations
10. Agent uses literal prefixes: `K` for INT, `H` for WORD/hex, `E` for REAL
11. Agent sets up 3-program structure: INIT, ROUTINE, MAIN
12. Agent creates state machines with Init/Reset/Idle
13. Agent never uses direct device access in ST code (uses labels via CSV)
14. Agent knows string `P` variants: `LEFTP`, `RIGHTP`, `MIDP`, `CONCATP`
15. Agent knows WORD/DWORD arithmetic: `ADD_E`/`ADDP`/`DADD`/`DADDP` etc.

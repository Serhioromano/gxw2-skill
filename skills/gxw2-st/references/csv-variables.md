# CSV Variable Management — GX Works 2 Label Editor

Always load this file. GX Works 2 does **not** use inline `VAR ... END_VAR` blocks for production code. Variables are managed via the **Label Editor** and imported/exported as CSV files. You **must** generate these CSV files alongside ST code.

---

## ⚠️ MANDATORY: Create ALL CSV Files in UTF-16 LE Encoding

> **Every CSV file you generate MUST be written in UTF-16 Little Endian encoding with BOM (`FF FE`).**
>
> GX Works 2 will **reject** any file that is not UTF-16 LE. This is non-negotiable. Before saving the file, explicitly set the encoding to **UTF-16 LE** in your editor or write tool. Do NOT use UTF-8, ASCII, or any other encoding — the import will fail silently or with an error.

---

## Critical: File Format

GX Works 2 exports and imports CSV files in **UTF-16 LE with BOM, tab-separated, all values quoted**. Any deviation will fail to import.

| Property | Value |
|----------|-------|
| Encoding | **UTF-16 Little Endian** (BOM: `FF FE`) |
| Separator | **Tab** (`\t`), NOT comma |
| Quoting | **Every cell** wrapped in double quotes `"..."` |
| Empty cells | `""` (two double quotes) |
| Line endings | `\n` (LF) |
| First line | `"Project Name"` — project name in quotes, no header |

**Do NOT use commas as separators. Do NOT omit quotes on any cell. Always write UTF-16 LE.**

Example of the raw format (shown here as readable text, but write as UTF-16 LE):
```
"Project Name"
"Class"	"Label Name"	"Data Type"	"Constant"	"Device"	"Address"	"Comment"
"VAR"	"iIndex"	"INT"	""	""	""	"Loop index"
```

---

## The 2-File Rule

Every POU (program, function block, function) requires two files with the same base name:

- `{POU_Name}.st` — code body only (no variable declarations)
- `{POU_Name}.csv` — all variables for that POU (UTF-16 LE, tab-separated, all quoted)

---

## Three Variable List Types

| File Pattern       | Class         | Columns | Purpose |
|--------------------|---------------|---------|---------|
| `IO.csv`           | `VAR_GLOBAL`  | 11 cols | Variables bound to physical I/O (X/Y). Prefixes: `DI_`, `DO_`, `AI_`, `AO_` |
| `GVL.csv`          | `VAR_GLOBAL`  | 11 cols | Global variables needing HMI access or exact addressing. Prefix: `g_` + **camelCase** (never ALL CAPS) |
| `GVL.csv` (constants) | `VAR_GLOBAL_CONSTANT` | 11 cols | Global constants / default values — value in the Constant column, no device binding. Prefix: `c_` |
| `{POU_Name}.csv`   | See below     | 7 cols  | Local variables — class depends on POU type |

### Available Classes by POU Type

| POU Type  | Supported Classes |
|-----------|-------------------|
| **Program** | `VAR`, `VAR_CONSTANT` only |
| **Function Block (FB)** | `VAR_INPUT`, `VAR_OUTPUT`, `VAR` |
| **Function (FUN)** | `VAR_INPUT` only (return value via function name) |

Global lists (`IO.csv`/`GVL.csv`) support `VAR_GLOBAL` and `VAR_GLOBAL_CONSTANT`.

> **Rule: a non-empty Constant column requires a CONSTANT class.** Any row whose **Constant** column holds a value (default/constant) must use `VAR_CONSTANT` (program local) or `VAR_GLOBAL_CONSTANT` (global). `VAR` / `VAR_GLOBAL` rows must leave the Constant column empty (`""`).

---

## % Address Numbering in Global Variable Lists

When a global variable (IO.csv or GVL.csv) is bound to a device, the **Address** column uses GX Works 2 `%`-notation. Addresses are numbered as follows (device → address):

| Device | Address | Label data type | Pattern |
|--------|---------|-----------------|---------|
| X000 | `%IX0` | BOOL | `%IX{n}` |
| X001 | `%IX1` | BOOL | `%IX{n}` |
| Y000 | `%QX0` | BOOL | `%QX{n}` |
| Y002 | `%QX2` | BOOL | `%QX{n}` |
| D0 | `%MD0.0` | REAL / DINT / DWORD | `%MD{area}.{n}` |
| D2 | `%MD0.2` | REAL / DINT / DWORD | `%MD{area}.{n}` |
| D500 | `%MW0.500` | INT / WORD | `%MW{area}.{n}` |
| D501 | `%MW0.501` | INT / WORD | `%MW{area}.{n}` |
| M500 | `%MX0.500` | BOOL | `%MX{area}.{n}` |
| M501 | `%MX0.501` | BOOL | `%MX{area}.{n}` |
| R500 | `%MW2.500` | INT / WORD | `%MW{area}.{n}` |
| R501 | `%MW2.501` | INT / WORD | `%MW{area}.{n}` |

**Rules:**
- `%IX` = digital input (X), `%QX` = digital output (Y) — the address is the device number itself (`X0` → `%IX0`, `Y2` → `%QX2`), no area prefix
- D registers and M relays use `{area}.{n}` where `{n}` is the device number: `%MW` = 16-bit word device (INT/WORD), `%MD` = 32-bit double-word device (REAL/DINT/DWORD), `%MX` = bit device (BOOL)
- The number before the dot is the device area: `0` = main D/M area, `2` = R file register area (`R500` → `%MW2.500`)
- 32-bit labels (`%MD`) occupy 2 consecutive D registers — e.g. `D2` as REAL is `%MD0.2` and covers D2–D3

This applies only to the 11-column global lists (IO.csv / GVL.csv). Local POU variables (7-column CSVs) leave Device and Address empty (`""`).

**Non-volatile range:** global variable lists must use **M400+** for M relays and **D200+** for D registers — these ranges are non-volatile (retentive, survive power loss / RUN–STOP). Never assign global variables below M400 / D200.

---

## IO.csv Format

**11 columns** (tab-separated, all quoted):

`"Class"	"Label Name"	"Data Type"	"Constant"	"Device"	"Address"	"Comment"	"Remark"	"Relation with System Label"	"System Label Name"	"Attribute"`

```tsv
"GXW2-ST Examples"
"Class"	"Label Name"	"Data Type"	"Constant"	"Device"	"Address"	"Comment"	"Remark"	"Relation with System Label"	"System Label Name"	"Attribute"
"VAR_GLOBAL"	"DI_Start"	"BOOL"	""	"X0"	"%IX0"	"Start pushbutton (NO)"	""	""	""	""
"VAR_GLOBAL"	"DI_Stop"	"BOOL"	""	"X1"	"%IX1"	"Stop pushbutton (NC)"	""	""	""	""
"VAR_GLOBAL"	"DO_Pump"	"BOOL"	""	"Y0"	"%QX0"	"Pump contactor output"	""	""	""	""
"VAR_GLOBAL"	"AI_Pressure"	"INT"	""	"D210"	"%MW0.210"	"Pressure sensor (4-20mA scaled)"	""	""	""	""
"VAR_GLOBAL"	"AO_Valve"	"INT"	""	"D220"	"%MW0.220"	"Valve position command (0-1000)"	""	""	""	""
```

**Rules:**
- Prefixes: `DI_` (digital input), `DO_` (digital output), `AI_` (analog input), `AO_` (analog output)
- Device column is **required**
- Address uses GX Works 2 `%`-notation (see **% Address Numbering in Global Variable Lists**): `%IX0` for X0, `%QX0` for Y0, `%MW0.200` for D200
- D registers for analog I/O start at **D200** (non-volatile range — see **% Address Numbering in Global Variable Lists**)
- Constant column stays **empty** (`""`) — I/O variables are bound to devices, never to constant values

---

## GVL.csv Format

**11 columns** (same as IO.csv):

```tsv
"GXW2-ST Examples"
"Class"	"Label Name"	"Data Type"	"Constant"	"Device"	"Address"	"Comment"	"Remark"	"Relation with System Label"	"System Label Name"	"Attribute"
"VAR_GLOBAL"	"g_xPumpStart"	"BOOL"	""	"X0"	"%IX0"	"Pump start command"	""	""	""	""
"VAR_GLOBAL"	"g_iCycleCount"	"INT"	""	"D200"	"%MW0.200"	"Cycle counter"	""	""	""	""
"VAR_GLOBAL"	"g_rTemperature"	"REAL"	""	"D202"	"%MD0.202"	"Current temperature"	""	""	""	""
"VAR_GLOBAL"	"g_xAlarmActive"	"BOOL"	""	"M400"	"%MX0.400"	"Alarm active flag"	""	""	""	""
"VAR_GLOBAL_CONSTANT"	"c_T_GREEN_A"	"TIME"	"T#30s"	""	""	"Green duration for direction A (default 30 s)"	""	""	""	""
"VAR_GLOBAL_CONSTANT"	"c_T_YELLOW"	"TIME"	"T#3s"	""	""	"Blinking yellow phase duration (default 3 s)"	""	""	""	""
```

**Rules:**
- Prefix: `g_` for all global variables; `c_` for global constants
- **Global variable names are camelCase** — `g_xPumpStart`, `g_iCycleCount`, `g_rTemperature`, `g_xAlarmActive`. **Never ALL CAPS** (`G_XPUMPSTART`, `G_PUMP_START`). ALL CAPS is reserved for constructs only: POU file names (`FB_`, `F_`, `PRG_`), constant names (`c_`), and instruction names (see `common-rules.md` → Naming Conventions)
- **A value in the Constant column ⇒ class `VAR_GLOBAL_CONSTANT`.** If a global row carries a default/constant value (e.g. `T#30s`, `K100`, `E3.14`), the Class MUST be `VAR_GLOBAL_CONSTANT` — never `VAR_GLOBAL`. `VAR_GLOBAL` rows must leave the Constant column empty (`""`)
- Global constants (`VAR_GLOBAL_CONSTANT`) have **no device binding** — Device and Address columns stay empty (`""`)
- Addresses must be **sequential** (no gaps) when using D registers
- `REAL`/`DINT`/`DWORD` consume **2 consecutive D registers** — account for this in address assignment
- M relays use `%MX0.{n}` in the Address column (e.g. `M400` → `%MX0.400`)
- Global M relays start at **M400**, D registers at **D200** — non-volatile ranges (survive power loss); never assign globals below M400 / D200 (see **% Address Numbering in Global Variable Lists**)
- Device column is required for all device-bound globals

---

## Program CSV ({ProgramName}.csv)

Programs support only `VAR` and `VAR_CONSTANT`. No `VAR_INPUT`, no `VAR_OUTPUT`.

**7 columns** (tab-separated, all quoted):

`"Class"	"Label Name"	"Data Type"	"Constant"	"Device"	"Address"	"Comment"`

```tsv
"GXW2-ST Examples"
"Class"	"Label Name"	"Data Type"	"Constant"	"Device"	"Address"	"Comment"
"VAR"	"iIndex"	"INT"	""	""	""	"Loop index"
"VAR"	"rSetpoint"	"REAL"	""	""	""	"Target setpoint"
"VAR"	"xDone"	"BOOL"	""	""	""	"Operation complete flag"
"VAR"	"tDelay"	"TIME"	""	""	""	"Delay duration"
"VAR_CONSTANT"	"iMaxRetries"	"INT"	"3"	""	""	"Maximum retry attempts"
```

**Rules:**
- `Class`: `VAR` for local variables, `VAR_CONSTANT` for compile-time constants
- For `VAR_CONSTANT`, the **Constant column must contain the value** (e.g. `"3"`, `"E3.14"`, `"TRUE"`)
- For `VAR`, the Constant column is left empty (`""`)
- Device and Address columns are **left empty** (`""`) for local variables
- Hungarian prefixes recommended but not enforced for local variables

---

## Function Block CSV Pattern

FB requires two files with the same name:
- `{FB_NAME}.st` — code only (no FB declaration, no VAR blocks)
- `{FB_NAME}.csv` — local + input + output variables (7 columns)

FB file names follow the `FB_` + ALL CAPS convention (see `common-rules.md` → Naming Conventions): the POU/file name is `FB_MOTOR`, while instances are declared in CamelCase (`fbMotor : FB_MOTOR`).

**FB_MOTOR.csv:**
```tsv
"GXW2-ST Examples"
"Class"	"Label Name"	"Data Type"	"Constant"	"Device"	"Address"	"Comment"
"VAR_INPUT"	"xStart"	"BOOL"	""	""	""	"Start command"
"VAR_INPUT"	"xStop"	"BOOL"	""	""	""	"Stop command"
"VAR_INPUT"	"xFeedback"	"BOOL"	""	""	""	"Contactor feedback"
"VAR_OUTPUT"	"xMotor"	"BOOL"	""	""	""	"Motor output"
"VAR_OUTPUT"	"xFault"	"BOOL"	""	""	""	"Fault indication"
"VAR"	"tonDelay"	"TIME"	""	""	""	"Start delay time"
"VAR"	"rtStart"	"R_TRIG"	""	""	""	"Rising edge detector instance"
```

**FB_MOTOR.st:**
```iecst
(* Motor control with feedback monitoring *)
rtStart(CLK := xStart, Q := xRisingEdge);
(* ... body uses VAR_INPUT, VAR_OUTPUT, and VAR names directly *)
```

**Caller (declares the instance in its own CSV — instance in CamelCase, type is the FB file name):**
```tsv
"VAR"	"fbMotor"	"FB_MOTOR"	""	""	""	"Motor FB instance"
```
```iecst
fbMotor(xStart := xStartBtn, xStop := xStopBtn,
        xFeedback := DI_Feedback, xFaultReset := xReset,
        xMotor := Y_Motor, xFault := xMotorFault,
        xRunning := xMotorRunning, xReady := xMotorReady,
        tStartDelay := T#2s, tFaultTimeout := T#5s);
```

---

## Function CSV Pattern

**Functions are called directly — no instance declaration needed.** Unlike FBs, calling a FUN does not require a VAR entry in any CSV. The FUN's own inputs are defined in its own CSV file for the function definition itself, but the **caller** needs no declaration.

FUN has VAR_INPUT only — no VAR_OUTPUT (result is function return).

FUN names follow the `F_` + ALL CAPS convention (see `common-rules.md` → Naming Conventions): the POU name and the file base name match, e.g. `F_SCALE_VALUE`. The caller uses the `F_` name directly — no instance declaration.

**F_SCALE_VALUE.csv** (defines the function's inputs, 7 columns):
```tsv
"GXW2-ST Examples"
"Class"	"Label Name"	"Data Type"	"Constant"	"Device"	"Address"	"Comment"
"VAR_INPUT"	"iRaw"	"INT"	""	""	""	"Raw input value"
"VAR_INPUT"	"iRawMin"	"INT"	""	""	""	"Raw minimum value"
"VAR_INPUT"	"iRawMax"	"INT"	""	""	""	"Raw maximum value"
"VAR_INPUT"	"rEngMin"	"REAL"	""	""	""	"Engineering minimum"
"VAR_INPUT"	"rEngMax"	"REAL"	""	""	""	"Engineering maximum"
```

**F_SCALE_VALUE.st:**
```iecst
(* Returns scaled REAL value *)
F_SCALE_VALUE := rEngMin +
    ((INT_TO_REAL(iRaw - iRawMin) / INT_TO_REAL(iRawMax - iRawMin)) *
     (rEngMax - rEngMin));
```

**Calling (no CSV declaration needed):**
```iecst
rResult := F_SCALE_VALUE(iRaw := AI_Pressure, iRawMin := K0, iRawMax := K4000,
                         rEngMin := E0.0, rEngMax := E100.0);
```

---

## Program CSV Pattern

Programs follow the same 2-file rule: `{ProgramName}.st` + `{ProgramName}.csv`

**MAIN.csv** (7 columns):
```tsv
"GXW2-ST Examples"
"Class"	"Label Name"	"Data Type"	"Constant"	"Device"	"Address"	"Comment"
"VAR"	"iState"	"INT"	""	""	""	"Current state"
"VAR"	"tonDelay"	"TON"	""	""	""	"On-delay timer instance"
"VAR"	"xMotor1"	"BOOL"	""	""	""	"Motor 1 output"
```

---

## Structure CSV

Structures are **not defined inline** (`TYPE ... END_TYPE`). Create an importable CSV file.

**4 columns** (tab-separated, all quoted): `"Label Name"	"Data Type"	"Constant"	"Comment"` — no `Class` column.

```tsv
"GXW2-ST Examples"
"Label Name"	"Data Type"	"Constant"	"Comment"
"iID"	"INT"	""	"Recipe ID number"
"sName"	"STRING"	""	"Recipe name"
"rTargetTemp"	"REAL"	""	"Target temperature"
"xEnabled"	"BOOL"	""	"Recipe enabled flag"
```

**Rules:**
- Structure name = CSV filename
- Members use Hungarian prefixes: `i` for INT, `x` for BOOL, etc.
- Cannot be nested (FX limitation)

---

## Variable Generation Rules Summary

| Variable Type     | File         | Prefix         | Class(es)       | Columns | Device Column | Address Column |
|-------------------|--------------|----------------|-----------------|---------|---------------|----------------|
| Digital input     | IO.csv       | `DI_`          | `VAR_GLOBAL`    | 11 cols | Required      | Required       |
| Digital output    | IO.csv       | `DO_`          | `VAR_GLOBAL`    | 11 cols | Required      | Required       |
| Analog input      | IO.csv       | `AI_`          | `VAR_GLOBAL`    | 11 cols | Required      | Required       |
| Analog output     | IO.csv       | `AO_`          | `VAR_GLOBAL`    | 11 cols | Required      | Required       |
| HMI/exact-address | GVL.csv      | `g_` (camelCase) | `VAR_GLOBAL`    | 11 cols | Required      | Required — `%`-notation, M ≥ 400 / D ≥ 200 |
| Global constant   | GVL.csv      | `c_` (UPPER_SNAKE_CASE) | `VAR_GLOBAL_CONSTANT` | 11 cols | Empty    | Empty          |
| Program local     | {Program}.csv| (free)         | `VAR`, `VAR_CONSTANT` | 7 cols | Empty   | Empty          |
| FB input          | {FB}.csv     | (free)         | `VAR_INPUT`     | 7 cols  | Empty         | Empty          |
| FB output         | {FB}.csv     | (free)         | `VAR_OUTPUT`    | 7 cols  | Empty         | Empty          |
| FB local          | {FB}.csv     | (free)         | `VAR`           | 7 cols  | Empty         | Empty          |
| FUN input         | {FUN}.csv    | (free)         | `VAR_INPUT`     | 7 cols  | Empty         | Empty          |
| Structure member  | {Struct}.csv | (Hungarian)    | —               | 4 cols  | —             | —              |

> Global M relays must be ≥ **M400** and global D registers ≥ **D200** (non-volatile ranges).

---

## FB/FUN/Timer/Counter Instances in CSV

When an ST code uses an FB instance (TON, CTU, R_TRIG, or user-defined FB), that instance must be declared as a VAR in the corresponding CSV:

```tsv
"VAR"	"tonDelay"	"TON"	""	""	""	"On-delay timer"
"VAR"	"ctParts"	"CTU"	""	""	""	"Parts counter"
"VAR"	"rtStart"	"R_TRIG"	""	""	""	"Rising edge detector"
"VAR"	"fbMotor"	"FB_MOTOR"	""	""	""	"Motor FB instance (type FB_MOTOR)"
```

Without this declaration, the code will not compile in GX Works 2.

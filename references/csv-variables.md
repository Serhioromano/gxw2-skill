# CSV Variable Management — GX Works 2 Label Editor

Always load this file. GX Works 2 does **not** use inline `VAR ... END_VAR` blocks for production code. Variables are managed via the **Label Editor** and imported/exported as CSV files. You **must** generate these CSV files alongside ST code.

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
| `GVL.csv`          | `VAR_GLOBAL`  | 11 cols | Global variables needing HMI access or exact addressing. Prefix: `g_` |
| `{POU_Name}.csv`   | See below     | 7 cols  | Local variables — class depends on POU type |

### Available Classes by POU Type

| POU Type  | Supported Classes |
|-----------|-------------------|
| **Program** | `VAR`, `VAR_CONSTANT` only |
| **Function Block (FB)** | `VAR_INPUT`, `VAR_OUTPUT`, `VAR` |
| **Function (FUN)** | `VAR_INPUT` only (return value via function name) |

---

## IO.csv Format

**11 columns** (tab-separated, all quoted):

`"Class"	"Label Name"	"Data Type"	"Constant"	"Device"	"Address"	"Comment"	"Remark"	"Relation with System Label"	"System Label Name"	"Attribute"`

```tsv
"GXW2-ST Examples"
"Class"	"Label Name"	"Data Type"	"Constant"	"Device"	"Address"	"Comment"	"Remark"	"Relation with System Label"	"System Label Name"	"Attribute"
"VAR_GLOBAL"	"DI_Start"	"BOOL"	""	"X0"	"%IX0.0"	"Start pushbutton (NO)"	""	""	""	""
"VAR_GLOBAL"	"DI_Stop"	"BOOL"	""	"X1"	"%IX0.1"	"Stop pushbutton (NC)"	""	""	""	""
"VAR_GLOBAL"	"DO_Pump"	"BOOL"	""	"Y0"	"%QX0.0"	"Pump contactor output"	""	""	""	""
"VAR_GLOBAL"	"AI_Pressure"	"INT"	""	"D10"	"%MW10"	"Pressure sensor (4-20mA scaled)"	""	""	""	""
"VAR_GLOBAL"	"AO_Valve"	"INT"	""	"D20"	"%MW20"	"Valve position command (0-1000)"	""	""	""	""
```

**Rules:**
- Prefixes: `DI_` (digital input), `DO_` (digital output), `AI_` (analog input), `AO_` (analog output)
- Device column is **required**
- Address uses IEC format: `%IX0.0` for X0, `%QX0.0` for Y0, `%MW100` for D100

---

## GVL.csv Format

**11 columns** (same as IO.csv):

```tsv
"GXW2-ST Examples"
"Class"	"Label Name"	"Data Type"	"Constant"	"Device"	"Address"	"Comment"	"Remark"	"Relation with System Label"	"System Label Name"	"Attribute"
"VAR_GLOBAL"	"g_xPumpStart"	"BOOL"	""	"X0"	"%IX0.0"	"Pump start command"	""	""	""	""
"VAR_GLOBAL"	"g_iCycleCount"	"INT"	""	"D100"	"%MW100"	"Cycle counter"	""	""	""	""
"VAR_GLOBAL"	"g_rTemperature"	"REAL"	""	"D102"	"%MW102"	"Current temperature"	""	""	""	""
"VAR_GLOBAL"	"g_xAlarmActive"	"BOOL"	""	"M100"	""	"Alarm active flag"	""	""	""	""
```

**Rules:**
- Prefix: `g_` for all global variables
- Addresses must be **sequential** (no gaps) when using D registers
- `REAL`/`DINT`/`DWORD` consume **2 consecutive D registers** — account for this in address assignment
- Bit devices (M) leave Address column empty (`""`)
- Device column is required for I/O-bound globals; optional for M-relay globals

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
- `{FBName}.st` — code only (no FB declaration, no VAR blocks)
- `{FBName}.csv` — local + input + output variables (7 columns)

**MotorControl.csv:**
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

**MotorControl.st:**
```iecst
(* Motor control with feedback monitoring *)
rtStart(CLK := xStart, Q := xRisingEdge);
// ... body uses VAR_INPUT, VAR_OUTPUT, and VAR names directly
```

---

## Function CSV Pattern

**Functions are called directly — no instance declaration needed.** Unlike FBs, calling a FUN does not require a VAR entry in any CSV. The FUN's own inputs are defined in its own CSV file for the function definition itself, but the **caller** needs no declaration.

FUN has VAR_INPUT only — no VAR_OUTPUT (result is function return).

**ScaleValue.csv** (defines the function's inputs, 7 columns):
```tsv
"GXW2-ST Examples"
"Class"	"Label Name"	"Data Type"	"Constant"	"Device"	"Address"	"Comment"
"VAR_INPUT"	"iRaw"	"INT"	""	""	""	"Raw input value"
"VAR_INPUT"	"iRawMin"	"INT"	""	""	""	"Raw minimum value"
"VAR_INPUT"	"iRawMax"	"INT"	""	""	""	"Raw maximum value"
"VAR_INPUT"	"rEngMin"	"REAL"	""	""	""	"Engineering minimum"
"VAR_INPUT"	"rEngMax"	"REAL"	""	""	""	"Engineering maximum"
```

**ScaleValue.st:**
```iecst
(* Returns scaled REAL value *)
ScaleValue := rEngMin +
    ((INT_TO_REAL(iRaw - iRawMin) / INT_TO_REAL(iRawMax - iRawMin)) *
     (rEngMax - rEngMin));
```

**Calling (no CSV declaration needed):**
```iecst
rResult := ScaleValue(iRaw := AI_Pressure, iRawMin := K0, iRawMax := K4000,
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
| HMI/exact-address | GVL.csv      | `g_`           | `VAR_GLOBAL`    | 11 cols | Required      | Required (D) / Empty (M) |
| Program local     | {Program}.csv| (free)         | `VAR`, `VAR_CONSTANT` | 7 cols | Empty   | Empty          |
| FB input          | {FB}.csv     | (free)         | `VAR_INPUT`     | 7 cols  | Empty         | Empty          |
| FB output         | {FB}.csv     | (free)         | `VAR_OUTPUT`    | 7 cols  | Empty         | Empty          |
| FB local          | {FB}.csv     | (free)         | `VAR`           | 7 cols  | Empty         | Empty          |
| FUN input         | {FUN}.csv    | (free)         | `VAR_INPUT`     | 7 cols  | Empty         | Empty          |
| Structure member  | {Struct}.csv | (Hungarian)    | —               | 4 cols  | —             | —              |

---

## FB/FUN/Timer/Counter Instances in CSV

When an ST code uses an FB instance (TON, CTU, R_TRIG, or user-defined FB), that instance must be declared as a VAR in the corresponding CSV:

```tsv
"VAR"	"tonDelay"	"TON"	""	""	""	"On-delay timer"
"VAR"	"ctParts"	"CTU"	""	""	""	"Parts counter"
"VAR"	"rtStart"	"R_TRIG"	""	""	""	"Rising edge detector"
"VAR"	"fbMotor"	"MotorControl"	""	""	""	"Motor FB instance"
```

Without this declaration, the code will not compile in GX Works 2.

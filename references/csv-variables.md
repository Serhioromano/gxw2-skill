# CSV Variable Management — GX Works 2 Label Editor

Always load this file. GX Works 2 does **not** use inline `VAR ... END_VAR` blocks for production code. Variables are managed via the **Label Editor** and imported/exported as CSV files. You **must** generate these CSV files alongside ST code.

---

## The 2-File Rule

Every POU (program, function block, function) requires two files with the same base name:

- `{POU_Name}.st` — code body only (no variable declarations)
- `{POU_Name}.csv` — all variables for that POU

## Three Variable List Types

| File Pattern       | Class         | Purpose                                              |
|--------------------|---------------|------------------------------------------------------|
| `IO.csv`           | `VAR_GLOBAL`  | Variables bound to physical I/O (X/Y). Prefixes: `DI_`, `DO_`, `AI_`, `AO_` |
| `GVL.csv`          | `VAR_GLOBAL`  | Global variables needing HMI access or exact addressing. Prefix: `g_` |
| `{POU_Name}.csv`   | `VAR`/`VAR_INPUT`/`VAR_OUTPUT` | Local variables for a program, FB, or FUN |

---

## IO.csv Format

First line is the project name in quotes.

Columns: `Class, Label Name, Data Type, Constant, Device, Address, Comment, Remark, Relation with System Label, System Label Name, Attribute`

```csv
"My Project"
Class, Label Name, Data Type, Constant, Device, Address, Comment
VAR_GLOBAL, DI_Start, BOOL,, X0, %IX0.0, "Start pushbutton (NO)"
VAR_GLOBAL, DI_Stop, BOOL,, X1, %IX0.1, "Stop pushbutton (NC)"
VAR_GLOBAL, DO_Pump, BOOL,, Y0, %QX0.0, "Pump contactor output"
VAR_GLOBAL, AI_Pressure, INT,, D10, %MW10, "Pressure sensor (4-20mA scaled)"
VAR_GLOBAL, AO_Valve, INT,, D20, %MW20, "Valve position command (0-1000)"
```

**Rules:**
- Prefixes: `DI_` (digital input), `DO_` (digital output), `AI_` (analog input), `AO_` (analog output)
- Device column is **required**
- Address uses IEC format: `%IX0.0` for X0, `%QX0.0` for Y0, `%MW100` for D100

---

## GVL.csv Format

Columns: same as IO.csv.

```csv
"My Project"
Class, Label Name, Data Type, Constant, Device, Address, Comment
VAR_GLOBAL, g_xPumpStart, BOOL,, X0, %IX0.0, "Pump start command"
VAR_GLOBAL, g_iCycleCount, INT,, D100, %MW100, "Cycle counter"
VAR_GLOBAL, g_rTemperature, REAL,, D102, %MW102, "Current temperature"
VAR_GLOBAL, g_xAlarmActive, BOOL,, M100,, "Alarm active flag"
```

**Rules:**
- Prefix: `g_` for all global variables
- Addresses must be **sequential** (no gaps) when using D registers
- `REAL`/`DINT`/`DWORD` consume **2 consecutive D registers** — account for this in address assignment
- Bit devices (M) do not need an Address column value
- Device column is required for I/O-bound globals; optional for M-relay globals

---

## Local Variable CSV ({POU_Name}.csv)

Columns (simpler format for locals): `Class, Label Name, Data Type, Constant, Device, Address, Comment`

```csv
"My Project"
Class, Label Name, Data Type, Constant, Device, Address, Comment
VAR, iIndex, INT,,,, "Loop index"
VAR, rSetpoint, REAL,,,, "Target setpoint"
VAR, xDone, BOOL,,,, "Operation complete flag"
VAR, tDelay, TIME,,,, "Delay duration"
VAR_INPUT, iInputValue, INT,,,, "Raw input value"
VAR_OUTPUT, rScaledValue, REAL,,,, "Scaled output value"
```

**Rules:**
- `Class`: `VAR` for local, `VAR_INPUT` for inputs, `VAR_OUTPUT` for outputs
- Device and Address columns are **left empty** for local variables
- Hungarian prefixes recommended but not enforced for local variables

---

## Function Block CSV Pattern

FB requires two files with the same name:
- `{FBName}.st` — code only (no FB declaration, no VAR blocks)
- `{FBName}.csv` — local + input + output variables

**MotorControl.csv:**
```csv
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

**MotorControl.st:**
```pascal
(* Motor control with feedback monitoring *)
rtStart(CLK := xStart, Q := xRisingEdge);
// ... body uses VAR_INPUT, VAR_OUTPUT, and VAR names directly
```

---

## Function CSV Pattern

Same 2-file pattern. FUN has VAR_INPUT only — no VAR_OUTPUT (result is function return).

**ScaleValue.csv:**
```csv
"My Project"
Class, Label Name, Data Type, Constant, Device, Address, Comment
VAR_INPUT, iRawMin, INT,,,, "Raw minimum value"
VAR_INPUT, iRawMax, INT,,,, "Raw maximum value"
VAR_INPUT, rEngMin, REAL,,,, "Engineering minimum"
VAR_INPUT, rEngMax, REAL,,,, "Engineering maximum"
```

**ScaleValue.st:**
```pascal
(* Returns scaled REAL value *)
ScaleValue := INT_TO_REAL(iRaw) * rGain + rOffset;
```

---

## Program CSV Pattern

Programs follow the same 2-file rule: `{ProgramName}.st` + `{ProgramName}.csv`

**MAIN.csv:**
```csv
"My Project"
Class, Label Name, Data Type, Constant, Device, Address, Comment
VAR, iState, INT,,,, "Current state"
VAR, tonDelay, TON,,,, "On-delay timer instance"
VAR_OUTPUT, xMotor1, BOOL,,,, "Motor 1 output"
```

---

## Structure CSV

Structures are **not defined inline** (`TYPE ... END_TYPE`). Create an importable CSV file.

Columns: `Label Name, Data Type, Constant, Comment` — no `Class` column.

```csv
"My Project"
Label Name, Data Type, Constant, Comment
iID, INT,, "Recipe ID number"
sName, STRING,, "Recipe name"
rTargetTemp, REAL,, "Target temperature"
xEnabled, BOOL,, "Recipe enabled flag"
```

**Rules:**
- Structure name = CSV filename
- Members use Hungarian prefixes: `i` for INT, `x` for BOOL, etc.
- Cannot be nested (FX limitation)

---

## Variable Generation Rules Summary

| Variable Type     | File         | Prefix         | Device Column | Address Column |
|-------------------|--------------|----------------|---------------|----------------|
| Digital input     | IO.csv       | `DI_`          | Required      | Required       |
| Digital output    | IO.csv       | `DO_`          | Required      | Required       |
| Analog input      | IO.csv       | `AI_`          | Required      | Required       |
| Analog output     | IO.csv       | `AO_`          | Required      | Required       |
| HMI/exact-address | GVL.csv      | `g_`           | Required      | Required (D) / Optional (M) |
| Local variable    | {POU}.csv    | (free)         | Empty         | Empty          |
| FB input          | {FB}.csv     | (free)         | Empty         | Empty          |
| FB output         | {FB}.csv     | (free)         | Empty         | Empty          |
| FB local          | {FB}.csv     | (free)         | Empty         | Empty          |
| FUN input         | {FUN}.csv    | (free)         | Empty         | Empty          |

---

## FB/FUN/Timer/Counter Instances in CSV

When an ST code uses an FB instance (TON, CTU, R_TRIG, or user-defined FB), that instance must be declared as a VAR in the corresponding CSV:

```csv
VAR, tonDelay, TON,,,, "On-delay timer"
VAR, ctParts, CTU,,,, "Parts counter"
VAR, rtStart, R_TRIG,,,, "Rising edge detector"
VAR, fbMotor, MotorControl,,,, "Motor FB instance"
```

Without this declaration, the code will not compile in GX Works 2.

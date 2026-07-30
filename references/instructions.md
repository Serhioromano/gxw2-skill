# ST Instruction Set — GX Works 2 (FX Series)

Load when writing control flow, operators, or ST statements. This covers all ST language constructs available on FX series.

---

## Assignment

| Instruction      | Description                                      |
|------------------|--------------------------------------------------|
| `:=`             | Value assignment. **Used for ALL parameters including FB outputs.** |
| `SET device;`    | Set bit device/label to TRUE (latching)           |
| `RST device;`    | Reset bit device/label to FALSE                   |
| `PLS device;`    | Rising edge pulse on bit device (one scan)        |
| `PLF device;`    | Falling edge pulse on bit device (one scan)       |

---

## Selection

### IF Statement
```pascal
IF condition THEN
    // statements
ELSIF other_condition THEN
    // statements
ELSE
    // statements
END_IF;
```

### CASE Statement
```pascal
CASE IntVar OF
    0: // Init
        // statements
    10: // Reset
        // statements
    20: // Idle
        // statements
ELSE
        // statements
END_CASE;
```

**Restrictions:**
- Integer labels only — no named values, no ranges (`1..5`)
- Use comments to label states

---

## Iteration

### FOR Loop
```pascal
FOR i := start TO end BY step DO
    // statements
END_FOR;
```
- `BY step` is optional (defaults to 1)
- `FOR` loops in ST have no scan time watchdog. Keep loops short to avoid scan time overrun.

### WHILE Loop
```pascal
WHILE condition DO
    // statements
END_WHILE;
```

### REPEAT Loop
```pascal
REPEAT
    // statements
UNTIL condition;
END_REPEAT;
```

### EXIT
```pascal
EXIT;  // exits the innermost loop immediately
```

---

## Operators

| Category     | Operators                                |
|-------------|------------------------------------------|
| Arithmetic  | `+`, `-`, `*`, `/`, `MOD`               |
| Comparison  | `=`, `<>`, `<`, `>`, `<=`, `>=`          |
| Logical     | `NOT`, `AND`, `OR`, `XOR`                |

---

## WORD/DWORD Arithmetic Instructions

For WORD and DWORD types, use dedicated arithmetic instructions. These have 4 variants each.

| Base  | `_E` (triggered) | `P` (pulse) | `D` (32-bit) | `DP` (32-bit pulse) |
|-------|------------------|-------------|--------------|----------------------|
| `ADD` | `ADD_E`          | `ADDP`      | `DADD`       | `DADDP`              |
| `SUB` | `SUB_E`          | `SUBP`      | `DSUB`       | `DSUBP`              |
| `MUL` | `MUL_E`          | `MULP`      | `DMUL`       | `DMULP`              |
| `DIV` | `DIV_E`          | `DIVP`      | `DDIV`       | `DDIVP`              |

### Usage Examples
```pascal
(* Direct: wResult := wVal1 + wVal2 *)
ADD(wVal1, wVal2, wResult);

(* Triggered: only when xTrig is TRUE *)
ADD_E(xTrig, wVal1, wVal2, wResult);

(* Pulse: executes once on rising edge of xTrig *)
ADDP(xTrig, wVal1, wVal2, wResult);

(* 32-bit *)
DADD(dwVal1, dwVal2, dwResult);

(* 32-bit pulse *)
DADDP(xTrig, dwVal1, dwVal2, dwResult);
```

---

## Bit Shift Instructions (support `_E` and `D` prefix)

All bit shift instructions support `D` prefix for 32-bit (DWORD) operation.

| Function       | `_E` Variant                    | `D` (32-bit)              | Description                    |
|----------------|---------------------------------|---------------------------|--------------------------------|
| `SHL(IN, N)`   | `SHL_E(Trig, IN, N, Result)`    | `DSHL`, `DSHL_E`          | Shift left by N bits           |
| `SHR(IN, N)`   | `SHR_E(Trig, IN, N, Result)`    | `DSHR`, `DSHR_E`          | Shift right by N bits          |
| `ROL(IN, N)`   | `ROL_E(Trig, IN, N, Result)`    | `DROL`, `DROL_E`          | Rotate left by N bits          |
| `ROR(IN, N)`   | `ROR_E(Trig, IN, N, Result)`    | `DROR`, `DROR_E`          | Rotate right by N bits         |

### Usage Examples
```pascal
(* 16-bit *)
SHL(wVal, K4, wResult);                  // wResult := wVal shifted left 4
SHL_E(xTrig, wVal, K4, wResult);         // triggered

(* 32-bit *)
DSHL(dwVal, K8, dwResult);               // 32-bit shift left 8
DSHL_E(xTrig, dwVal, K8, dwResult);      // 32-bit triggered
```

---

## Edge Detection Instructions

| Instruction | Description                                                    |
|-------------|----------------------------------------------------------------|
| `MEP(IN)`   | Rising edge pulse. Returns TRUE for one scan on rising edge.   |
| `MEF(IN)`   | Falling edge pulse. Returns TRUE for one scan on falling edge. |

**These are preferred** over R_TRIG/F_TRIG FBs — no CSV declaration needed, inline usage:

```pascal
IF MEP(xStart) THEN
    iCount := iCount + 1;       // Increment once per rising edge
END_IF;

xPulse := MEP(xSensor);         // Use directly in assignment
```

---

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

---

## Hardware Timer Instructions

For direct hardware timer access without FB declaration:

```pascal
OUT_T(TRUE, TC1, K20);    // Start timer TC1: 20 × 100ms = 2s preset
```

- `TN1` — current timer value (elapsed, 100ms units)
- `TS1` — timer contact (TRUE when timer done)
- No CSV declaration needed for `OUT_T`, `TNx`, `TSx`

---

## Hardware Counter Instructions

### Counter Types and Ranges

| Type                                  | Range        | Points | Counting Range                |
|---------------------------------------|-------------|--------|-------------------------------|
| General up counter (16-bit)           | C0–C15      | 16     | 0 to 32,767                   |
| EEPROM hold up counter (16-bit)       | C16–C199    | 184    | 0 to 32,767                   |
| General bi-direction (32-bit)         | C200–C219   | 20     | -2,147,483,648 to +2,147,483,647 |
| EEPROM hold bi-direction (32-bit)     | C220–C234   | 15     | -2,147,483,648 to +2,147,483,647 |
| High-speed single-phase (32-bit, EEPROM hold) | C235–C245 | 11 | -2,147,483,648 to +2,147,483,647 |
| High-speed single-phase dual input (32-bit, EEPROM hold) | C246–C250 | 5 | -2,147,483,648 to +2,147,483,647 |
| High-speed dual-phase (32-bit, EEPROM hold) | C251–C255 | 5 | -2,147,483,648 to +2,147,483,647 |

**High-speed counter notes:** Single-phase up to 60kHz (6 channels max). Dual-phase: 1× frequency up to 30kHz (2–3 channels), 4× frequency up to 24kHz (2 channels). M8198 enables 4× for C251/C252; M8199 enables 4× for C253/C255.

### Instructions

```pascal
(* 16-bit counters (C0–C199) *)
OUT_C(TRUE, CC0, K200);       // Start 16-bit counter, preset 200

(* 32-bit counters (C200–C255) *)
OUT_C_32(TRUE, CC235, K200);  // Start 32-bit counter, preset 200

(* Reset *)
RST(TRUE, CC235);             // Reset counter to 0
```

- `CNx` — current counter value (e.g., `CN235`)
- `CSx` — counter contact, TRUE when count ≥ preset
- No CSV declaration needed for `OUT_C`, `OUT_C_32`, `CNx`, `CSx`
- `OUT_C` for 16-bit (C0–C199), `OUT_C_32` for 32-bit (C200–C255)

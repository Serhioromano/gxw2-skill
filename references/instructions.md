# ST Instruction Set — GX Works 2 (FX Series)

Load when writing control flow, operators, or ST statements. This covers all ST language constructs available on FX series.

---

## SET / RST

SET and RST replace the SR and RS function blocks (not available on FX series). Both accept two parameters: a condition and a destination bit device.

```iecst
(* SET: latches destination TRUE when condition is TRUE *)
(* Destination stays TRUE even after condition drops *)
SET(xAlarmCondition, Y0);        // Y0 latches ON when xAlarmCondition rises
SET(xStart, M100);               // M100 latches ON

(* RST: resets destination to FALSE when condition is TRUE *)
RST(xResetButton, Y0);           // Y0 cleared when xResetButton is TRUE
RST(xStop, M100);                // M100 cleared
```

**Key behavior:**
- When condition is TRUE, destination is set/reset **every scan** (not edge-triggered)
- If both SET and RST conditions are TRUE in the same scan, the **last one executed wins**
- SET has priority over OUT/`:=` assignment to the same device — a SET device cannot be cleared by `:= FALSE`
- No CSV declaration needed

---

## Selection

### SEL

Binary selection instruction. Returns one of two inputs based on a boolean selector.

```iecst
result := SEL(G, IN0, IN1);
(* If G is FALSE → returns IN0 *)
(* If G is TRUE  → returns IN1 *)
```

**Parameters:**

| Param | Type   | Description                        |
|-------|--------|------------------------------------|
| `G`   | BOOL   | Selector: FALSE → IN0, TRUE → IN1  |
| `IN0` | Any    | Value returned when G is FALSE     |
| `IN1` | Any    | Value returned when G is TRUE      |

**Examples:**

```iecst
iResult := SEL(xSelect, K10, K20);           // xSelect=FALSE → 10, TRUE → 20
rOut := SEL(xMode, rValA, rValB);            // Pick between two REAL values
wOut := SEL(xHiLo, wLowLimit, wHighLimit);   // Select WORD limit
```

**Restrictions:**
- IN0 and IN1 must be the same data type
- SEL is an expression (returns a value) — use in assignments, not as a standalone statement

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
```iecst
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

| Function            | `_E` Variant                    | `D` (32-bit)              | Description                    |
|---------------------|---------------------------------|---------------------------|--------------------------------|
| `SHL(IN, N, Result)`| `SHL_E(Trig, IN, N, Result)`    | `DSHL`, `DSHL_E`          | Shift left by N bits           |
| `SHR(IN, N, Result)`| `SHR_E(Trig, IN, N, Result)`    | `DSHR`, `DSHR_E`          | Shift right by N bits          |
| `ROL(IN, N, Result)`| `ROL_E(Trig, IN, N, Result)`    | `DROL`, `DROL_E`          | Rotate left by N bits          |
| `ROR(IN, N, Result)`| `ROR_E(Trig, IN, N, Result)`    | `DROR`, `DROR_E`          | Rotate right by N bits         |

### Usage Examples
```iecst
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

```iecst
IF MEP(xStart) THEN
    iCount := iCount + 1;       // Increment once per rising edge
END_IF;

xPulse := MEP(xSensor);         // Use directly in assignment
```

### PLS / PLF

PLS and PLF are edge-detection instructions that **write a one-scan pulse to a destination variable**. Unlike MEP/MEF (which return a boolean value for inline use), PLS/PLF set a specified bit device TRUE for one scan.

```iecst
(* PLS: sets dest TRUE for one scan on rising edge of condition *)
PLS(xStartButton, M50);          // M50 pulses ON for 1 scan when button pressed

(* PLF: sets dest TRUE for one scan on falling edge of condition *)
PLF(xStopButton, M51);           // M51 pulses ON for 1 scan when button released

(* Typical use: triggering actions on edge *)
IF MEP(xSensor) THEN             // Option A: inline with MEP
    iCount := iCount + 1;
END_IF;

PLS(xSensor, M60);               // Option B: PLS sets M60 for 1 scan
IF M60 THEN                       // ... then check M60 elsewhere
    iCount := iCount + 1;
END_IF;
```

**PLS vs MEP, PLF vs MEF:**
- `MEP(IN)` / `MEF(IN)` — return TRUE for one scan; ideal for inline use in IF/assignment
- `PLS(cond, dest)` / `PLF(cond, dest)` — set a destination bit TRUE for one scan; useful when the pulse needs to be referenced in multiple places or across POU boundaries
- No CSV declaration needed for PLS/PLF

---

## Hardware Timer Instructions

For direct hardware timer access without FB declaration:

```iecst
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

```iecst
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

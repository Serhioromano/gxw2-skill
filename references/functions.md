# Built-in FUN & FB Catalog — GX Works 2 (FX Series)

Load when using any built-in function, function block, timer, counter, or edge detector.

---

## Postfix Patterns

### `_E` Postfix (Triggered Execution)

Adds a BOOL trigger as the **first** parameter. Result moves to the **last** parameter. Applies to: conversions, math, selection, timer/counter/edge FBs, bit shifts. **String functions have limited `_E` support.**

| Aspect  | Without `_E`                     | With `_E`                                  |
|---------|----------------------------------|---------------------------------------------|
| Trigger | None (always executes)           | First parameter: `Trigger` (BOOL)           |
| Return  | Function returns value           | Last parameter: stores result              |
| Usage   | `rResult := MAXIMUM(rA, rB);`    | `MAXIMUM_E(xTrig, rA, rB, rResult);`       |

### `P` Postfix (Pulse / Rising-Edge Execution)

Attaches **directly without underscore**. Applies to: some arithmetic (ADD/SUB/MUL/DIV), string functions, SQRT, RND. First parameter is trigger.

| Aspect     | Without `P`               | With `P`                              |
|-----------|---------------------------|---------------------------------------|
| Execution  | Every scan                | Once on rising edge of first param    |
| Usage      | `sOut := LEFT(sIn, 5);`   | `LEFTP(xTrig, sIn, 5, sOut);`         |

### `D` Prefix (32-bit / Double-Word)

Upgrades operation from WORD/INT to DWORD/DINT. Applies to arithmetic and math functions.

| 16-bit | 32-bit |
|--------|--------|
| `ABS`  | `DABS` |
| `ADD`  | `DADD` |
| `SUB`  | `DSUB` |
| `MUL`  | `DMUL` |
| `DIV`  | `DDIV` |

Combined: `DABS_E` (32-bit + triggered), `DADDP` (32-bit + pulse), etc.

---

## Arithmetic & Math Functions

| Function   | Signature            | `_E`      | `P`      | `D` (32-bit)              | Notes                         |
|------------|---------------------|-----------|----------|---------------------------|-------------------------------|
| `ABS`      | `ABS(IN)`           | `ABS_E`   | —        | `DABS`, `DABS_E`          | Absolute value. D prefix for DINT. |
| `SQRT`     | `SQRT(IN)` — REAL   | —         | `SQRTP`  | —                         | Square root. REAL only — no D prefix. |
| `EXPT`     | `EXPT(Base, Exp)`   | `EXPT_E`  | —        | —                         | Base^Exp. REAL only — no D prefix. |
| `MOD`      | `MOD(IN1, IN2)`     | `MOD_E`   | —        | —                         | Modulo. INT only — no D prefix. |
| `RND`      | `RND(IN)` — REAL→INT| —         | `RNDP`   | —                         | Round. REAL→INT. **NOT `ROUND`.** No D prefix. |

> **NOT supported on FX series:** `LN`, `LOG`, `EXP`, `SIN`, `COS`, `TAN`, `ASIN`, `ACOS`, `ATAN`, `TRUNC`.

---

## Selection Functions

| Function      | Signature                                      | `_E`           |
|---------------|------------------------------------------------|----------------|
| `SEL`         | `SEL(G, IN0, IN1)` — G=FALSE→IN0, G=TRUE→IN1  | `SEL_E`        |
| `MAXIMUM`     | `MAXIMUM(IN1, IN2)` — max of two values           | `MAXIMUM_E` |
| `MINIMUM`     | `MINIMUM(IN1, IN2)` — min of two values           | `MINIMUM_E` |
| `LIMITATION`  | `LIMITATION(MIN, IN, MAX)` — clamp value       | `LIMITATION_E` |
| `MUX`         | `MUX(K, IN0, IN1, ...)` — select K-th (0-based)| `MUX_E`        |

> **Critical naming:** These are `MAXIMUM`, `MINIMUM`, `LIMITATION` — NOT `MAX`, `MIN`, `LIMIT` as in standard IEC 61131-3.

### Selection Examples
```iecst
(* Non-triggered *)
iResult := MAXIMUM(iA, iB);                 // max of two values
iResult := MINIMUM(iA, iB);                 // min of two values
iResult := LIMITATION(iMin, iInput, iMax);  // clamp
iResult := SEL(xSelect, iVal0, iVal1);
iResult := MUX(iChoice, iOpt0, iOpt1, iOpt2, iOpt3);

(* Triggered *)
MAXIMUM_E(xTrig, iA, iB, iResult);
MINIMUM_E(xTrig, iA, iB, iResult);
LIMITATION_E(xTrig, iMin, iInput, iMax, iResult);
SEL_E(xTrig, xSelect, iVal0, iVal1, iResult);
MUX_E(xTrig, iChoice, iOpt0, iOpt1, iOpt2, iResult);
```

---

## Timer Function Blocks & Instructions

### IEC Timer FBs (TON/TOF/TP)

All timer FBs support `_E`. **Must be declared as VAR in CSV before use.**

| FB   | `_E` Variant | Description                                                    |
|------|-------------|----------------------------------------------------------------|
| `TON`| `TON_E`     | On-delay. IN: trigger, PT: preset TIME, Q: output, ET: elapsed |
| `TOF`| `TOF_E`     | Off-delay. Parameters same as TON                              |
| `TP` | `TP_E`      | Pulse (fixed-width). Parameters same as TON                    |

**GX Works 2 uses `:=` for ALL parameters, including outputs:**
```iecst
(* Declare in CSV: VAR, tonDelay, TON *)
tonDelay(IN := xStart, PT := T#5s, Q := xDone, ET := tElapsed);

(* _E variant: first param is trigger *)
TON_E(xEnable, xStart, T#5s, xDone, tElapsed);
```

### Hardware Timer (OUT_T)

See `instructions.md` — Hardware Timer Instructions. Direct hardware timer access, no CSV declaration needed.

---

## Counter Function Blocks & Instructions

### IEC Counter FBs (CTU/CTD/CTUD)

All counter FBs support `_E`. **Must be declared as VAR in CSV before use.**

| FB    | `_E` Variant | Description                                                       |
|-------|-------------|-------------------------------------------------------------------|
| `CTU` | `CTU_E`     | Count-up. CU: pulse, RESET: reset, PV: preset, Q: output, CV: current |
| `CTD` | `CTD_E`     | Count-down. CD: pulse, LOAD: load preset, PV: preset, Q: output, CV: current |
| `CTUD`| `CTUD_E`    | Up-down. CU/CD: pulses, RESET/LOAD, PV: preset, QU/QD: outputs, CV: current |

Usage (all parameters use `:=`):
```iecst
(* Declare in CSV: VAR, ctParts, CTU *)
ctParts(CU := xPulse, RESET := xReset, PV := K100, Q := xFull, CV := iCount);

(* _E variant *)
CTU_E(xEnable, xPulse, xReset, K100, xFull, iCount);
```

### Hardware Counter (OUT_C / OUT_C_32)

See `instructions.md` — Hardware Counter Instructions. Direct hardware counter access with full counter type/range table. No CSV declaration needed.

---

## Edge Detection FBs & Instructions

### IEC Edge Detection FBs (R_TRIG / F_TRIG)

Support `_E`. **Must be declared as VAR in CSV before use.**

| FB       | `_E` Variant  | Signature                                                      |
|----------|--------------|----------------------------------------------------------------|
| `R_TRIG` | `R_TRIG_E`   | Rising edge. CLK: input, Q: one-scan pulse on rising edge      |
| `F_TRIG` | `F_TRIG_E`   | Falling edge. CLK: input, Q: one-scan pulse on falling edge    |

```iecst
(* Declare in CSV: VAR, rtStart, R_TRIG *)
rtStart(CLK := xSignal, Q := xRisingEdge);

(* _E variant *)
R_TRIG_E(xEnable, xSignal, xRisingEdge);
```

### Edge Detection Instructions (MEP / MEF)

See `instructions.md` — Edge Detection Instructions. Preferred over R_TRIG/F_TRIG: no CSV declaration, work inline.

---

## String Functions

> String functions have **mixed** postfix support. `_E` only on INSERT, DELETE, REPLACE, FIND. `P` only on LEN, LEFT, RIGHT, MID, CONCAT.

| Function   | Signature                    | `P` variant | `_E` variant  | Notes                        |
|------------|------------------------------|-------------|---------------|------------------------------|
| `LEN`      | `LEN(IN)` — string length    | `LENP`      | —             | Returns INT                  |
| `LEFT`     | `LEFT(IN, L)` — L left chars | `LEFTP`     | —             |                              |
| `RIGHT`    | `RIGHT(IN, L)` — L right chars| `RIGHTP`   | —             |                              |
| `MID`      | `MID(IN, L, P)` — L chars at P| `MIDP`     | —             | P is 1-based position        |
| `CONCAT`   | `CONCAT(IN1, IN2)`           | `CONCATP`   | —             | Concatenate two strings      |
| `INSERT`   | `INSERT(IN1, IN2, P)`        | —           | `INSERT_E`    | Insert IN2 into IN1 at pos P |
| `DELETE`   | `DELETE(IN, L, P)`           | —           | `DELETE_E`    | Delete L chars at position P |
| `REPLACE`  | `REPLACE(IN1, IN2, L, P)`    | —           | `REPLACE_E`   | Replace L chars at P         |
| `FIND`     | `FIND(IN1, IN2)`             | —           | `FIND_E`      | Returns position (0 = not found) |

### P Variant (Pulse) Examples
```iecst
LENP(xTrig, sIn, iLength);           // iLength := LEN(sIn) on rising edge
LEFTP(xTrig, sIn, 5, sOut);          // sOut := LEFT(sIn, 5) on rising edge
RIGHTP(xTrig, sIn, 3, sOut);         // sOut := RIGHT(sIn, 3)
MIDP(xTrig, sIn, 4, 2, sOut);        // sOut := MID(sIn, 4, 2)
CONCATP(xTrig, sFirst, sLast, sFull);// sFull := CONCAT(sFirst, sLast)
```

### `_E` Variant (Triggered) Examples
```iecst
INSERT_E(xTrig, sBase, sInsert, 3, sResult);
DELETE_E(xTrig, sBase, 5, 2, sResult);
REPLACE_E(xTrig, sBase, sNew, 4, 3, sResult);
FIND_E(xTrig, sBase, sSearch, iPosition);
```

---

## User-Defined Function Blocks (FB)

**Rule: No declaration in code.** Two files, same name:
- `{Name}.csv` — variables (VAR_INPUT, VAR_OUTPUT, VAR)
- `{Name}.st` — code body only

**All parameters use `:=` — including outputs.**

Inside FB code:
```iecst
xMotor := xStart AND NOT xStop AND NOT xFault;
```

Calling (outputs also use `:=`):
```iecst
fbMotor(xStart := DI_Start, xStop := DI_Stop, xFeedback := DI_Feedback,
        xMotor := DO_Pump, xFault := g_xMotorFault);
```

---

## User-Defined Functions (FUN)

**Functions are called directly — no instance declaration needed in CSV.** Unlike FBs, you do not need a VAR entry to use a FUN. Just call it by name.

FUN has VAR_INPUT only (no VAR_OUTPUT). Return via function result:

```iecst
(* Inside ScaleValue.st *)
ScaleValue := INT_TO_REAL(iRaw) * rGain + rOffset;
```

Calling — no CSV declaration required:
```iecst
rResult := ScaleValue(iRaw := g_iRawValue, rGain := rGain, rOffset := rOffset);
```

---

## Quick Reference: What Needs CSV Declaration

| Category                    | CSV Declaration Required? |
|-----------------------------|---------------------------|
| `TON`, `TOF`, `TP`          | Yes — VAR declaration     |
| `CTU`, `CTD`, `CTUD`        | Yes — VAR declaration     |
| `R_TRIG`, `F_TRIG`          | Yes — VAR declaration     |
| User-defined FB             | Yes — VAR declaration     |
| User-defined FUN            | **No** — called directly  |
| `MEP`, `MEF`                | **No** — inline only      |
| `OUT_T`, `OUT_C`            | **No** — direct hardware  |
| `SET`, `RST`, `PLS`, `PLF`  | **No** — direct instructions |

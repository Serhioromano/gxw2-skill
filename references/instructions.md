# ST Instruction Set — GX Works 2 (FX Series)

Load when writing control flow, operators, or ST statements. This covers all ST language constructs available on FX series.

> For the **complete catalog** of all 180+ GX Works 2 instructions (including ladder-only),
> see [instruction-db.md](instruction-db.md).

---

## Common ST Instructions (Quick Reference)

Most-used instructions in everyday ST programming. Each has `_E` (triggered), `P` (pulse), and/or `D` (32-bit) variants.

| Instruction | Description | Quick Example |
|-------------|-------------|---------------|
| `SET(EN, Dev)` | Latch bit ON | `SET(xAlarm, Y0);` |
| `RST(EN, Dev)` | Reset bit OFF | `RST(xReset, Y0);` |
| `PLS(EN, Dev)` | One-scan pulse on rising edge | `PLS(xTrig, M50);` |
| `PLF(EN, Dev)` | One-scan pulse on falling edge | `PLF(xTrig, M51);` |
| `MEP(IN)` | Rising edge detect (inline, returns BOOL) | `IF MEP(xStart) THEN ...` |
| `MEF(IN)` | Falling edge detect (inline, returns BOOL) | `xPulse := MEF(xStop);` |
| `MOV(EN, S, D)` | Move value | `MOV(TRUE, K100, wOut);` |
| `INC(EN, D)` | Increment by 1 | `INC(TRUE, iCount);` |
| `DEC(EN, D)` | Decrement by 1 | `DEC(TRUE, iCount);` |
| `CMP(EN, S1, S2, D)` | Compare, result bits in D | `CMP(TRUE, wVal, K100, M0);` |
| `ZCP(EN, Lo, Hi, S, D)` | Zone compare | `ZCP(TRUE, K0, K100, wVal, M10);` |
| `WAND(EN, S1, S2, D)` | Word bitwise AND | `WAND(TRUE, wIn, H00FF, wOut);` |
| `WOR(EN, S1, S2, D)` | Word bitwise OR | `WOR(TRUE, wIn, HFF00, wOut);` |
| `WXOR(EN, S1, S2, D)` | Word bitwise XOR | `WXOR(TRUE, wIn, HFFFF, wOut);` |
| `NEG(EN, D)` | Two's complement negation | `NEG(TRUE, iVal);` |
| `BON(EN, S, N, D)` | Test bit N of S → D | `BON(TRUE, wStatus, K3, M20);` |
| `SWAP(EN, D)` | Swap high/low byte | `SWAP(TRUE, wData);` |
| `BCD(EN, S, D)` | Binary → BCD | `BCD(TRUE, iVal, wBcd);` |
| `BIN(EN, S, D)` | BCD → Binary | `BIN(TRUE, wBcd, iVal);` |
| `DECO(EN, S, D, N)` | Decode N bits of S → bit in D | `DECO(TRUE, iStep, M0, K3);` |
| `ENCO(EN, S, D, N)` | Encode bit position of S → D | `ENCO(TRUE, M0, iPos, K3);` |
| `OUT_T(EN, TCx, Preset)` | Hardware timer start | `OUT_T(TRUE, TC1, K20);` |
| `OUT_C(EN, CCx, Preset)` | Hardware counter (16-bit) | `OUT_C(TRUE, CC0, K200);` |
| `OUT_C_32(EN, CCx, Preset)` | Hardware counter (32-bit) | `OUT_C_32(TRUE, CC235, K200);` |
| `wResult := SHL(IN, N)` | Shift left by N bits (returns) | `wResult := SHL(wVal, K4);` |
| `wResult := SHR(IN, N)` | Shift right by N bits (returns) | `wResult := SHR(wVal, K4);` |
| `EI` | Enable interrupts | `EI;` |
| `DI` | Disable interrupts | `DI;` |
| `WDT` | Reset watchdog timer | `WDT;` |

---

## SET / RST

SET and RST replace the SR and RS function blocks (not available on FX series). Both accept an enable (`EN`) as the first parameter and a destination bit device as the second.

```iecst
(* SET: latches destination TRUE when EN is TRUE *)
(* Destination stays TRUE even after EN drops *)
SET(xAlarmCondition, Y0);        // Y0 latches ON when xAlarmCondition rises
SET(xStart, M100);               // M100 latches ON

(* RST: resets destination to FALSE when EN is TRUE *)
RST(xResetButton, Y0);           // Y0 cleared when xResetButton is TRUE
RST(xStop, M100);                // M100 cleared
```

**Key behavior:**
- When EN is TRUE, destination is set/reset **every scan** (not edge-triggered)
- If both SET and RST EN are TRUE in the same scan, the **last one executed wins**
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
(* Direct (unconditional): EN = TRUE *)
ADD(TRUE, wVal1, wVal2, wResult);

(* Triggered: only when xTrig is TRUE *)
ADD_E(xTrig, wVal1, wVal2, wResult);

(* Pulse: executes once on rising edge of xTrig *)
ADDP(xTrig, wVal1, wVal2, wResult);

(* 32-bit *)
DADD(TRUE, dwVal1, dwVal2, dwResult);

(* 32-bit pulse *)
DADDP(xTrig, dwVal1, dwVal2, dwResult);
```

---

## Bit Shift Instructions (support `_E` and `D` prefix)

All bit shift instructions support `D` prefix for 32-bit (DWORD) operation.

**Without `_E`: returns a value (function-style). With `_E`: triggered, stores in last parameter.**

| Function            | `_E` Variant                       | `D` (32-bit)              | Description                    |
|---------------------|------------------------------------|---------------------------|--------------------------------|
| `SHL(IN, N)`        | `SHL_E(EN, IN, N, Result)`         | `DSHL`, `DSHL_E`          | Shift left by N bits           |
| `SHR(IN, N)`        | `SHR_E(EN, IN, N, Result)`         | `DSHR`, `DSHR_E`          | Shift right by N bits          |
| `ROL(IN, N)`        | `ROL_E(EN, IN, N, Result)`         | `DROL`, `DROL_E`          | Rotate left by N bits          |
| `ROR(IN, N)`        | `ROR_E(EN, IN, N, Result)`         | `DROR`, `DROR_E`          | Rotate right by N bits         |

### Usage Examples
```iecst
(* 16-bit — returns value *)
wResult := SHL(wVal, K4);                // wResult := wVal shifted left 4
wResult := SHR(wVal, K4);                // wResult := wVal shifted right 4
wResult := ROL(wVal, K4);                // wResult := wVal rotated left 4
wResult := ROR(wVal, K4);                // wResult := wVal rotated right 4

(* 16-bit triggered — stores in last parameter *)
SHL_E(xTrig, wVal, K4, wResult);         // triggered shift left
SHR_E(xTrig, wVal, K4, wResult);         // triggered shift right

(* 32-bit *)
dwResult := DSHL(dwVal, K8);             // 32-bit shift left 8
dwResult := DSHR(dwVal, K8);             // 32-bit shift right 8
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
(* PLS: sets dest TRUE for one scan on rising edge of EN *)
PLS(xStartButton, M50);          // M50 pulses ON for 1 scan when button pressed

(* PLF: sets dest TRUE for one scan on falling edge of EN *)
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
- `PLS(EN, dest)` / `PLF(EN, dest)` — set a destination bit TRUE for one scan; useful when the pulse needs to be referenced in multiple places or across POU boundaries
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

---

## Data Move — MOV

Transfers data from source to destination. Supports `P` (pulse) and `D` (32-bit) variants.

```iecst
(* MOV(EN, S, D) — EN is always the first parameter *)

(* Unconditional: use TRUE as EN *)
MOV(TRUE, K100, wOut);          // wOut := 100 (always executes)
MOV(TRUE, wInput, D200);        // D200 := wInput (always executes)

(* Conditional: EN controls execution *)
MOV(xEnable, K100, wOut);       // Execute only when xEnable is TRUE
MOV(M8002, K500, D500);         // Execute on first scan only

(* Variants *)
MOVP(xTrig, K100, wOut);        // Pulse: one-shot on rising edge of xTrig
DMOV(TRUE, diSrc, diDst);       // 32-bit: DINT/DWORD, unconditional
DMOVP(xTrig, diSrc, diDst);     // 32-bit pulse
```

`MOV_E` not available; use `MOV(EN, S, D)` with a BOOL EN. For block/fill operations, use `BMOV` (copy N words) or `FMOV` (fill N words with same value).

---

## Comparison — CMP / ZCP

Compare two values or check if a value falls within a zone. Results written to 3 consecutive bit devices starting from the destination.

```iecst
(* CMP: compare S1 vs S2, results in D..D+2 *)
(* D+0: ON when S1 > S2   *)
(* D+1: ON when S1 = S2   *)
(* D+2: ON when S1 < S2   *)
CMP(EN, S1, S2, D);

CMP(TRUE, wValue, K100, M0);
// M0: wValue > 100
// M1: wValue = 100
// M2: wValue < 100

IF M0 THEN xHigh := TRUE; END_IF;

(* ZCP: zone compare S vs [Lower, Upper], results in D..D+2 *)
(* D+0: ON when S < Lower  *)
(* D+1: ON when Lower ≤ S ≤ Upper *)
(* D+2: ON when S > Upper  *)
ZCP(EN, Lower, Upper, S, D);

ZCP(TRUE, K0, K100, wTemp, M10);
// M10: wTemp < 0
// M11: 0 ≤ wTemp ≤ 100
// M12: wTemp > 100
```

| Variant | Example |
|---------|---------|
| 32-bit | `DCMP(TRUE, diVal, K1000, M0)` |
| 32-bit+pulse | `DCMPP(xTrig, diVal, K1000, M0)` |
| Floating | `ECMP(TRUE, rVal, E50.0, M0)`, `EZCP(TRUE, E0.0, E100.0, rVal, M10)` |

> In ST, native `IF` with `=`, `<`, `>`, `<=`, `>=`, `<>` is usually cleaner. Use CMP/ZCP when you need all three comparison results simultaneously.

---

## Increment / Decrement — INC / DEC

Add or subtract 1 from a value in-place. Supports `P` (pulse) and `D` (32-bit) variants.

```iecst
INC(EN, D);     // D := D + 1 (16-bit), EN enables execution
DEC(EN, D);     // D := D - 1 (16-bit), EN enables execution

INC(TRUE, iCount);             // iCount := iCount + 1 (always)
INC(xTrig, iCount);            // iCount := iCount + 1 when xTrig TRUE
DEC(TRUE, wRemaining);         // wRemaining := wRemaining - 1 (always)

(* Variants *)
INCP(xTrig, iCount);     // Pulse: one-shot
DINC(TRUE, diPosition);  // 32-bit increment
DINCP(xTrig, diPosition);
DDEC(TRUE, diTotal);     // 32-bit decrement
```

No `_E` variant. No CSV declaration needed.

---

## Word Logic — WAND / WOR / WXOR

Bitwise logic operations on 16-bit WORD values. Required because ST logical operators (`AND`, `OR`, `XOR`) work on BOOL only.

```iecst
WAND(EN, S1, S2, D);     // D := S1 AND S2 (bitwise)
WOR(EN, S1, S2, D);      // D := S1 OR S2  (bitwise)
WXOR(EN, S1, S2, D);     // D := S1 XOR S2 (bitwise)

(* Bit masking examples *)
WAND(TRUE, wStatus, H00FF, wLowByte);    // Extract lower 8 bits
WXOR(TRUE, wFlags, HFFFF, wInverted);    // Invert all 16 bits
WOR(TRUE, wOutput, H0001, wOutput);      // Set bit 0 without affecting others

(* Variants *)
WANDP(xTrig, wA, wB, wResult);     // Pulse
DAND(TRUE, dwA, dwB, dwResult);    // 32-bit
DANDP(xTrig, dwA, dwB, dwResult);  // 32-bit pulse
```

| Base   | `P`      | `D` (32-bit) | `DP` (32-bit pulse) |
|--------|----------|--------------|----------------------|
| `WAND` | `WANDP`  | `DAND`       | `DANDP`              |
| `WOR`  | `WORP`   | `DOR`        | `DORP`               |
| `WXOR` | `WXORP`  | `DXOR`       | `DXORP`              |

> No `WNEG` (word negate). Use `WXOR(wVal, HFFFF, wResult)` for bitwise NOT.

---

## Negation — NEG

Two's complement: `D := 0 − D`. Supports `P` (pulse) and `D` (32-bit) variants.

```iecst
NEG(EN, D);              // D := -D (EN enables execution)

NEG(TRUE, iVal);               // iVal := -iVal (always)
NEGP(xTrig, iVal);             // Pulse
DNEG(TRUE, diVal);             // 32-bit

(* Floating point negation *)
ENEG(TRUE, rVal);              // rVal := -rVal
```

> In ST, `iVal := -iVal;` is equivalent and preferred for INT/DINT. Use `NEG` when pulse execution is needed (`NEGP`).

---

## Bit Test — BON

Check if bit N of source is ON/OFF, result written to destination bit.

```iecst
BON(EN, S, N, D);     // D := (bit N of S) ? TRUE : FALSE

BON(TRUE, wStatus, K3, M20);     // M20 := bit 3 of wStatus
BON(TRUE, dwEncoder, K15, xBit15);

(* Variants *)
BON_E(xTrig, wStatus, K3, M20);   // Triggered
BONP(xTrig, wStatus, K3, M20);    // Pulse
DBON(TRUE, dwVal, K31, xBit31);   // 32-bit
```

> In ST, `xResult := (wVal AND H0008) <> WORD#0;` is equivalent for simple bit tests. Use BON when pulse/triggered execution is needed.

---

## Byte Swap — SWAP

Swaps high and low byte of a 16-bit word. Supports `P` (pulse) and `D` (32-bit) variants.

```iecst
SWAP(EN, D);             // Swap bytes when EN is TRUE

SWAP(TRUE, wData);             // Swap bytes: 0xAABB → 0xBBAA (always)
SWAPP(xTrig, wData);           // Pulse
DSWAP(TRUE, dwData);           // 32-bit (swaps high/low word)
```

Common uses: endianness conversion for communication protocols, rearranging data from network byte order.

---

## BCD / BIN Conversion

Convert between binary and BCD (Binary Coded Decimal) representations.

```iecst
BCD(EN, S, D);    // Binary → BCD (e.g., 123 → H0123)
BIN(EN, S, D);    // BCD → Binary (e.g., H0123 → 123)

BCD(TRUE, iCount, wBcdOut);     // wBcdOut := BCD of iCount
BIN(TRUE, wBcdIn, iResult);     // iResult := decimal value of BCD

(* Variants *)
BCDP(xTrig, iCount, wBcdOut);  // Pulse
DBCD(TRUE, diCount, dwBcdOut); // 32-bit BCD
DBIN(TRUE, dwBcdIn, diResult); // 32-bit BIN
```

> BCD is used for thumbwheel switches, 7-segment displays, and legacy devices. For ST with no BCD peripherals, prefer `INT_TO_BCD`/`BCD_TO_INT` function blocks or keep values in native binary.

---

## Decode / Encode — DECO / ENCO

Decode an integer to a single bit position, or encode a bit position to an integer.

```iecst
(* DECO: decode N bits of S → set a single bit in D *)
(* D is a bit device (M, Y). D is set at position = value of S *)
DECO(EN, S, D, N);

DECO(TRUE, iStep, M0, K3);     // If iStep=5 → M5 ON, others OFF (3 bits → 0–7)

(* ENCO: encode bit position of S → D (N bits) *)
(* S is a bit device, D is a word device *)
ENCO(EN, S, D, N);

ENCO(TRUE, M0, iPos, K3);      // If M5 is ON → iPos := 5 (2^N bits of S encoded)
```

| Param | DECO | ENCO |
|-------|------|------|
| S | Word: integer value | Bit device start: bit group to scan |
| D | Bit device: destination bit | Word: result integer |
| N | Number of bits to decode (1–8) | Number of bits to encode (1–8, 2^N bits scanned) |

> N=3 → 8 values (0–7), N=4 → 16 values (0–15), etc. `DECOP`/`ENCOP` for pulse.

---

## Bit Shift Register — SFTR / SFTL

Multi-word shift register. Shifts N bits across a range of consecutive word devices.

```iecst
(* SFTR: shift right through N words, shift-in bit from S *)
SFTR(EN, S, D, N1, N2);
(* EN: enable execution
   S: shift-in data source (bit device)
   D: head of shift register (bit device)
   N1: length of shift register (words)
   N2: number of bits to shift *)

SFTR(TRUE, xNewBit, M0, K4, K1); // Shift M0–M63 right by 1, xNewBit → M0

(* SFTL: shift left *)
SFTL(TRUE, xNewBit, M0, K4, K1); // Shift M0–M63 left by 1, xNewBit → M63
```

| Variant | Description |
|---------|-------------|
| `SFTRP` / `SFTLP` | Pulse execution |
| `WSFR` / `WSFL` | Word shift register (shifts whole words, not bits) |

> For simple bit shifts on a single WORD, use `SHL`/`SHR`. Use `SFTR`/`SFTL` for tracking sequences (conveyor tracking, FIFO history).

---

## Interrupt Control — EI / DI

Enable or disable hardware interrupts.

```iecst
EI;    // Enable interrupts (after DI)
DI;    // Disable interrupts (globally)

(* Typical usage pattern *)
DI;
// ... critical section (cannot be interrupted) ...
EI;
```

- Standalone statements — no parameters, no CSV declaration
- `DI` disables all external interrupts until `EI` is executed
- Interrupt POUs must end with `IRET;` (returns to main program)
- Does NOT disable the scan watchdog timer

---

## Watchdog Timer — WDT

Resets the scan watchdog timer to prevent a watchdog timeout during long operations.

```iecst
WDT;         // Reset watchdog timer
WDTP;        // Pulse (one-shot on rising edge of implicit trigger)

(* Typical use: inside long loops *)
FOR i := 0 TO 10000 DO
    // ... lengthy operation ...
    IF (i MOD 100) = 0 THEN
        WDT;  // Reset WDT every 100 iterations
    END_IF;
END_FOR;
```

- `WDT` is a standalone statement (no parameters)
- `WDTP` is the pulse variant — use when called conditionally
- Default scan watchdog: 200ms. Extended by `WDT` to 200ms from the point of execution
- No CSV declaration needed

---

## FOR / NEXT

Loop construct (IEC syntax) for repeating a block. See [common-rules.md](common-rules.md) for the full pattern.

```iecst
FOR iVar := Start TO End BY Step DO
    // statements
END_FOR;
```

- `BY Step` is optional (defaults to 1)
- `EXIT;` exits the innermost loop immediately
- Keep loops short to avoid scan time overrun — use `WDT` inside long loops
- `CONTINUE` is **not available** on FX series — restructure with `IF/ELSE`

# Function Blocks (Standard Function Blocks)

Function blocks from the [Application Functions] manual (doc2), section **14**. Three groups: edge triggers, counters, timers.

> FBs are used **only via an instance declared in the variable editor (CSV VAR)** — there is no direct/positional call form, and no `_E` variants exist for these FBs. GX Works 2 uses `:=` for **all** parameters, including outputs. The `_E` postfix (callable without declaration) applies to functions/instructions only, **not** to these FBs.

## Group 1 — Edge Triggers: R_TRIG, F_TRIG

| FB | Operation |
|----|-----------|
| `R_TRIG` | Rising edge: Q = one-scan pulse on rising edge of CLK |
| `F_TRIG` | Falling edge: Q = one-scan pulse on falling edge of CLK |

```iecst
(* Declare in CSV: VAR, rtStart, R_TRIG *)
rtStart(CLK := xSignal, Q := xRisingEdge);
```

- `CLK`: Input signal [Bit]
- `Q`: One-scan pulse output [Bit]

Support: FX3U ✓, FX3G ✓.

> Prefer `MEP`/`MEF` instructions — no CSV declaration, work inline (see [00_Instruction_List.md](00_Instruction_List.md)).

## Group 2 — Counters: CTU, CTD, CTUD

| FB | Operation |
|----|-----------|
| `CTU`  | Count-up: Q = ON when CV reaches PV; RESET clears CV |
| `CTD`  | Count-down: Q = ON when CV reaches 0; LOAD reloads PV |
| `CTUD` | Up/down: CU increments, CD decrements; QU/QD outputs, RESET/LOAD |

```iecst
(* Declare in CSV: VAR, ctParts, CTU *)
ctParts(CU := xPulse, RESET := xReset, PV := K100, Q := xFull, CV := iCount);

(* CTD: CD, LOAD, PV, Q, CV *)
ctDown(CD := xPulse, LOAD := xLoad, PV := K100, Q := xEmpty, CV := iCount);

(* CTUD: CU, CD, RESET, LOAD, PV, QU, QD, CV *)
ctUpDown(CU := xUp, CD := xDown, RESET := xReset, LOAD := xLoad,
         PV := K100, QU := xHigh, QD := xLow, CV := iCount);
```

- `CU`/`CD`: Count up/down pulse [Bit]
- `RESET`/`LOAD`: Reset / load preset [Bit]
- `PV`: Preset value [ANY_INT]
- `Q`/`QU`/`QD`: Output signals [Bit]
- `CV`: Current count value [ANY_INT]

Support: FX3U ✓, FX3G ✓.

### Hardware Counters (OUT_C / OUT_C_32)

Direct hardware counter access, **no CSV declaration needed** — the alternative to IEC counter FBs when you want a hardware counter device. Instruction syntax, operands, examples, device ranges and the full counter type table — see [OUT_C.md](OUT_C.md).

## Group 3 — Timers: TON, TOF, TP

| FB | Operation |
|----|-----------|
| `TON` | On-delay: Q turns ON `PT` after IN turns ON |
| `TOF` | Off-delay: Q turns OFF `PT` after IN turns OFF |
| `TP`  | Pulse: Q stays ON for `PT` after IN rising edge |

`_10` variants (`TON_10`, `TOF_10`, `TP_10`) allow `PT` in 10 ms units instead of 100 ms.

```iecst
(* Declare in CSV: VAR, tonDelay, TON *)
tonDelay(IN := xStart, PT := T#5s, Q := xDone, ET := tElapsed);
```

- `IN`: Input signal [Bit]
- `PT`: Preset time [Time]
- `Q`: Output signal [Bit]
- `ET`: Elapsed time [Time]

Support: FX3U ✓, FX3G ✓.

### Hardware Timers (OUT_T)

Direct hardware timer access, **no CSV declaration needed** — the alternative to IEC timer FBs when you want a hardware timer device. Instruction syntax, operands and examples — see [OUT_T.md](OUT_T.md).

**Timer types and ranges (FX3U):**

| Type | Range | Points | Timing Range |
|------|-------|--------|--------------|
| ON delay timer (100ms) | T0–T199 | 200 | 0.1 to 3,276.7s |
| ON delay timer (10ms) | T200–T245 | 46 | 0.01 to 327.67s |
| Accumulative (EEPROM hold, 1ms) | T246–T249 | 4 | 0.001 to 32.767s |
| Accumulative (EEPROM hold, 100ms) | T250–T255 | 6 | 0.1 to 3,276.7s |
| ON delay timer (1ms) | T256–T319 | 64 | 0.001 to 32.767s |

> Accumulative timers (T246–T255) hold elapsed time across power cycles (EEPROM hold). `OUT_T` uses 100ms units for the preset; `T256–T319` (1ms) are for high-resolution timing.

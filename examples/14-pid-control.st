(*
  Program: PID Control (14-pid-control)
  Purpose: Demonstrates PID instruction (FNC 88) for GX Works 2 FX series.
           Covers parameter table setup (D500–D528), autotune mode selection
           (Step Response / Limit Cycle), and runtime PID loop execution.

  Parameter table: D500–D528 (29 consecutive registers)
    +0  D500  Sampling time Ts (ms)
    +1  D501  ACT — action / autotune bit field
    +2  D502  Input filter α (%)
    +3  D503  Proportional gain Kp (%)
    +4  D504  Integral time Ti (×100ms)
    +5  D505  Derivative gain Kd (%)
    +6  D506  Derivative time Td (×10ms)
    +7  D507  SCAN — autotune operation cycle (ms)
    +8..+19  D508–D519  Internal work area (PID manages these)
    +20 D520  Input variation alarm — incremental
    +21 D521  Input variation alarm — decremental
    +22 D522  Output upper limit (100.0%) / output var alarm (inc)
    +23 D523  Output lower limit (0.0%) / output var alarm (dec)
    +24 D524  Alarm output bit flags (read-only)
    +25 D525  SHPV — PV hysteresis width (limit cycle only)
    +26 D526  ULV  — output upper limit (limit cycle only)
    +27 D527  LLV  — output lower limit (limit cycle only)
    +28 D528  KW   — wait after tuning before PID start (%)

  D501 ACT bit field (16-bit):
    b0  Operation direction: 0=forward (cooling), 1=reverse (heating)
    b1  Input variation alarm enable (expands table to +20..+24)
    b2  0=output limit mode, 1=output variation alarm mode
    b3  2-degree-of-freedom PID (not used in this example)
    b4  Autotune enable (cleared automatically when tuning completes)
    b5  Step Response autotune method (valid when b4=1)
    b6  Limit Cycle autotune method (valid when b4=1)
    b7–b15  Reserved (must be 0)

  Global signals required (add to GVL.csv):
    g_xAutoMode   — BOOL, M2   — PID auto mode active (uses existing)
    g_xPIDAT      — BOOL, M20  — Rising edge → trigger autotune
    g_xPIDATMode  — BOOL, M21  — FALSE=Step Response, TRUE=Limit Cycle
    g_iSetpoint   — INT,  D110 — Target setpoint (0–4000)
    g_iPIDOutput  — INT,  D200 — PID computed output (MV)

  I/O signals used (from IO.csv):
    AI_Pressure   — INT,  D10  — Process value (4–20mA scaled 0–1000)
    AO_SpeedRef   — INT,  D20  — PID output → actuator (0–1000)

  Critical:
    - PID parameter table must occupy 29 consecutive, undisturbed D registers.
    - No other logic may write to D500–D528 while PID is active.
    - Autotune completion: PID clears D501 bit 4 automatically.
      If (D501 AND 2#0000_0000_0001_0000) = 0 after a scan, autotune finished.
    - Sampling time (D500) must be ≥ 1 scan time.
    - ACT bit 2 determines whether +22/+23 are limit values (b2=0)
      or alarm values (b2=1). This example uses b2=0 → limit mode.
*)

(* ==========================================================================
   Section 1: Initialize PID Parameter Table on First Scan
   M8002 = first-scan pulse. MOV takes EN (condition) as first parameter.
   All 29 parameter registers are written once and persist through scan cycles.
   ========================================================================== *)

(* +0: Sampling time Ts = 500ms *)
MOV(M8002, K500, D500);

(* +1: ACT — reverse action, output limit mode, no autotune *)
MOV(M8002, 2#0000_0000_0000_0001, D501);

(* +2: Input filter α = 70% *)
MOV(M8002, K70, D502);

(* +3: Proportional gain Kp = 200% *)
MOV(M8002, K200, D503);

(* +4: Integral time Ti = 30 (×100ms → 3.0s) *)
MOV(M8002, K30, D504);

(* +5: Derivative gain Kd = 0% (PI-only control) *)
MOV(M8002, K0, D505);

(* +6: Derivative time Td = 0 (×10ms) *)
MOV(M8002, K0, D506);

(* +7: SCAN: autotune operation cycle = 1000ms *)
MOV(M8002, K1000, D507);

(* +8..+19 D508–D519: Internal work area. PID manages these — do not write. *)

(* +20: Input variation alarm (incremental) = max → disabled *)
MOV(M8002, K32767, D520);

(* +21: Input variation alarm (decremental) = max → disabled *)
MOV(M8002, K32767, D521);

(* +22: Output upper limit = 1000 (100.0%) *)
MOV(M8002, K1000, D522);

(* +23: Output lower limit = 0 (0.0%) *)
MOV(M8002, K0, D523);

(* +24: Alarm output flags — cleared on init *)
MOV(M8002, K0, D524);

(* +25: SHPV — PV threshold hysteresis width for limit cycle *)
MOV(M8002, K10, D525);

(* +26: ULV — output upper limit for limit cycle method *)
MOV(M8002, K1000, D526);

(* +27: LLV — output lower limit for limit cycle method *)
MOV(M8002, K0, D527);

(* +28: KW — wait from autotune end to PID start (0% = no wait) *)
MOV(M8002, K0, D528);

(* Mark init complete *)
IF M8002 THEN
    xInitComplete := TRUE;
END_IF;

(* ==========================================================================
   Section 2: Autotune Trigger
   On rising edge of g_xPIDAT while in auto mode, assign autotune bit pattern
   to D501 and IMMEDIATELY clear g_xPIDAT. This ensures the trigger fires
   exactly once — next scan g_xPIDAT is already FALSE, nothing happens.

   ACT bit patterns:
     Step Response: b0(reverse) + b4(autotune on) + b5(step response)
     Limit Cycle:   b0(reverse) + b4(autotune on) + b6(limit cycle)

   PID clears bit 4 automatically when tuning finishes → D501 returns to
   2#0000_0000_0000_0001 (normal operation).
   ========================================================================== *)
IF g_xPIDAT AND g_xAutoMode AND xInitComplete THEN
    IF g_xPIDATMode THEN
        (* Limit Cycle method *)
        D501 := 2#0000_0000_0101_0001;
    ELSE
        (* Step Response method *)
        D501 := 2#0000_0000_0011_0001;
    END_IF;
    (* Clear trigger immediately — autotune is now armed *)
    RST(TRUE, g_xPIDAT);
END_IF;

(* ==========================================================================
   Section 4: PID Loop Execution
   S1 = setpoint (SP),   S2 = process value (PV),
   S3 = parameter table head (D500),   D = output (MV → g_iPIDOutput)

   PID takes EN as first parameter — only executes when auto mode is active
   and init is complete. When condition is FALSE, output freezes at last value.
   ========================================================================== *)
xPIDActive := g_xAutoMode AND xInitComplete;
PID(xPIDActive, g_iSetpoint, AI_Pressure, D500, g_iPIDOutput);
(* Sometimes after PID stops it freezes output we need to reset it. *)
MOV(NOT xPIDActive, 0, g_iPIDOutput);  

(* Route PID output to physical analog output *)
AO_SpeedRef := g_iPIDOutput;

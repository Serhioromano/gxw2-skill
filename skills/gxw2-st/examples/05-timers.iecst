(*
  Program: Timers
  Purpose: Demonstrates IEC timer FBs (TON, TOF, TP).
           Also shows hardware OUT_T instructions.
  Critical: GX Works 2 uses := for ALL parameters, including outputs.
            All timer FB instances must be declared as VAR in CSV.
            No _E variants exist for timer FBs.
*)

(*
  Example 1: TON — On-Delay Timer
  Motor starts 3 seconds after xStart becomes TRUE.
  All parameters use := including outputs Q and ET.
*)
tonStartDelay(IN := DI_Start, PT := T#3s, Q := xMotorReady, ET := tMotorElapsed);
xMotorOutput := xMotorReady AND g_xSystemReady;

(*
  Example 2: TON with enable condition
  Same on-delay, but the call is guarded by an IF instead of an _E variant
  (timer FBs have no _E form; they are called via a declared instance).
*)
IF xEnable THEN
    tonStartDelay(IN := DI_Start, PT := T#3s, Q := xMotorReady, ET := tMotorElapsed);
ELSE
    xMotorReady := FALSE;
END_IF;

(*
  Example 3: TOF — Off-Delay Timer
  Cooling fan runs for 10 seconds after motor stops.
  Q goes FALSE only after the delay expires.
*)
tofStopDelay(IN := xMotorOutput, PT := T#10s, Q := xFanRunning, ET := tFanElapsed);

(*
  Example 4: TP — Pulse Timer
  Generates a fixed-width 500ms pulse on start button press.
*)
tpPulse(IN := MEP(DI_Start), PT := T#500ms, Q := xPulseOut, ET := tPulseElapsed);

(*
  Example 5: Hardware Timer OUT_T (no CSV declaration needed)
  TC0 = hardware timer 0. Preset in 100ms units.
  K20 = 20 × 100ms = 2 seconds.
*)
(* OUT_T(TRUE, TC0, K20); *)  (* Uncomment for hardware timer usage *)
(* TS0 = timer contact, TN0 = current elapsed value in 100ms units *)

(* Physical outputs *)
DO_Motor := xMotorOutput;
DO_Valve := xFanRunning;

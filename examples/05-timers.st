(*
  Program: Timers
  Purpose: Demonstrates IEC timer FBs (TON, TOF, TP) and their _E variants.
           Also shows hardware OUT_T instructions.
  Critical: GX Works 2 uses := for ALL parameters, including outputs.
            All timer FB instances must be declared as VAR in CSV.
*)

(*
  Example 1: TON — On-Delay Timer
  Motor starts 3 seconds after xStart becomes TRUE.
  All parameters use := including outputs Q and ET.
*)
tonStartDelay(IN := DI_Start, PT := T#3s, Q := xMotorReady, ET := tMotorElapsed);
xMotorOutput := xMotorReady AND g_xSystemReady;

(*
  Example 2: TON_E (_E trigger variant)
  Same on-delay, but only executes when xEnable is TRUE.
  First param = trigger, result stored in last param.
*)
(* TON_E(xEnable, IN, PT, Q, ET); *)
(* In practice: TON_E(M8000, DI_Start, T#3s, xMotorReady, tMotorElapsed); *)

(*
  Example 3: TOF — Off-Delay Timer
  Cooling fan runs for 10 seconds after motor stops.
  Q goes FALSE only after the delay expires.
*)
tofStopDelay(IN := xMotorOutput, PT := T#10s, Q := xFanRunning, ET := tFanElapsed);
(* TOF_E variant: TOF_E(xEnable, xMotorOutput, T#10s, xFanRunning, tFanElapsed); *)

(*
  Example 4: TP — Pulse Timer
  Generates a fixed-width 500ms pulse on start button press.
*)
tpPulse(IN := MEP(DI_Start), PT := T#500ms, Q := xPulseOut, ET := tPulseElapsed);
(* TP_E variant: TP_E(xEnable, MEP(DI_Start), T#500ms, xPulseOut, tPulseElapsed); *)

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

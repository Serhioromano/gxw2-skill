(*
  Program: PRG_INIT
  Purpose: One-time startup actions for the pump station.
  Run mode: registered in program/task settings (PLC Parameter → PLC System
            → Program) with execution condition M8002 (initial pulse) — the
            PLC executes this body exactly once after RUN. No M8002 guard
            inside the code — see common-rules.md → 3-Program Structure.
  I/O Map: writes DO_Pump (IO.csv) and globals (GVL.csv) only.
*)

(* Force the state machine into Init *)
g_iState := 0;

(* Default commands and setpoint *)
DO_Pump := FALSE;
g_iSetpoint := iDefaultSetpoint;

(* Clear errors and alarms *)
g_iErrorCode := 0;
g_xAlarmActive := FALSE;
g_iHeartbeat := 0;

(* Startup sanity *)
g_xSystemReady := TRUE;

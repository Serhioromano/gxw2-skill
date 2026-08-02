(*
  Program: IO_Assignment
  Purpose: Demonstrates basic I/O assignment — reading physical inputs and
           writing to physical outputs using label variables from IO.csv.
           Uses GVL variables for HMI-accessible flags.
  I/O Map: See IO.csv and GVL.csv for full variable-to-device mapping.
*)

(* Rising edge detectors for pushbuttons *)
rtStart(CLK := DI_Start, Q := xStartPulse);
rtStop(CLK := DI_Stop, Q := xStopPulse);

(* Motor control with start/stop + emergency + low level interlock *)
IF xStartPulse AND g_xSystemReady AND NOT g_xAlarmActive THEN
    xMotorRun := TRUE;
END_IF;

IF xStopPulse OR DI_EmergencyStop OR g_xAlarmActive THEN
    xMotorRun := FALSE;
END_IF;

(* Pump runs when motor is on and low level switch is NOT active *)
(* LowLevel is NC: TRUE = level OK, FALSE = level low *)
xPumpRun := xMotorRun AND DI_LowLevel;

(* Physical outputs mapped via labels *)
DO_Motor := xMotorRun;
DO_Pump := xPumpRun;
DO_GreenLight := xMotorRun AND NOT g_xAlarmActive;
DO_RedLight := g_xAlarmActive;
DO_Buzzer := g_xAlarmActive;

(* Update HMI-accessible flags *)
g_xSystemReady := NOT DI_EmergencyStop AND DI_LowLevel;

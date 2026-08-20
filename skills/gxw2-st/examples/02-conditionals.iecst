(*
  Program: Conditionals
  Purpose: Demonstrates IF / ELSIF / ELSE statements with comparison
           operators (=, <>, <, >, <=, >=) and logical operators
           (NOT, AND, OR, XOR).
  I/O Map: Uses AI_Pressure, AI_Temperature from IO.csv.
           Uses g_rTemperatureSP, g_rPressureSP from GVL.csv.
*)

(* Scale raw analog inputs to engineering units (0-1000 → 0.0-100.0) *)
rScaledTemp := INT_TO_REAL(AI_Temperature) / E10.0;
rScaledPressure := INT_TO_REAL(AI_Pressure) / E10.0;

(* --- Temperature monitoring with hysteresis --- *)
IF rScaledTemp > (g_rTemperatureSP + E5.0) THEN
    (* Too hot — disable heater *)
    xHeaterEnable := FALSE;
    xTempOK := FALSE;
ELSIF rScaledTemp < (g_rTemperatureSP - E5.0) THEN
    (* Too cold — enable heater *)
    xHeaterEnable := TRUE;
    xTempOK := FALSE;
ELSE
    (* Within hysteresis band *)
    xHeaterEnable := FALSE;
    xTempOK := TRUE;
END_IF;

(* --- Pressure monitoring — simple window comparator --- *)
IF (rScaledPressure >= (g_rPressureSP - E2.0)) AND
   (rScaledPressure <= (g_rPressureSP + E2.0)) THEN
    xPressureOK := TRUE;
ELSE
    xPressureOK := FALSE;
END_IF;

(* --- Valve control based on pressure --- *)
IF rScaledPressure > (g_rPressureSP + E10.0) THEN
    (* Over-pressure: close valve *)
    xValveEnable := FALSE;
ELSIF rScaledPressure < (g_rPressureSP - E10.0) THEN
    (* Under-pressure: open valve *)
    xValveEnable := TRUE;
ELSE
    (* Within operating band: maintain current state *)
    (* No change — valve stays in last position *)
END_IF;

(* --- Fault aggregation --- *)
xAnyFault := NOT xTempOK OR NOT xPressureOK OR NOT DI_LowLevel;

IF xAnyFault THEN
    g_xAlarmActive := TRUE;
ELSE
    g_xAlarmActive := FALSE;
END_IF;

(* Physical outputs *)
DO_Valve := xValveEnable;

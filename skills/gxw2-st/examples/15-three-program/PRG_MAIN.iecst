(*
  Program: PRG_MAIN
  Purpose: All business logic — pump state machine (Init → Reset → Idle →
           Run → Fault). Runs every scan.
  I/O Map: DI_Start, DI_Stop, DI_EmergencyStop, DI_LowLevel, DO_Pump from
           IO.csv; globals from GVL.csv (g_iState, g_xAlarmActive,
           g_xSystemReady).
*)

CASE g_iState OF
    0: (* Init — entered via PRG_INIT, set defaults *)
        DO_Pump := FALSE;
        g_iState := 10;  (* Auto-advance to Reset *)

    10: (* Reset — outputs off, wait 2 s *)
        DO_Pump := FALSE;
        g_xAlarmActive := FALSE;
        tonReset(IN := TRUE, PT := T#2s, Q := xResetDone, ET := tResetTime);
        IF xResetDone THEN
            g_iState := 20;  (* Advance to Idle *)
        END_IF;

    20: (* Idle — waiting for start *)
        DO_Pump := FALSE;
        IF MEP(DI_Start) AND g_xSystemReady THEN
            g_iState := 30;  (* Advance to Run *)
        END_IF;

    30: (* Run — pump running *)
        DO_Pump := TRUE;
        IF DI_Stop OR DI_EmergencyStop OR NOT DI_LowLevel THEN
            g_iState := 40;  (* Go to Fault *)
        END_IF;

    40: (* Fault — alarm active, wait for start to reset *)
        DO_Pump := FALSE;
        g_xAlarmActive := TRUE;
        IF MEP(DI_Start) THEN
            g_iState := 10;  (* Go to Reset *)
        END_IF;

ELSE
    (* Unknown state — force to Init *)
    g_iState := 0;
END_CASE;

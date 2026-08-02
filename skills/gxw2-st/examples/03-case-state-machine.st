(*
  Program: Case_State_Machine
  Purpose: Demonstrates CASE-based state machine with the mandatory
           Init (0) → Reset (10) → Idle (20) pattern, plus Run (30)
           and Fault (40) states.
  Rules:    Integer state values only. Use comments for state names.
            No named CASE labels, no ranges.
  I/O Map:  DI_Start, DI_Stop, DI_EmergencyStop from IO.csv.
            DO_Motor, DO_Valve, DO_GreenLight, DO_RedLight from IO.csv.
*)

(* State timer — tracks time spent in current state *)
tonState(IN := TRUE, PT := T#30s, Q := , ET := tStateTimer);

(* Detect state entry on first scan after change *)
IF iState <> iPrevState THEN
    iPrevState := iState;
    (* Reset state timer on state entry *)
    tonState(IN := FALSE, PT := T#30s, Q := , ET := );
    tonState(IN := TRUE, PT := T#30s, Q := , ET := tStateTimer);
END_IF;

CASE iState OF
    0: (* Init — entered on first scan, set defaults *)
        xMotorRun := FALSE;
        xValveOpen := FALSE;
        xCycleComplete := FALSE;
        iCycleStep := 0;
        g_xAlarmActive := FALSE;
        iState := 10;  (* Auto-advance to Reset *)

    10: (* Reset — reset all outputs and intermediate values *)
        xMotorRun := FALSE;
        xValveOpen := FALSE;
        xCycleComplete := FALSE;
        iCycleStep := 0;
        DO_Motor := FALSE;
        DO_Valve := FALSE;
        DO_GreenLight := FALSE;
        DO_RedLight := TRUE;  (* Red light during reset *)
        (* Wait 2 seconds in reset *)
        IF tStateTimer >= T#2s THEN
            iState := 20;  (* Advance to Idle *)
        END_IF;

    20: (* Idle — waiting for start condition *)
        DO_RedLight := FALSE;
        DO_GreenLight := TRUE;  (* Green light = ready *)
        xMotorRun := FALSE;
        xValveOpen := FALSE;
        IF MEP(g_xHMI_Start) OR MEP(DI_Start) THEN
            iState := 30;  (* Advance to Run *)
        END_IF;

    30: (* Run — execute process cycle *)
        DO_GreenLight := FALSE;
        xMotorRun := TRUE;
        DO_Motor := TRUE;

        (* Step through cycle *)
        IF iCycleStep < 10 THEN
            xValveOpen := TRUE;
            DO_Valve := TRUE;
            iCycleStep := iCycleStep + 1;
        ELSIF iCycleStep < 50 THEN
            xValveOpen := FALSE;
            DO_Valve := FALSE;
            iCycleStep := iCycleStep + 1;
        ELSE
            xCycleComplete := TRUE;
            iState := 20;  (* Return to Idle *)
        END_IF;

        (* Fault check during run *)
        IF NOT DI_LowLevel OR NOT g_xSystemReady THEN
            iState := 40;  (* Go to Fault *)
        END_IF;

    40: (* Fault — alarm active, wait for reset *)
        xMotorRun := FALSE;
        xValveOpen := FALSE;
        DO_Motor := FALSE;
        DO_Valve := FALSE;
        DO_RedLight := TRUE;
        g_xAlarmActive := TRUE;
        (* Wait for HMI reset *)
        IF MEP(g_xHMI_Reset) THEN
            g_xAlarmActive := FALSE;
            iState := 10;  (* Go to Reset after fault *)
        END_IF;

ELSE
    (* Unknown state — force to Init *)
    iState := 0;
END_CASE;

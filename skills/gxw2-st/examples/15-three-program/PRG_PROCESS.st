(*
  Program: PRG_PROCESS
  Purpose: Non-business actions — error diagnostics, alarm handling, data
           transfer (analog scaling), slow periodic housekeeping.
           Runs every scan.
  I/O Map: AI_Pressure from IO.csv; special relays/registers M8067, D8067,
           D8012; globals from GVL.csv.
*)

(* Error check — operation error from special registers *)
IF M8067 THEN
    g_iErrorCode := D8067;
    g_xAlarmActive := TRUE;
ELSE
    g_iErrorCode := 0;
END_IF;

(* Data transfer — scale raw analog to engineering value *)
g_rPressure := INT_TO_REAL(AI_Pressure) * E0.025;  (* 0–4000 counts → 0–100.0 bar *)

(* Slow periodic housekeeping on 100 ms clock *)
IF M8012 THEN
    g_iHeartbeat := g_iHeartbeat + 1;
END_IF;

(* Diagnostic sequencing — report max scan time every 100th scan *)
iDiagStep := iDiagStep + 1;
IF iDiagStep >= 100 THEN
    iDiagStep := 0;
    g_iMaxScan := D8012;  (* max scan time, 0.1 ms units *)
END_IF;

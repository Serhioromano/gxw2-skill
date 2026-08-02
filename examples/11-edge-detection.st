(*
  Program: Edge_Detection
  Purpose: Demonstrates edge detection using MEP/MEF (preferred) and
           R_TRIG/F_TRIG FBs.
  Preference: Use MEP/MEF for simple cases — no CSV declaration needed,
              works inline in expressions. Use R_TRIG/F_TRIG when you
              need to reuse the same edge detection in multiple places.
  Note: R_TRIG/F_TRIG have no _E variants; they are called via declared
        instances only.
*)

(* ─── MEP / MEF — Preferred Inline Edge Detection ─── *)
(* No CSV declaration required. Works directly in expressions. *)

(* Rising edge: increment counter once per button press *)
IF MEP(DI_Start) THEN
    iEdgeCount := iEdgeCount + 1;
END_IF;

(* Falling edge: detect stop button release *)
IF MEF(DI_Stop) THEN
    xEdgeTriggered := FALSE;
END_IF;

(* MEP in assignment — one-scan pulse *)
xMEP_Pulse := MEP(DI_PhotoEye);

(* MEF in assignment *)
xMEF_Pulse := MEF(DI_LowLevel);

(* Toggle on each rising edge *)
IF MEP(DI_Start) THEN
    xToggle := NOT xToggle;
END_IF;

(* MEP with combined conditions *)
IF MEP(DI_Start) AND g_xSystemReady THEN
    xEdgeTriggered := TRUE;
END_IF;

(* ─── R_TRIG / F_TRIG — FB-Based Edge Detection ─── *)
(* Must be declared as VAR in CSV. Useful for reusable edge detection. *)

(* Rising edge detection — uses := for ALL parameters including Q *)
rtStart(CLK := DI_Start, Q := xStartEdge);

(* Falling edge detection *)
ftStop(CLK := DI_Stop, Q := xStopEdge);

(* Use the edge outputs *)
IF xStartEdge THEN
    iEdgeCount := iEdgeCount + 1;
END_IF;

IF xStopEdge THEN
    xEdgeTriggered := FALSE;
END_IF;

(* ─── Edge-Triggered Counter Pattern ─── *)
(* Only count on rising edge of photo eye, not every scan *)
IF MEP(DI_PhotoEye) THEN
    iEdgeCount := iEdgeCount + 1;
    IF iEdgeCount >= K100 THEN
        iEdgeCount := 0;
        xEdgeTriggered := TRUE;
    END_IF;
END_IF;

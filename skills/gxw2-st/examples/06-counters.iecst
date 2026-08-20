(*
  Program: Counters
  Purpose: Demonstrates IEC counter FBs (CTU, CTD, CTUD).
           Also shows hardware OUT_C / OUT_C_32 instructions.
  Critical: GX Works 2 uses := for ALL parameters, including outputs.
            All counter FB instances must be declared as VAR in CSV.
            No _E variants exist for counter FBs.
*)

(*
  Example 1: CTU — Count-Up Counter
  Counts parts using photo eye sensor. Resets on batch complete.
  Preset = 100 parts.
*)
ctParts(CU := MEP(DI_PhotoEye), RESET := xBatchComplete,
        PV := K100, Q := xPartsFull, CV := iPartsCount);

(*
  Example 2: CTU with enable condition
  Same count-up, but the call is guarded by an IF instead of an _E variant
  (counter FBs have no _E form; they are called via a declared instance).
*)
IF xEnable THEN
    ctParts(CU := MEP(DI_PhotoEye), RESET := xBatchComplete,
            PV := K100, Q := xPartsFull, CV := iPartsCount);
END_IF;

(*
  Example 3: CTD — Count-Down Counter
  Starts at preset 50 batches, counts down on each batch complete.
  Loads preset value on rising edge of LOAD input.
*)
ctBatches(CD := MEP(xPartsFull), LOAD := MEP(g_xHmiReset),
          PV := K50, Q := xBatchesDone, CV := iBatchesLeft);

(*
  Example 4: CTUD — Count-Up/Down Counter
  Tracks net total: up on part added, down on part removed.
  Uses separate QU (up output) and QD (down output).
*)
ctTotal(CU := MEP(DI_PhotoEye), CD := MEP(DI_LowLevel),
        RESET := MEP(g_xHmiReset), LOAD := FALSE,
        PV := K9999, QU := xTotalUp, QD := xTotalDown, CV := iTotalCount);

(*
  Example 5: Hardware Counter OUT_C / OUT_C_32 (no CSV declaration needed)
  OUT_C  for 16-bit counters (C0–C199)
  OUT_C_32 for 32-bit counters (C200–C255)
*)
(* OUT_C(TRUE, CC0, K200);      *)   (* 16-bit counter C0, preset 200 *)
(* OUT_C_32(TRUE, CC235, K200); *)   (* 32-bit counter C235, preset 200 *)
(*
  CN0  — current value of C0
  CS0  — contact: TRUE when C0 >= preset
  RST(TRUE, CC0);  — reset counter to zero
*)

(* Batch complete logic *)
xBatchComplete := xPartsFull;
DO_GreenLight := NOT xBatchComplete;
DO_RedLight := xBatchesDone;

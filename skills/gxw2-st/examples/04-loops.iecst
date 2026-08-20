(*
  Program: Loops
  Purpose: Demonstrates FOR, WHILE, REPEAT loops with EXIT.
           Includes scan-time awareness comments.
  WARNING:  FOR loops in GX Works 2 ST have no built-in scan time watchdog.
            Keep loops short (max a few hundred iterations) to avoid
            scan time overrun and PLC watchdog timeout.
  Rules:    No CONTINUE — restructure with IF/ELSE.
            EXIT exits only the innermost loop.
*)

(*
  Example 1: FOR loop — sum values from 1 to 100
  Safe: bounded iteration count.
*)
iSum := 0;
FOR iIndex := 1 TO 100 BY 1 DO
    iSum := iSum + iIndex;
END_FOR;
(* iSum = 5050 *)

(*
  Example 2: FOR loop with EXIT — find first matching value
  Demonstrates early exit when condition is met.
*)
xFound := FALSE;
iFound := -1;
iSearchTarget := K42;
iTableSize := K200;

FOR iIndex := 0 TO (iTableSize - 1) BY 1 DO
    (* Simulate table lookup — in real code, use array access *)
    IF iIndex = iSearchTarget THEN
        iFound := iIndex;
        xFound := TRUE;
        EXIT;  (* Stop searching once found *)
    END_IF;
END_FOR;

(*
  Example 3: WHILE loop — bit scanning
  Find the first set bit in a WORD value.
  Uses EXIT for early termination.
*)
wBitMask := AI_Pressure;  (* Use analog input as bit pattern *)
iBitPos := 0;
xBitSet := FALSE;

WHILE (iBitPos < 16) AND NOT xBitSet DO
    SHL(K1, iBitPos, wShiftTemp);       (* Build bit mask at position *)
    IF (wBitMask AND wShiftTemp) <> H0 THEN
        xBitSet := TRUE;
        EXIT;  (* Found a set bit *)
    END_IF;
    iBitPos := iBitPos + 1;
END_WHILE;

(*
  Example 4: REPEAT loop with scan-time safety
  Demonstrates adding a failsafe iteration cap.
*)
iIndex := 0;
iSum := 0;
REPEAT
    iSum := iSum + iIndex;
    iIndex := iIndex + 1;
    (* Scan-time safety: force exit after 500 iterations *)
    IF iIndex >= 500 THEN
        EXIT;
    END_IF;
UNTIL iSum > K10000;
END_REPEAT;

(*
  Example 5: No CONTINUE — restructure with IF/ELSE
  Instead of: FOR i := 1 TO 10 DO IF skip THEN CONTINUE; END_IF; ... END_FOR;
  Use:
*)
iSum := 0;
FOR iIndex := 1 TO 10 BY 1 DO
    IF (iIndex MOD 2) = 0 THEN
        (* Skip even indices — put the work in ELSE branch *)
        (* Do nothing for even values *)
    ELSE
        (* Process odd indices only *)
        iSum := iSum + iIndex;
    END_IF;
END_FOR;

(* Output the computed sum *)
iResult := iSum;

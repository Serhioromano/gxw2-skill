(*
  Program: Bit_Operations
  Purpose: Demonstrates SET/RST/PLS/PLF instructions, bit shift
           functions (SHL/SHR/ROL/ROR), and logical bit masking.
  Rules:    No SR/RS bistable FBs — use SET/RST instead.
            No D100.0 bit-of-word addressing — use bit masking or M relays.
*)

(* ─── SET / RST — Latching Bit Instructions ─── *)
(* SET: turns bit TRUE and holds until RST *)
IF DI_Start THEN
    SET(xLatchFlag);          (* Latch ON *)
END_IF;
IF DI_Stop THEN
    RST(xLatchFlag);          (* Release latch *)
END_IF;

(* Alternative to SR/RS FBs (not available on FX): *)
(* SR pattern using SET/RST: *)
(* IF xSetCondition THEN SET(xOutput); END_IF; *)
(* IF xResetCondition THEN RST(xOutput); END_IF; *)

(* ─── PLS / PLF — Pulse Instructions ─── *)
(* PLS: TRUE for one scan on rising edge of argument *)
PLS(xPulseFlag);              (* xPulseFlag pulses on its own rising edge *)
(* PLF: TRUE for one scan on falling edge *)
(* PLF(xPulseFlag); *)

(* ─── Logical Operators (NOT, AND, OR, XOR) ─── *)
xCombined := (DI_Start AND NOT DI_Stop) OR g_xAutoMode;
xBitOutput := xCombined XOR g_xManualMode;

(* ─── Bit Masks on WORD/DWORD ─── *)
(* Extract bits 0-3 from input word *)
wResult := wInput AND H000F;

(* Set bit 7 in result word *)
wResult := wResult OR H0080;

(* Toggle bit 3 using XOR *)
wResult := wResult XOR H0008;

(* Clear bits 8-11 *)
wResult := wResult AND (NOT H0F00);

(* ─── Bit Shift Instructions ─── *)
(* 16-bit shifts *)
SHL(wInput, K4, wResult);                  (* Shift left 4 bits *)
SHR(wInput, K4, wResult);                  (* Shift right 4 bits *)
ROL(wInput, K2, wResult);                  (* Rotate left 2 bits *)
ROR(wInput, K2, wResult);                  (* Rotate right 2 bits *)

(* _E variants (triggered) *)
SHL_E(g_xSystemReady, wInput, K4, wResult);
SHR_E(g_xSystemReady, wInput, K4, wResult);
ROL_E(g_xSystemReady, wInput, K2, wResult);
ROR_E(g_xSystemReady, wInput, K2, wResult);

(* 32-bit (D prefix) shifts *)
DSHL(dwInput, K8, dwResult);               (* 32-bit shift left 8 *)
DSHR(dwInput, K8, dwResult);               (* 32-bit shift right 8 *)
DROL(dwInput, K4, dwResult);               (* 32-bit rotate left 4 *)
DROR(dwInput, K4, dwResult);               (* 32-bit rotate right 4 *)

(* 32-bit triggered *)
DSHL_E(g_xSystemReady, dwInput, K8, dwResult);

(* ─── Bit-of-Word Alternative ─── *)
(* D100.0 is NOT supported on FX. To check bit 3 of a word: *)
IF (wInput AND H0008) <> H0 THEN
    (* Bit 3 is set *)
    xBitOutput := TRUE;
ELSE
    xBitOutput := FALSE;
END_IF;

(* Better: use M relays for individual bit flags *)
(* Assign M100-M115 to bits of D200 via GVL.csv *)

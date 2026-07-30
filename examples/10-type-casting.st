(*
  Program: Type_Casting
  Purpose: Demonstrates all type conversion functions available on
           FX series. All casting functions support the _E postfix
           for triggered execution.
  Note:     Non-_E form returns value directly.
            _E form: first param = trigger, last param = result.
*)

(* ─── Integer ↔ Real Conversions ─── *)

(* INT → REAL *)
rResult := INT_TO_REAL(iVal);
(* INT_TO_REAL_E(xTrig, iVal, rResult); *)

(* REAL → INT (truncates toward zero) *)
iResult := REAL_TO_INT(rVal);
(* REAL_TO_INT_E(xTrig, rVal, iResult); *)

(* DINT → REAL *)
rResult := DINT_TO_REAL(diVal);
(* DINT_TO_REAL_E(xTrig, diVal, rResult); *)

(* REAL → DINT *)
diResult := REAL_TO_DINT(rVal);
(* REAL_TO_DINT_E(xTrig, rVal, diResult); *)

(* ─── Integer Width Conversions ─── *)

(* INT → DINT (safe, no data loss) *)
diResult := INT_TO_DINT(iVal);
(* INT_TO_DINT_E(xTrig, iVal, diResult); *)

(* DINT → INT (overflow risk if DINT > 32767 or < -32768) *)
iResult := DINT_TO_INT(diVal);
(* DINT_TO_INT_E(xTrig, diVal, iResult); *)

(* WORD → DWORD *)
dwResult := WORD_TO_DWORD(wVal);
(* WORD_TO_DWORD_E(xTrig, wVal, dwResult); *)

(* DWORD → WORD (overflow risk if DWORD > 65535) *)
wResult := DWORD_TO_WORD(dwVal);
(* DWORD_TO_WORD_E(xTrig, dwVal, wResult); *)

(* ─── BOOL / WORD ↔ INT Conversions ─── *)

(* BOOL → INT (TRUE→1, FALSE→0) *)
iResult := BOOL_TO_INT(xFlag);
(* BOOL_TO_INT_E(xTrig, xFlag, iResult); *)

(* BOOL → WORD *)
wResult := BOOL_TO_WORD(xFlag);
(* BOOL_TO_WORD_E(xTrig, xFlag, wResult); *)

(* WORD → INT (unsigned → signed, no data loss in range) *)
iResult := WORD_TO_INT(wVal);
(* WORD_TO_INT_E(xTrig, wVal, iResult); *)

(* INT → WORD (signed → unsigned, negative → large WORD) *)
wResult := INT_TO_WORD(iVal);
(* INT_TO_WORD_E(xTrig, iVal, wResult); *)

(* ─── String Conversions ─── *)

(* INT → STRING *)
sResult := INT_TO_STRING(iVal);
(* INT_TO_STRING_E(xTrig, iVal, sResult); *)

(* STRING → INT (returns 0 if invalid) *)
iResult := STR_TO_INT(sVal);
(* STR_TO_INT_E(xTrig, sVal, iResult); *)

(* STRING → REAL (returns 0.0 if invalid) *)
rResult := STR_TO_REAL(sVal);
(* STR_TO_REAL_E(xTrig, sVal, rResult); *)

(* STRING → DINT *)
diResult := STR_TO_DINT(sVal);
(* STR_TO_DINT_E(xTrig, sVal, diResult); *)

(* REAL → STRING *)
sResult := REAL_TO_STRING(rVal);
(* REAL_TO_STRING_E(xTrig, rVal, sResult); *)

(* DINT → STRING *)
sResult := DINT_TO_STRING(diVal);
(* DINT_TO_STRING_E(xTrig, diVal, sResult); *)

(* ─── TIME Conversions ─── *)

(* TIME → DINT (milliseconds as DINT) *)
diResult := TIME_TO_DINT(tDuration);
(* TIME_TO_DINT_E(xTrig, tDuration, diResult); *)

(* DINT → TIME (milliseconds → TIME) *)
tResult := DINT_TO_TIME(diVal);
(* DINT_TO_TIME_E(xTrig, diVal, tResult); *)

(* ─── Practical: Scale analog input to engineering units ─── *)
(* AI_Pressure is INT (0-1000), convert to REAL (0.0-100.0 bar) *)
rFinalOutput := INT_TO_REAL(AI_Pressure) / E10.0;

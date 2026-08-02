(*
  Program: Math
  Purpose: Demonstrates arithmetic and math functions with all postfix
           variants (_E, P, D). Note that SIN/COS/TAN/LN/LOG/EXP/TRUNC
           are NOT available on FX series.
  Critical naming: MAXIMUM, MINIMUM, LIMITATION — NOT MAX, MIN, LIMIT.
                   RND — NOT ROUND.
*)

(* ─── Standard REAL arithmetic (inline operators) ─── *)
rResultA := rA + rB;        (* Addition *)
rResultA := rA - rB;        (* Subtraction *)
rResultA := rA * rB;        (* Multiplication *)
rResultA := rA / rB;        (* Division *)

(* ─── WORD/DWORD arithmetic instructions ─── *)
(* Direct: wResultA := wA + wB *)
ADD(wA, wB, wResultA);                  (* 16-bit add *)
SUB(wA, wB, wResultA);                  (* 16-bit sub *)
MUL(wA, wB, wResultA);                  (* 16-bit mul *)
DIV(wA, wB, wResultA);                  (* 16-bit div *)

(* _E (triggered): first param = trigger, last = result *)
ADD_E(g_xSystemReady, wA, wB, wResultA);
SUB_E(g_xSystemReady, wA, wB, wResultA);
MUL_E(g_xSystemReady, wA, wB, wResultA);
DIV_E(g_xSystemReady, wA, wB, wResultA);

(* P (pulse): executes once on rising edge of first param *)
ADDP(MEP(DI_Start), wA, wB, wResultA);
SUBP(MEP(DI_Start), wA, wB, wResultA);
MULP(MEP(DI_Start), wA, wB, wResultA);
DIVP(MEP(DI_Start), wA, wB, wResultA);

(* D prefix (32-bit): DWORD operands *)
DADD(dwA, dwB, dwResultA);              (* 32-bit add *)
DSUB(dwA, dwB, dwResultA);              (* 32-bit sub *)
DMUL(dwA, dwB, dwResultA);              (* 32-bit mul *)
DDIV(dwA, dwB, dwResultA);              (* 32-bit div *)

(* D + _E combined: 32-bit triggered *)
DADD_E(g_xSystemReady, dwA, dwB, dwResultA);

(* D + P combined: 32-bit pulse *)
DADDP(MEP(DI_Start), dwA, dwB, dwResultA);

(* ─── Math Functions ─── *)
(* ABS — absolute value (INT, _E, D, D_E) *)
iResultA := ABS(iA);                    (* INT absolute *)
(* ABS_E(xTrig, iA, iResultA); *)       (* Triggered *)
(* DABS(diA, diResultA); *)             (* 32-bit *)
(* DABS_E(xTrig, diA, diResultA); *)    (* 32-bit triggered *)

(* SQRT — square root (REAL only, P variant) *)
rResultA := SQRT(rA);                   (* Direct *)
(* SQRTP(xTrig, rA, rResultA); *)       (* Pulse *)

(* EXPT — power: Base^Exp *)
rResultA := EXPT(rA, rB);               (* Direct *)
(* EXPT_E(xTrig, rA, rB, rResultA); *)  (* Triggered *)

(* MOD — modulo (INT) *)
iResultA := MOD(iA, iB);                (* Direct *)
(* MOD_E(xTrig, iA, iB, iResultA); *)   (* Triggered *)

(* RND — round REAL to INT (P variant). NOT ROUND. *)
iResultA := RND(rA);                    (* Direct *)
(* RNDP(xTrig, rA, iResultA); *)        (* Pulse *)

(* ─── Selection Functions ─── *)
(* MAXIMUM — max of two values (NOT MAX) *)
rResultA := MAXIMUM(rA, rB);
(* MAXIMUM_E(xTrig, rA, rB, rResultA); *)

(* MINIMUM — min of two values (NOT MIN) *)
rResultA := MINIMUM(rA, rB);
(* MINIMUM_E(xTrig, rA, rB, rResultA); *)

(* LIMITATION — clamp (NOT LIMIT) *)
rResultA := LIMITATION(E0.0, rA, E100.0);
(* LIMITATION_E(xTrig, E0.0, rA, E100.0, rResultA); *)

(* SEL — binary selection: G=FALSE→IN0, G=TRUE→IN1 *)
iResultA := SEL(xMotorOutput, iA, iB);
(* SEL_E(xTrig, xMotorOutput, iA, iB, iResultA); *)

(* MUX — N-way selection (0-based index) *)
iResultA := MUX(iChoice, K10, K20, K30, K40);
(* MUX_E(xTrig, iChoice, K10, K20, K30, K40, iResultA); *)

(* ─── Practical example: scale and clamp ─── *)
rScaledOutput := LIMITATION(
    E0.0,
    (INT_TO_REAL(AI_Pressure) / E10.0),
    E100.0
);

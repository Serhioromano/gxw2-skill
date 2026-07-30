(*
  Program: Strings
  Purpose: Demonstrates string functions available on FX3U/FX5U.
           String operations are NOT supported on FX3G/FX3S.
  Postfix rules: _E only on INSERT, DELETE, REPLACE, FIND.
                  P only on LEN, LEFT, RIGHT, MID, CONCAT.
                  (no underscore: LEFTP, RIGHTP, MIDP, CONCATP, LENP)
  Note:         Single quotes for literals. Double '' to escape quote.
                Max 255 characters.
*)

(*
  Example 1: LEN — string length (P variant: LENP)
  Returns INT length of string.
*)
iLength := LEN(sBase);
(* Pulse variant — first param is trigger, result last *)
(* LENP(xTrig, sBase, iLength); *)

(*
  Example 2: LEFT / LEFTP — leftmost L characters
*)
sResult := LEFT(sBase, 5);
(* LEFTP(xTrig, sBase, 5, sResult); *)

(*
  Example 3: RIGHT / RIGHTP — rightmost L characters
*)
sResult := RIGHT(sBase, 3);
(* RIGHTP(xTrig, sBase, 3, sResult); *)

(*
  Example 4: MID / MIDP — L characters starting at position P (1-based)
*)
sResult := MID(sBase, 4, 2);
(* MIDP(xTrig, sBase, 4, 2, sResult); *)

(*
  Example 5: CONCAT / CONCATP — concatenate two strings
*)
sFull := CONCAT(sFirst, sLast);
(* CONCATP(xTrig, sFirst, sLast, sFull); *)

(*
  Example 6: INSERT / INSERT_E — insert string at position P (1-based)
  _E variant only: first param = trigger, last = result
*)
INSERT_E(g_xSystemReady, sBase, sInsert, 3, sResult);

(*
  Example 7: DELETE / DELETE_E — delete L chars at position P (1-based)
*)
DELETE_E(g_xSystemReady, sBase, 5, 2, sResult);

(*
  Example 8: REPLACE / REPLACE_E — replace L chars at position P
*)
REPLACE_E(g_xSystemReady, sBase, sInsert, 4, 3, sResult);

(*
  Example 9: FIND / FIND_E — find substring, returns position (0 = not found)
*)
iPosition := FIND(sBase, sSearch);
(* FIND_E variant — last param stores result *)
(* FIND_E(xTrig, sBase, sSearch, iPosition); *)

(*
  Example 10: Practical — build an alarm message string
*)
IF g_xAlarmActive THEN
    sDisplay := CONCAT('ALARM: ', 'System fault');
ELSE
    sDisplay := 'System running';
END_IF;

(*
  Example 11: Escaping single quotes
  Use double '' inside a string literal for a single quote.
  'It''s running' produces: It's running
*)

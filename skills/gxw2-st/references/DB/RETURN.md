# RETURN — RETURN (ST early exit)

Manual section: **ST language statement** — no ladder instruction equivalent. Index names: RETURN.

## Purpose
`RETURN;` terminates the body of the current POU immediately. Every statement after it in that POU is skipped for the current scan; other POUs (FBs called later, other programs) still execute normally.

In a **function (FUN)** `RETURN;` ends the function evaluation — the value the caller receives is whatever was last assigned to the function name (`F_NAME := ...`). This is how guard clauses are written in GX Works 2 ST.

## ST Syntax (GX Works 2)
- `RETURN;`

Statement only — no parentheses, no parameters, no `EN`/`ENO`.

## Operands
None. `RETURN` takes no operands and produces no value.

## Support
- FX3U: ✓
- FX3G: ✓
- FX3S: ✓
- FX5U: ✓

## Examples (ST)

### Guard clause in a FUN — assign the result BEFORE RETURN
```iecst
(*
  Function: F_DIVIDE_SAFE
  Purpose:  Division with divide-by-zero protection.
  Result is returned through the function name (no VAR_OUTPUT).
*)
IF rDenominator = E0.0 THEN
    F_DIVIDE_SAFE := E0.0;   (* result MUST be assigned before RETURN *)
    RETURN;                  (* remaining statements are skipped *)
END_IF;

F_DIVIDE_SAFE := rNumerator / rDenominator;
```

### Several guard clauses in one FUN
```iecst
(*
  Function: F_SCALE_VALUE
  Purpose:  Linear scaling of a raw INT to engineering units.
*)
(* Guard 1: invalid input range *)
IF iRawMax <= iRawMin THEN
    F_SCALE_VALUE := rEngMin;
    RETURN;
END_IF;

(* Guard 2: raw value below range *)
IF iRaw < iRawMin THEN
    F_SCALE_VALUE := rEngMin;
    RETURN;
END_IF;

(* Guard 3: raw value above range *)
IF iRaw > iRawMax THEN
    F_SCALE_VALUE := rEngMax;
    RETURN;
END_IF;

(* Normal path — always the last assignment in the body *)
F_SCALE_VALUE := rEngMin +
    ((INT_TO_REAL(iRaw - iRawMin) / INT_TO_REAL(iRawMax - iRawMin)) *
     (rEngMax - rEngMin));
```

### Early exit from a program body
```iecst
(* PRG_PROCESS — skip housekeeping while the machine is not ready *)
IF NOT g_xSystemReady THEN
    RETURN;                  (* ends PRG_PROCESS for this scan only *)
END_IF;

(* Everything below runs only when the system is ready *)
g_iErrorCode := F_CHECK_ERRORS(...);
```

## Key Rules
- `RETURN;` — statement form with a terminating semicolon. There is **no** `RETURN(EN);` form and **no** `RETURN <value>;` form (that is IEC syntax from other vendors). A FUN result is always passed through the function name assignment.
- **In a FUN, assign the function name before every `RETURN`.** `RETURN` does not carry a value; if the body exits before the assignment, the caller gets whatever the function name happened to hold — `0` in the best case, the result of a previous call in the worst.
- `RETURN` exits the **whole POU body**, not just a loop. To leave a `FOR`/`WHILE`/`REPEAT` loop, use `EXIT` — see [common-rules.md](../common-rules.md) → Iteration.
- No CSV declaration needed — `RETURN` is a statement, not a variable or FB.
- Everything after an unconditional `RETURN` in the same block is unreachable; the GX Works 2 compiler may warn about it. Keep such code deleted rather than left dead.
- Do **not** use `RETURN` in `PRG_INIT` to emulate a one-time run — one-time execution comes from the program registration (execution condition M8002), not from code.

## RETURN vs RET vs IRET vs EXIT

| Construct | Kind | Where it applies | What it ends |
|---|---|---|---|
| `RETURN;` | ST statement | Any POU body (FUN, FB, PRG) | The current POU body for this scan |
| `RET(EN);` | Ladder instruction | STL step-ladder sequences | The current step (returns to the calling step) — see [RET.md](RET.md) |
| `IRET(EN);` | Ladder instruction | Interrupt routine | The interrupt routine — see [IRET.md](IRET.md) |
| `EXIT;` | ST statement | `FOR`/`WHILE`/`REPEAT` loops | The innermost loop only, execution continues after `END_FOR`/`END_WHILE`/`END_REPEAT` |

## Pitfalls
- **Missing assignment before RETURN (most common bug).** The FUN compiles, but a guard path returns an undefined result — `0` or a leftover from an earlier call. Silent, hard to find. Pattern: assign, then `RETURN`.
- **Using `RETURN` instead of `EXIT` in a loop.** All statements after the loop in the same POU are skipped, so outputs/FB calls at the end of the POU never execute that scan.
- **`RETURN` inside `IF` in a program** silently skips the code below — check that no required-every-scan code (error reset, `WDT(TRUE)`, FB calls) sits after the guard.
- **Several exit paths with different assignments.** Verify every path through the FUN assigns `F_NAME`; single-exit style (one assignment at the end) avoids the problem entirely.

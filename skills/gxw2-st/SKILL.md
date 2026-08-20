---
name: gxw2-st
description: >
  Generates Structured Text (ST) code and CSV variable import files for
  Mitsubishi Electric FX series PLCs (FX3U, FX3G, FX3S, FX5U) in GX Works 2.
  Covers ST syntax, built-in FUN/FB, timers, counters, edge detection, type
  casting, and CSV-based label management.
  Triggers: "GX Works 2", "Mitsubishi FX", "FX3U", "FX3G", "FX3S", "FX5U",
  ST code for Mitsubishi PLC, device addresses X/Y/M/D/T/C,
  Mitsubishi ST syntax, built-in functions, factory automation,
  industrial control ST code, PLC Structured Text.
version: 1.4.2
compatibility: GX Works 2, FX series (FX3U, FX3G, FX3S, FX5U)
---

# GX Works 2 Structured Text — FX Series

Generate ST code and CSV variable import files for Mitsubishi FX series PLCs
in GX Works 2. Every code output must include both `.iecst` code files and `.csv`
variable files for the Label Editor.

## Target Platform

This skill always writes code for **Mitsubishi FX series PLCs** (FX3U, FX3G,
FX3S, FX5U) in **GX Works 2** — never for other vendors or for Q/L/iQ-R series.

- **Generating new code:** if the user did not name a controller, state the
  assumption explicitly: the code targets Mitsubishi FX in GX Works 2.
- **Modifying existing code:** before touching provided ST, verify it is
  Mitsubishi-compatible — device addresses X/Y/M/D/T/C/Z/V/R, Mitsubishi
  function names (`RND` not `ROUND`, `MAXIMUM` not `MAX`), no forbidden
  constructs from [references/common-rules.md](references/common-rules.md).
  If the code is not Mitsubishi ST, say so instead of "fixing" it with FX syntax.

## Workflow: Plan → Generate

This skill uses a **two-phase workflow** to avoid context overload from the
heavy instruction catalog.

### Phase 1 — Planning

1. Load [references/DB/00_Instruction_List.md](references/DB/00_Instruction_List.md) — the full
   180+ instruction catalog.
2. Analyze the task. Identify which instructions are needed, their exact
   signatures, variant availability (`_E`/`P`/`D`), and any model-specific
   restrictions.
3. Also load [references/compatibility.md](references/compatibility.md) if the
   user specified an FX model (FX3U/FX3G/FX3S/FX5U).
4. Produce a **plan** — a detailed blueprint that expands the original task
   with concrete technical decisions. Include:
   - **Original task** — restate the user's request in your own words
   - **POU list** — which Program/FB/FUN units to create, their responsibilities.
     Default project layout = 3 programs: `PRG_INIT` (one-time startup; registered
     in program/task settings with execution condition M8002 — **no M8002 guard in
     code**), `PRG_MAIN` (business logic), `PRG_PROCESS` (error checks, data
     transfer, non-business actions). See
     [references/common-rules.md](references/common-rules.md) → 3-Program Structure.
   - **Instruction selection** — exactly which instructions to use (with full
     signatures, variants `_E`/`P`/`D`, and why this variant fits the task).
     Record the **File** column from the index for each selected instruction
     (e.g. `MOV` → `references/DB/MOV.md`) so Phase 2 can load instruction
     files directly without reloading the index.
   - **Data layout** — which data types, device ranges, and CSV variables are
     needed. Sketch variable names and types.
   - **Code skeletons** — key structures pre-drafted: state machine outline,
     main loops, FB call patterns, critical sections. Not full code, but enough
     structure to make Phase 2 mechanical.
   - **Model-specific notes** — if a model was specified, what restrictions apply
   - **Edge cases** — any gotchas, forbidden constructs to avoid, scan-time risks
5. **No size limit.** The plan is as long as it needs to be. A complex task may
   produce a 60–100 line plan. The plan is the bridge between the catalog and
   the final code — make it thorough.
6. **Drop `references/DB/00_Instruction_List.md` from context after planning.** The plan is all you
   need for Phase 2.

### Phase 2 — Code Generation

1. Load the **mandatory references**:
   - [references/common-rules.md](references/common-rules.md) — always first
   - [references/csv-variables.md](references/csv-variables.md) — always second
2. Load on-demand references as needed by the plan:
   - instruction files recorded in the plan (e.g. `references/DB/MOV.md`) — load only those, never the index
   - [references/data-types.md](references/data-types.md) — type declarations and casting
   - [references/devices.md](references/devices.md) — device addresses (X, Y, M, D, etc.)
   - [references/system-devices.md](references/system-devices.md) — special relays/registers (M8000+, D8000+)
3. Generate `.iecst` and `.csv` files according to the plan.
4. **Do not re-load `references/DB/00_Instruction_List.md`** during code generation — use your plan
   and the lightweight reference files.

---

## Workflow: Modify

When the user asks to **change existing ST code** (fix a bug, add a timer,
rework a state machine), do not regenerate from scratch:

1. Read the existing `.iecst`/`.csv` pair(s) named in the request. Confirm the
   target platform first (see Target Platform above).
2. Produce a **delta plan** — what logic changes, which instructions/FBs are
   added or removed, which CSV variables and FB instances are affected.
3. Load only the instruction files involved (see Instruction File Path Rule).
4. Edit **both** files of each pair — `.iecst` (code) and `.csv` (variables).
   A device or address changed in one file must be changed in the other.
5. Keep the delta plan small; re-run the full Plan → Generate only if the
   change touches program structure (POU list, INIT/MAIN/PROCESS split).

---

## Reference Loading

### Planning Phase Only

| File | When | Size |
|------|------|------|
| [references/DB/00_Instruction_List.md](references/DB/00_Instruction_List.md) | **Phase 1 only.** Full catalog of 180+ instructions with variant tables. Drop after planning. | Heavy (~400 lines) |
| [references/compatibility.md](references/compatibility.md) | **Phase 1 only** if targeting a specific FX model. | Light |

### Always Load (mandatory for every code generation — Phase 2)

| File | Contents |
|------|----------|
| [references/common-rules.md](references/common-rules.md) | Forbidden constructs, naming conventions, literal prefixes, project structure, state machine pattern, edge detection preference |
| [references/csv-variables.md](references/csv-variables.md) | CSV file formats: IO.csv, GVL.csv, local POU CSV, structure CSV, FB/FUN CSV patterns, instance declaration rules |

Read `common-rules.md` first. Read `csv-variables.md` second. Then proceed to
code generation.

### On-Demand (load during Phase 2 as needed)

| File | Load When |
|------|-----------|
| Instruction files from the plan (`references/DB/{File}`) | Load only the instruction files the plan recorded; never the index (see path rule below) |
| [references/data-types.md](references/data-types.md) | Declaring variables, choosing types, writing K/H/E literals, or type casting |
| [references/devices.md](references/devices.md) | Code uses device addresses (X, Y, M, D, T, C, Z, V, R) or digit-specified addressing (`K4X0`) |
| [references/system-devices.md](references/system-devices.md) | Code uses M8000+ special relays or D8000+ special registers |

> **After planning:** Do NOT load `references/DB/00_Instruction_List.md` again. Trust your plan.
> If the plan is missing an instruction detail, consult the instruction files in
> `references/DB/` — see the path rule below.

### Instruction File Path Rule

Each instruction has its own file in `references/DB/`. To get full details
(ST syntax, operands, variants, examples, support):

1. Read the **File** column from your plan (recorded during Phase 1) — e.g. `MOV` → `references/DB/MOV.md`, `ADD` → `references/DB/ADD.md`.
2. If the plan lacks the file name, load [references/DB/00_Instruction_List.md](references/DB/00_Instruction_List.md) **once**, look up the instruction, then drop the index from context again.
3. Load the file at `references/DB/{File}` — the instruction's own file. Never keep the index loaded just to read one instruction.

> Some instructions share one file with a paired instruction (e.g. `SET`/`RST` in `SET.md`, `PLS`/`PLF` in `PLS.md`, `MEP`/`MEF` in `MEP.md`, `OUT_C`/`OUT_C_32` in `OUT_C.md`). The File column always shows the exact filename to load.

> **Single source of truth:** every instruction is documented in **exactly
> one** file — its own `{INSTR}.md` in `references/DB/`, or its group section
> (30–38) when no individual file exists. The index lists each instruction
> once; group sections summarize and link but never restate syntax or
> examples from an instruction's own file. Never add a second description of
> an existing instruction to another file — update its own file instead.

> **All constraints (forbidden constructs, naming, postfix patterns, state
> machine rules, literal prefixes, variable naming) are in
> [references/common-rules.md](references/common-rules.md).**
> Load it in Phase 2 — do not duplicate here.

## Output Structure

Every code generation produces **two file sets**:

1. **`.iecst` files** — code body only. No `VAR...END_VAR` blocks, no inline
   variable declarations, no FB instance declarations.
2. **`.csv` files** — all variables for GX Works 2 Label Editor import.
   Exact column formats and rules in
   [references/csv-variables.md](references/csv-variables.md).

### File Map by POU Type

| POU Type | Files Required |
|----------|---------------|
| Program | `PRG_<NAME>.iecst` + `PRG_<NAME>.csv` |
| Function Block | `FB_<NAME>.iecst` + `FB_<NAME>.csv` |
| Function | `F_<NAME>.iecst` + `F_<NAME>.csv` |
| I/O binding (project-wide) | `IO.csv` |
| Global variables (project-wide) | `GVL.csv` |
| Structure definition | `{StructName}.csv` |

> POU file names carry an ALL-CAPS prefix — `FB_`
> for function blocks, `F_` for functions, `PRG_` for programs (`FB_MOTOR`,
> `F_SCALE_VALUE`, `PRG_MAIN`). FB instances are declared in CamelCase
> (`fbMotor : FB_MOTOR`). Full rules in `references/common-rules.md` → Naming
> Conventions.

### FB Instance Declarations

FB instances (TON, CTU, R_TRIG, user-defined FBs) must be declared as `VAR`
in the CSV of the POU that uses them. For user-defined FBs the instance is
declared in CamelCase with the `fb` prefix: `fbMotor : FB_MOTOR`.



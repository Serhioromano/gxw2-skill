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
version: 1.3.0
compatibility: GX Works 2, FX series (FX3U, FX3G, FX3S, FX5U)
---

# GX Works 2 Structured Text — FX Series

Generate ST code and CSV variable import files for Mitsubishi FX series PLCs
in GX Works 2. Every code output must include both `.st` code files and `.csv`
variable files for the Label Editor.

## Workflow: Plan → Generate

This skill uses a **two-phase workflow** to avoid context overload from the
heavy instruction catalog.

### Phase 1 — Planning

1. Load [references/instruction-db.md](references/instruction-db.md) — the full
   180+ instruction catalog.
2. Analyze the task. Identify which instructions are needed, their exact
   signatures, variant availability (`_E`/`P`/`D`), and any model-specific
   restrictions.
3. Also load [references/compatibility.md](references/compatibility.md) if the
   user specified an FX model (FX3U/FX3G/FX3S/FX5U).
4. Produce a **plan** — a detailed blueprint that expands the original task
   with concrete technical decisions. Include:
   - **Original task** — restate the user's request in your own words
   - **POU list** — which Program/FB/FUN units to create, their responsibilities
   - **Instruction selection** — exactly which instructions to use (with full
     signatures, variants `_E`/`P`/`D`, and why this variant fits the task)
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
6. **Drop `instruction-db.md` from context after planning.** The plan is all you
   need for Phase 2.

### Phase 2 — Code Generation

1. Load the **mandatory references**:
   - [references/common-rules.md](references/common-rules.md) — always first
   - [references/csv-variables.md](references/csv-variables.md) — always second
2. Load on-demand references as needed by the plan:
   - [references/DB/00_Instruction_List.md](references/DB/00_Instruction_List.md) — instruction index; load it to find the instruction file you need
   - [references/data-types.md](references/data-types.md) — type declarations and casting
   - [references/functions.md](references/functions.md) — built-in FUN/FB (timers, counters, strings, etc.)
   - [references/devices.md](references/devices.md) — device addresses (X, Y, M, D, etc.)
   - [references/system-devices.md](references/system-devices.md) — special relays/registers (M8000+, D8000+)
3. Generate `.st` and `.csv` files according to the plan.
4. **Do not re-load `instruction-db.md`** during code generation — use your plan
   and the lightweight reference files.

---

## Reference Loading

### Planning Phase Only

| File | When | Size |
|------|------|------|
| [references/instruction-db.md](references/instruction-db.md) | **Phase 1 only.** Full catalog of 180+ instructions with variant tables. Drop after planning. | Heavy (~400 lines) |
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
| [references/DB/00_Instruction_List.md](references/DB/00_Instruction_List.md) | Using ST instructions from your plan: load this index, find the instruction in the table, then load its individual file (see path rule below) |
| [references/data-types.md](references/data-types.md) | Declaring variables, choosing types, writing K/H/E literals, or type casting |
| [references/functions.md](references/functions.md) | Using built-in FUN/FB: timers, counters, edge detection, math, strings, selection, type casting, user-defined FB/FUN |
| [references/devices.md](references/devices.md) | Code uses device addresses (X, Y, M, D, T, C, Z, V, R) or digit-specified addressing (`K4X0`) |
| [references/system-devices.md](references/system-devices.md) | Code uses M8000+ special relays or D8000+ special registers |

> **After planning:** Do NOT load `instruction-db.md` again. Trust your plan.
> If the plan is missing an instruction detail, consult the instruction files in
> `references/DB/` — see the path rule below.

### Instruction File Path Rule

Each instruction has its own file in `references/DB/`. To get full details
(ST syntax, operands, variants, examples, support):

1. Load [references/DB/00_Instruction_List.md](references/DB/00_Instruction_List.md) — the index of all instruction files.
2. Find the instruction in the table (by name or short description) and read the **File** column.
3. Load the file at `references/DB/{File}` — e.g. instruction `MOV` → `references/DB/MOV.md`, `ADD` → `references/DB/ADD.md`.

> Some instructions share one file with a paired instruction (e.g. `SET`/`RST` in `SET.md`, `PLS`/`PLF` in `PLS.md`, `MEP`/`MEF` in `MEP.md`, `SWAP` in `SWA.md`, `RAMP` in `RAM.md`). The File column always shows the exact filename to load.

> **All constraints (forbidden constructs, naming, postfix patterns, state
> machine rules, literal prefixes, variable naming) are in
> [references/common-rules.md](references/common-rules.md).**
> Load it in Phase 2 — do not duplicate here.

## Output Structure

Every code generation produces **two file sets**:

1. **`.st` files** — code body only. No `VAR...END_VAR` blocks, no inline
   variable declarations, no FB instance declarations.
2. **`.csv` files** — all variables for GX Works 2 Label Editor import.
   Exact column formats and rules in
   [references/csv-variables.md](references/csv-variables.md).

### File Map by POU Type

| POU Type | Files Required |
|----------|---------------|
| Program | `{Name}.st` + `{Name}.csv` |
| Function Block | `{Name}.st` + `{Name}.csv` |
| Function | `{Name}.st` + `{Name}.csv` |
| I/O binding (project-wide) | `IO.csv` |
| Global variables (project-wide) | `GVL.csv` |
| Structure definition | `{StructName}.csv` |

### FB Instance Declarations

FB instances (TON, CTU, R_TRIG, user-defined FBs) must be declared as `VAR`
in the CSV of the POU that uses them.



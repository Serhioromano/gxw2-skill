# Changelog

All notable changes to GXW2-ST will be documented in this file.

## [v1.5.0]

- `change` - **Default project layout is INIT/MAIN/PROCESS (was INIT/ROUTINE/MAIN)**: every project now generates `PRG_INIT` (one-time startup actions; registered in program/task settings with execution condition M8002 — **no M8002 guard inside the code**), `PRG_MAIN` (business logic, every scan), and `PRG_PROCESS` (non-business actions: error checks, alarm handling, data transfer, HMI/comm refresh). Programs communicate only via globals. Updated `references/common-rules.md` (3-Program Structure section), `references/system-devices.md` (usage example — INIT without `IF M8002`, ROUTINE → PROCESS), `SKILL.md` (Phase 1 POU-list default + Modify split name), `README.md` (Three Programs Per Project), `examples/14-pid-control.st` (header note: PID table init moves to PRG_INIT in the 3-program layout). Added example project `examples/15-three-program/` (`PRG_INIT`, `PRG_MAIN`, `PRG_PROCESS` `.st`/`.csv` pairs, UTF-16 LE + BOM).

- `change` - **Global variables use non-volatile ranges (M400+/D200+)**: global variable lists must start M relays at **M400** and D registers at **D200** — these ranges are non-volatile (retentive, survive power loss); never assign globals below M400 / D200. Documented in `references/csv-variables.md` (% Address Numbering section, IO.csv/GVL.csv rules, Variable Generation Rules Summary). Updated `examples/gvl.csv` (M0–M12 → M400–M412, D100–D108 → D200–D208) and `examples/io.csv` (D10–D21 → D210–D221), keeping UTF-16 LE + BOM, tab-separated, all-quoted format.

- `change` - **% Address numbering in global variable lists**: device-bound globals (IO.csv/GVL.csv) use GX Works 2 `%`-notation — `%IX{n}`/`%QX{n}` for X/Y, `%MW{area}.{n}` for 16-bit D (INT/WORD), `%MD{area}.{n}` for 32-bit D (REAL/DINT/DWORD), `%MX{area}.{n}` for M relays, `%MW2.{n}` for R file registers (area 2). Documented in a new `% Address Numbering in Global Variable Lists` section in `references/csv-variables.md`; synced IO.csv/GVL.csv examples and rules (M relays now carry `%MX0.{n}` addresses, removed "M leaves Address empty"). Updated example files `examples/io.csv` (X/Y → `%IX{n}`/`%QX{n}`, D → `%MW0.{n}`) and `examples/gvl.csv` (M → `%MX0.{n}`, INT D → `%MW0.{n}`, REAL/TIME D → `%MD0.{n}`), keeping UTF-16 LE + BOM, tab-separated, all-quoted format.

- `change` - **Global variables are camelCase (Issue #6)**: global variable names MUST be camelCase (`g_xSystemReady`, `g_iCycleCount`, `g_rTemperature`) — never ALL CAPS. ALL CAPS / UPPER_SNAKE_CASE is reserved for constructs only: POU file names (`FB_`, `F_`, `PRG_`), constants (`c_`), and instruction names. Documented in `references/common-rules.md` (Naming Conventions) and `references/csv-variables.md` (GVL.csv rules). Renamed example globals `g_xHMI_Start`/`g_xHMI_Stop`/`g_xHMI_Reset` → `g_xHmiStart`/`g_xHmiStop`/`g_xHmiReset` in `examples/gvl.csv`; synced refs in `examples/03-case-state-machine.st` and `examples/06-counters.st`.

- `change` - **FB/FUN/PRG file naming (Issue #7)**: POU **file names** carry an ALL-CAPS prefix — `FB_` for function blocks, `F_` for functions, `PRG_` for programs (`FB_MOTOR`, `F_SCALE_VALUE`, `PRG_MAIN`). The POU name in the definition area matches the file base name. FB **instances** are declared in CamelCase with the `fb` prefix (`fbMotor : FB_MOTOR`); FUNs are named and called as `F_...` (`rResult := F_SCALE_VALUE(...)`) with no instance declaration. Documented in `references/common-rules.md` (Naming Conventions → FB/FUN/PRG POU and File Naming), `references/csv-variables.md` (FB/FUN CSV patterns), and `SKILL.md` (File Map + FB Instance Declarations). Renamed example pairs: `examples/12-function-block/MotorControl` → `FB_MOTOR`, `examples/13-function/ScaleValue` → `F_SCALE_VALUE`. Built-in FB instances (TON/TOF/TP/CTU/CTD/CTUD/R_TRIG/F_TRIG) keep lowercase type-prefixed names (`tonStart`, `ctParts`, `rtStart`).
- `fix` - Synced `SKILL.md` frontmatter version to 1.4.2 (package.json was bumped at `f222c5e` but the skill frontmatter was left at 1.4.0).

## [v1.4.2]

- `change` - **Global constants require `VAR_GLOBAL_CONSTANT`**: a non-empty Constant column in a global CSV row must use class `VAR_GLOBAL_CONSTANT` (never `VAR_GLOBAL`); `VAR_GLOBAL` rows must leave Constant empty. Documented in `references/csv-variables.md` (Three Variable List Types, Available Classes, GVL.csv example + rules, IO.csv rules, Variable Generation Rules Summary).

- `change` - **Comments: `(* ... *)` only** — GX Works 2 ST does not support `//` line comments. Added mandatory constraint #12 and a Comment Style section to `references/common-rules.md`; converted every code example from `//` to `(* ... *)` in `common-rules.md`, `compatibility.md`, `csv-variables.md`, `devices.md`, `system-devices.md`, and all 37 instruction files in `references/DB/` that used `//` comments.
- `fix` - Synced `SKILL.md` frontmatter version to 1.4.0 (package.json was bumped at `abeb53f` but the skill frontmatter was left at 1.3.0).
- `plan` - Skill feedback loop design (`plans/02-skill-feedback-loop.md`): auto-create GitHub issue when the skill generates incorrect code, with code before/after, root cause, and recommended reference change.
- `change` - **Makefile manages CHANGELOG.md again** (restored from pi-defender): `make publish` automatically renames `## [Unreleased]` → `## [vX.Y.Z]` (idempotent) and creates the GitHub release with notes extracted from CHANGELOG.md, falling back to auto-generated notes when none are found.
- `chore` - Added `make publish v=<patch|minor|major|X.Y.Z>` release workflow (adapted from pi-defender): prereq checks, version bump + tag, npm publish, GitHub release.
- `docs` - README positioned as a Pi package only (not for other agent harnesses); added full `pi install` / `pi update` / `pi remove` instructions.

## [v1.3.0]

- `add` - **Pi package distribution**: repository restructured as a Pi package — the skill lives in `skills/gxw2-st/`, `package.json` declares `pi.skills` and the `pi-package` keyword, MIT `LICENSE` added. Installs with `pi install git:github.com/Serhioromano/gxw2-skill` or `pi install npm:gxw2-skill` (once published).
- `add` - Instruction catalog sections: ANS, HOUR, RAMP, SCL, PWM; EI/DI/WDT use the EN parameter.
- `change` - Removed FOR/NEXT (IEC syntax, covered in common-rules.md).
- `fix` - MOV instruction docs (2-param base + optional EN); removed non-existent `_E` variants from WAND/WOR/WXOR; SHL/SHR/ROL/ROR return values (function-style).

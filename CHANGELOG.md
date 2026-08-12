# Changelog

All notable changes to GXW2-ST will be documented in this file.

## [Unreleased]

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

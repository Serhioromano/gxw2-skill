# GXW2-ST Skill

A skill for Pi Coding Agent that makes the agent an expert in writing **Structured Text (ST)** code for **Mitsubishi Electric FX series PLCs** (FX3U, FX3G, FX3S, FX5U) in **GX Works 2**.

## What This Skill Does

- Generates correct ST code compatible with GX Works 2 FX series compiler
- Generates **CSV variable files** for the GX Works 2 Label Editor (UTF-16 LE, tab-separated)
- Creates function blocks (FB), functions (FUN), and structured programs with proper 2-file pattern (`.st` + `.csv`)
- Knows every GX Works 2 FX-specific constraint:
  - Forbidden constructs (`CONTINUE`, `LREAL`, `SR`/`RS`, named CASE, `VAR_IN_OUT`)
  - Correct Mitsubishi function names (`RND` not `ROUND`, `MAXIMUM` not `MAX`, `LIMITATION` not `LIMIT`)
  - Postfix variants (`_E` triggered, `P` pulse, `D` prefix 32-bit)
  - `:=` for ALL FB parameters including outputs
  - MEP/MEF preferred over R_TRIG/F_TRIG
  - K/H/E/T# literal prefix notation
- Provides state machine patterns (Init→Reset→Idle) and 3-program structure (INIT/ROUTINE/MAIN)

## Versions & Compatibility

| Target Environment | Support |
|--------------------|---------|
| GX Works 2         | ✅ Primary |
| FX3U               | ✅ Full (STRING, all FBs) |
| FX3G               | ✅ (no STRING) |
| FX3S               | ✅ (no STRING, limited I/O) |
| FX5U               | ✅ (use GX Works 3 for primary tooling) |

## Installation

```bash
git clone https://github.com/Serhioromano/gxw2-skill.git
cp -r gxw2-skill ~/.pi/agent/skills/gxw2-st/
```

## Usage

Once the skill is installed, the agent activates on triggers like "GX Works 2", "FX3U", "Mitsubishi ST", or device addresses (X, Y, M, D). It always produces both ST code and CSV variable files.

Example prompts:

- "Write a motor control function block with feedback monitoring for FX3U"
- "Create a state machine for a pump station in ST for GX Works 2"
- "Generate IO.csv and GVL.csv for a 5-pump cascade system"
- "Show me how to use TON/TOF timers in Mitsubishi ST"
- "How do I cast INT to REAL in GX Works 2 ST?"

## Repository Structure

```
gxw2-skill/
├── README.md                        # This file
├── SKILL.md                         # Main skill (triggers, lazy-load index, critical constraints)
├── references/                      # Detailed reference files (loaded on-demand by SKILL.md)
│   ├── common-rules.md              # Mandatory constraints, naming, literal prefixes
│   ├── csv-variables.md             # CSV file formats and Label Editor rules
│   ├── devices.md                   # Device address space (X, Y, M, D, T, C, etc.)
│   ├── system-devices.md            # Special relays (M8000+) and registers (D8000+)
│   ├── instruction-db.md            # Complete 180+ instruction catalog (planning phase only)
│   ├── DB/                           # Per-instruction files (ST syntax, operands, examples)
│   │   └── 00_Instruction_List.md    # Index of all instruction files + how to load them
│   ├── data-types.md                # Types, K/H/E/REAL#/T# literals, casting functions
│   ├── functions.md                 # Built-in FUN/FB catalog: timers, counters, math, strings
│   └── compatibility.md             # FX series feature matrix (FX3U vs FX3G vs FX3S vs FX5U)
├── examples/                        # 14 example pairs (.st + .csv) plus standalone CSVs
│   ├── io.csv                       # Standalone: I/O variable list (DI_/DO_/AI_/AO_)
│   ├── gvl.csv                      # Standalone: Global variable list (g_ prefix)
│   ├── pou-local.csv                # Standalone: Local POU variable template
│   ├── structure.csv                # Standalone: Structure definition example
│   ├── 01-io-assignment.st + .csv
│   ├── 02-conditionals.st + .csv
│   ├── 03-case-state-machine.st + .csv
│   ├── 04-loops.st + .csv
│   ├── 05-timers.st + .csv
│   ├── 06-counters.st + .csv
│   ├── 07-math.st + .csv
│   ├── 08-strings.st + .csv
│   ├── 09-bit-operations.st + .csv
│   ├── 10-type-casting.st + .csv
│   ├── 11-edge-detection.st + .csv
│   ├── 12-function-block/MotorControl.st + .csv
│   ├── 13-function/ScaleValue.st + .csv
│   └── 14-pid-control.st + .csv
```

## Key Design Decisions

### CSV-First Variable Management
GX Works 2 uses the **Label Editor** for variables, not inline `VAR...END_VAR` blocks. This skill always generates paired `.st` code files and `.csv` label files in **UTF-16 LE with BOM, tab-separated, all values quoted** — exactly the format GX Works 2 expects for CSV import.

### FX Series Only
No Q-series, L-series, or iQ-R constructs. The skill targets the FX compiler's specific limitations: no `CONTINUE`, no `LREAL`, no `SR`/`RS` FBs, no `VAR_IN_OUT`, no named CASE labels, and no trigonometric functions (`SIN`, `COS`, `TAN`, etc.).

### Three Programs Per Project
Every project follows the INIT → ROUTINE → MAIN structure:
- **INIT** — runs once on first scan (M8002)
- **ROUTINE** — runs every 100ms for non-critical tasks
- **MAIN** — runs every scan with all business logic

### State Machine Convention
All state machines start with states 0 (Init), 10 (Reset), 20 (Idle). Integer values only, no CONSTANT declarations for state names.

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.3.0 | 2025-07-31 | Added ANS, HOUR, RAMP, SCL, PWM sections; EI/DI/WDT use EN parameter; removed FOR/NEXT (IEC syntax, covered in common-rules.md) |
| 1.2.0 | 2025-07-31 | All instruction signatures use EN as first parameter; SHL/SHR/ROL/ROR return values (function-style); PID example uses EN-first MOV |
| 1.1.0 | 2025-07-31 | Clarified MOV instruction docs (2-param base + optional EN), removed non-existent `_E` variants from WAND/WOR/WXOR, cleaned PID example, improved SKILL.md triggers |
| 1.0.1 | 2025-07-31 | Fixed MOV `_E` in instruction-db, added CSV UTF-16 LE warning, initial SKILL.md trigger improvement |
| 1.0.0 | 2025-07-30 | Initial release |

## Author

Serhioromano

## License

MIT

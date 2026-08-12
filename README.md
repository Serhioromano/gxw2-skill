# GXW2-ST — Pi Package (Extension)

A **package for the [Pi Coding Agent](https://github.com/earendil-works/pi)** that makes the agent an expert in writing **Structured Text (ST)** code for **Mitsubishi Electric FX series PLCs** (FX3U, FX3G, FX3S, FX5U) in **GX Works 2**.

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
- Provides state machine patterns (Init→Reset→Idle) and 3-program structure (INIT/MAIN/PROCESS)

## Versions & Compatibility

| Target Environment | Support |
|--------------------|---------|
| GX Works 2         | ✅ Primary |
| FX3U               | ✅ Full (STRING, all FBs) |
| FX3G               | ✅ (no STRING) |
| FX3S               | ✅ (no STRING, limited I/O) |
| FX5U               | ✅ (use GX Works 3 for primary tooling) |

## Installation

This repository is a **Pi package**. It installs with one command and is
auto-discovered by the Pi Coding Agent as the `gxw2-st` skill.

### From GitHub (recommended)

```bash
pi install git:github.com/Serhioromano/gxw2-skill
```

### From npm

```bash
pi install npm:gxw2-skill
```

### From a local checkout (development)

```bash
pi install /path/to/gxw2-skill
```

### Project-local install

Install for a specific project instead of globally; Pi installs missing
packages automatically on startup after the project is trusted:

```bash
pi install -l git:github.com/Serhioromano/gxw2-skill
```

### Verify

```bash
pi list      # the package appears in the list
pi config    # the gxw2-st skill is enabled
```

Load the skill on demand with `/skill:gxw2-st`, or just describe your task —
the agent auto-activates the skill on topics like "GX Works 2", "FX3U",
"Mitsubishi ST", or device addresses (X, Y, M, D).

### Update

```bash
pi update git:github.com/Serhioromano/gxw2-skill
```

### Remove

```bash
pi remove git:github.com/Serhioromano/gxw2-skill
```

## Usage

Once installed, the agent activates on triggers like "GX Works 2", "FX3U", "Mitsubishi ST", or device addresses (X, Y, M, D). It always produces both ST code and CSV variable files.

Example prompts:

- "Write a motor control function block with feedback monitoring for FX3U"
- "Create a state machine for a pump station in ST for GX Works 2"
- "Generate IO.csv and GVL.csv for a 5-pump cascade system"
- "Show me how to use TON/TOF timers in Mitsubishi ST"
- "How do I cast INT to REAL in GX Works 2 ST?"

## Development

- The skill lives in `skills/gxw2-st/`; all its internal links are relative to
  that directory, so moving/installing the folder keeps them valid.
- The package manifest (`pi.skills`) points at `./skills`; pi discovers
  `SKILL.md` recursively there.
- Version numbers in `package.json` and `skills/gxw2-st/SKILL.md` frontmatter
  must stay in sync.

## Key Design Decisions

### CSV-First Variable Management
GX Works 2 uses the **Label Editor** for variables, not inline `VAR...END_VAR` blocks. This skill always generates paired `.st` code files and `.csv` label files in **UTF-16 LE with BOM, tab-separated, all values quoted** — exactly the format GX Works 2 expects for CSV import.

### FX Series Only
No Q-series, L-series, or iQ-R constructs. The skill targets the FX compiler's specific limitations: no `CONTINUE`, no `LREAL`, no `SR`/`RS` FBs, no `VAR_IN_OUT`, no named CASE labels, and no trigonometric functions (`SIN`, `COS`, `TAN`, etc.).

### Three Programs Per Project
Every project follows the INIT → MAIN → PROCESS structure:
- **PRG_INIT** — one-time startup actions; registered in program/task settings
  with execution condition M8002 so the PLC runs it once — **no M8002 guard in code**
- **PRG_MAIN** — runs every scan with all business logic
- **PRG_PROCESS** — runs every scan; non-business actions: error checks, alarm
  handling, data transfer, HMI/comm refresh

### State Machine Convention
All state machines start with states 0 (Init), 10 (Reset), 20 (Idle). Integer values only, no CONSTANT declarations for state names.

## Author

Serhioromano

## License

MIT

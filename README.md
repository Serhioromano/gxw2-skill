# GXW2-ST Skill

A skill for Pi Coding Agent that helps write Structured Text (ST) code for **GX Works 2** (Mitsubishi Electric PLCs).

## What This Skill Does

- Writes correct ST code compatible with GX Works 2
- Provides syntax guidance and dialect specifics for Mitsubishi ST (FX / Q / L series)
- Generates function blocks (FB), functions (FUN), and structured programs
- Understands GX Works 2 constraints: supported data types, instructions, built-in functions
- Accounts for GX Works 2 compiler quirks and IEC compatibility

## Versions & Compatibility

| Target Environment | Support |
|--------------------|---------|
| GX Works 2         | ✅ Primary |
| GX Works 3         | ⚠️ Partial (ST syntax is similar, but differences exist) |
| FX Series          | ✅ FX3U, FX3G |

## Installation

```bash
# Clone the repository
git clone https://github.com/Serhioromano/gxw2-skill.git

# Copy the skill into Pi's skills folder
cp -r gxw2-skill ~/.pi/agent/skills/gxw2-st/
```

Alternatively, use as an external skill via Pi configuration.

## Usage

Once the skill is installed, ask Pi about ST programming tasks:

- "Write a function block for a PID controller in ST for GX Works 2"
- "Convert this ladder diagram to ST for Mitsubishi FX3U"
- "Check this ST code for GX Works 2 compatibility"
- "Explain how timers work in ST for Q-series"

## Repository Structure

```
gxw2-skill/
├── README.md           # This file
├── SKILL.md            # Skill definition for Pi
├── prompts/            # Prompts for various scenarios
│   ├── st-syntax.md    # ST syntax reference
│   ├── fb-generator.md # Function block generation
│   └── debug.md        # ST code debugging
└── examples/           # ST code examples
    ├── basics/         # Basic examples
    └── advanced/       # Advanced examples
```

## GX Works 2 ST Specifics

The ST dialect in GX Works 2 differs from standard IEC 61131-3 ST:

- Limited data type set (no LREAL, WSTRING, etc.)
- Device-specific syntax for bit operations (SET/RST)
- Specific variable declaration rules (VAR, VAR_GLOBAL, VAR_INPUT/OUTPUT)
- Array and string handling constraints
- Missing certain modern constructs (CONTINUE, named CASE steps)

This skill accounts for all these specifics and generates code that compiles without errors.

## Author

Serhioromano

## License

MIT

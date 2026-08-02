# Changelog

All notable changes to GXW2-ST will be documented in this file.

## [Unreleased]

## [v1.3.0]

- `add` - **Pi package distribution**: repository restructured as a Pi package — the skill lives in `skills/gxw2-st/`, `package.json` declares `pi.skills` and the `pi-package` keyword, MIT `LICENSE` added. Installs with `pi install git:github.com/Serhioromano/gxw2-skill` or `pi install npm:gxw2-skill` (once published).
- `add` - Instruction catalog sections: ANS, HOUR, RAMP, SCL, PWM; EI/DI/WDT use the EN parameter.
- `change` - Removed FOR/NEXT (IEC syntax, covered in common-rules.md).
- `fix` - MOV instruction docs (2-param base + optional EN); removed non-existent `_E` variants from WAND/WOR/WXOR; SHL/SHR/ROL/ROR return values (function-style).

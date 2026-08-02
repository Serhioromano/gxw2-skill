# DI — DI / Disable Interrupt

Manual section: **7.5**, page **120**. Index names: DI.

## Purpose
This instruction disables interrupts after interrupts were enabled by EI instruction.

## ST Syntax (GX Works 2)
- `DI(EN);`

## Operands
- **EN**: Execution condition [Bit]
- **ENO**: Execution state [Bit]

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
```iecst
DI(TRUE);    // Disable interrupts (globally)
// ... critical section (cannot be interrupted) ...
EI(TRUE);
```

## Key Rules
- `DI(EN)` — disables interrupts when EN is TRUE
- Typical pattern: `DI(TRUE); ... critical section ... EI(TRUE);`
- Does NOT disable the scan watchdog timer
- No CSV declaration needed

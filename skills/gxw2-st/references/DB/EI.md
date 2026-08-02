# EI — EI / Enable Interrupt

Manual section: **7.6**, page **121**. Index names: EI.

## Purpose
Interrupts are usually disabled in PLCs. This instruction enables interrupts in PLCs. Use it for the input interrupt, timer interrupt and counter interrupt functions.

## ST Syntax (GX Works 2)
- `EI(EN);`

## Operands
- **EN**: Input condition [Bit]
- **ENO**: Input status [Bit]

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
```iecst
EI(TRUE);    (* Enable interrupts (after DI) *)
```

## Key Rules
- `EI(EN)` — enables interrupts when EN is TRUE
- Typical pattern: `DI(TRUE); ... critical section ... EI(TRUE);`
- Interrupt POUs must end with `IRET;` (returns to main program)
- Does NOT disable the scan watchdog timer
- No CSV declaration needed

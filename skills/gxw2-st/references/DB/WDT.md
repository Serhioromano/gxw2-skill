# WDT — WDT / Watchdog Timer Refresh

Manual section: **7.8**, page **125**. Index names: WDT.

## Purpose
This instruction refreshes the watchdog timer in a sequence program.

## ST Syntax (GX Works 2)
- `WDT(EN);`
- `WDTP(EN);`

## Operands
- **EN**: Execution condition [Bit]
- **ENO**: Execution state [Bit]

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
```iecst
WDT(TRUE);    // Reset watchdog timer (unconditional)
WDTP(xTrig);  // Pulse (one-shot on rising edge)

(* Typical use: inside long loops *)
FOR i := 0 TO 10000 DO
    // ... lengthy operation ...
    IF (i MOD 100) = 0 THEN
        WDT(TRUE);  // Reset WDT every 100 iterations
    END_IF;
END_FOR;
```

## Key Rules
- `WDT(EN)` — resets watchdog when EN is TRUE; `WDTP(EN)` — pulse variant
- Default scan watchdog: 200ms. Extended by `WDT` to 200ms from the point of execution
- No CSV declaration needed

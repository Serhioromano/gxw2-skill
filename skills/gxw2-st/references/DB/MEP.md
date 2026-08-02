# MEP — MEP, MEF

Manual section: **5.9**, page **79**. Index names: MEP, MEF.

## Purpose
MEP returns TRUE for one scan on the rising edge of the input. MEF returns TRUE for one scan on the falling edge of the input. Inline edge detection — preferred over R_TRIG/F_TRIG FBs.

## ST Syntax (GX Works 2)
- `MEP(EN);`
- `MEF(EN);`

## Operands
- **EN**: Execution condition [Bit]
- **ENO**: Execution state [Bit]

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
```iecst
IF MEP(xStart) THEN
    iCount := iCount + 1;       (* Increment once per rising edge *)
END_IF;

xPulse := MEP(xSensor);         (* Use directly in assignment *)
```

## Key Rules
- Returns a BOOL value for inline use in IF/assignment — no destination device needed
- Preferred over R_TRIG/F_TRIG FBs: no CSV declaration, works inline
- No CSV declaration needed

# SET — SET, RST

Manual section: **5.10**, page **81**. Index names: SET, RST.

## Purpose
SET sets a bit device ON (holding operation). RST resets a bit device OFF. They replace the SR and RS function blocks (not available on FX series).

## ST Syntax (GX Works 2)
- `SET(EN,d);`
- `RST(EN,d);`

## Operands
- **EN**: Execution condition [Bit]
- **ENO**: Execution state [Bit]
- **d**: Bit device or variable (Y, M, S, bit of word device)

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
```iecst
SET(xAlarmCondition, Y0);        // Y0 latches ON when xAlarmCondition rises
SET(xStart, M100);               // M100 latches ON
RST(xResetButton, Y0);           // Y0 cleared when xResetButton is TRUE
RST(xStop, M100);                // M100 cleared
```

## Key Rules
- When EN is TRUE, destination is set/reset **every scan** (not edge-triggered)
- If both SET and RST EN are TRUE in the same scan, the **last one executed wins**
- SET has priority over OUT/`:=` assignment to the same device — a SET device cannot be cleared by `:= FALSE`
- No CSV declaration needed

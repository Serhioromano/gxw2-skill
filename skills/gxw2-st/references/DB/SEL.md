# SEL — SEL / Selection

Manual section: **10.1**, page **190**. Index names: SEL.

## Purpose
This function selects either one between two data in accordance with the input condition, and outputs the selection result.

## ST Syntax (GX Works 2)
- `SEL_E(EN,_G,_IN0,_IN1,Output_label);`
- `SEL(_G,_IN0,_IN1);`

## Operands
- **EN**: Execution condition [Bit]
- **_G**: Selector: FALSE → IN0, TRUE → IN1 [Bit]
- **_IN0**: Value returned when G is FALSE
- **_IN1**: Value returned when G is TRUE
- **ENO**: Execution status [Bit]
- **d**: Device which will store the selection result

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
```iecst
g_word3 := SEL(g_bool1, g_word1, g_word2);
g_bool3 := SEL_E(g_bool1, g_bool2, g_word1, g_word2, g_word3);
```

## Key Rules
- `SEL` is an expression (returns a value) — use in assignments, not as a standalone statement
- IN0 and IN1 must be the same data type
- With `_E` the function returns only the ENO flag; result goes to the last parameter `d`

# SHL — SHL / Shift Left

Manual section: **8.1**, page **176**. Index names: SHL.

## Purpose
This function shifts data of specified bit length leftward by the specified number of bits.

## ST Syntax (GX Works 2)
- `SHL_E(EN,_IN,_N,Output_label);`
- `SHL(_IN,_N);`

## Operands
- **EN**: Execution condition [Bit]
- **_IN**: Word device which stores data to be shifted leftward [ANY_BIT]
- **_N**: Number of shifted bits [ANY_BIT]
- **ENO**: Execution status [Bit]
- **d**: Device which will store the shift result [ANY_BIT]

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
```iecst
wResult := SHL(wVal, K4);              (* returns value *)
g_bool3 := SHL_E(g_bool1, g_word1, g_const_word1, g_word2);  (* triggered *)
dwResult := DSHL(dwVal, K8);           (* 32-bit *)
DSHL_E(xTrig, dwVal, K8, dwResult);    (* 32-bit triggered *)
```

## Key Rules
- Without `_E`: returns a value (function-style). With `_E`: triggered, stores in last parameter
- `D` prefix for 32-bit (DWORD): `DSHL`, `DSHL_E`
- SHIFT discards bits pushed out (unlike ROTATE which wraps them)

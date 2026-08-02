# Time Functions (Time Data Types)

Functions from the [Application Functions] manual (doc2), section **13**. Index names: `ADD_TIME(_E)`, `SUB_TIME(_E)`, `MUL_TIME(_E)`, `DIV_TIME(_E)`.

## The idea

| Function | Operation |
|----------|-----------|
| `ADD_TIME` | Adds time data (TIME + TIME = TIME) |
| `SUB_TIME` | Subtracts time data (TIME − TIME = TIME) |
| `MUL_TIME` | Multiplies time data by a number (TIME × N = TIME) |
| `DIV_TIME` | Divides time data by a number (TIME ÷ N = TIME) |

## Syntax (GX Works 2)

All functions share the same `_E` pattern — first parameter is the condition (`EN`), result goes to the last parameter:

```iecst
ADD_TIME_E(EN, IN1, IN2, d);    (* IN1, IN2: TIME *)
SUB_TIME_E(EN, IN1, IN2, d);    (* IN1, IN2: TIME *)
MUL_TIME_E(EN, IN1, IN2, d);    (* IN1: TIME, IN2: ANY_NUM *)
DIV_TIME_E(EN, IN1, IN2, d);    (* IN1: TIME, IN2: ANY_NUM *)
```

- `EN`: Execution condition [Bit]
- `IN1`: Time data [Time]
- `IN2`: Time data (`ADD_TIME`/`SUB_TIME`) or number (`MUL_TIME`/`DIV_TIME`) [Time / ANY_NUM]
- `ENO`: Execution status [Bit]
- `d`: Operation result [Time]

> With the `_E` form the function returns **only the ENO flag** (executed or not); the result is written to the last parameter `d`. Without `_E` — returns the result directly: `g := ADD_TIME(IN1, IN2);`

## Support

- FX3U: ✓ (all)
- FX3G: ✓ (all)

## Examples (ST, from the manual)

```iecst
g_time3 := ADD_TIME(g_time1, g_time2);
g_bool3 := ADD_TIME_E(g_bool1, g_time1, g_time2, g_time3);
g_time3 := SUB_TIME(g_time1, g_time2);
g_time2 := MUL_TIME(g_time1, g_int1);
g_time2 := DIV_TIME(g_time1, g_int1);
```

> TIME values are stored in ms as DINT (2 D registers). For simple offset math, `T#` literals and native `+`/`-` on DINT work as well.

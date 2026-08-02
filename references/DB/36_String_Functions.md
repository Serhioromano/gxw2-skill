# String Functions (Character String)

Functions from the [Application Functions] manual (doc2), section **12**. Index names: `MID(_E)`, `CONCAT(_E)`, `INSERT(_E)`, `DELETE(_E)`, `REPLACE(_E)`, `FIND(_E)`.

## The idea

| Function | Operation |
|----------|-----------|
| `MID`     | Extracts a substring from a specified position |
| `CONCAT`  | Concatenates character strings |
| `INSERT`  | Inserts a character string at a specified position |
| `DELETE`  | Deletes a specified number of characters |
| `REPLACE` | Replaces a character string |
| `FIND`    | Searches for a character string, outputs position |

## Syntax (GX Works 2)

All functions share the same `_E` pattern — first parameter is the condition (`EN`), result goes to the last parameter:

```iecst
MID_E(EN, IN, L, P, d);         (* substring: L chars from position P *)
CONCAT_E(EN, IN1, IN2, d);      (* concatenate *)
INSERT_E(EN, IN1, IN2, P, d);   (* insert IN2 into IN1 at position P *)
DELETE_E(EN, IN, L, P, d);      (* delete L chars from position P *)
REPLACE_E(EN, IN1, IN2, L, P, d); (* replace L chars of IN1 with IN2 at P *)
FIND_E(EN, IN1, IN2, d);        (* position of IN2 in IN1, result is INT *)
```

- `EN`: Execution condition [Bit]
- `IN`, `IN1`, `IN2`: Character strings [String]
- `L`: Number of characters [INT]
- `P`: Position [INT]
- `ENO`: Execution status [Bit]
- `d`: Result string (or INT position for `FIND`) [String / Word]

> With the `_E` form the function returns **only the ENO flag** (executed or not); the result is written to the last parameter `d`. Without `_E` — returns the result directly: `g := CONCAT(IN1, IN2);`

## Support

- FX3U: ✓ (all)
- FX3G: — (no STRING support on FX3G)

## Examples (ST, from the manual)

```iecst
g_string2 := MID(g_string1, g_int1, g_int2);
g_bool3 := MID_E(g_bool1, g_string1, g_int1, g_int2, g_string2);
g_string3 := CONCAT(g_string1, g_string2);
g_string3 := INSERT(g_string1, g_string2, g_int1);
g_string2 := DELETE(g_string1, g_int1, g_int2);
g_string3 := REPLACE(g_string1, g_string2, g_int1, g_int2);
g_int1 := FIND(g_string1, g_string2);
```

# SCL — SCL / Scaling (Coordinate by Point Data)

Manual section: **29.4**, page **691**. Index names: SCL.

## Purpose
This instruction executes scaling of the input value using a specified data table, and outputs the result. SCL2 is also available with a different data table configuration for scaling. → For SCL2 instruction, refer to Section 29.7.

## ST Syntax (GX Works 2)
- `SCL(EN,s1,s2,d);`
- `SCLP(EN,s1,s2,d);`
- `DSCL(EN,s1,s2,d);`
- `DSCLP(EN,s1,s2,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s1**: Input value used in scaling or device storing the input value [ANY16/ANY32]
- **s2**: Head device storing the conversion table used in scaling [ANY16/ANY32]
- **ENO**: Execution state [Bit]
- **d**: Device storing the output value controlled by scaling [ANY16/ANY32]

## Support
- FX3U: —
- FX3G: —

## Examples (ST, from the manual)
```iecst
SCL(TRUE, wRawValue, D300, wScaled);
SCLP(xTrig, wRawValue, D300, wScaled);  (* Pulse *)
```

## Key Rules
- SCL scales using a multi-point point table; SCL2 uses 2-point X/Y data (single linear segment)
- **SCL point-data table format (S2):** first word at `(s2)` holds the point count N. Each point n (1-indexed) occupies two words — X at `(s2) + (2n − 1)`, Y at `(s2) + 2n`. Total table length is `1 + 2N` words
- SCL interpolates the source value between the nearest X breakpoints
- No `_E` or `D` variants
- No CSV declaration needed

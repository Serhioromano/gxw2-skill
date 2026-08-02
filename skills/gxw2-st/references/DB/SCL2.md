# SCL2 — SCL2 / Scaling 2 (Coordinate by X/Y Data)

Manual section: **29.7**, page **702**. Index names: SCL2.

## Purpose
This instruction executes scaling of the input value using a specified data table, and outputs the result. SCL instruction is also available with a different data table configuration for scaling. → For SCL instruction, refer to Section 29.4.

## ST Syntax (GX Works 2)
- `SCL2(EN,s1,s2,d);`
- `SCL2P(EN,s1,s2,d);`
- `DSCL2(EN,s1,s2,d);`
- `DSCL2P(EN,s1,s2,d);`

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
SCL2(M8000, D0, R0, D10);
SCL2(TRUE, wRawValue, D400, wScaled);
SCL2P(xTrig, wRawValue, D400, wScaled); // Pulse
```

## Key Rules
- SCL2 scales using 2-point X/Y coordinates (single linear segment); SCL uses a multi-point table
- **SCL2 point-data table format (S2):** (s2)+0 = number of points (= 2), (s2)+1 = X1, (s2)+2 = Y1, (s2)+3 = X2, (s2)+4 = Y2
- No `_E` or `D` variants
- No CSV declaration needed

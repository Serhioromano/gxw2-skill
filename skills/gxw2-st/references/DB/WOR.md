# WOR — WOR / Logical Word OR

Manual section: **9.8**, page **187**. Index names: WOR.

## Purpose
This instruction executes the logical sum (OR) operation of two numeric values.

## ST Syntax (GX Works 2)
- `WOR(EN,s1,s2,d);`
- `WORP(EN,s1,s2,d);`
- `DOR(EN,s1,s2,d);`
- `DORP(EN,s1,s2,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s1**: Data used for logical sum or word device storing data [ANY16/ANY32]
- **s2**: Data used for logical sum or word device storing data [ANY16/ANY32]
- **ENO**: Execution state [Bit]
- **d**: Device storing the logical sum result [Word/ANY16/ANY32]

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
```iecst
WOR(TRUE, wOutput, H0001, wOutput);      (* Set bit 0 without affecting others *)
WORP(xTrig, wA, wB, wResult);            (* Pulse *)
DOR(TRUE, dwA, dwB, dwResult);           (* 32-bit *)
DORP(xTrig, dwA, dwB, dwResult);         (* 32-bit pulse *)
```

## Key Rules
- Bitwise logic on 16-bit WORD values. Required because ST logical operators (`AND`, `OR`, `XOR`) work on BOOL only
- Variants: `WORP` (pulse), `DOR` (32-bit), `DORP` (32-bit pulse)
- No CSV declaration needed

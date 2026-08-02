# WXOR — WXOR / Logical Exclusive OR

Manual section: **9.9**, page **189**. Index names: WXOR.

## Purpose
This instruction executes the exclusive logical sum (XOR) operation of two numeric values.

## ST Syntax (GX Works 2)
- `WXOR(EN,s1,s2,d);`
- `WXORP(EN,s1,s2,d);`
- `DXOR(EN,s1,s2,d);`
- `DXORP(EN,s1,s2,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s1**: Data used for exclusive logical sum or word device storing data [ANY16/ANY32]
- **s2**: Data used for exclusive logical sum or word device storing data [ANY16/ANY32]
- **ENO**: Execution state [Bit]
- **d**: Device storing the exclusive logical sum result [Word/ANY16/ANY32]

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
```iecst
WXOR(TRUE, wFlags, HFFFF, wInverted);    (* Invert all 16 bits *)
WXORP(xTrig, wA, wB, wResult);           (* Pulse *)
DXOR(TRUE, dwA, dwB, dwResult);          (* 32-bit *)
DXORP(xTrig, dwA, dwB, dwResult);        (* 32-bit pulse *)
```

## Key Rules
- Bitwise logic on 16-bit WORD values. Required because ST logical operators (`AND`, `OR`, `XOR`) work on BOOL only
- Variants: `WXORP` (pulse), `DXOR` (32-bit), `DXORP` (32-bit pulse)
- No `WNEG` (word negate) exists — use `WXOR(wVal, HFFFF, wResult)` for bitwise NOT
- No CSV declaration needed

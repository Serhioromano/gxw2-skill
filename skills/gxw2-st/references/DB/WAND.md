# WAND — WAND / Logical Word AND

Manual section: **9.7**, page **185**. Index names: WAND.

## Purpose
This instruction executes the logical product (AND) operation of two numeric values.

## ST Syntax (GX Works 2)
- `WAND(EN,s1,s2,d);`
- `WANDP(EN,s1,s2,d);`
- `DAND(EN,s1,s2,d);`
- `DANDP(EN,s1,s2,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s1**: Data used for logical product or word device storing data [ANY16/ANY32]
- **s2**: Data used for logical product or word device storing data [ANY16/ANY32]
- **ENO**: Execution state [Bit]
- **d**: Device storing the logical product result [Word/ANY16/ANY32]

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
```iecst
WAND(TRUE, wStatus, H00FF, wLowByte);    // Extract lower 8 bits
WANDP(xTrig, wA, wB, wResult);           // Pulse
DAND(TRUE, dwA, dwB, dwResult);          // 32-bit
DANDP(xTrig, dwA, dwB, dwResult);        // 32-bit pulse
```

## Key Rules
- Bitwise logic on 16-bit WORD values. Required because ST logical operators (`AND`, `OR`, `XOR`) work on BOOL only
- Variants: `WANDP` (pulse), `DAND` (32-bit), `DANDP` (32-bit pulse)
- No CSV declaration needed

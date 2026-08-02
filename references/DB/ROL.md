# ROL — ROL / Rotation Left

Manual section: **10.2**, page **199**. Index names: ROL.

## Purpose
This instruction shifts and rotates the bit information leftward by the specified number of bits without the carry flag.

## ST Syntax (GX Works 2)
- `ROL(EN,s,n,d);`
- `ROLP(EN,s,n,d);`
- `DROL(EN,s,n,d);`
- `DROLP(EN,s,n,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s**: Device storing data to be rotated leftward [Word/ANY16/ANY32]
- **n**: Number of bits to rotate
- **ENO**: Execution state [Bit]
- **d**: Result device [Word/ANY16/ANY32]

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
```iecst
wResult := ROL(wVal, K4);                // rotated left 4 (returns value)
ROL(TRUE, D0, K4, D0);                   // rotate D0 left by 4 bits
DROL(TRUE, g_dword1, K8, g_dword1);      // 32-bit rotate left (32-bit variable required)
DROLP(xTrig, dwVal, K8, dwResult);       // 32-bit pulse
```

## Key Rules
- ROTATE wraps bits pushed out to the other end (unlike SHIFT which discards them)
- 32-bit variants (`DROL`, `DROLP`) require a 32-bit variable (DINT/DWORD/REAL) — passing a raw 16-bit device like `D10` gives "invalid data format"
- No CSV declaration needed

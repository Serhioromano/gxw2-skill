# ROR — ROR / Rotation Right

Manual section: **10.1**, page **196**. Index names: ROR.

## Purpose
This instruction shifts and rotates the bit information rightward by the specified number of bits without the carry flag.

## ST Syntax (GX Works 2)
- `ROR(EN,s,n,d);`
- `RORP(EN,s,n,d);`
- `DROR(EN,s,n,d);`
- `DRORP(EN,s,n,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s**: Device storing data to be rotated rightward [Word/ANY16/ANY32]
- **n**: Number of bits to rotate
- **ENO**: Execution state [Bit]
- **d**: Result device [Word/ANY16/ANY32]

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
```iecst
wResult := ROR(wVal, K4);                // rotated right 4 (returns value)
ROR(TRUE, D0, K4, D0);                   // rotate D0 right by 4 bits
DROR(TRUE, g_dword1, K8, g_dword1);      // 32-bit rotate right (32-bit variable required)
DRORP(xTrig, dwVal, K8, dwResult);       // 32-bit pulse
```

## Key Rules
- ROTATE wraps bits pushed out to the other end (unlike SHIFT which discards them)
- 32-bit variants (`DROR`, `DRORP`) require a 32-bit variable (DINT/DWORD/REAL) — passing a raw 16-bit device like `D10` gives "invalid data format"
- No CSV declaration needed

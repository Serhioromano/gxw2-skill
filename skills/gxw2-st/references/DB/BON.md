# BON — BON / Check Specified Bit Status

Manual section: **11.5**, page **239**. Index names: BON.

## Purpose
This instruction checks whether a specified bit position in a device is ON or OFF.

## ST Syntax (GX Works 2)
- `BON(EN,s,n,d);`
- `BONP(EN,s,n,d);`
- `DBON(EN,s,n,d);`
- `DBONP(EN,s,n,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s**: Device storing the data [Word/ANY16/ANY32]
- **n**: Bit position to be checked [Bit]
- **ENO**: Execution state [Bit]
- **d**: Bit device to be driven [Bit]

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
```iecst
BON(X000, D10, K9, M0);
BON(TRUE, wStatus, K3, M20);     // M20 := bit 3 of wStatus
BON(TRUE, dwEncoder, K15, xBit15);
BON_E(xTrig, wStatus, K3, M20);  // Triggered
BONP(xTrig, wStatus, K3, M20);   // Pulse
DBON(TRUE, dwVal, K31, xBit31);  // 32-bit
```

## Key Rules
- `BON(EN, S, N, D)` — D := (bit N of S) ? TRUE : FALSE
- In ST, `xResult := (wVal AND H0008) <> WORD#0;` is equivalent for simple bit tests. Use BON when pulse/triggered execution is needed
- No CSV declaration needed

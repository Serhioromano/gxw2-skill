# DHCMOV — DHCMOV / High Speed Counter Move

Manual section: **24.5**, page **596**. Index names: DHCMOV.

## Purpose
This instruction transfers the current value of a specified high speed counter or ring counter. The function of this instruction varies depending on the PLC version.

## ST Syntax (GX Works 2)
- `DHCMOV(EN,s,n,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s**: Device of high speed counter or ring counter handled as transfer source [ANY32]
- **ENO**: Execution state [Bit]
- **n**: Device handled as transfer destination [ANY32]

## Support
- FX3U: ✓
- FX3G: —

## Examples (ST, from the manual)
```iecst
DHCMOV(M8394,C235,K1,D200);
```

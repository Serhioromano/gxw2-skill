# DHSCS — DHSCS, DHSCS_I / High Speed Counter Set, High Speed Interrupt Counter Set

Manual section: **12.4**, page **267**. Index names: DHSCS, DHSCS_I.

## Purpose
These instructions compare a value counted by a high speed counter with a specified value at each count, and execute the following processing. • DHSCS: Sets an external output (Y). • DHSCS_I: Executes an interrupt program.

## ST Syntax (GX Works 2)
- `DHSCS(EN,s1,s2,d);`
- `DHSCS_I(EN,s1,s2);`

## Operands
- **Instruction**: Instruction
- **EN**: Execution condition [Bit]
- **s1**: Device of a high speed counter [ANY32]
- **EN0**: Execution state [Bit]
- **s2**: Bit device to be set to ON when the compared two values are equivalent to each other [Bit]
- **DHSCS_I**: DHSCS_I [ANY32]
- **d**: agree. [ANY16]

## Support
- FX3U: —
- FX3G: —

## Examples (ST, from the manual)
```iecst
DHSCS(M8000,K100,CN251,Y010);
DHSCS(M8000,K150,CN251,Y011);
```

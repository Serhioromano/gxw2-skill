# VRRD — VRRD / Volume Read

Manual section: **15.6**, page **406**. Index names: VRRD.

## Purpose
This instruction reads out the value determined by the variable resistor.

## ST Syntax (GX Works 2)
- `VRRD(EN,s,d);`
- `VRRDP(EN,s,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s**: Variable resistor No. to be read out [ANY16]
- **ENO**: Execution state [Bit]
- **d**: variable Storage destination of variable resistor value [ANY16]

## Support
- FX3U: —
- FX3G: —

## Examples (ST, from the manual)
```iecst
VRRD(M8000, K0Z, D200Z);
```

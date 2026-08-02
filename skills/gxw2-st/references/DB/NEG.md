# NEG — NEG / Negation

Manual section: **9.10**, page **192**. Index names: NEG.

## Purpose
This instruction obtains the 2's complement of a numeric value (by inverting each bit and adding "1"). A sign of a numeric value can be converted by this instruction.

## ST Syntax (GX Works 2)
- `NEG(EN,d);`
- `NEGP(EN,d);`
- `DNEG(EN,d);`
- `DNEGP(EN,d);`

## Operands
- **EN**: Execution condition [Bit]
- **ENO**: Execution state [Bit]
- **d**: Device which stores data for obtaining complement and will store the operation result [ANY16/ANY32]

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
```iecst
NEG(TRUE, iVal);               // iVal := -iVal (always)
NEGP(xTrig, iVal);             // Pulse
DNEG(TRUE, diVal);             // 32-bit
ENEG(TRUE, rVal);              // Floating point negation
```

## Key Rules
- Two's complement: `D := 0 − D`
- In ST, `iVal := -iVal;` is equivalent and preferred for INT/DINT. Use `NEG` when pulse execution is needed (`NEGP`)
- No CSV declaration needed

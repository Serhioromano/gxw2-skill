# SPD — SPD / Speed Detection

Manual section: **12.7**, page **292**. Index names: SPD.

## Purpose
This instruction counts the input pulse for a specified period of time as interrupt input. The function of this instruction varies depending on the version.

## ST Syntax (GX Works 2)
- `SPD(EN,s1,s2,d);`
- `DSPD(EN,s1,s2,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s1**: Input variable [Bit]
- **s2**: Time data (ms) or word device storing the data [ANY16/ANY32]
- **EN0**: Execution state [Bit]

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
_not extracted_

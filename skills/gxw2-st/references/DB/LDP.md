# LDP — LDP, LDF, ANDP, ANDF, ORP, ORF

Manual section: **5.2**, page **57**. Index names: LDP, LDF, ANDP, ANDF, ORP, ORF.

## Purpose
Contact instructions LDP, ANDP, and ORP detect the rising edge, and become active during one operation cycle only at the rising edge of a specified bit device (that is, when the bit device turns ON from OFF). Contact instructions LDF, ANDF and ORF detect the falling edge, and become active during one operation cycle only at the falling edge of a specified bit device (that is, when the bit device turns OFF from ON).

## ST Syntax (GX Works 2)
- `LDP(EN,s);`
- `LDF(EN,s);`
- `ANDP(EN,s);`
- `ANDF(EN,s);`
- `ORP(EN,s);`
- `ORF(EN,s);`

## Operands
- **EN**: Execution condition
- **s**: Except LDP, LDF : [BOOL]
- **?**: Applicable devices [Bit]
- **ENO**: Execution state [Bit]

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
_not extracted_

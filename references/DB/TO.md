# TO — TO / Write To A Special Function Block

Manual section: **14.10**, page **386**. Index names: TO.

## Purpose
This instruction writes data from PLC into the buffer memory (BFM) of special extension unit/block. By this instruction, when data is written into multiple buffer memories (BFM) in batch a watchdog timer error may occur. When there is no bad influence for the control if the data is divided and written in, you can use WBFM instruction.

## ST Syntax (GX Works 2)
- `TO(EN,s);`
- `TOP(EN,s);`
- `DTO(EN,s);`
- `DTOP(EN,s);`

## Operands
- **EN**: Execution condition [Bit]
- **s**: 16-bit operation: n3 points occupied [ANY16/ANY32]
- **?**: ANY32*1 [ANY16]
- **?**: Transfer destination buffer memory (BFM) number [ANY16]
- **?**: Number of transfer points [ANY16]
- **ENO**: Execution state [Bit]
- **?**: operation is . [ANY16]

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
_not extracted_

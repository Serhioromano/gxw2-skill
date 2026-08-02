# RMRD — RMRD / Read from F2-32RM

Manual section: **16.6**, page **427**. Index names: RMRD.

## Purpose
Processing) (High Speed  Applied Instructions This instruction reads out the ON/OFF state of output of the F2-32RM type programmable cam switch to the PLC.

## ST Syntax (GX Works 2)
- `RMRD(EN,s,d1,d2);`
- `RMRDP(EN,s,d1,d2);`
- `DRMRD(EN,s,d1,d2);`
- `DRMRDP(EN,s,d1,d2);`

## Operands
- **EN**: Execution condition [Bit]
- **ENO**: Execution state [Bit]
- **s**: device for storing output status (ON/OFF). [Bit]
- **d1**: 16-bit operation: 16 points occupied [Bit]
- **Operand**: Operand
- **d2**: System user Digit designation user unit Index stant Number Pointer [String]
- **DRMRD**: DRMRD
- **DRMRDP**: DRMRDP

## Support
- FX3U: —
- FX3G: —

## Examples (ST, from the manual)
_not extracted_

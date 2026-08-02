# IVRD — IVRD / Inverter Parameter Read

Manual section: **30.3**, page **714**. Index names: IVRD.

## Purpose
This instruction reads an inverter parameter to the PLC using the computer link operation function of the inverter. This instruction corresponds to the EXTR (K12) instruction in the FX2N and FX2NC series PLCs. → For detailed explanation of the instruction, refer to the Data Communication Edition manual.

## ST Syntax (GX Works 2)
- `IVRD(EN,s1,s2,n,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s1**: Inverter station number [ANY16]
- **s2**: Inverter parameter number [ANY16]
- **n**: Channel to be used (K1:ch1,K2:ch2*1) [ANY16]
- **ENO**: Execution state [Bit]
- **d**: Device storing the read value [ANY16]

## Support
- FX3U: ✓
- FX3G: —

## Examples (ST, from the manual)
_not extracted_

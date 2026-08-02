# IVWR — IVWR / Inverter Parameter Write

Manual section: **30.4**, page **716**. Index names: IVWR.

## Purpose
This instruction writes a parameter of an inverter using the computer link operation function of the inverter. This instruction corresponds to the EXTR (K13) instruction in the FX2N and FX2NC series PLCs. → For detailed explanation of the instruction, refer to the Data Communication Edition manual.

## ST Syntax (GX Works 2)
- `IVWR(EN,s1,s2,n);`

## Operands
- **EN**: Execution condition [Bit]
- **s1**: Inverter station number [ANY16]
- **s2**: Inverter parameter number [ANY16]
- **n**: Set value to be written to the inverter parameter or device storing the data [ANY16]
- **?**: Channel to be used (K1:ch1,K2:ch2*1) [ANY16]
- **ENO**: Execution state [Bit]

## Support
- FX3U: ✓
- FX3G: —

## Examples (ST, from the manual)
_not extracted_

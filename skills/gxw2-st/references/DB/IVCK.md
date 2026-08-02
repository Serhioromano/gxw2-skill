# IVCK — IVCK / Inverter Status Check

Manual section: **30.1**, page **708**. Index names: IVCK.

## Purpose
This instruction reads the operation status of an inverter to a PLC using the computer link operation function of the inverter. Applicable inverters vary depending on the version. This instruction corresponds to the EXTR (K10) instruction in the FX2N and FX2NC series. → For detailed explanation of the instruction, refer to the Data Communication Edition manual.

## ST Syntax (GX Works 2)
- `IVCK(EN,s1,s2,n,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s1**: Inverter station number [ANY16]
- **s2**: Inverter instruction code [ANY16]
- **n**: Channel to be used (K1:ch1,K2:ch2*1) [ANY16]
- **ENO**: Execution state [Bit]
- **d**: Device storing the read value [ANY16]

## Support
- FX3U: ✓
- FX3G: —

## Examples (ST, from the manual)
_not extracted_

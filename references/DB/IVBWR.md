# IVBWR — IVBWR / Inverter Parameter Block Write

Manual section: **30.5**, page **719**. Index names: IVBWR.

## Purpose
(External Device) Applied Instructions This instruction writes parameters of an inverter at one time using the computer link operation function of the inverter. → For detailed explanation of the instruction, refer to the Data Communication Edition manual.

## ST Syntax (GX Works 2)
- `IVBWR(EN,s1,s2,n);`

## Operands
- **EN**: Execution condition [Bit]
- **s1**: Inverter station number [ANY16]
- **s2**: variable Number of parameters in an inverter to be written at one time. [ANY16]
- **n**: Head device of a parameter table to be written to an inverter [ANY16]
- **?**: Channel to be used (K1:ch1,K2:ch2) [ANY16]
- **ENO**: Execution state [Bit]

## Support
- FX3U: ✓
- FX3G: —

## Examples (ST, from the manual)
_not extracted_

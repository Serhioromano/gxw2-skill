# IVDR — IVDR / Inverter Drive

Manual section: **30.2**, page **711**. Index names: IVDR.

## Purpose
(External Device) Applied Instructions This instruction writes a inverter operation required control value to the PLC using the computer link operation function of the inverter. This instruction corresponds to the EXTR (K11) instruction in the FX2N and FX2NC series PLCs.

## ST Syntax (GX Works 2)
- `IVDR(EN,s1,s2,n);`

## Operands
- **EN**: EN Execution condition Operation) (Block Data Applied Instructions [Bit]
- **s1**: Inverter station number [ANY16]
- **s2**: Inverter instruction code [ANY16]
- **n**: Channel to be used (K1:ch1, K2:ch2*1) [ANY16]
- **?**: Control) (Character Applied Instructions [String]
- **ENO**: Execution state [Bit]

## Support
- FX3U: ✓
- FX3G: —

## Examples (ST, from the manual)
_not extracted_

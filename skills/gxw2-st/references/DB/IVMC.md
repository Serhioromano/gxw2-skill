# IVMC — IVMC / Inverter Multi Command

Manual section: **30.6**, page **721**. Index names: IVMC.

## Purpose
(External Device) Applied Instructions This instruction writes 2 types of settings (operation command and set frequency) to the inverter, and reads 2 types of data (inverter status monitor, output frequency, etc.) from the inverter at the same time. → For detailed explanation of the instruction, refer to the Data Communication Edition manual.

## ST Syntax (GX Works 2)
- `IVMC(EN,s1,s2,n,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s1**: Inverter station number (K0 to K31) [ANY16]
- **s2**: Multiple instructions for inverter: Send/receive data type specification [ANY16]
- **n**: Channel to be used (K1: ch1, K2: ch2*1) [ANY16]
- **ENO**: Execution state [Bit]
- **d**: Devices Devices Others (Data Operation 3) Applied Instructions [Word/Bit]
- **Operand**: Operand [Real]
- **?**: Number [String]
- **H0000**: H0000
- **H0001**: H0001
- **H0011**: H0011

## Support
- FX3U: —
- FX3G: —

## Examples (ST, from the manual)
_not extracted_

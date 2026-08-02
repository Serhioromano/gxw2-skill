# RS2 — RS2 / Serial Communication 2

Manual section: **15.8**, page **411**. Index names: RS2.

## Purpose
Processing) (High Speed  Applied Instructions This instruction transmits and receives data by no-procedure communication via serial port of RS-232C or RS-485 installed in the basic unit. In the case of FX3G and FX3GC PLCs, data can be transmitted and received by no-procedure communication

## ST Syntax (GX Works 2)
- `RS2(EN,s,n,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s**: 16-bit processing mode: m÷2 points *1 occupied [ANY16]
- **n**: variable Number of transmission data bytes [Setting range: 0 to 4096] [ANY16]
- **d**: Number of reception data bytes [Setting range: 0 to 4096] [ANY16]
- **?**: Used channel number [Setting content: K0: ch0, K1: ch1, K2: ch2]*2 (External Device) Applied Instructions [ANY16]
- **ENO**: Execution state [Bit]

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
_not extracted_

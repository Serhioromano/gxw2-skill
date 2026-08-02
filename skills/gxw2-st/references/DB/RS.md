# RS — RS / Serial Communication

Manual section: **15.1**, page **390**. Index names: RS.

## Purpose
This instruction sends and receives data in no-protocol communication by way of a serial port (only the ch1) in accordance with RS-232C or RS-485 provided in the main unit.

## ST Syntax (GX Works 2)
- `RS(EN,s,n,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s**: Head device storing data to be sent [ANY16]
- **n**: Number of bytes of data to be sent [ANY16]
- **d**: Number of bytes to be received [ANY16]
- **ENO**: Execution state [Bit]
- **?**: Head device storing received data when receiving is completed [ANY16]

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
_not extracted_

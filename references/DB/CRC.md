# CRC — CRC / Cyclic Redundancy Check

Manual section: **24.4**, page **592**. Index names: CRC.

## Purpose
This CRC instruction calculates the CRC (cyclic redundancy check) value which is an error check method used in communication. In addition to CRC value, there are other error check methods such as parity check and sum check. For obtaining the horizontal parity value and sum check value, CCD instruction is available. For the generation of

## ST Syntax (GX Works 2)
- `CRC(EN,s,n,d);`
- `CRCP(EN,s,n,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s**: Head device storing data for which the CRC value is generated [ANY16]
- **n**: Number of 8-bit (byte) data for which the CRC value is generated or the [ANY16]
- **ENO**: Execution state [Bit]
- **d**: Device storing the generated CRC value [ANY16]

## Support
- FX3U: ✓
- FX3G: —

## Examples (ST, from the manual)
```iecst
CRC(TRUE,D100,K7,D0);
```

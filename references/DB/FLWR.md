# FLWR — FLWR / Data write

Manual section: **34.3**, page **781**. Index names: FLWR.

## Purpose
Processing 2) (High Speed  Applied Instructions The FLWR instruction writes data to the CompactFlashTM card or to the buffer inside the FX3U-CF-ADP. → As for explanation of the instruction, see the FX3U-CF-ADP User's Manual.

## ST Syntax (GX Works 2)
- `FLWR(EN,s1,s2,n,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s1**: File ID (Refer to Detailed explanation of setting data) Function and Pulse Catch Interrupt Function [ANY16]
- **s2**: Data write parameter (Refer to Detailed explanation of setting data) ARRAY [0..4] OF [ANY16]
- **n**: Used channel number [contents of setting : K1 = ch1, K2 = ch2] A [ANY16]
- **ENO**: Execution state [Bit]
- **d**: Position after data writing (Refer to Detailed explanation of setting data) ARRAY [0..1] OF [ANY16]

## Support
- FX3U: —
- FX3G: —

## Examples (ST, from the manual)
_not extracted_

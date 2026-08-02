# SFTL — SFTL / Bit Shift Left

Manual section: **10.6**, page **210**. Index names: SFTL.

## Purpose
This instruction shifts bit devices of the specified bit length leftward by the specified number of bits.

## ST Syntax (GX Works 2)
- `SFTL(EN,s,d,n1,n2);`
- `SFTLP(EN,s,d,n1,n2);`

## Operands
- **EN**: Execution condition [Bit]
- **s**: Shift-in data source (bit device)
- **d**: Head of shift register (bit device)
- **n1**: Length of shift register (words)
- **n2**: Number of bits to shift
- **ENO**: Execution state [Bit]

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
```iecst
SFTL(TRUE, xNewBit, M0, K4, K1); // Shift M0–M63 left by 1, xNewBit → M63
SFTLP(xTrig, xNewBit, M0, K4, K1); // Pulse
```

## Key Rules
- Multi-word shift register: shifts N bits across a range of consecutive word devices
- `WSFL` — word shift register (shifts whole words, not bits)
- For simple bit shifts on a single WORD, use `SHL`/`SHR`
- Use SFTR/SFTL for tracking sequences (conveyor tracking, FIFO history)
- No CSV declaration needed

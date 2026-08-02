# SFTR — SFTR / Bit Shift Right

Manual section: **10.5**, page **208**. Index names: SFTR.

## Purpose
This instruction shifts bit devices of the specified bit length rightward by the specified number of bits.

## ST Syntax (GX Works 2)
- `SFTR(EN,s,d,n1,n2);`
- `SFTRP(EN,s,d,n1,n2);`

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
SFTR(TRUE, xNewBit, M0, K4, K1); // Shift M0–M63 right by 1, xNewBit → M0
SFTRP(xTrig, xNewBit, M0, K4, K1); // Pulse
```

## Key Rules
- Multi-word shift register: shifts N bits across a range of consecutive word devices
- `WSFR` — word shift register (shifts whole words, not bits)
- For simple bit shifts on a single WORD, use `SHL`/`SHR`
- Use SFTR/SFTL for tracking sequences (conveyor tracking, FIFO history)
- No CSV declaration needed

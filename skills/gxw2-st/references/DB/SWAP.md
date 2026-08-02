# SWA — SWAP / Byte Swap

Manual section: **19.6**, page **510**. Index names: SWAP.

## Purpose
This instruction swaps higher 8 bits and lower 8 bits of word data.

## ST Syntax (GX Works 2)
- `SWAP(EN,s);`
- `SWAPP(EN,s);`
- `DSWAP(EN,s);`
- `DSWAPP(EN,s);`

## Operands
- **EN**: Execution condition [Bit]
- **s**: Device for swapping higher and lower bytes [ANY16/ANY32]
- **ENO**: Execution state [Bit]

## Support
- FX3U: ✓
- FX3G: —

## Examples (ST, from the manual)
```iecst
SWAP(TRUE, wData);       (* Swap bytes: 0xAABB → 0xBBAA (always) *)
SWAPP(xTrig, wData);     (* Pulse *)
DSWAP(TRUE, dwData);     (* 32-bit (swaps high/low word) *)
```

## Key Rules
- Common uses: endianness conversion for communication protocols, rearranging data from network byte order
- No CSV declaration needed

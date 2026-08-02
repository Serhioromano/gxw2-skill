# DECO — DECO / Decode

Manual section: **11.2**, page **229**. Index names: DECO.

## Purpose
This instruction converts numeric data into an ON bit. The bit number set to ON indicates the numeric value.

## ST Syntax (GX Works 2)
- `DECO(EN,s,d,n);`
- `DECOP(EN,s,d,n);`

## Operands
- **EN**: Execution condition [Bit]
- **s**: Word: integer value to decode
- **d**: Bit device: destination bit (M, Y)
- **n**: Number of bits to decode (1–8)
- **ENO**: Execution state [Bit]

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
```iecst
DECO(TRUE, iStep, M0, K3);     (* If iStep=5 → M5 ON, others OFF (3 bits → 0–7) *)
DECOP(xTrig, iStep, M0, K3);   (* Pulse *)
```

## Key Rules
- Decode N bits of S → set a single bit in D at position = value of S
- D is a bit device (M, Y). N=3 → 8 values (0–7), N=4 → 16 values (0–15), etc.
- No CSV declaration needed

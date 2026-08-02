# ENCO — ENCO / Encode

Manual section: **11.3**, page **233**. Index names: ENCO.

## Purpose
This instruction obtains positions in which bits are ON in data.

## ST Syntax (GX Works 2)
- `ENCO(EN,s,d,n);`
- `ENCOP(EN,s,d,n);`

## Operands
- **EN**: Execution condition [Bit]
- **s**: Bit device start: bit group to scan
- **d**: Word: result integer
- **n**: Number of bits to encode (1–8, 2^N bits scanned)
- **ENO**: Execution state [Bit]

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
```iecst
ENCO(TRUE, M0, iPos, K3);      (* If M5 is ON → iPos := 5 (2^N bits of S encoded) *)
ENCOP(xTrig, M0, iPos, K3);    (* Pulse *)
```

## Key Rules
- Encode bit position of S → D (N bits). S is a bit device, D is a word device
- N=3 → 8 values (0–7), N=4 → 16 values (0–15), etc.
- No CSV declaration needed

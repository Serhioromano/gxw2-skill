# TWR — TWR / Set RTC data

Manual section: **21.8**, page **559**. Index names: TWR.

## Purpose
(External Device) Applied Instructions The clock data is written into the real-time clock built in the PLC. When using FX2NC PLC, optional memory board for Real time clock is required.

## ST Syntax (GX Works 2)
- `TWR(EN,s);`
- `TWRP(EN,s);`

## Operands
- **EN**: Execution condition [Bit]
- **ENO**: Execution state [Bit]
- **s**: Control) (Character Applied Instructions [String]
- **Operand**: Operand [Real]
- **?**: Number [String]
- **?**: FXCPU Structured Programming Manual 21 Applied Instructions ( Clock Control) [Time/Real]
- **?**: FXCPU Structured Programming Manual 21 Applied Instructions ( Clock Control) [Time/Real]
- **?**: Clock Control) ( Applied Instructions [Time/Real]
- **LDP**: (External Device) Applied Instructions
- **d**: X000 s
- **?**: Control) (Character Applied Instructions [String]
- **K2000**: K2000
- **?**: FXCPU Structured Programming Manual 21 Applied Instructions ( Clock Control) [Time/Real]
- **?**: FXCPU Structured Programming Manual 21 Applied Instructions ( Clock Control) [Time/Real]

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
```iecst
TWR(M0,D0);
```

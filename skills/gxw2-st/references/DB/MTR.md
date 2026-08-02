# MTR — MTR / Input Matrix

Manual section: **12.3**, page **263**. Index names: MTR.

## Purpose
Processing) (High Speed  Applied Instructions This instruction reads matrix input as 8-point input × "n" output (transistor) in the time division method.

## ST Syntax (GX Works 2)
- `MTR(EN,s,n,d1,d2);`

## Operands
- **EN**: Execution condition [Bit]
- **s**: variable X000, X010, X020, ..., final input X number (Only "0" is allowed in the [Bit]
- **n**: Number of columns in matrix input (K2 to K8/H2 to H8) [ANY16]
- **d1**: ENO Execution state (optional device)) (External Device Applied Instructions [Bit]
- **d2**: Y000, Y010, Y020, ..., final output Y number (Only "0" is allowed in the [Bit]

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
```iecst
MTR(M0,X020,K3,Y020,M30);
```

# INCD — INCD / Incremental Drum Sequencer

Manual section: **13.4**, page **331**. Index names: INCD.

## Purpose
Processing) (High Speed  Applied Instructions This is a command for creating multiple output patterns by using a pair of counters.

## ST Syntax (GX Works 2)
- `INCD(EN,s1,s2,n,d);`

## Operands
- **EN**: Execution condition [Bit]
- **s1**: Beginning word device for storing the set value [ANY16]
- **s2**: variable Beginning device of counter for present value monitor (2 points occupied) 15 [ANY16]
- **n**: Number of bit devices to be output [ANY16]
- **ENO**: Execution state [Bit]
- **d**: variable Beginning bit device to be output (n points occupied) [Bit]

## Support
- FX3U: ✓
- FX3G: ✓

## Examples (ST, from the manual)
_not extracted_

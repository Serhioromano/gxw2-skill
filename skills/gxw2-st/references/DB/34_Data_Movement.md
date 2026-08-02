# Data Movement (Move Operations)

Functions/instructions from the [Application Functions] manual (doc2), section **7.7** (MOVE) and **8.3/8.6/8.7** (MOV, BMOV, FMOV). Move/copy data between devices.

## The idea

| Function | Operation |
|----------|-----------|
| `MOV`  | Instruction: transfers (copies) contents of a device to another device |
| `BMOV` | Block move: transfers a specified number of data at one time |
| `FMOV` | Fill move: transfers the same data to a specified number of devices |

## Variants

`MOVE` is a function with `_E` trigger. `MOV` is an instruction with the full variant set:

| Variant | Meaning |
|---------|---------|
| `MOV`   | Base form |
| `MOVP`  | Pulse execution (one scan) |
| `DMOV`  | 32-bit (DINT/DWORD/REAL) |
| `DMOVP` | 32-bit + pulse |

`BMOV` also has `BMOVP`; `FMOV` has `FMOVP` and 32-bit `DFMOV`/`DFMOVP`.

## Syntax (GX Works 2)

```iecst
MOV(EN, s, d);          (* instruction *)
DMOV(EN, s, d);         (* 32-bit instruction *)
BMOV(EN, s, n, d);      (* block move, n = number of points *)
FMOV(EN, s, n, d);      (* fill move, n = number of points *)
```

- `EN`: Execution condition [Bit]
- `s`: Transfer source data or device [ANY16/ANY32]
- `n`: Number of transfer points [ANY16]
- `ENO`: Execution state [Bit]
- `d`: Transfer destination device [ANY16/ANY32]

> With the `_E` form the function returns **only the ENO flag**; the result is written to the last parameter `d`.

## Support

- FX3U: ✓ (all)
- FX3G: ✓ (all)

## Examples (ST, from the manual)

```iecst
MOV(X001, TN0, D20);
MOV(X002, K100, D10);
MOV(NOT X002, K50, D10);
MOV(M8000, K1X000, K1Y000);
FMOV(X000, K0, K5, D0);
```

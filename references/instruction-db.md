# GX Works 2 — Complete Instruction Catalog (FX Series)

> **Planning-phase only.** Load this file during Phase 1 to select instructions
> and build a plan. Drop it before Phase 2 (code generation). Do NOT keep in
> context while writing code — use your plan and the per-instruction files in
> [DB/00_Instruction_List.md](DB/00_Instruction_List.md).

Full catalog of GX Works 2 instructions with variant availability
(`_E`, `P`, `D`) and typed input parameters.

> **ST focus:** Instructions marked ❌ ladder-only are not usable in ST.
> Instructions marked ⚠️ have special ST syntax or limited variant support.
> For ST code examples and usage patterns, load the per-instruction files from
> [DB/00_Instruction_List.md](DB/00_Instruction_List.md).

Legend:
- `_E` = triggered (16-bit only; 32-bit `D` variants do **not** have `_E`), `P` = pulse, `D` = 32-bit (prefix), `DP` = 32-bit + pulse.
- **Parameters:** `EN` = enable (always first; pass `TRUE` for unconditional execution). `D` = destination — **always the last parameter** (except for instructions with multiple destinations where D1/D2 are last).
- **Type tags:** `BOOL_*` = bit device (X/Y/M/S), `ANY16_*` = 16-bit word (D/T/C/K), `ANY_SIMPLE_*` = any simple type, `STRING(N)_*` = string of N chars, `ARRAY [a..b] OF ...` = multi-register range.
- All ST function calls accept `EN` as the first argument: `INSTR(TRUE, ...)` for unconditional.

---

## 1. Data Move Instructions

| Instruction | Parameters | Description | `_E` | `P` | `D` |
|-------------|------------|-------------|:---:|:---:|:---:|
| `MOV` | `EN, ANY16_s, ANY16_d` | Move data: (S) → (D) | — | `MOVP` | `DMOV`, `DMOVP` |
| `SMOV` | `EN, ANY16_s, ANY16_m1, ANY16_m2, ANY16_n, ANY16_d` | Shift move (digit-wise): m1=digit pos in S, m2=#digits, n=start digit in D | — | `SMOVP` | — |
| `CML` | `EN, ANY16_s, ANY16_d` | Complement (bit-invert then move) | — | `CMLP` | `DCML`, `DCMLP` |
| `BMOV` | `EN, ANY16_s, ANY16_n, ANY16_d` | Block move: copy n words from S to D | — | `BMOVP` | — |
| `FMOV` | `EN, ANY16_s, ANY16_n, ANY16_d` | Fill move: write same value to n registers | — | `FMOVP` | `DFMOV`, `DFMOVP` |
| `XCH` | `EN, ANY16_d1, ANY16_d2` | Exchange: swap contents of two devices | — | `XCHP` | `DXCH`, `DXCHP` |
| `SWAP` | `EN, ANY16_d` | Byte swap (high/low byte of word) | — | `SWAPP` | `DSWAP`, `DSWAPP` |
| `EMOV` | `EN, REAL_s, REAL_d` | Floating point move (REAL) | — | `EMOVP` | — |
| `HCMOV` | `❓ Verify` | High-speed counter move | — | — | — |
| `PRUN` | `EN, ANY16_s, ANY16_d` | Parallel run (octal mode) | — | `PRUNP` | `DPRUN`, `DPRUNP` |

---

## 2. Data Conversion Instructions

| Instruction | Parameters | Description | `_E` | `P` | `D` |
|-------------|------------|-------------|:---:|:---:|:---:|
| `BCD` | `EN, ANY16_s, ANY16_d` | Binary → BCD conversion | — | `BCDP` | `DBCD`, `DBCDP` |
| `BIN` | `EN, ANY16_s, ANY16_d` | BCD → Binary conversion | — | `BINP` | `DBIN`, `DBINP` |
| `GRY` | `EN, ANY16_s, ANY16_d` | Decimal → Gray code | — | `GRYP` | `DGRY`, `DGRYP` |
| `GBIN` | `EN, ANY16_s, ANY16_d` | Gray code → Decimal | — | `GBINP` | `DGBIN`, `DGBINP` |
| `FLT` | `EN, ANY16_s, REAL_d` | Integer → Floating point (REAL) | — | `FLTP` | `DFLT`, `DFLTP` |
| `INT` | `EN, REAL_s, ANY16_d` | Floating point → Integer (truncates) | — | `INTP` | `DINT`, `DINTP` |
| `EBCD` | `EN, REAL_s, REAL_d` | REAL → Scientific notation | — | `EBCDP` | — |
| `EBIN` | `EN, REAL_s, REAL_d` | Scientific notation → REAL | — | `EBINP` | — |
| `RAD` | `EN, REAL_s, REAL_d` | Degrees → Radians (REAL) | — | `RADP` | — |
| `DEG` | `EN, REAL_s, REAL_d` | Radians → Degrees (REAL) | — | `DEGP` | — |

> In ST, prefer IEC type-cast functions: `INT_TO_REAL`, `REAL_TO_INT`, `DINT_TO_REAL`,
> `WORD_TO_INT`, etc. See [data-types.md](data-types.md).

---

## 3. Arithmetic Operation Instructions

| Instruction | Parameters | Description | `_E` | `P` | `D` |
|-------------|------------|-------------|:---:|:---:|:---:|
| `ADD` | `EN, ANY16_s1, ANY16_s2, ANY16_d` | Addition: (S1)+(S2) → (D) | `ADD_E` | `ADDP` | `DADD`, `DADDP` |
| `SUB` | `EN, ANY16_s1, ANY16_s2, ANY16_d` | Subtraction: (S1)−(S2) → (D) | `SUB_E` | `SUBP` | `DSUB`, `DSUBP` |
| `MUL` | `EN, ANY16_s1, ANY16_s2, ANY16_d` | Multiplication: (S1)×(S2) → (D,D+1) | `MUL_E` | `MULP` | `DMUL`, `DMULP` |
| `DIV` | `EN, ANY16_s1, ANY16_s2, ANY16_d` | Division: (S1)÷(S2) → Quotient(D), Remainder(D+1) | `DIV_E` | `DIVP` | `DDIV`, `DDIVP` |
| `EADD` | `EN, REAL_s1, REAL_s2, REAL_d` | Floating point addition | `EADD_E` | `EADDP` | — |
| `ESUB` | `EN, REAL_s1, REAL_s2, REAL_d` | Floating point subtraction | `ESUB_E` | `ESUBP` | — |
| `EMUL` | `EN, REAL_s1, REAL_s2, REAL_d` | Floating point multiplication | `EMUL_E` | `EMULP` | — |
| `EDIV` | `EN, REAL_s1, REAL_s2, REAL_d` | Floating point division | `EDIV_E` | `EDIVP` | — |
| `INC` | `EN, ANY16_d` | Increment: (D)+1 → (D) | — | `INCP` | `DINC`, `DINCP` |
| `DEC` | `EN, ANY16_d` | Decrement: (D)−1 → (D) | — | `DECP` | `DDEC`, `DDECP` |

> For WORD/DWORD arithmetic in ST, prefer `+`, `-`, `*`, `/` operators on INT/DINT types.
> Use `ADD_E`/`DADD` etc. only when dealing with unsigned WORD/DWORD types or when
> pulse/triggered execution is required. See the per-instruction files in [DB/](DB/00_Instruction_List.md).

---

## 4. Logical Operation Instructions

| Instruction | Parameters | Description | `_E` | `P` | `D` |
|-------------|------------|-------------|:---:|:---:|:---:|
| `WAND` | `EN, ANY16_s1, ANY16_s2, ANY16_d` | Word AND: (S1) AND (S2) → (D) | — | `WANDP` | `DAND`, `DANDP` |
| `WOR` | `EN, ANY16_s1, ANY16_s2, ANY16_d` | Word OR: (S1) OR (S2) → (D) | — | `WORP` | `DOR`, `DORP` |
| `WXOR` | `EN, ANY16_s1, ANY16_s2, ANY16_d` | Word XOR: (S1) XOR (S2) → (D) | — | `WXORP` | `DXOR`, `DXORP` |

> Essential for bit masking on WORD/DWORD types. ST logical operators (`AND`, `OR`, `XOR`)
> work on BOOL only. Use WAND/WOR/WXOR for word-level bit manipulation. `WNEG`/`WNEGP` not
> available; use `CML` (complement) instead.

---

## 5. Rotate Instructions

| Instruction | Parameters | Description | `_E` | `P` | `D` |
|-------------|------------|-------------|:---:|:---:|:---:|
| `ROR` | `EN, ANY16_n, ANY16_d` | Rotate right: rotate D right by n bits | — | `RORP` | `DROR`, `DRORP` |
| `ROL` | `EN, ANY16_n, ANY16_d` | Rotate left: rotate D left by n bits | — | `ROLP` | `DROL`, `DROLP` |
| `RCR` | `EN, ANY16_n, ANY16_d` | Rotate right with carry: includes M8022 carry flag | — | `RCRP` | `DRCR`, `DRCRP` |
| `RCL` | `EN, ANY16_n, ANY16_d` | Rotate left with carry: includes M8022 carry flag | — | `RCLP` | `DRCL`, `DRCLP` |

> ST aliases: `SHL`, `SHR`, `ROL`, `ROR` with `_E` and `D` variants.
> See the per-instruction files in [DB/](DB/00_Instruction_List.md) for ST syntax.

---

## 6. Shift Instructions

| Instruction | Parameters | Description | `_E` | `P` | `D` |
|-------------|------------|-------------|:---:|:---:|:---:|
| `SFTR` | `EN, ANY16_s, ANY16_n1, ANY16_n2, ANY16_d` | Bit shift right (multi-word): n1=shift register length (bits), n2=#bits to shift | — | `SFTRP` | — |
| `SFTL` | `EN, ANY16_s, ANY16_n1, ANY16_n2, ANY16_d` | Bit shift left (multi-word): n1=shift register length, n2=#bits to shift | — | `SFTLP` | — |
| `SFR` | `EN, ANY16_n, ANY16_d` | Bit shift right of n bits in D, with carry (M8022) | — | `SFRP` | — |
| `SFL` | `EN, ANY16_n, ANY16_d` | Bit shift left of n bits in D, with carry (M8022) | — | `SFLP` | — |
| `WSFR` | `EN, ANY16_s, ANY16_n1, ANY16_n2, ANY16_d` | Word shift right: n1=#words in shift register, n2=#words to shift | — | `WSFRP` | — |
| `WSFL` | `EN, ANY16_s, ANY16_n1, ANY16_n2, ANY16_d` | Word shift left: n1=#words in shift register, n2=#words to shift | — | `WSFLP` | — |
| `SFWR` | `EN, ANY16_s, ANY16_n, ANY16_d` | Shift write (FIFO push): write S to FIFO stack of n words at D | — | `SFWRP` | — |
| `SFRD` | `EN, ANY16_s, ANY16_n, ANY16_d` | Shift read (FIFO pop): read from FIFO stack of n words at S → D | — | `SFRDP` | — |
| `POP` | `EN, ANY16_s, ANY16_d` | Shift last data read (FILO/LIFO pop): pop from stack S → D | — | `POPP` | — |

> In ST, `SHL`/`SHR` cover simple shifts. Use `SFTR`/`SFTL`/`WSFR`/`WSFL` for multi-word
> shift registers. `SFWR`/`SFRD`/`POP` implement FIFO/FILO stacks.

---

## 7. Data Operation Instructions

| Instruction | Parameters | Description | `_E` | `P` | `D` |
|-------------|------------|-------------|:---:|:---:|:---:|
| `ZRST` | `EN, ANY16_d1, ANY16_d2` | Zone reset: reset range D1–D2 (inclusive) | — | `ZRSTP` | — |
| `DECO` | `EN, ANY16_s, ANY16_n, ANY16_d` | Decode: integer S → set bit n of D (1-of-N decoder) | — | `DECOP` | — |
| `ENCO` | `EN, ANY16_s, ANY16_n, ANY16_d` | Encode: bit position in S (n bits) → integer D | — | `ENCOP` | — |
| `MEAN` | `EN, ANY16_s, ANY16_n, ANY16_d` | Mean: average of n values starting at S → D | — | `MEANP` | `DMEAN`, `DMEANP` |
| `WSUM` | `EN, ANY16_s, ANY16_n, ANY16_d` | Sum of n word data starting at S → D | — | `WSUMP` | `DWSUM`, `DWSUMP` |
| `SUM` | `EN, ANY16_s, ANY16_d` | Sum of active bits (count bits set to 1 in S) → D | — | `SUMP` | `DSUM`, `DSUMP` |
| `BON` | `EN, ANY16_s, ANY16_n, BOOL_d` | Check bit n of S → D (D=ON if bit n of S is 1) | `BON_E` | `BONP` | `DBON`, `DBONP` |
| `NEG` | `EN, ANY16_d` | Negation (two's complement): 0−(D) → (D) | — | `NEGP` | `DNEG`, `DNEGP` |
| `ENEG` | `EN, REAL_d` | Floating point negation (sign flip of D) | — | `ENEGP` | — |
| `WTOB` | `EN, ANY16_s, ANY16_n, ANY16_d` | WORD → BYTE (split n 16-bit words into 2n bytes) | — | `WTOBP` | — |
| `BTOW` | `EN, ANY16_s, ANY16_n, ANY16_d` | BYTE → WORD (combine 2n bytes into n 16-bit words) | — | `BTOWP` | — |
| `UNI` | `EN, ANY16_s, ANY16_n, ANY16_d` | 4-bit linking of word data (nibble combine) | — | `UNIP` | — |
| `DIS` | `EN, ANY16_s, ANY16_n, ANY16_d` | 4-bit grouping of word data (nibble split) | — | `DISP` | — |
| `CCD` | `EN, ANY16_s, ANY16_n, ARRAY [0..1] OF ANY16_d` | Check code (sum check / parity over n words) → 2-word result | — | `CCDP` | — |
| `CRC` | `EN, ANY16_s, ANY16_n, ANY16_d` | Cyclic redundancy check over n words | — | `CRCP` | — |
| `LIMIT` | `EN, ANY16_min, ANY16_s, ANY16_max, ANY16_d` | Limit control: clamp S to [Min, Max] → D | — | `LIMITP` | `DLIMIT`, `DLIMITP` |
| `BAND` | `EN, ANY16_s1, ANY16_s2, ANY16_s3, ANY16_d` | Dead band control: S1=lower, S2=upper, S3=input → D | — | `BANDP` | `DBAND`, `DBANDP` |
| `ZONE` | `EN, ANY16_s1, ANY16_s2, ANY16_s3, ANY16_d` | Zone control (offset/scaling): S1=input, S2=offset, S3=zone range → D | — | `ZONEP` | `DZONE`, `DZONEP` |
| `SCL` | `EN, ANY16_s1, ANY16_s2, ANY16_d` | Scaling (coordinate by point data). S1=source, S2=point-table head. | — | `SCLP` | — |
| `SCL2` | `EN, ANY16_s1, ANY16_s2, ANY16_d` | Scaling (coordinate by X/Y data, 2-point). S1=source, S2=XY-table head. | — | `SCL2P` | — |
| `SORT` | `EN, ANY16_s, ANY16_n, ANY16_d` | Sort n tabulated data values from S → D (ascending/descending) | — | `SORTP` | — |
| `SER` | `EN, ANY16_s1, ANY16_s2, ANY16_n, ARRAY [1..5] OF ANY16_d` | Search n values from S1 for S2 → 5-word result to D | — | `SERP` | `DSER`, `DSERP` |
| `FDEL` | `EN, ANY16_s, ANY16_n, ANY16_d` | Delete data from table of n entries at S → D | — | `FDELP` | — |
| `FINS` | `EN, ANY16_s, ANY16_n, ANY16_d` | Insert data into table of n entries at S → D | — | `FINSP` | — |

> In ST, prefer IEC functions where available: `LIMITATION` (not `LIMIT`), `MAXIMUM`,
> `MINIMUM`. See [functions.md](functions.md). For `NEG`, use `-iValue` in ST expressions.

---

## 8. String Processing Instructions

| Instruction | Parameters | Description | `_E` | `P` | `D` |
|-------------|------------|-------------|:---:|:---:|:---:|
| `ESTR` | `EN, REAL_s, STRING_d` | REAL → String conversion | — | `ESTRP` | — |
| `EVAL` | `EN, STRING_s, REAL_d` | String → REAL conversion | — | `EVALP` | — |
| `STR` | `EN, ANY16_s, STRING_d` | BIN (INT) → String conversion | — | `STRP` | `DSTR`, `DSTRP` |
| `VAL` | `EN, STRING_s, ANY16_d` | String → BIN (INT) conversion | — | `VALP` | `DVAL`, `DVALP` |
| `DABIN` | `EN, STRING_s, ANY16_d` | Decimal ASCII → BIN conversion | — | `DABINP` | `DDABIN`, `DDABINP` |
| `BINDA` | `EN, STRING_s, ANY16_d` | BIN → Decimal ASCII conversion | — | `BINDAP` | `DBINDA`, `DBINDAP` |
| `ASCI` | `EN, ANY16_s, ANY16_n, ANY16_d` | HEX → ASCII conversion (n characters) | — | `ASCIP` | — |
| `HEX` | `EN, ANY16_s, ANY16_n, ANY16_d` | ASCII → HEX conversion (n characters) | — | `HEXP` | — |
| `$MOV` | `EN, STRING_s, STRING_d` | String transfer (copy) | — | `$MOVP` | — |
| `$+` | `EN, STRING_s1, STRING_s2, STRING_d` | String concatenation: S1 + S2 → D | — | `$+P` | — |
| `LEN` | `EN, STRING_s, ANY16_d` | String length: length of S → D | — | `LENP` | — |
| `RIGH` | `EN, STRING_s, ANY16_n, STRING_d` | Extract right n characters from S → D | — | `RIGHTP` | — |
| `LEFT` | `EN, STRING_s, ANY16_n, STRING_d` | Extract left n characters from S → D | — | `LEFTP` | — |
| `MIDR` | `EN, STRING_s, ANY16_n1, ANY16_n2, STRING_d` | Extract substring from S: start=n1, length=n2 → D | — | `MIDRP` | — |
| `MIDW` | `EN, STRING_s, STRING_s1, ANY16_n, STRING_d` | Replace in S at position n with S1 → D | — | `MIDWP` | — |
| `INSTR` | `EN, STRING_s1, STRING_s2, ANY16_n, ANY16_d` | String search: find S2 in S1 starting at position n → result to D | — | `INSTRP` | — |
| `COMRD` | `EN, ANY_SIMPLE_s, STRING(32)_d` | Read device comment data → 32-char string | — | — | — |

> ⚠️ String instructions available on FX3U/FX5U only. FX3G/FX3S do not support STRING type.
> In ST, IEC functions (`LEN`, `LEFT`, `RIGHT`, `MID`, `CONCAT`, `INSERT`, `DELETE`,
> `REPLACE`, `FIND`) are preferred. See [functions.md](functions.md).

---

## 9. Program Flow Control Instructions

| Instruction | Parameters | Description | ST Equivalent |
|-------------|------------|-------------|---------------|
| `IRET` | _(none)_ | Interrupt return | Use in interrupt POU `.st` file. |
| `EI` | _(none)_ | Enable interrupt | `EI;` (standalone ST statement) |
| `DI` | _(none)_ | Disable interrupt | `DI;` (standalone ST statement) |
| `FOR` | `n` | Start FOR/NEXT loop (loop count = n) | `FOR i := start TO end BY step DO` |
| `NEXT` | _(none)_ | End FOR/NEXT loop | `END_FOR;` |

> `CJ`, `CALL`, `SRET`, `FEND` are **ladder-only** — removed. Use `IF`/`CASE`, FUN/FB, and `RETURN` in ST instead.
> `EI`/`DI` are usable as standalone ST statements. `FOR`/`NEXT` use IEC syntax
> (`FOR...END_FOR`). See [common-rules.md](common-rules.md) for loop patterns.

---

## 10. I/O Refresh Instructions

| Instruction | Parameters | Description | `_E` | `P` | `D` |
|-------------|------------|-------------|:---:|:---:|:---:|
| `REF` | `EN, ANY16_n, ANY16_d` | Refresh I/O: immediate refresh of n devices starting at D | — | `REFP` | — |
| `REFF` | `EN, ANY16_n` | Refresh and filter adjust: set input filter time to n (ms) | — | `REFFP` | — |

> `REF` forces immediate read/write of specified I/O points during scan. Useful when
> response time must be faster than the scan cycle.

---

## 11. Real Time Clock Control Instructions

| Instruction | Parameters | Description | `_E` | `P` | `D` |
|-------------|------------|-------------|:---:|:---:|:---:|
| `TCMP` | `EN, ANY16_s1, ANY16_s2, ANY16_s3, ARRAY [0..2] OF ANY16_s, ARRAY [0..2] OF BOOL_d` | RTC data compare: S1–S3 = setpoint (H,M,S), S = RTC values (3 words), D = flags (3 bits) | — | `TCMPP` | — |
| `TZCP` | `EN, ARRAY [0..2] OF ANY16_s1, ARRAY [0..2] OF ANY16_s2, ARRAY [0..2] OF ANY16_s, ARRAY [0..2] OF BOOL_d` | RTC data zone compare: S1/S2=lower/upper bounds (3w each), S=RTC vals (3w), D=flags (3b) | — | `TZCPP` | — |
| `TADD` | `EN, ARRAY [0..2] OF ANY16_s1, ARRAY [0..2] OF ANY16_s2, ARRAY [0..2] OF ANY16_d` | RTC data addition: add time S1 + S2 → 3-word D | — | `TADDP` | — |
| `TSUB` | `EN, ARRAY [0..2] OF ANY16_s1, ARRAY [0..2] OF ANY16_s2, ARRAY [0..2] OF ANY16_d` | RTC data subtraction: S1 − S2 → 3-word D | — | `TSUBP` | — |
| `TRD` | `EN, ANY16_d` | Read RTC data to 7 consecutive D registers | — | `TRDP` | — |
| `TWR` | `EN, ANY16_s` | Set RTC data from 7 consecutive S registers | — | `TWRP` | — |
| `HTOS` | `EN, ANY16_s, ANY16_d` | Hour → Second conversion | — | `HTOSP` | `DHTOS`, `DHTOSP` |
| `STOH` | `EN, ANY16_s, ANY16_d` | Second → Hour conversion | — | `STOHP` | `DSTOH`, `DSTOHP` |

> RTC data is read/written as BCD values to consecutive D registers.
> Special relays M8015 (clock stop), M8016 (30s adjust), M8017 (±30s), M8018 (detect),
> M8019 (error). Special registers D8010–D8019 hold current RTC values.

---

## 12. Positioning Control Instructions

| Instruction | Parameters | Description | `_E` | `P` | `D` |
|-------------|------------|-------------|:---:|:---:|:---:|
| `ABS` | `EN, ANY16_s, ANY16_d1, ANY16_d2` | Absolute current value read (servo ABS data): S=input point, D1/D2=❓ | — | `ABSP` | `DABS` |
| `DSZR` | `EN, BOOL_s1, BOOL_s2, BOOL_d` | DOG search zero return: S1=near-point DOG, S2=zero-point, D=pulse output | — | — | `DDSZR` |
| `ZRN` | `EN, ANY16_s1, ANY16_s2, BOOL_s3, BOOL_d` | Zero return: S1=start speed, S2=creep speed, S3=near-point DOG, D=pulse output | — | — | `DZRN` |
| `DVIT` | `EN, ANY16_s1, ANY16_s2, BOOL_d` | Interrupt positioning: S1=pulses, S2=freq, D=pulse output | — | — | `DDVIT` |
| `DRVI` | `EN, ANY16_s1, ANY16_s2, BOOL_d1, BOOL_d2` | Drive to increment (relative): S1=pulses, S2=freq, D1=pulse output, D2=direction | — | — | `DDRVI` |
| `DRVA` | `EN, ANY16_s1, ANY16_s2, BOOL_d1, BOOL_d2` | Drive to absolute: S1=pulses, S2=freq, D1=pulse output, D2=direction | — | — | `DDRVA` |
| `PLSV` | `EN, ANY16_s, BOOL_d1, BOOL_d2` | Variable speed pulse output: S=freq, D1=pulse output, D2=direction | — | — | `DPLSV` |
| `PLSY` | `EN, ANY16_s1, ANY16_s2, BOOL_d` | Pulse Y output: S1=frequency, S2=#pulses, D=pulse output (Y) | — | — | `DPLSY` |
| `PLSR` | `EN, ANY16_s1, ANY16_s2, ANY16_s3, BOOL_d` | Acceleration/deceleration: S1=max freq, S2=total pulses, S3=accel/decel time, D=output | — | — | `DPLSR` |

> Positioning instructions use Y0–Y4 as pulse outputs. Requires FX3U with transistor output.
> Parameters stored in consecutive D registers. Check M8340–M8349, D8340–D8349 for axis status.
> TBL removed — does not exist on FX series.

---

## 13. Special Block / Unit Control Instructions

| Instruction | Parameters | Description | `_E` | `P` | `D` |
|-------------|------------|-------------|:---:|:---:|:---:|
| `FROM` | `EN, ANY16_m1, ANY16_m2, ANY16_n, ANY16_d` | Read from special function block: m1=unit#, m2=BFM#, n=#words, D=data dest | — | `FROMP` | `DFROM`, `DFROMP` |
| `TO` | `EN, ANY16_m1, ANY16_m2, ANY16_s, ANY16_n` | Write to special function block: m1=unit#, m2=BFM#, S=data source, n=#words | — | `TOP` | `DTO`, `DTOP` |
| `RD3A` | `EN, ANY16_m1, ANY16_m2, ANY16_d` | Read from dedicated analog block: m1=unit#, m2=channel#, D=data dest | — | `RD3AP` | — |
| `WR3A` | `EN, ANY16_m1, ANY16_m2, ANY16_s` | Write to dedicated analog block: m1=unit#, m2=channel#, S=data source | — | `WR3AP` | — |

> `FROM`/`TO` for generic special function modules. `RD3A`/`WR3A` for FX3U analog adapters
> (simpler addressing). BFM = Buffer Memory. RBFM/WBFM removed — not applicable.

---

## 14. MODBUS Communication

| Instruction | Parameters | Description | `_E` | `P` | `D` |
|-------------|------------|-------------|:---:|:---:|:---:|
| `ADPRW` | `❓ Verify` | MODBUS read and write (FX3U with RS-485 adapter) | — | — | — |

> `ADPRW` is the preferred MODBUS instruction for FX3U with RS-485 adapter.
> All other serial communication instructions (RS, RS2, IVCK, IVDR, IVRD, IVWR, IVBWR, IVMC)
> are ladder-oriented and removed from this ST-focused catalog.

---

## 15. Other Instructions

| Instruction | Parameters | Description | `_E` | `P` | `D` |
|-------------|------------|-------------|:---:|:---:|:---:|
| `WDT` | `EN` | Watchdog timer refresh (reset scan watchdog) | — | `WDTP` | — |
| `ALT` | `EN, BOOL_d` | Alternate state (toggle: OUT inversion of device D) | — | `ALTP` | — |
| `ANS` | `EN, ANY16_s, ANY16_m, BOOL_d` | Timed annunciator set: S=timer#, m=delay (100ms), D=annunciator flag | — | — | — |
| `ANR` | `EN` | Annunciator reset (clear annunciator flags) | — | `ANRP` | — |
| `HOUR` | `EN, ANY16_s, ARRAY [1..2] OF ANY16_d1, BOOL_d2` | Hour meter: S=enable input, D1=accumulated hours (2w), D2=overflow flag | — | `HOURP` | `DHOUR`, `DHOURP` |
| `RAMP` | `EN, ANY16_s1, ANY16_s2, ANY16_n, ARRAY [0..1] OF ANY16_d` | Ramp variable value: S1=target, S2=step, n=interval scans, D=current+flags (2w) | — | — | — |
| `SPD` | `EN, BOOL_s1, ANY16_s2, ARRAY [0..2] OF ANY16_d` | Speed detection: S1=pulse input (X), S2=measurement time (ms), D=result (3w) | — | — | — |
| `PWM` | `EN, ANY16_s1, ANY16_s2, BOOL_d` | Pulse width modulation: S1=pulse width, S2=period, D=output (Y) | — | — | — |
| `DUTY` | `EN, ANY16_n1, ANY16_n2, BOOL_d` | Timing pulse generation: n1=ON scans, n2=OFF scans, D=output | — | — | — |
| `PID` | `EN, ANY16_s1, ANY16_s2, ANY16_s3, ANY16_d` | PID control loop: S1=setpoint, S2=process value, S3=parameter table head, D=output (MV) | — | — | — |
| `ZPUSH` | `EN, ANY16_d` | Batch store of index register (Z, V → stack at D) | — | `ZPUSHP` | — |
| `ZPOP` | `EN, ANY16_d` | Batch pop of index register (stack at D → Z, V) | — | `ZPOPP` | — |
| `TTMR` | `EN, ANY16_n, ARRAY [0..1] OF ANY16_d` | Teaching timer: n=scale factor, D=measured value+flags (2w) | — | — | — |
| `STMR` | `EN, ANY16_s, ANY16_m, ARRAY [0..3] OF BOOL_d` | Special timer: S=timer#, m=preset (100ms), D=4 output bits | — | — | — |
| `ABSD` | `EN, ANY16_s1, ANY16_s2, ANY16_n, BOOL_d` | Absolute drum sequencer: S1=table, S2=counter, n=#steps, D=outputs | — | — | `DABSD` |
| `INCD` | `EN, ANY16_s1, ANY16_s2, ANY16_n, BOOL_d` | Incremental drum sequencer: S1=table, S2=counter, n=#steps, D=outputs | — | — | — |
| `ROTC` | `EN, ARRAY [0..2] OF ANY16_s, ANY16_m1, ANY16_m2, ARRAY [0..7] OF BOOL_d` | Rotary table control: S=table (3w), m1=#stations, m2=call station, D=8-bit output | — | — | — |
| `IST` | `EN, ARRAY [0..7] OF BOOL_s, BOOL_d1, BOOL_d2` | Initial state: S=8 input bits, D1/D2=❓ | — | — | — |
| `MTR` | `EN, BOOL_s, ANY16_n, BOOL_d1, BOOL_d2` | Input matrix: S=input, n=❓, D1=output scan, D2=result | — | — | — |
| `TKY` | `EN, ARRAY [0..9] OF BOOL_s, ANY16_d1, ARRAY [0..10] OF BOOL_d2` | Ten key input: S=10 key inputs, D1=data, D2=11 key flags | — | — | `DTKY` |
| `HKY` | `EN, ARRAY [0..3] OF BOOL_s, ARRAY [0..3] OF BOOL_d1, ANY16_d2, ARRAY [0..7] OF BOOL_d3` | Hexadecimal input: S=4 inputs, D1=4-scan outputs, D2=data, D3=8 key flags | — | — | `DHKY` |
| `DSW` | `EN, BOOL_s, ANY16_n, ARRAY [0..3] OF BOOL_d1, ANY16_d2` | Digital switch: S=input, n=#digits, D1=4-scan outputs, D2=data | — | — | — |
| `SEGD` | `EN, ANY16_s, ANY16_d` | Seven segment decoder: BCD S → 7-seg pattern D | — | `SEGDP` | — |
| `SEGL` | `EN, ANY16_s, ANY16_n, BOOL_d` | Seven segment with latch: S=data, n=#digits, D=start output | — | — | — |
| `ARWS` | `EN, ARRAY [0..3] OF BOOL_s, ANY16_n, ANY16_d1, ARRAY [0..7] OF BOOL_d2` | Arrow switch: S=4 inputs (up/down/clear/read), n=❓, D1=data, D2=8 output bits | — | — | — |
| `ASC` | `EN, STRING(8)_s, ANY_SIMPLE_d` | ASCII code data input: 8-char string → D | — | — | — |
| `PR` | `EN, STRING_s, BOOL_d` | Print ASCII code: send string S, D=busy flag | — | — | — |
| `VRRD` | `EN, ANY16_s, ANY16_d` | Volume read: analog volume pot #S → D | — | `VRRDP` | — |
| `VRSC` | `EN, ANY16_s, ANY16_d` | Volume scale: read pot #S, scale to range → D | — | `VRSCP` | — |

> `WDT`/`WDTP` resets the scan watchdog timer during long loops.
> `PID` uses dedicated D registers for parameters. See FX3U Programming Manual for full PID setup.
> `ALT` toggles a bit device each execution — useful in ST as `xFlag := NOT xFlag;`.

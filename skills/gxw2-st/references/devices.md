# Device Address Space — FX Series PLCs (GX Works 2)

Load when code uses device addresses (X, Y, M, D, T, C) or when creating IO.csv / GVL.csv files.

---

## Bit Devices

### Inputs (X)
| Device | Range        | Access | Notes                          |
|--------|-------------|--------|---------------------------------|
| X      | X0–X377     | R      | Physical inputs. **Octal addressing.** |

### Outputs (Y)
| Device | Range        | Access | Notes                          |
|--------|-------------|--------|---------------------------------|
| Y      | Y0–Y377     | R/W    | Physical outputs. **Octal addressing.** |

### Internal Relays (M)
| Device       | Range         | Access | Notes                    |
|-------------|---------------|--------|---------------------------|
| M (General) | M0–M7679      | R/W    | General purpose           |
| M (Latched) | M7680–M8511   | R/W    | Battery-backed / retentive |

### Step Relays (S)
| Device | Range        | Access | Notes                          |
|--------|-------------|--------|---------------------------------|
| S      | S0–S4095    | R/W    | For SFC / state machine usage   |

### Timer Contacts (TS)
| Device | Range        | Access | Notes                          |
|--------|-------------|--------|---------------------------------|
| TS     | TS0–TS511   | R      | Timer done contact (normally-open). TRUE when timer elapsed. |

### Counter Contacts (CS)
| Device | Range        | Access | Notes                          |
|--------|-------------|--------|---------------------------------|
| CS     | CS0–CS255   | R      | Counter done contact. TRUE when count ≥ preset. |

---

## Word Devices

### Data Registers (D)
| Device       | Range         | Size   | Notes                      |
|-------------|---------------|--------|-----------------------------|
| D (General) | D0–D7999      | 16-bit | General data register       |
| D (Latched) | D8000–D8511   | 16-bit | Battery-backed (overlaps special registers) |

### Timer Current Values (TN)
| Device | Range        | Size       | Notes                      |
|--------|-------------|------------|-----------------------------|
| TN     | TN0–TN511   | 16/32-bit  | Current timer elapsed value |

### Counter Current Values (CN)
| Device | Range        | Size       | Notes                      |
|--------|-------------|------------|-----------------------------|
| CN     | CN0–CN255   | 16/32-bit  | Current counter value       |

### File Registers (R)
| Device | Range         | Size   | Notes                    |
|--------|--------------|--------|---------------------------|
| R      | R0–R32767    | 16-bit | Extended memory area      |

### Index Registers (Z, V)
| Device | Range    | Size   | Notes                              |
|--------|---------|--------|-------------------------------------|
| Z      | Z0–Z7   | 16-bit | Index for addressing (Z0–Z7 on FX3U/FX3G) |
| V      | V0–V7   | 16-bit | Index for addressing. Paired with Z for 32-bit (Z is low word). |

---

## Addressing Modes

| Mode              | Example      | Description                                    |
|-------------------|-------------|------------------------------------------------|
| Direct            | `D100`, `X0` | Direct access to a device                      |
| Indexed           | `D100Z0`     | Offset D100 by value in Z0                     |
| Digit-specified   | `K4X0`       | Read 4 nibbles (16 bits) starting from X0      |

> **Bit-of-word addressing (e.g., `D100.0`) is NOT supported on FX series.** Use bit masking with AND/OR or use M relays.

---

## IEC Address Format (for CSV Address Column)

| Device | IEC Format      | Example        |
|--------|-----------------|----------------|
| X      | `%IX{octal}.{bit}` | `%IX0.0` for X0 |
| Y      | `%QX{octal}.{bit}` | `%QX0.0` for Y0 |
| D      | `%MW{n}`         | `%MW100` for D100 |
| M      | (leave empty)    | —               |

---

## Important: Octal Addressing for X and Y

X and Y devices use **octal** numbering (base-8). Valid digits per position: 0–7.

- X0–X7, then X10–X17, X20–X27, ... X70–X77, then X100–X107
- X8 and X9 are **not valid** addresses
- Octal applies to both the device number and the IEC address: `%IX0.0` through `%IX0.7`

---

## Device Access Policy for ST Code

> **Do not use direct device access in ST code.** Always create label variables in CSV files and reference labels in code.

```iecst
// ❌ Wrong — direct device access in ST
IF X0 THEN
    D100 := K100;
END_IF;

// ✅ Correct — use labels from CSV
IF DI_Start THEN
    g_iCounter := K100;
END_IF;
```

**Exception:** Special relays (M8000+) and special registers (D8000+) may be used directly when necessary — see `system-devices.md`. Hardware timer/counter instructions (`OUT_T`, `OUT_C`) also use direct device addressing.

---

## FX5U Differences

| Feature         | FX3U/FX3G/FX3S  | FX5U              |
|-----------------|------------------|-------------------|
| Index Z range   | Z0–Z7            | Z0–Z19            |
| Index V         | V0–V7            | Not available     |
| D registers     | D0–D7999         | D0–D7999          |
| X/Y octal       | Yes              | Yes (but also supports hex display) |

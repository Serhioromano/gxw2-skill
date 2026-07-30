# Compatibility Matrix — FX Series Models (GX Works 2)

Load when targeting a specific FX CPU model to verify feature availability.

---

## Feature Matrix

| Feature                          | FX3U         | FX3G         | FX3S         | FX5U         |
|----------------------------------|-------------|-------------|-------------|-------------|
| ST language                      | ✅           | ✅           | ✅           | ✅           |
| Label editor (CSV import)        | ✅           | ✅           | ✅           | ✅           |
| IEC timers (TON/TOF/TP)          | ✅           | ✅           | ✅           | ✅           |
| TIME type                        | ✅           | ✅           | ✅           | ✅           |
| REAL type                        | ✅           | ✅           | ✅           | ✅           |
| DINT type                        | ✅           | ✅           | ✅           | ✅           |
| STRING type                      | ✅           | ❌           | ❌           | ✅           |
| String functions (LEN, LEFT, etc)| ✅           | ❌           | ❌           | ✅           |
| 2D arrays                        | ✅           | ✅           | ✅           | ✅           |
| Structures (via CSV)             | ✅           | ✅           | ✅           | ✅           |
| Nestable structures              | ❌           | ❌           | ❌           | ❌           |
| File registers (R)               | ✅           | ✅           | ⚠️ limited   | ✅           |

---

## Device Ranges

| Device       | FX3U             | FX3G             | FX3S             | FX5U             |
|-------------|------------------|------------------|------------------|------------------|
| X (input)   | X0–X377 (octal)  | X0–X377 (octal)  | X0–X177 (octal)  | X0–X377 (octal)  |
| Y (output)  | Y0–Y377 (octal)  | Y0–Y377 (octal)  | Y0–Y177 (octal)  | Y0–Y377 (octal)  |
| M (relay)   | M0–M7679         | M0–M7679         | M0–M3839         | M0–M7679         |
| M (latched) | M7680–M8511      | M7680–M8511      | M3840–M4095      | M7680–M8511      |
| D (register)| D0–D7999         | D0–D7999         | D0–D3999         | D0–D7999         |
| D (latched) | D8000–D8511      | D8000–D8511      | D4000–D4095      | D8000–D8511      |
| T (timer)   | T0–T511          | T0–T511          | T0–T255          | T0–T511          |
| C (counter) | C0–C255          | C0–C255          | C0–C127          | C0–C255          |
| S (step)    | S0–S4095         | S0–S4095         | S0–S1023         | S0–S4095         |
| Z (index)   | Z0–Z7            | Z0–Z7            | Z0–Z7            | Z0–Z19           |
| V (index)   | V0–V7            | V0–V7            | V0–V7            | ❌               |
| R (file)    | R0–R32767        | R0–R32767        | R0–R2047 (if present) | R0–R32767    |

---

## Model Selection Guidelines

### Choose FX3U when:
- Full feature set needed (STRING, all function blocks)
- Larger program memory required
- Highest I/O count
- Serial communication, positioning, or analog modules needed

### Choose FX3G when:
- Similar to FX3U but with some limitations
- Built-in USB port useful
- String functions not required

### Choose FX3S when:
- Lowest cost, smallest size
- Limited I/O count acceptable
- STRING type not needed
- Timer/counter count of FX3U not needed

### Choose FX5U when:
- Newer generation platform
- Full STRING support
- Extended index registers (Z0–Z19)
- Higher performance needed

---

## GX Works 2 vs GX Works 3

| Aspect           | GX Works 2              | GX Works 3              |
|-------------------|-------------------------|-------------------------|
| Target PLCs       | FX series, Q series, L series | FX5U, iQ-R, iQ-F  |
| FX3U support      | ✅                      | ❌ (use GX Works 2)     |
| FX5U support      | Limited                 | ✅ (primary tool)       |

> This skill targets **GX Works 2** and **FX3U/FX3G/FX3S** primarily. FX5U may also work but GX Works 3 is its primary tool. When generating code for FX5U, verify GX Works 2 compatibility.

---

## Model-Specific Code Generation

When the user specifies a target model, apply these rules:

```pascal
// FX3U/FX5U — STRING OK
sMessage := CONCAT(sPrefix, sValue);

// FX3G/FX3S — no STRING, use INT/DINT arrays or D registers instead
// Generate code without string operations
g_wMsgLen := K0; // use WORD registers for message handling
```

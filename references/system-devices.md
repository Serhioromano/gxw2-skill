# System Devices (Special Relays & Registers)

Complete reference of special relays (M8000+) and special registers (D8000+) for FX3U/FX3G series PLCs and compatible controllers.

**Note:** "Low + High" pairs form a 32-bit value. Low word holds bits 0–15, High word holds bits 16–31.

---

## 1. Special Relays (M8000+)

### 1.1 Run Status Flags

| Device | Name | Description |
|--------|------|-------------|
| M8000 | RUN Always ON | TRUE while PLC is in RUN mode |
| M8001 | RUN Always OFF | FALSE while PLC is in RUN mode |
| M8002 | First Scan ON | TRUE for the first scan cycle only (pulse on RUN start) |
| M8003 | First Scan OFF | FALSE for the first scan cycle only (inverted M8002) |

### 1.2 Clock Pulses

| Device | Name | Description |
|--------|------|-------------|
| M8011 | 10 ms Clock | 5 ms ON, 5 ms OFF |
| M8012 | 100 ms Clock | 50 ms ON, 50 ms OFF |
| M8013 | 1 s Clock | 500 ms ON, 500 ms OFF |
| M8014 | 1 min Clock | 30 s ON, 30 s OFF |

### 1.3 Arithmetic Status Flags

| Device | Name | Description |
|--------|------|-------------|
| M8020 | Zero Flag | TRUE when result of arithmetic operation is zero |
| M8021 | Borrow Flag | TRUE when subtraction result is negative (borrow occurred) |
| M8022 | Carry Flag | TRUE when addition result exceeds range (carry occurred) |
| M8024 | BMOV Direction | Specifies direction for BMOV instruction. OFF = normal, ON = reverse. |
| M8028 | Interrupt Allow During Instruction | When ON, allows interrupts during instruction execution |
| M8029 | Instruction Execution End | TRUE when an applied instruction completes execution (pulse) |

### 1.4 Memory & PLC Control

| Device | Name | Description |
|--------|------|-------------|
| M8031 | Clear Non-Retentive Memory | When triggered, clears all non-latched (non-retentive) memory areas |
| M8032 | Clear Retentive Memory | When triggered, clears all latched (retentive/battery-backed) memory areas |
| M8033 | Memory Retention Stop | When ON, stops retaining memory values on power-off (latch disable) |
| M8034 | Prohibit All Outputs | When ON, all Y outputs are forced OFF regardless of logic |
| M8035 | Forced RUN Mode | Forces PLC into RUN mode (used for remote RUN control) |
| M8036 | Force RUN Command | Pulse-triggered: forces PLC into RUN mode |
| M8037 | Force STOP Command | Pulse-triggered: forces PLC into STOP mode |
| M8045 | Prohibit Reset of All Outputs | When ON, Y outputs are NOT reset on RUN→STOP transition |
| M8046 | STL State Active | TRUE when any STL (step ladder) state is active |
| M8047 | STL Temporary Control Enable | When ON, enables temporary STL state control |
| M8048 | Signal Alarm Active | TRUE when any alarm condition (M8049+alarm list) is triggered |
| M8049 | Signal Alarm Enable | When ON, enables signal alarm monitoring |

### 1.5 Interrupt Control

Set to ON to **disable** the corresponding interrupt.

| Device | Interrupt | Description |
|--------|-----------|-------------|
| M8050 | I00 | Disable input interrupt I00 (X0 rising edge) |
| M8051 | I10 | Disable input interrupt I10 (X1 rising edge) |
| M8052 | I20 | Disable input interrupt I20 (X2 rising edge) |
| M8053 | I30 | Disable input interrupt I30 (X3 rising edge) |
| M8054 | I40 | Disable input interrupt I40 (X4 rising edge) |
| M8055 | I50 | Disable input interrupt I50 (X5 rising edge) |
| M8056 | I6xx | Disable timer interrupt I6xx |
| M8057 | I7xx | Disable timer interrupt I7xx |
| M8058 | I8xx | Disable timer interrupt I8xx |
| M8059 | Counter | Disable counter interrupt (high-speed counter match) |

### 1.6 Error Diagnostics

These relays latch ON when the corresponding error occurs. Reset by clearing the error cause and cycling power (or by program).

| Device | Name | Description |
|--------|------|-------------|
| M8060 | I/O Configuration Error | I/O module configuration mismatch |
| M8061 | PLC Hardware Error | Internal hardware fault detected |
| M8062 | Serial Communication Error 0 | Communication error on channel 0 (programming port) |
| M8063 | Serial Communication Error 1 | Communication error on channel 1 (serial port 2) |
| M8064 | Parameter Error | Invalid parameter or configuration setting |
| M8065 | Syntax Error | Grammatical/syntax error in program |
| M8066 | Loop Error | Program loop structure error (e.g. infinite loop detected) |
| M8067 | Operation Error | Runtime operation error (e.g. division by zero) |
| M8068 | Operation Error Latch | Latched version of M8067 — stays ON after error, even if condition clears |
| M8069 | I/O Bus Detection | I/O bus check/detection flag |

### 1.7 Sampling & Tracking

| Device | Name | Description |
|--------|------|-------------|
| M8075 | Sample Tracking Preparation | Start command for sample tracking preparation |
| M8076 | Sample Tracking Execution Start | Start command for sample tracking execution |
| M8077 | Sample Tracking Temporary Control | Temporary control flag during sample tracking execution |
| M8078 | Sample Tracking Execution End | TRUE when sample tracking execution completes |
| M8079 | Sampling Tracking System Area | System-use flag for sample tracking area |

### 1.8 Pulse Capture

These relays capture short-duration input pulses (< 1 scan) on X0–X7 that would otherwise be missed.

| Device | Input | Description |
|--------|-------|-------------|
| M8170 | X000 | Pulse captured on X000 (rises for one scan on detection) |
| M8171 | X001 | Pulse captured on X001 |
| M8172 | X002 | Pulse captured on X002 |
| M8173 | X003 | Pulse captured on X003 |
| M8174 | X004 | Pulse captured on X004 |
| M8175 | X005 | Pulse captured on X005 |
| M8176 | X006 | Pulse captured on X006 |
| M8177 | X007 | Pulse captured on X007 |

### 1.9 XCH / SWAP Control

| Device | Name | Description |
|--------|------|-------------|
| M8160 | XCH SWAP Function | When ON, XCH instruction performs byte swap instead of exchange |
| M8161 | 8-Bit Processing Mode | When ON, certain instructions operate in 8-bit mode instead of 16-bit |

### 1.10 Counter Direction Control (C224–C255)

Each relay controls the count direction for the corresponding high-speed counter.
**Rule:** ON = decrease (down), OFF = increase (up).

| Device | Counter | Description |
|--------|---------|-------------|
| M8224 | C224 | Count direction for C224 |
| M8225 | C225 | Count direction for C225 |
| M8226 | C226 | Count direction for C226 |
| M8227 | C227 | Count direction for C227 |
| M8228 | Handwheel | Handwheel function enable (takes slot of C228 direction control) |
| M8229 | C229 | Count direction for C229 |
| M8230 | C230 | Count direction for C230 |
| M8231 | C231 | Count direction for C231 |
| M8232 | C232 | Count direction for C232 |
| M8233 | C233 | Count direction for C233 |
| M8234 | C234 | Count direction for C234 |
| M8235 | C235 | Count direction for C235 |
| M8236 | C236 | Count direction for C236 |
| M8237 | C237 | Count direction for C237 |
| M8238 | C238 | Count direction for C238 |
| M8239 | C239 | Count direction for C239 |
| M8240 | C240 | Count direction for C240 |
| M8241 | C241 | Count direction for C241 |
| M8242 | C242 | Count direction for C242 |
| M8243 | C243 | Count direction for C243 |
| M8244 | C244 | Count direction for C244 |
| M8245 | C245 | Count direction for C245 |
| M8246 | C246 | Count direction for C246 |
| M8247 | C247 | Count direction for C247 |
| M8248 | C248 | Count direction for C248 |
| M8249 | C249 | Count direction for C249 |
| M8250 | C250 | Count direction for C250 |
| M8251 | C251 | Count direction for C251 |
| M8252 | C252 | Count direction for C252 |
| M8253 | C253 | Count direction for C253 |
| M8254 | C254 | Count direction for C254 |
| M8255 | C255 | Count direction for C255 |

### 1.11 Serial Port 2 — Communication Control

| Device | Name | Description |
|--------|------|-------------|
| M8120 | Reserved | Cannot be used |
| M8121 | RS/RS2 Send Standby | TRUE when RS/RS2 command is waiting to send (Serial Port 2) |
| M8122 | RS/RS2 Send Request | Trigger to request RS/RS2 data transmission |
| M8123 | RS/RS2 Reception Complete | TRUE when RS/RS2 command reception ends |
| M8124 | RS/RS2 Data Receiving | TRUE while RS/RS2 data is being received |
| M8125 | MODBUS / Mitsubishi Enable | Enables MODBUS and Mitsubishi protocol functions |
| M8128 | RD3A/WR3A Receive OK | TRUE when RD3A/WR3A command receives correctly |
| M8129 | RD3A/WR3A Timeout | TRUE when RD3A/WR3A communication times out |
| M8196 | Port 2 Protocol Enable | Enables programming port protocol and other protocols on Serial Port 2 |
| M8198 | C251/C252 4× Frequency | Enables 4× frequency multiplication for counters C251 and C252 |
| M8199 | C253/C255 4× Frequency | Enables 4× frequency multiplication for counters C253 and C255 |

### 1.12 Serial Port 3 — Communication Control

| Device | Name | Description |
|--------|------|-------------|
| M8192 | Port 3 Protocol Enable | Enables programming port protocol and other protocols on Serial Port 3 |
| M8401 | RS2 Send Standby | TRUE when RS2 command is waiting to send (Serial Port 3) |
| M8402 | RS2 Send Request | Trigger to request RS2 data transmission |
| M8403 | RS2 Reception Complete | TRUE when RS2 command reception ends |
| M8404 | RS2 Data Receiving | TRUE while RS2 data is being received |

### 1.13 Positioning Control — Axes 1–4 (Y0–Y3)

#### Axis 1 (Y0)

| Device | Name | Description |
|--------|------|-------------|
| M8340 | Y0 Pulse Operation Temporary Control | Temporary control flag during Y0 pulse operation |
| M8341 | Y0 Clear Signal Enable | Enables CLEAR signal output function for Y0 |
| M8342 | Y0 Origin Return Direction | Specifies origin return direction for Y0 |
| M8343 | Y0 Forward Limit | Y0 forward limit switch input status |
| M8344 | Y0 Reverse Limit | Y0 reverse limit switch input status |
| M8345 | Y0 Near-Point DOG Logic Inversion | Inverts near-point DOG signal logic for Y0 |
| M8346 | Y0 Zero Signal Logic Inversion | Inverts zero-point signal logic for Y0 |
| M8347 | Y0 Interrupt Signal Logic Inversion | Inverts interrupt signal logic for Y0 |
| M8348 | Y0 Positioning Command Driver | Positioning command driver status for Y0 |
| M8349 | Y0 Pulse Stop | Stop command for Y0 pulse output |

#### Axis 2 (Y1)

| Device | Name | Description |
|--------|------|-------------|
| M8350 | Y1 Pulse Operation Temporary Control | Temporary control flag during Y1 pulse operation |
| M8351 | Y1 Clear Signal Enable | Enables CLEAR signal output function for Y1 |
| M8352 | Y1 Origin Return Direction | Specifies origin return direction for Y1 |
| M8353 | Y1 Forward Limit | Y1 forward limit switch input status |
| M8354 | Y1 Reverse Limit | Y1 reverse limit switch input status |
| M8355 | Y1 Near-Point DOG Logic Inversion | Inverts near-point DOG signal logic for Y1 |
| M8356 | Y1 Zero Signal Logic Inversion | Inverts zero-point signal logic for Y1 |
| M8357 | Y1 Interrupt Signal Logic Inversion | Inverts interrupt signal logic for Y1 |
| M8358 | Y1 Positioning Command Driver | Positioning command driver status for Y1 |
| M8359 | Y1 Pulse Stop | Stop command for Y1 pulse output |

#### Axis 3 (Y2)

| Device | Name | Description |
|--------|------|-------------|
| M8360 | Y2 Pulse Operation Temporary Control | Temporary control flag during Y2 pulse operation |
| M8361 | Y2 Clear Signal Enable | Enables CLEAR signal output function for Y2 |
| M8362 | Y2 Origin Return Direction | Specifies origin return direction for Y2 |
| M8363 | Y2 Forward Limit | Y2 forward limit switch input status |
| M8364 | Y2 Reverse Limit | Y2 reverse limit switch input status |
| M8365 | Y2 Near-Point DOG Logic Inversion | Inverts near-point DOG signal logic for Y2 |
| M8366 | Y2 Zero Signal Logic Inversion | Inverts zero-point signal logic for Y2 |
| M8367 | Y2 Interrupt Signal Logic Inversion | Inverts interrupt signal logic for Y2 |
| M8368 | Y2 Positioning Command Driver | Positioning command driver status for Y2 |
| M8369 | Y2 Pulse Stop | Stop command for Y2 pulse output |

#### Axis 4 (Y3)

| Device | Name | Description |
|--------|------|-------------|
| M8370 | Y3 Pulse Operation Temporary Control | Temporary control flag during Y3 pulse operation |
| M8371 | Y3 Clear Signal Enable | Enables CLEAR signal output function for Y3 |
| M8372 | Y3 Origin Return Direction | Specifies origin return direction for Y3 |
| M8373 | Y3 Forward Limit | Y3 forward limit switch input status |
| M8374 | Y3 Reverse Limit | Y3 reverse limit switch input status |
| M8375 | Y3 Near-Point DOG Logic Inversion | Inverts near-point DOG signal logic for Y3 |
| M8376 | Y3 Zero Signal Logic Inversion | Inverts zero-point signal logic for Y3 |
| M8377 | Y3 Interrupt Signal Logic Inversion | Inverts interrupt signal logic for Y3 |
| M8378 | Y3 Positioning Command Driver | Positioning command driver status for Y3 |
| M8379 | Y3 Pulse Stop | Stop command for Y3 pulse output |

### 1.14 Positioning Control — Axes 5–8

| Device | Name | Description |
|--------|------|-------------|
| M8151 | 5th Pulse Operation Temporary Control | Temporary control flag during axis 5 pulse operation |
| M8152 | 6th Pulse Operation Temporary Control | Temporary control flag during axis 6 pulse operation |
| M8153 | 7th Pulse Operation Temporary Control | Temporary control flag during axis 7 pulse operation |
| M8154 | 8th Pulse Operation Temporary Control | Temporary control flag during axis 8 pulse operation |

### 1.15 Other

| Device | Name | Description |
|--------|------|-------------|
| M8396 | C254 Phase Input Function | Configures C254 function to correspond to input phase |

---

## 2. System Information Registers (D8000–D8009)

| Device | Name | Description |
|--------|------|-------------|
| D8000 | Watchdog Timer | Default: 200 (×1 ms = 200 ms). Write a new value to change. |
| D8001 | PLC Type & Version | Low byte: main version number. High byte: PLC type code. |
| D8002 | Memory Capacity | 2 = 2K steps, 4 = 4K steps, 8 = 8K steps. For 16K+, D8002 = 8 and D8102 holds the code (16, 32, 64). |
| D8003 | Memory Type | `H10` = PLC built-in memory. Other values for memory cassette types. |

---

## 3. Scan Time Registers (D8010–D8012)

All values in **0.1 ms** units.

| Device | Name | Description |
|--------|------|-------------|
| D8010 | Current Scan Time | Last scan cycle duration (0.1 ms units). Read-only. |
| D8011 | Minimum Scan Time | Shortest scan since RUN start. Read-only. |
| D8012 | Maximum Scan Time | Longest scan since RUN start. Read-only. |

---

## 4. Real-Time Clock Registers (D8013–D8019)

Read/write. Set values then toggle a clock-set bit to update the RTC.

| Device | Name | Range | Description |
|--------|------|-------|-------------|
| D8013 | Second | 0–59 | Current second |
| D8014 | Minute | 0–59 | Current minute |
| D8015 | Hour | 0–23 | Current hour (24-hour format) |
| D8016 | Date | 1–31 | Day of month |
| D8017 | Month | 1–12 | Month number |
| D8018 | Year | 00–99 | Last two digits (2000–2099) |
| D8019 | Week | 0–6 | Day of week. 0 = Sunday, 1 = Monday, …, 6 = Saturday |

---

## 5. Input Filter & Constant Scan (D8020, D8059)

| Device | Name | Description |
|--------|------|-------------|
| D8020 | Input Filter Adjustment | X0–X17 filter time. Range: 0–60 (×1 ms), default: 10 ms. |
| D8059 | Constant Scan Time | Set to non-zero value to enable constant scan mode (0.1 ms units). 0 = disabled (normal scan). |

---

## 6. Analog I/O Registers (D8030–D8058)

### 6.1 Analog Inputs (Built-in AD)

| Device | Channel | Description |
|--------|---------|-------------|
| D8030 | AD0 | Analog input channel 0 (0–4095 for 12-bit) |
| D8031 | AD1 | Analog input channel 1 |
| D8032 | AD2 | Analog input channel 2 |
| D8033 | AD3 | Analog input channel 3 |

### 6.2 Analog Outputs (Built-in DA)

| Device | Channel | Description |
|--------|---------|-------------|
| D8050 | DA0 | Analog output channel 0 |
| D8051 | DA1 | Analog output channel 1 |
| D8052 | DA2 | Analog output channel 2 |
| D8053 | DA3 | Analog output channel 3 |

### 6.3 Module Status

| Device | Name | Description |
|--------|------|-------------|
| D8054 | Module Digital Input Bytes | Total digital input bytes from special modules |
| D8055 | Module Analog Input Words | Total analog input words from special modules |
| D8056 | Module Digital Output Bytes | Total digital output bytes to special modules |
| D8057 | Module Analog Output Words | Total analog output words to special modules |
| D8058 | DA Current Mode Bit Setting | Bitmask for DA channels set to current output mode (4–20 mA) |

---

## 7. High-Speed Counter Registers (D8074–D8097)

Each counter input has three 32-bit register pairs: rising edge ring counter, falling edge ring counter, and pulse width/period measurement.

### 7.1 X0 High-Speed Input

| Device (Low + High) | Name | Unit | Description |
|---------------------|------|------|-------------|
| D8074 + D8075 | X0 Rising Edge Ring Counter | 1/6 μs | 32-bit ring counter, increments on rising edge |
| D8076 + D8077 | X0 Falling Edge Ring Counter | 1/6 μs | 32-bit ring counter, increments on falling edge |
| D8078 + D8079 | X0 Pulse Width / Period | 10 μs | Pulse width or period measurement (32-bit) |

### 7.2 X1 High-Speed Input

| Device (Low + High) | Name | Unit | Description |
|---------------------|------|------|-------------|
| D8080 + D8081 | X1 Rising Edge Ring Counter | 1/6 μs | 32-bit ring counter |
| D8082 + D8083 | X1 Falling Edge Ring Counter | 1/6 μs | 32-bit ring counter |
| D8084 + D8085 | X1 Pulse Width / Period | 10 μs | Pulse width or period measurement (32-bit) |

### 7.3 X3 High-Speed Input

| Device (Low + High) | Name | Unit | Description |
|---------------------|------|------|-------------|
| D8086 + D8087 | X3 Rising Edge Ring Counter | 1/6 μs | 32-bit ring counter |
| D8088 + D8089 | X3 Falling Edge Ring Counter | 1/6 μs | 32-bit ring counter |
| D8090 + D8091 | X3 Pulse Width / Period | 10 μs | Pulse width or period measurement (32-bit) |

### 7.4 X4 High-Speed Input

| Device (Low + High) | Name | Unit | Description |
|---------------------|------|------|-------------|
| D8092 + D8093 | X4 Rising Edge Ring Counter | 1/6 μs | 32-bit ring counter |
| D8094 + D8095 | X4 Falling Edge Ring Counter | 1/6 μs | 32-bit ring counter |
| D8096 + D8097 | X4 Pulse Width / Period | 10 μs | Pulse width or period measurement (32-bit) |

---

## 8. System Info Extended (D8101–D8109)

| Device | Name | Description |
|--------|------|-------------|
| D8101 | PLC Type & System Version | Extended version info |
| D8102 | Memory Capacity (Large) | Code for 16K+ steps: 16 = 16K, 32 = 32K, 64 = 64K. Used when D8002 = 8. |
| D8108 | Connected Special Modules | Number of special function modules/blocks connected |
| D8109 | Output Refresh Error Y | Y-device number where an output refresh error occurred |

---

## 9. Serial Port 2 — Modbus RTU / RS (D8120–D8129)

| Device | Name | Description |
|--------|------|-------------|
| D8120 | Communication Parameters | Baud rate, parity, stop bits, data length (bit-coded). See communication manual. |
| D8121 | Station Number | Master/slave station number for Modbus RTU |
| D8122 | RS Receive Points Monitoring | Remaining receive data points for RS command |
| D8123 | RS Send Data Remaining | Remaining send data points |
| D8124 | RS Header | Communication header character. Default: STX (`H02`). |
| D8125 | RS Trailer | Communication trailer character. Default: ETX (`H03`). |
| D8126 | Interval Period | Inter-character timeout setting for serial port 2 |
| D8127 | Data Request Count | Number of data words requested from lower computer |
| D8128 | Data Request Start | Starting device number for lower computer communication request |
| D8129 | Timeout Setting | Communication timeout value |

---

## 10. Positioning — Axes 5–8 (D8140–D8161)

Extended axis registers.

| Device (Low + High) | Name | Description |
|---------------------|------|-------------|
| D8140 + D8141 | 5th Position Pulse Amount | Current position pulse count for axis 5 (32-bit) |
| D8142 + D8143 | 6th Position Pulse Amount | Current position pulse count for axis 6 (32-bit) |
| D8144 + D8145 | 7th Position Pulse Amount | Current position pulse count for axis 7 (32-bit) |
| D8146 + D8147 | 5th–8th Pulse Max Speed | Maximum speed setting for axes 5–8 (32-bit) |
| D8148 | 5th–8th Accel/Decel Time | Acceleration and deceleration time for axes 5–8 |
| D8160 + D8161 | 8th Position Pulse Amount | Current position pulse count for axis 8 (32-bit) |

---

## 11. Restrict Access (D8169)

| Device | Name | Description |
|--------|------|-------------|
| D8169 | Restrict Access Status | Access restriction control register |

---

## 12. Index Register Backup (D8182–D8195)

These registers mirror the current values of index registers Z and V. Useful for saving/restoring index context.

| Device | Index Register | Description |
|--------|---------------|-------------|
| D8182 | Z1 | Contents of Z1 |
| D8183 | V1 | Contents of V1 |
| D8184 | Z2 | Contents of Z2 |
| D8185 | V2 | Contents of V2 |
| D8186 | Z3 | Contents of Z3 |
| D8187 | V3 | Contents of V3 |
| D8188 | Z4 | Contents of Z4 |
| D8189 | V4 | Contents of V4 |
| D8190 | Z5 | Contents of Z5 |
| D8191 | V5 | Contents of V5 |
| D8192 | Z6 | Contents of Z6 |
| D8193 | V6 | Contents of V6 |
| D8194 | Z7 | Contents of Z7 |
| D8195 | V7 | Contents of V7 |

---

## 13. PWM Custom Frequency (D8268–D8279)

| Device | PWM Channels | Description |
|--------|-------------|-------------|
| D8268 | PWM0–PWM3 Frequency (Low) | Custom frequency for PWM channels 0–3. 32-bit value, range: 840–16,800,000 |
| D8269 | PWM0–PWM3 Frequency (High) | High word of PWM0–PWM3 frequency |
| D8278 | PWM4–PWM7 Frequency (Low) | Custom frequency for PWM channels 4–7. 32-bit value, range: 840–16,800,000 |
| D8279 | PWM4–PWM7 Frequency (High) | High word of PWM4–PWM7 frequency |

---

## 14. Positioning — Axes 1–4 (D8340–D8379)

### 14.1 Axis 1 (Y0)

| Device (Low + High) | Name | Initial | Description |
|---------------------|------|---------|-------------|
| D8340 + D8341 | 1st Position Pulse Amount | — | Current position pulse count (32-bit) |
| D8342 | Y0 Deviation Speed | 0 | Allowable deviation counter value |
| D8343 + D8344 | 1st Pulse Maximum Speed | — | Maximum speed setting (32-bit) |
| D8345 | Y0 Crawling Speed | 1000 | Creep/crawling speed for origin return |
| D8346 + D8347 | Y0 Origin Return Speed | 50000 | Speed during origin return (32-bit) |
| D8348 | 1st Pulse Acceleration Time | — | Acceleration time |
| D8349 | 1st Pulse Deceleration Time | — | Deceleration time |

### 14.2 Axis 2 (Y1)

| Device (Low + High) | Name | Initial | Description |
|---------------------|------|---------|-------------|
| D8350 + D8351 | 2nd Position Pulse Amount | — | Current position pulse count (32-bit) |
| D8352 | Y1 Deviation Speed | 0 | Allowable deviation counter value |
| D8353 + D8354 | 2nd Pulse Maximum Speed | — | Maximum speed setting (32-bit) |
| D8355 | Y1 Crawling Speed | 1000 | Creep/crawling speed for origin return |
| D8356 + D8357 | Y1 Origin Return Speed | 50000 | Speed during origin return (32-bit) |
| D8358 | 2nd Pulse Acceleration Time | — | Acceleration time |
| D8359 | 2nd Pulse Deceleration Time | — | Deceleration time |

### 14.3 Axis 3 (Y2)

| Device (Low + High) | Name | Initial | Description |
|---------------------|------|---------|-------------|
| D8360 + D8361 | 3rd Position Pulse Amount | — | Current position pulse count (32-bit) |
| D8362 | Y2 Deviation Speed | 0 | Allowable deviation counter value |
| D8363 + D8364 | 3rd Pulse Maximum Speed | — | Maximum speed setting (32-bit) |
| D8365 | Y2 Crawling Speed | 1000 | Creep/crawling speed for origin return |
| D8366 + D8367 | Y2 Origin Return Speed | 50000 | Speed during origin return (32-bit) |
| D8368 | 3rd Pulse Acceleration Time | — | Acceleration time |
| D8369 | 3rd Pulse Deceleration Time | — | Deceleration time |

### 14.4 Axis 4 (Y3)

| Device (Low + High) | Name | Initial | Description |
|---------------------|------|---------|-------------|
| D8370 + D8371 | 4th Position Pulse Amount | — | Current position pulse count (32-bit) |
| D8372 | Y3 Deviation Speed | 0 | Allowable deviation counter value |
| D8373 + D8374 | 4th Pulse Maximum Speed | — | Maximum speed setting (32-bit) |
| D8375 | Y3 Crawling Speed | 1000 | Creep/crawling speed for origin return |
| D8376 + D8377 | Y3 Origin Return Speed | 50000 | Speed during origin return (32-bit) |
| D8378 | 4th Pulse Acceleration Time | — | Acceleration time |
| D8379 | 4th Pulse Deceleration Time | — | Deceleration time |

---

## 15. ADPRW / Network / Ring Counter (D8395–D8399)

| Device | Name | Description |
|--------|------|-------------|
| D8395 | ADPRW Serial Port Position | Network setting / ADPRW command serial port configuration |
| D8397 | — | Refer to communication manual chapter 8.2 |
| D8398 + D8399 | Incremental Ring Counter | 32-bit ring counter for incremental actions. Range: 0–2,147,483,647. Unit: 1 ms. |

---

## 16. Serial Port 3 — Modbus RTU / RS (D8400–D8416)

| Device | Name | Description |
|--------|------|-------------|
| D8400 | Communication Parameters | Baud rate, parity, stop bits, data length for serial port 3 |
| D8401 | Communication Mode | Protocol selection for port 3 |
| D8406 | Overtime Time | Communication timeout setting for port 3 |
| D8409 | Interval Period | Inter-character timeout for port 3 |
| D8410 | RS2 Header 1, 2 | Header characters 1 and 2. Default: STX. |
| D8411 | RS2 Header 3, 4 | Header characters 3 and 4 |
| D8412 | RS2 Trailer 1, 2 | Trailer characters 1 and 2. Default: ETX. |
| D8413 | RS2 Trailer 3, 4 | Trailer characters 3 and 4 |
| D8414 | Station Number | Master/slave station number for port 3 |
| D8415 | RS2 Receive Checksum | Checksum/summation calculation result for received data |
| D8416 | RS2 Send Checksum | Checksum/summation value for sent data |

---

## 17. CAN Communication (D8420–D8429)

| Device | Name | Description |
|--------|------|-------------|
| D8420 | CAN Communication Parameters | Baud rate and configuration for CAN bus |
| D8421 | CAN Communication Mode | Protocol mode selection |
| D8426 | CAN Interval Period | Inter-message interval setting |
| D8429 | CAN Overtime Time | CAN communication timeout |

---

## 18. Serial Port RS2 (D8430–D8436)

| Device | Name | Description |
|--------|------|-------------|
| D8430 | RS2 Header 1, 2 | Header characters 1 and 2. Default: STX. |
| D8431 | RS2 Header 3, 4 | Header characters 3 and 4 |
| D8432 | RS2 Trailer 1, 2 | Trailer characters 1 and 2. Default: ETX. |
| D8433 | RS2 Trailer 3, 4 | Trailer characters 3 and 4 |
| D8434 | RS2 Receive Data Checksum | Summation of received data |
| D8435 | RS2 Receive Checksum Result | Calculated checksum for received data verification |
| D8436 | RS2 Send Checksum | Checksum/summation for sent data |

---

## Quick-Reference: Most Commonly Used in ST Code

### Special Relays

```
M8000   — Always TRUE during RUN (unconditional execution)
M8002   — First scan pulse (initialization trigger)
M8013   — 1-second clock (blinking logic, periodic tasks)
M8020   — Zero flag (arithmetic result = 0)
M8029   — Instruction execution complete (pulse)
M8034   — Prohibit all outputs (emergency disable)
M8050–M8059 — Interrupt disable control (ON = disabled)
M8060–M8068 — Error diagnostics (hardware, syntax, operation errors)
M8170–M8177 — X0–X7 pulse capture (catch short pulses)
M8340–M8379 — Positioning control for Y0–Y3 (axis control relays)
```

### Special Registers

```
D8000   — Watchdog timer value
D8010   — Current scan time (0.1 ms units)
D8013–D8019 — Real-time clock (second, minute, hour, day, month, year, weekday)
D8020   — Input filter adjustment
D8030–D8033 — Analog inputs AD0–AD3
```

### Usage in ST

Direct device access in ST — special relays and registers are the **exception** to the "always use labels" rule:

```
IF M8002 THEN
    (* First scan initialization *)
    iState := 0;
    xMotor := FALSE;
END_IF;

(* Read analog input *)
iPressureRaw := D8030;

(* Use 1s clock for periodic task *)
IF M8013 THEN
    iCycleCount := iCycleCount + 1;
END_IF;
```

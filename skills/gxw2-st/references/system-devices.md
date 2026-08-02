# System Devices — Special Relays & Registers (FX Series)

Load when using special relays (M8000+) or special registers (D8000+) for diagnostics, clock pulses, or system status.

> **Note:** This is a quick-reference subset. A comprehensive list of all M8000+ and D8000+ devices can be provided separately when needed for specific applications (PID, communications, positioning).

---

## Frequently Used Special Relays (M8000+)

| Device | Name               | Description                          |
|--------|--------------------|--------------------------------------|
| M8000  | Always ON          | TRUE during PLC RUN mode             |
| M8001  | Always OFF         | FALSE during PLC RUN mode            |
| M8002  | First Scan ON      | TRUE for first scan only after RUN   |
| M8003  | First Scan OFF     | FALSE for first scan only after RUN  |
| M8011  | 10ms Clock         | 5ms ON, 5ms OFF (10ms period)        |
| M8012  | 100ms Clock        | 50ms ON, 50ms OFF (100ms period)     |
| M8013  | 1s Clock           | 0.5s ON, 0.5s OFF (1s period)        |
| M8014  | 1min Clock         | 30s ON, 30s OFF (1min period)        |
| M8020  | Zero Flag          | TRUE when operation result is 0      |
| M8021  | Borrow Flag        | TRUE when borrow occurs on subtraction|
| M8022  | Carry Flag         | TRUE when carry occurs on addition   |
| M8030  | Battery LED OFF    | Turn OFF battery alarm LED           |
| M8031  | Clear non-latched  | Clear all non-latched devices        |
| M8032  | Clear latched      | Clear all latched devices            |
| M8033  | Memory hold stop   | Stop output when PLC stops           |
| M8034  | All outputs disable| Disable all physical outputs         |
| M8039  | Constant scan mode | Enable constant scan time mode       |
| M8060  | I/O error          | I/O configuration error              |
| M8061  | PLC hardware error | Hardware error detected              |
| M8064  | Parameter error    | Parameter setting error              |
| M8065  | Syntax error       | Program syntax error                 |
| M8066  | Program error      | Program execution error              |
| M8067  | Operation error    | Operation execution error            |

---

## Frequently Used Special Registers (D8000+)

| Device | Name               | Description                               |
|--------|--------------------|-------------------------------------------|
| D8000  | Watchdog Timer     | Default 200ms. Write to change.           |
| D8001  | PLC Type & Version | PLC type and firmware version             |
| D8002  | Memory Capacity    | Program memory capacity (steps)           |
| D8010  | Current Scan Time  | Current scan time in 0.1ms units          |
| D8011  | Min Scan Time      | Minimum scan time in 0.1ms units          |
| D8012  | Max Scan Time      | Maximum scan time in 0.1ms units          |
| D8013  | Seconds            | RTC seconds (0–59)                        |
| D8014  | Minutes            | RTC minutes (0–59)                        |
| D8015  | Hours              | RTC hours (0–23)                          |
| D8016  | Day                | RTC day (1–31)                            |
| D8017  | Month              | RTC month (1–12)                          |
| D8018  | Year               | RTC year (2000–2099, 2-digit)             |
| D8019  | Day of Week        | RTC day of week (0=Sun, 1=Mon, ...)       |
| D8039  | Constant Scan Time | Scan time setting in ms (when M8039 ON)   |
| D8060  | I/O Error Detail   | Detail code for I/O error                 |
| D8064  | Parameter Error    | Error code for parameter error            |
| D8065  | Syntax Error Step  | Step number of syntax error               |
| D8066  | Program Error Step | Step number of program error              |
| D8067  | Operation Error    | Error code for operation error            |

---

## Usage in ST Code

Special relays and registers are one of the **few exceptions** to the "no direct device access" rule. They may be used directly in ST code:

```iecst
(* INIT program — runs on first scan *)
IF M8002 THEN
    g_iState := 0;
    g_iCycleCount := K0;
END_IF;

(* ROUTINE program — runs on 100ms clock *)
IF M8012 THEN
    g_iCounter := g_iCounter + K1;
END_IF;

(* Scan time monitoring *)
g_iCurrentScan := D8010;  (* 0.1ms units *)
```

---

## Error Handling Pattern

```iecst
IF M8067 THEN
    g_iErrorCode := D8067;
    g_iState := 40;  (* Fault state *)
END_IF;
```

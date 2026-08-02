# FX3U / FX3G — ST Instruction Knowledge Base

This is the knowledge base index for the AI skill. Each row is one file with a full instruction description.
Workflow: 1) load this index, 2) pick the matching instructions by task and short description,
3) load the concrete files from this folder for full description, ST syntax and examples.

Flags: ✓✓ = FX3U and FX3G · ✓— = FX3U only · —✓ = FX3G only.

## How to load an instruction file

Each instruction has its own file in this folder. To get full details (ST syntax,
operands, variants, examples, support):

1. Find the instruction in the tables below (by name or short description) and read the **File** column.
2. Load the file at `references/DB/{File}` — e.g. instruction `MOV` → `MOV.md`, `ADD` → `ADD.md`.

> Some instructions share one file with a paired instruction (e.g. `SET`/`RST` in `SET.md`, `PLS`/`PLF` in `PLS.md`, `MEP`/`MEF` in `MEP.md`, `OUT_C`/`OUT_C_32` in `OUT_C.md`). The File column always shows the exact filename to load.

## Part 1 — Basic & Applied Instruction

| Group | File | Instruction | Description | Page | FX3U | FX3G |
|---|---|---|---|---|---|---|
### 5. Basic Instruction

| LDP.md | [LDP.md](LDP.md) | LDP, LDF, ANDP, ANDF, ORP, ORF |  | 57 | ✓ | ✓ |
| OUT.md | [OUT.md](OUT.md) | OUT (Excluding timers and counters) |  | 62 | ✓ | ✓ |
| OUT_T.md | [OUT_T.md](OUT_T.md) | OUT_T / Hardware Timer Start | Hardware Timer Start | 62 | ✓ | ✓ |
| OUT_C.md | [OUT_C.md](OUT_C.md) | OUT_C, OUT_C_32 / Hardware Counter Start | Hardware Counter Start (16-bit / 32-bit) | 66 / 68 | ✓ | ✓ |
| MPS.md | [MPS.md](MPS.md) | MPS, MRD, MPP |  | 73 | ✓ | ✓ |
| INV.md | [INV.md](INV.md) | INV | | 77 | ✓ | ✓ |
| MEP.md | [MEP.md](MEP.md) | MEP, MEF | Raise and fall adge detection  | 79 | ✓ | ✓ |
| SET.md | [SET.md](SET.md) | SET, RST |  | 81 | ✓ | ✓ |
| PLS.md | [PLS.md](PLS.md) | PLS, PLF | Raise and fall adge detection | 85 | ✓ | ✓ |
| MC.md | [MC.md](MC.md) | MC, MCR |  | 87 | ✓ | ✓ |
### 6. Step Ladder Instructions

| STL.md | [STL.md](STL.md) | STL |  | 100 | ✓ | ✓ |
| RET.md | [RET.md](RET.md) | RET |  | 101 | ✓ | ✓ |
### 7. Program Flow

| IRET.md | [IRET.md](IRET.md) | IRET / Interrupt Return | Interrupt Return | 117 | ✓ | ✓ |
| DI.md | [DI.md](DI.md) | DI / Disable Interrupt | Disable Interrupt | 120 | ✓ | ✓ |
| EI.md | [EI.md](EI.md) | EI / Enable Interrupt | Enable Interrupt | 121 | ✓ | ✓ |
| FEND.md | [FEND.md](FEND.md) | FEND / Main Routine Program End | Main Routine Program End | 123 | ✓ | ✓ |
| WDT.md | [WDT.md](WDT.md) | WDT / Watchdog Timer Refresh | Watchdog Timer Refresh | 125 | ✓ | ✓ |
### 8. Move and Compare

| CMP.md | [CMP.md](CMP.md) | CMP / Compare | Compare | 133 | ✓ | ✓ |
| ZCP.md | [ZCP.md](ZCP.md) | ZCP / Zone Compare | Zone Compare | 136 | ✓ | ✓ |
| MOV.md | [MOV.md](MOV.md) | MOV / Move | Move | 139 | ✓ | ✓ |
| SMOV.md | [SMOV.md](SMOV.md) | SMOV / Shift Move | Shift Move | 143 | ✓ | ✓ |
| CML.md | [CML.md](CML.md) | CML / Complement | Complement | 146 | ✓ | ✓ |
| XCH.md | [XCH.md](XCH.md) | XCH / Exchange | Exchange | 157 | ✓ | — |
| BCD.md | [BCD.md](BCD.md) | BCD / Conversion to Binary Coded Decimal | Conversion to Binary Coded Decimal | 159 | ✓ | ✓ |
| BIN.md | [BIN.md](BIN.md) | BIN / Conversion to Binary | Conversion to Binary | 163 | ✓ | ✓ |
### 9. Arithmetic and Logical Operation

| ADD.md | [ADD.md](ADD.md) | ADDP / Addition | Addition | 168 | ✓ | ✓ |
| SUB.md | [SUB.md](SUB.md) | SUBP / Subtraction | Subtraction | 171 | ✓ | ✓ |
| MUL.md | [MUL.md](MUL.md) | MULP / Multiplication | Multiplication | 174 | ✓ | ✓ |
| DIV.md | [DIV.md](DIV.md) | DIVP / Division | Division | 178 | ✓ | ✓ |
| INC.md | [INC.md](INC.md) | INC / Increment | Increment | 181 | ✓ | ✓ |
| DEC.md | [DEC.md](DEC.md) | DEC / Decrement | Decrement | 183 | ✓ | ✓ |
| WAND.md | [WAND.md](WAND.md) | WAND / Logical Word AND | Logical Word AND | 185 | ✓ | ✓ |
| WOR.md | [WOR.md](WOR.md) | WOR / Logical Word OR | Logical Word OR | 187 | ✓ | ✓ |
| WXOR.md | [WXOR.md](WXOR.md) | WXOR / Logical Exclusive OR | Logical Exclusive OR | 189 | ✓ | ✓ |
| NEG.md | [NEG.md](NEG.md) | NEG / Negation | Negation | 192 | ✓ | ✓ |
### 10. Rotation and Shift Operation

| ROR.md | [ROR.md](ROR.md) | ROR / Rotation Right | Rotation Right | 196 | ✓ | ✓ |
| ROL.md | [ROL.md](ROL.md) | ROL / Rotation Left | Rotation Left | 199 | ✓ | ✓ |
| SHL.md | [SHL.md](SHL.md) | SHL / Shift Left (function) | Shift Left | 176 | ✓ | ✓ |
| SHR.md | [SHR.md](SHR.md) | SHR / Shift Right (function) | Shift Right | 178 | ✓ | ✓ |
| RCR.md | [RCR.md](RCR.md) | RCR / Rotation Right with Carry | Rotation Right with Carry | 202 | ✓ | — |
| RCL.md | [RCL.md](RCL.md) | RCL / Rotation Left with Carry | Rotation Left with Carry | 205 | ✓ | — |
| SFTR.md | [SFTR.md](SFTR.md) | SFTR / Bit Shift Right | Bit Shift Right | 208 | ✓ | ✓ |
| SFTL.md | [SFTL.md](SFTL.md) | SFTL / Bit Shift Left | Bit Shift Left | 210 | ✓ | ✓ |
| WSFR.md | [WSFR.md](WSFR.md) | WSFR / Word Shift Right | Word Shift Right | 213 | ✓ | ✓ |
| WSFL.md | [WSFL.md](WSFL.md) | WSFL / Word Shift Left | Word Shift Left | 216 | ✓ | ✓ |
| SFWR.md | [SFWR.md](SFWR.md) | SFWR / Shift Write [FIFO/FILO Control] | Shift Write [FIFO/FILO Control] | 219 | — | — |
| SFRD.md | [SFRD.md](SFRD.md) | SFRD / Shift Read [FIFO Control] | Shift Read [FIFO Control] | 222 | — | — |
### 11. Data Operation

| ZRST.md | [ZRST.md](ZRST.md) | ZRST / Zone Reset | Zone Reset | 225 | ✓ | ✓ |
| DECO.md | [DECO.md](DECO.md) | DECO / Decode | Decode | 229 | ✓ | ✓ |
| ENCO.md | [ENCO.md](ENCO.md) | ENCO / Encode | Encode | 233 | ✓ | ✓ |
| SUM.md | [SUM.md](SUM.md) | SUM / Sum of Active Bits | Sum of Active Bits | 236 | ✓ | ✓ |
| BON.md | [BON.md](BON.md) | BON / Check Specified Bit Status | Check Specified Bit Status | 239 | ✓ | ✓ |
| MEAN.md | [MEAN.md](MEAN.md) | MEAN / Mean | Mean | 242 | ✓ | ✓ |
| ANS.md | [ANS.md](ANS.md) | ANS / Timed Annunciator Set | Timed Annunciator Set | 244 | ✓ | ✓ |
| ANR.md | [ANR.md](ANR.md) | ANR / Annunciator Reset | Annunciator Reset | 246 | ✓ | ✓ |
| SQR.md | [SQR.md](SQR.md) | SQR / Square Root | Square Root | 248 | ✓ | — |
| FLT.md | [FLT.md](FLT.md) | FLT / Conversion to Floating Point | Conversion to Floating Point | 250 | ✓ | — |
### 12. High Speed Processing

| REF.md | [REF.md](REF.md) | REF / Refresh | Refresh | 255 | ✓ | ✓ |
| REFF.md | [REFF.md](REFF.md) | REFF / Refresh and Filter Adjust | Refresh and Filter Adjust | 259 | ✓ | ✓ |
| MTR.md | [MTR.md](MTR.md) | MTR / Input Matrix | Input Matrix | 263 | ✓ | ✓ |
| DHSCS.md | [DHSCS.md](DHSCS.md) | DHSCS, DHSCS_I / High Speed Counter Set, High Speed Interrupt Counter Set | High Speed Counter Set, High Speed Interrupt Counter Set | 267 | — | — |
| DHSCR.md | [DHSCR.md](DHSCR.md) | DHSCR / High Speed Counter Reset | High Speed Counter Reset | 275 | ✓ | ✓ |
| DHSZ.md | [DHSZ.md](DHSZ.md) | DHSZ / High Speed Counter Zone Compare | High Speed Counter Zone Compare | 279 | ✓ | ✓ |
| SPD.md | [SPD.md](SPD.md) | SPD / Speed Detection | Speed Detection | 292 | ✓ | ✓ |
| PLSY.md | [PLSY.md](PLSY.md) | PLSY / Pulse Y Output | Pulse Y Output | 296 | ✓ | ✓ |
| PWM.md | [PWM.md](PWM.md) | PWM / Pulse Width Modulation | Pulse Width Modulation | 303 | ✓ | ✓ |
| PLSR.md | [PLSR.md](PLSR.md) | PLSR / Acceleration/Deceleration Setup | Acceleration/Deceleration Setup | 306 | ✓ | ✓ |
### 13. Handy Instruction

| SER.md | [SER.md](SER.md) | SER / Search a Data Stack | Search a Data Stack | 323 | ✓ | ✓ |
| ABSD.md | [ABSD.md](ABSD.md) | ABSD / Absolute Drum Sequencer | Absolute Drum Sequencer | 327 | ✓ | ✓ |
| INCD.md | [INCD.md](INCD.md) | INCD / Incremental Drum Sequencer | Incremental Drum Sequencer | 331 | ✓ | ✓ |
| TTMR.md | [TTMR.md](TTMR.md) | TTMR / Teaching Timer | Teaching Timer | 334 | ✓ | — |
| STMR.md | [STMR.md](STMR.md) | STMR / Special Timer | Special Timer | 337 | ✓ | — |
| ALT.md | [ALT.md](ALT.md) | ALT / Alternate State | Alternate State | 340 | ✓ | ✓ |
| RAMP.md | [RAMP.md](RAMP.md) | RAMP / Ramp Variable Value | Ramp Variable Value | 343 | ✓ | ✓ |
| ROTC.md | [ROTC.md](ROTC.md) | ROTC / Rotary Table Control | Rotary Table Control | 346 | ✓ | — |
| SORT.md | [SORT.md](SORT.md) | SORT / SORT Tabulated Data | SORT Tabulated Data | 349 | ✓ | — |
### 14. External FX I/O Device

| TKY.md | [TKY.md](TKY.md) | TKY / Ten Key Input | Ten Key Input | 353 | ✓ | — |
| HKY.md | [HKY.md](HKY.md) | HKY / Hexadecimal Input | Hexadecimal Input | 357 | ✓ | — |
| DSW.md | [DSW.md](DSW.md) | DSW / Digital Switch (Thumbwheel Input) | Digital Switch (Thumbwheel Input) | 361 | ✓ | ✓ |
| SEGD.md | [SEGD.md](SEGD.md) | SEGD / Seven Segment Decoder | Seven Segment Decoder | 365 | ✓ | — |
| SEGL.md | [SEGL.md](SEGL.md) | SEGL / Seven Segment With Latch | Seven Segment With Latch | 367 | ✓ | ✓ |
| ARWS.md | [ARWS.md](ARWS.md) | ARWS / Arrow Switch | Arrow Switch | 372 | ✓ | — |
| ASC.md | [ASC.md](ASC.md) | ASC / ASCII Code Data Input | ASCII Code Data Input | 376 | ✓ | — |
| PR.md | [PR.md](PR.md) | PR / Print (ASCII Code) | Print (ASCII Code) | 378 | ✓ | — |
| FROM.md | [FROM.md](FROM.md) | FROM / Read From A Special Function Block | Read From A Special Function Block | 381 | ✓ | ✓ |
| TO.md | [TO.md](TO.md) | TO / Write To A Special Function Block | Write To A Special Function Block | 386 | ✓ | ✓ |
### 15. External Device (optional device)

| RS.md | [RS.md](RS.md) | RS / Serial Communication | Serial Communication | 390 | ✓ | ✓ |
| PRUN.md | [PRUN.md](PRUN.md) | PRUN / Parallel Run (Octal Mode) | Parallel Run (Octal Mode) | 393 | ✓ | ✓ |
| ASCI.md | [ASCI.md](ASCI.md) | ASCI / Hexadecimal to ASCII Conversion | Hexadecimal to ASCII Conversion | 395 | ✓ | ✓ |
| HEX.md | [HEX.md](HEX.md) | HEX / ASCII to Hexadecimal Conversion | ASCII to Hexadecimal Conversion | 399 | — | — |
| CCD.md | [CCD.md](CCD.md) | CCD / Check Code | Check Code | 403 | ✓ | ✓ |
| VRRD.md | [VRRD.md](VRRD.md) | VRRD / Volume Read | Volume Read | 406 | — | — |
| VRSC.md | [VRSC.md](VRSC.md) | VRSC / Volume Scale | Volume Scale | 409 | — | — |
| RS2.md | [RS2.md](RS2.md) | RS2 / Serial Communication 2 | Serial Communication 2 | 411 | ✓ | ✓ |
| PID.md | [PID.md](PID.md) | PID / PID Control Loop | PID Control Loop | 414 | ✓ | ✓ |
### 16. External Device

| MNET.md | [MNET.md](MNET.md) | MNET / F-16NP/NT communication | F-16NP/NT communication | 419 | — | — |
| ANRD.md | [ANRD.md](ANRD.md) | ANRD / Read from F2-6A | Read from F2-6A | 421 | — | — |
| ANWR.md | [ANWR.md](ANWR.md) | ANWR / Write to F2-6A | Write to F2-6A | 423 | — | — |
| RMST.md | [RMST.md](RMST.md) | RMST / F2-32RM start | F2-32RM start | 424 | — | — |
| RMWR.md | [RMWR.md](RMWR.md) | RMWR / Write to F2-32RM | Write to F2-32RM | 425 | — | — |
| RMRD.md | [RMRD.md](RMRD.md) | RMRD / Read from F2-32RM | Read from F2-32RM | 427 | — | — |
| RMMN.md | [RMMN.md](RMMN.md) | RMMN / F2-32RM monitor | F2-32RM monitor | 429 | — | — |
| BLK.md | [BLK.md](BLK.md) | BLK / Specify F2-30GM | Specify F2-30GM | 430 | — | — |
| MCDE.md | [MCDE.md](MCDE.md) | MCDE / F2-30GM code | F2-30GM code | 432 | — | — |
### 17. Data Transfer 2

| ZPUSH.md | [ZPUSH.md](ZPUSH.md) | ZPUSH / Batch Store of Index Register | Batch Store of Index Register | 434 | ✓ | — |
| ZPO.md | [ZPO.md](ZPO.md) | ZPOP / Batch POP of Index Register | Batch POP of Index Register | 437 | ✓ | — |
### 18. Floating Point

| DECM.md | [DECM.md](DECM.md) | DECMP / Floating Point Compare | Floating Point Compare | 441 | ✓ | — |
| DEZC.md | [DEZC.md](DEZC.md) | DEZCP / Floating Point Zone Compare | Floating Point Zone Compare | 443 | ✓ | — |
| DEMOV.md | [DEMOV.md](DEMOV.md) | DEMOV / Floating Point Move | Floating Point Move | 445 | ✓ | — |
| DESTR.md | [DESTR.md](DESTR.md) | DESTR / Floating Point to Character String Conversion | Floating Point to Character String Conversion | 447 | — | — |
| DEVAL.md | [DEVAL.md](DEVAL.md) | DEVAL / Character String to Floating Point Conversion | Character String to Floating Point Conversion | 454 | — | — |
| DEBCD.md | [DEBCD.md](DEBCD.md) | DEBCD / Floating Point to Scientific Notation Conversion | Floating Point to Scientific Notation Conversion | 459 | — | — |
| DEBIN.md | [DEBIN.md](DEBIN.md) | DEBIN / Scientific Notation to Floating Point Conversion | Scientific Notation to Floating Point Conversion | 461 | — | — |
| DEADD.md | [DEADD.md](DEADD.md) | DEADD / Floating Point Addition | Floating Point Addition | 463 | ✓ | — |
| DESUB.md | [DESUB.md](DESUB.md) | DESUB / Floating Point Subtraction | Floating Point Subtraction | 465 | ✓ | — |
| DEMUL.md | [DEMUL.md](DEMUL.md) | DEMUL / Floating Point Multiplication | Floating Point Multiplication | 467 | ✓ | — |
| DEDIV.md | [DEDIV.md](DEDIV.md) | DEDIV / Floating Point Division | Floating Point Division | 469 | ✓ | — |
| DEX.md | [DEX.md](DEX.md) | DEXP / Floating Point Exponent | Floating Point Exponent | 471 | ✓ | — |
| DLOGE.md | [DLOGE.md](DLOGE.md) | DLOGE / Floating Point Natural Logarithm | Floating Point Natural Logarithm | 473 | ✓ | — |
| DLOG10.md | [DLOG10.md](DLOG10.md) | DLOG10 / Floating Point Common Logarithm | Floating Point Common Logarithm | 475 | ✓ | — |
| DESQR.md | [DESQR.md](DESQR.md) | DESQR / Floating Point Square Root | Floating Point Square Root | 477 | ✓ | — |
| DENEG.md | [DENEG.md](DENEG.md) | DENEG / Floating Point Negation | Floating Point Negation | 479 | ✓ | — |
| INT.md | [INT.md](INT.md) | INT / Floating Point to Integer Conversion | Floating Point to Integer Conversion | 480 | ✓ | — |
| DSIN.md | [DSIN.md](DSIN.md) | DSIN / Floating Point Sine | Floating Point Sine | 482 | ✓ | — |
| DCOS.md | [DCOS.md](DCOS.md) | DCOS / Floating Point Cosine | Floating Point Cosine | 484 | ✓ | — |
| DTAN.md | [DTAN.md](DTAN.md) | DTAN / Floating Point Tangent | Floating Point Tangent | 485 | ✓ | — |
| DASIN.md | [DASIN.md](DASIN.md) | DASIN / Floating Point Arc Sine | Floating Point Arc Sine | 486 | ✓ | — |
| DACOS.md | [DACOS.md](DACOS.md) | DACOS / Floating Point Arc Cosine | Floating Point Arc Cosine | 488 | ✓ | — |
| DATAN.md | [DATAN.md](DATAN.md) | DATAN / Floating Point Arc Tangent | Floating Point Arc Tangent | 490 | ✓ | — |
| DRAD.md | [DRAD.md](DRAD.md) | DRAD / Floating Point Degrees to Radians Conversion | Floating Point Degrees to Radians Conversion | 492 | ✓ | — |
| DDEG.md | [DDEG.md](DDEG.md) | DDEG / Floating Point Radians to Degrees Conversion | Floating Point Radians to Degrees Conversion | 494 | — | — |
### 19. Data Operation 2

| WSUM.md | [WSUM.md](WSUM.md) | WSUM / Sum of Word Data | Sum of Word Data | 497 | — | — |
| WTOB.md | [WTOB.md](WTOB.md) | WTOB / WORD to BYTE | WORD to BYTE | 500 | — | — |
| BTOW.md | [BTOW.md](BTOW.md) | BTOW / BYTE to WORD | BYTE to WORD | 503 | — | — |
| UNI.md | [UNI.md](UNI.md) | UNI / 4-bit Linking of Word Data | 4-bit Linking of Word Data | 506 | — | — |
| DIS.md | [DIS.md](DIS.md) | DIS / 4-bit Grouping of Word Data | 4-bit Grouping of Word Data | 508 | — | — |
| SWA.md | [SWA.md](SWA.md) | SWAP / Byte Swap | Byte Swap | 510 | ✓ | — |
| SORT2.md | [SORT2.md](SORT2.md) | SORT2 / Sort Tabulated Data 2 | Sort Tabulated Data 2 | 512 | ✓ | — |
### 20. Positioning Control

| DSZR.md | [DSZR.md](DSZR.md) | DSZR / Dog Search Zero Return | Dog Search Zero Return | 518 | ✓ | ✓ |
| DVIT.md | [DVIT.md](DVIT.md) | DVIT / Interrupt Positioning | Interrupt Positioning | 520 | ✓ | — |
| DTBL.md | [DTBL.md](DTBL.md) | DTBL / Batch Data Positioning Mode | Batch Data Positioning Mode | 523 | — | ✓ |
| DABS.md | [DABS.md](DABS.md) | DABS / Absolute Current Value Read | Absolute Current Value Read | 525 | ✓ | ✓ |
| ZRN.md | [ZRN.md](ZRN.md) | ZRN / Zero Return | Zero Return | 527 | ✓ | ✓ |
| PLSV.md | [PLSV.md](PLSV.md) | PLSV / Variable Speed Pulse Output | Variable Speed Pulse Output | 531 | ✓ | ✓ |
| DRVI.md | [DRVI.md](DRVI.md) | DRVI / Drive to Increment | Drive to Increment | 534 | ✓ | ✓ |
| DRVA.md | [DRVA.md](DRVA.md) | DRVA / Drive to Absolute | Drive to Absolute | 537 | ✓ | ✓ |
### 21. Real Time Clock Control

| TCM.md | [TCM.md](TCM.md) | TCMP / RTC Data Compare | RTC Data Compare | 541 | — | — |
| TZC.md | [TZC.md](TZC.md) | TZCP / RTC Data Zone Compare | RTC Data Zone Compare | 544 | — | — |
| TADD.md | [TADD.md](TADD.md) | TADD / RTC Data Addition | RTC Data Addition | 547 | — | — |
| TSUB.md | [TSUB.md](TSUB.md) | TSUB / RTC Data Subtraction | RTC Data Subtraction | 549 | — | — |
| HTOS.md | [HTOS.md](HTOS.md) | HTOS / Hour to Second Conversion | Hour to Second Conversion | 551 | ✓ | ✓ |
| STOH.md | [STOH.md](STOH.md) | STOH / Second to Hour Conversion | Second to Hour Conversion | 554 | ✓ | — |
| TRD.md | [TRD.md](TRD.md) | TRD / Read RTC data | Read RTC data | 557 | ✓ | ✓ |
| TWR.md | [TWR.md](TWR.md) | TWR / Set RTC data | Set RTC data | 559 | ✓ | ✓ |
| HOUR.md | [HOUR.md](HOUR.md) | HOUR / Hour Meter | Hour Meter | 563 | ✓ | ✓ |
### 22. External Device

| GRY.md | [GRY.md](GRY.md) | GRY / Decimal to Gray Code Conversion | Decimal to Gray Code Conversion | 567 | ✓ | ✓ |
| GBIN.md | [GBIN.md](GBIN.md) | GBIN / Gray Code to Decimal Conversion | Gray Code to Decimal Conversion | 569 | ✓ | ✓ |
| RD3A.md | [RD3A.md](RD3A.md) | RD3A / Read form Dedicated Analog Block | Read form Dedicated Analog Block | 571 | ✓ | ✓ |
| WR3A.md | [WR3A.md](WR3A.md) | WR3A / Write to Dedicated Analog Block | Write to Dedicated Analog Block | 573 | ✓ | ✓ |
### 23. Extension Function

| EXTR_IN.md | [EXTR_IN.md](EXTR_IN.md) | EXTR_IN / External ROM function | External ROM function | 576 | — | — |
| EXTR_OUT.md | [EXTR_OUT.md](EXTR_OUT.md) | EXTR_OUT / External ROM function | External ROM function | 579 | — | — |
### 24. Others

| COMRD.md | [COMRD.md](COMRD.md) | COMRD / Read Device Comment Data | Read Device Comment Data | 584 | — | — |
| RND.md | [RND.md](RND.md) | RND / Random Number Generation | Random Number Generation | 587 | ✓ | — |
| DUTY.md | [DUTY.md](DUTY.md) | DUTY / Timing Pulse Generation | Timing Pulse Generation | 589 | — | — |
| CRC.md | [CRC.md](CRC.md) | CRC / Cyclic Redundancy Check | Cyclic Redundancy Check | 592 | ✓ | — |
| DHCMOV.md | [DHCMOV.md](DHCMOV.md) | DHCMOV / High Speed Counter Move | High Speed Counter Move | 596 | ✓ | — |
### 26. Character String Control

| STR.md | [STR.md](STR.md) | STR / BIN to Character String Conversion | BIN to Character String Conversion | 617 | — | — |
| VAL.md | [VAL.md](VAL.md) | VAL / Character String to BIN Conversion | Character String to BIN Conversion | 622 | — | — |
| LEN.md | [LEN.md](LEN.md) | LEN / Character String Length Detection | Character String Length Detection | 631 | ✓ | — |
| RIGHT.md | [RIGHT.md](RIGHT.md) | RIGHT / Extracting Character String Data from the Right | Extracting Character String Data from the Right | 634 | — | — |
| LEFT.md | [LEFT.md](LEFT.md) | LEFT / Extracting Character String Data from the Left | Extracting Character String Data from the Left | 637 | — | — |
| MIDR.md | [MIDR.md](MIDR.md) | MIDR / Random Selection of Character Strings | Random Selection of Character Strings | 640 | — | — |
| MIDW.md | [MIDW.md](MIDW.md) | MIDW / Random Replacement of Character Strings | Random Replacement of Character Strings | 643 | — | — |
| INSTR.md | [INSTR.md](INSTR.md) | INSTR / Character string search | Character string search | 647 | ✓ | — |
### 27. Data Operation 3

| FDEL.md | [FDEL.md](FDEL.md) | FDEL / Deleting Data from Tables | Deleting Data from Tables | 654 | — | — |
| FINS.md | [FINS.md](FINS.md) | FINS / Inserting Data to Tables | Inserting Data to Tables | 657 | ✓ | — |
| POP.md | [POP.md](POP.md) | POP / Shift Last Data Read [FILO Control] | Shift Last Data Read [FILO Control] | 660 | — | — |
| SFR.md | [SFR.md](SFR.md) | SFR / Bit Shift Right with Carry | Bit Shift Right with Carry | 664 | ✓ | — |
| SFL.md | [SFL.md](SFL.md) | SFL / Bit Shift Left with Carry | Bit Shift Left with Carry | 666 | ✓ | — |
### 29. Data Table Operation

| LIMIT.md | [LIMIT.md](LIMIT.md) | LIMIT / Limit Control | Limit Control | 679 | ✓ | — |
| BAND.md | [BAND.md](BAND.md) | BAND / Dead Band Control | Dead Band Control | 683 | ✓ | — |
| ZONE.md | [ZONE.md](ZONE.md) | ZONE / Zone Control | Zone Control | 687 | ✓ | — |
| SCL.md | [SCL.md](SCL.md) | SCL / Scaling (Coordinate by Point Data) | Scaling (Coordinate by Point Data) | 691 | — | — |
| DABIN.md | [DABIN.md](DABIN.md) | DABIN / Decimal ASCII to BIN Conversion | Decimal ASCII to BIN Conversion | 695 | ✓ | — |
| BINDA.md | [BINDA.md](BINDA.md) | BINDA / BIN to Decimal ASCII Conversion | BIN to Decimal ASCII Conversion | 698 | — | — |
| SCL2.md | [SCL2.md](SCL2.md) | SCL2 / Scaling 2 (Coordinate by X/Y Data) | Scaling 2 (Coordinate by X/Y Data) | 702 | — | — |
### 30. External Device Communication

| IVCK.md | [IVCK.md](IVCK.md) | IVCK / Inverter Status Check | Inverter Status Check | 708 | ✓ | — |
| IVDR.md | [IVDR.md](IVDR.md) | IVDR / Inverter Drive | Inverter Drive | 711 | ✓ | — |
| IVRD.md | [IVRD.md](IVRD.md) | IVRD / Inverter Parameter Read | Inverter Parameter Read | 714 | ✓ | — |
| IVWR.md | [IVWR.md](IVWR.md) | IVWR / Inverter Parameter Write | Inverter Parameter Write | 716 | ✓ | — |
| IVBWR.md | [IVBWR.md](IVBWR.md) | IVBWR / Inverter Parameter Block Write | Inverter Parameter Block Write | 719 | ✓ | — |
| IVMC.md | [IVMC.md](IVMC.md) | IVMC / Inverter Multi Command | Inverter Multi Command | 721 | — | — |
### 31. Data Transfer 3

| RBFM.md | [RBFM.md](RBFM.md) | RBFM / Divided BFM Read | Divided BFM Read | 729 | — | — |
| WBFM.md | [WBFM.md](WBFM.md) | WBFM / Divided BFM Write | Divided BFM Write | 735 | — | — |
### 32. High Speed Processing 2

| DHSCT.md | [DHSCT.md](DHSCT.md) | DHSCT / High Speed Counter Compare With Data Table | High Speed Counter Compare With Data Table | 738 | ✓ | — |
### 33. Extension File Register Control

| LOADR.md | [LOADR.md](LOADR.md) | LOADR / Load From ER | Load From ER | 744 | ✓ | ✓ |
| SAVER.md | [SAVER.md](SAVER.md) | SAVER / Save to ER | Save to ER | 748 | ✓ | — |
| INITR.md | [INITR.md](INITR.md) | INITR / Initialize R and ER | Initialize R and ER | 757 | ✓ | — |
| LOGR.md | [LOGR.md](LOGR.md) | LOGR / Logging R and ER | Logging R and ER | 761 | ✓ | — |
| RWER.md | [RWER.md](RWER.md) | RWER / Rewrite to ER | Rewrite to ER | 765 | — | ✓ |
| INITER.md | [INITER.md](INITER.md) | INITER / Initialize ER | Initialize ER | 770 | — | — |
### 34. FX3U-CF-ADP

| FLCRT.md | [FLCRT.md](FLCRT.md) | FLCRT / File create • check | File create • check | 775 | — | — |
| FLDEL.md | [FLDEL.md](FLDEL.md) | FLDEL / File delete • CF card format | File delete • CF card format | 779 | — | — |
| FLWR.md | [FLWR.md](FLWR.md) | FLWR / Data write | Data write | 781 | — | — |
| FLRD.md | [FLRD.md](FLRD.md) | FLRD / Data read | Data read | 785 | — | — |
| FLCMD.md | [FLCMD.md](FLCMD.md) | FLCMD / FX3U-CF-ADP command | FX3U-CF-ADP command | 787 | — | — |
| FLSTRD.md | [FLSTRD.md](FLSTRD.md) | FLSTRD / FX3U-CF-ADP status read | FX3U-CF-ADP status read | 789 | — | — |

## Part 2 — Application Functions

| Group | File | Function | Description | Page | FX3U | FX3G |
|---|---|---|---|---|---|---|
| 30_Type_Conversion.md | [30_Type_Conversion.md](30_Type_Conversion.md) | Type Conversion | 30_Type_Conversion.md |  | ✓ | ✓ |
| 31_Comparisons.md | [31_Comparisons.md](31_Comparisons.md) | Comparisons | 31_Comparisons.md |  | ✓ | ✓ |
| 32_Bit_Operations.md | [32_Bit_Operations.md](32_Bit_Operations.md) | Bit Operations | 32_Bit_Operations.md |  | ✓ | ✓ |
| 33_Arithmetic_Functions.md | [33_Arithmetic_Functions.md](33_Arithmetic_Functions.md) | Arithmetic Functions | 33_Arithmetic_Functions.md |  | ✓ | ✓ |
| 34_Data_Movement.md | [34_Data_Movement.md](34_Data_Movement.md) | Data Movement | 34_Data_Movement.md |  | ✓ | ✓ |
| 35_Selection_Functions.md | [35_Selection_Functions.md](35_Selection_Functions.md) | Selection Functions | 35_Selection_Functions.md |  | ✓ | ✓ |
| SEL.md | [SEL.md](SEL.md) | SEL / Selection | SEL.md |  | ✓ | ✓ |
| 36_String_Functions.md | [36_String_Functions.md](36_String_Functions.md) | String Functions | 36_String_Functions.md |  | ✓ | ✓ |
| 37_Time_Functions.md | [37_Time_Functions.md](37_Time_Functions.md) | Time Functions | 37_Time_Functions.md |  | ✓ | ✓ |
| 38_Function_Blocks.md | [38_Function_Blocks.md](38_Function_Blocks.md) | Function Blocks | 38_Function_Blocks.md |  | ✓ | ✓ |
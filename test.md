List of basic logic instructions
Mnemonic Name Features Available devices
LD Take Normally open contact logic operation
starts X,Y,M,S,D□.b,T,C
LDI Negate Normally closed contact logic operation
starts X,Y,M,S,D□.b,T,C
LDP Take the rising edge of
the pulse Start of operation to detect rising edge X,Y,M,S,D□.b,T,C
LDF Take the falling edge of
the pulse Start of operation to detect falling edge X,Y,M,S,D□.b,T,C
AND Versus Series of normally open contacts X,Y,M,S,D□.b,T,C
ANI With reverse Series of normally closed contacts X,Y,M,S,D□.b,T,C
ANDP With pulse rising edge Detect rising edge series connection X,Y,M,S,D□.b,T,C
OR Or pulse rising edge Normally open contacts in parallel X,Y,M,S,D□.b,T,C
ORI Or reverse Normally closed contacts in parallel X,Y,M,S,D□.b,T,C
ORP Or pulse rising edge Parallel connection detecting rising edge X,Y,M,S,D□.b,T,C
ORF Or pulse falling edge Parallel connection to detect falling edge X,Y,M,S,D□.b,T,C
ANB Block with Series connection of circuit blocks -
ORB Block or Parallel connection of circuit blocks -
MPS Push stack Push onto the stack -
MRD Read stack Read stack -
MPP Unstack Pop the stack -
INV Negate Inversion of operation result -
MEP M.E.P Conduction on rising edge -
MEF M..EF Conduction on falling edge -
OUT Output Coil drive Y,M,S,D□.b,T,C
SET Position Movement retention Y,M,S,D□.b
RST Reset Clear action keeps, register cleared Y,M,S,D□.b,T,C,
D,R,V,Z
PLS Pulse Differential output on rising edge Y,M
PLF Falling edge pulse Differential output on falling edge Y,M
MC Master Connection circle command for common
series point Y,M
MCR Master reset Instruction to eliminate common series
point -
NOP No operation No action -
END End End of the program and
I/O and return to the beginning

Applied instruction can be divided into the following 18 kinds.
1 Data move instructions
2 Data conversion instructions
3 Comparison instructions
4 Arithmetic operation instructions
5 Logical operation instructions
6 Special function instructions
7 Rotate instructions
8 Data operation instructions
9 Data operation instructions
10 Character string operation instructions
11 Program flow control instructions
12 I/O refresh instructions
13 Real time clock control instructions
14 Pulse output/positioning control instructions
15 Serial communication
16 Special block/unit control instructions
17 Extension register/extension file register control instructions
18 Other handy instruct
1. Data move instructions
Mnemonic FNC No. Function Support
MOV 12 Move ★
SMOV 13 Shift Move ★
CML 14 Compliment ★
BMOV 15 Block Move ★
FMOV 16 Fill Move ★
PRUN 81 Parallel Run (Octal Mode) ★
XCH 17 Exchange ★
SWAP 147 Byte Swap ★
EMOV 112 Floating Point Move ★
HCMOV 189 High Speed Counter Move ★
2. Data conversion instructions
Mnemonic FNC No. Function Support
BCD 18 Conversion to Binary Coded Decimal ★
BIN 19 Conversion to Binary ★
GRY 170 Decimal to Gray Code Conversion ★Coolmay L02 Series PLC Programming Manual
22 https://en.coolmay.com/
GBIN 171 Gray Code to Decimal Conversion ★
FLT 49 Conversion to Floating Point ★
INT 129 Floating Point to Integer Conversion ★
EBCD 118 Floating Point to Scientific Notation
Conversion ★
EBIN 119 Scientific Notation to Floating Point
Conversion ★
RAD 136 Floating Point Degree to Radian Conversion ★
DEG 137 Floating Point Radian to degree Conversion ★
3. Comparison instructions
Mnemonic FNC No. Function Support
LD= 224 Contact compare LD (S1)=(S2) ★
LD> 225 Contact compare LD (S1)>(S2) ★
LD< 226 Contact compare LD (S1)<(S2) ★
LD<> 228 Contact compare LD (S1)≠(S2) ★
LD<= 229 Contact compare LD (S1)≦ (S2) ★
LD>= 230 Contact compare LD (S1)≧ (S2) ★
AND= 232 Contact compare AND (S1)=(S2) ★
AND> 233 Contact compare AND (S1)>(S2) ★
AND< 234 Contact compare AND (S1)<(S2) ★
AND<> 236 Contact compare AND (S1)≠(S2) ★
AND<= 237 Contact compare AND (S1)≦ (S2) ★
AND>= 238 Contact compare AND (S1)≧ (S2) ★
OR= 240 Contact compare OR (S1)=(S2) ★
OR> 241 Contact compare OR (S1)>(S2) ★
OR< 242 Contact compare OR (S1)<(S2) ★
OR<> 244 Contact compare OR (S1)≠(S2) ★
OR<= 245 Contact compare OR (S1)≦ (S2) ★
OR>= 246 Contact compare OR (S1)≧ (S2) ★
CMP 10 Compare ★
ZCP 11 Zone Compare ★
ECMP 110 Floating Point Compare ★
EZCP 111 Floating Point Zone Compare ★
HSCS 53 High speed counter set ★
HSCR 54 High speed counter reset ★
HSZ 55 High Speed Counter Zone Compare ★
HSCT 280 High speed counter table compare ★
BKCMP= 194 Block compare (S1)=(S2) ★
BKCMP> 195 Block compare (S1)>(S2) ★
BKCMP< 196 Block compare (S1)<(S2) ★
BKCMP<> 197 Block compare (S1)≠(S2) ★
BKCMP<= 198 Block compare (S1)≦ (S2) ★
BKCMP>= 199 Block compare (S1)≧ (S2) ★Coolmay L02 Series PLC Programming Manual
23 https://en.coolmay.com/
4. Arithmetic operation instructions
Mnemonic FNC No. Function Support
ADD 20 Addition ★
SUB 21 Subtraction ★
MUL 22 Multiplication ★
DIV 23 Division ★
EADD 120 Floating Point Addition ★
ESUB 121 Floating Point Subtraction ★
EMUL 122 Floating Point Multiplication ★
EDIV 123 Floating Point Division ★
BK+ 192 Block Data Addition ★
BK- 193 Block Data Subtraction ★
INC 24 Increase ★
DEC 25 Decrement ★
5. Logical operation instructions
Mnemonic FNC No. Function Support
WAND 26 Word AND ★
WOR 27 Word OR ★
WXOR 28 Word Exclusive OR ★
6. Special function instructions
Mnemonic FNC No. Function Support
SQR 48 Square Root ★
ESQR 127 Floating Point Square Root ★
EXP 124 Floating Point Exponent ★
LOGE 125 Floating Point Natural Logarithm ★
LOG10 126 Floating Point Common Logarithm ★
SIN 130 Floating Point Sine ★
COS 131 Floating Point Cosine ★
TAN 132 Floating Point Tangent ★
ASIN 133 Floating Point Arc Sine ★
ACOS 134 Floating Point Arc Cosine ★
ATAN 135 Floating Point Arc Tangent ★
RND 184 Random Number Generation ★
7. Rotate instructions
Mnemonic FNC No. Function Support
ROR 30 Rotation Right ★
ROL 31 Rotation Left ★
RCR 32 Rotation right With Carry ★
RCL 33 Rotation Left with Carry ★Coolmay L02 Series PLC Programming Manual
24 https://en.coolmay.com/
8. Shift instructions
Mnemonic FNC No. Function Support
SFTR 34 Bit Shift Right ★
SFTL 35 Bit Shift Left ★
SFR 213 Bit Shift Right with Carry ★
SFL 214 Bit Shift Left with Carry ★
WSFR 36 Word Shift Right ★
WSFL 37 Word Shift left ★
SFWR 38 Shift Write [FIFO/FILO Control] ★
SFRD 39 Shift Read [FIFO Control] ★
POP 212 Shift Last Data Read [FILO Control] ★
9. Data operation instructions
Mnemonic FNC No. Function Support
ZRST 40 Zone Reset ★
DECO 41 Decode ★
ENCO 42 Encode ★
MEAN 45 Mean ★
WSUM 140 Sum of Word Data ★
SUM 43 Sum of Active Bits ★
BON 44 Check Specified Bit Status ★
NEG 29 Negation ★
ENEG 128 Floating Point Negation ★
WTOB 141 WORD to BYTE ★
BTOW 142 BYTE to WORD ★
UNI 143 4-bit Linking of Word Data ★
DIS 144 4-bit Grouping of Word Data ★
CCD 84 Check Code ★
CRC 188 Cyclic Redundancy Check ★
LIMIT 256 Limit Control ★
BAND 257 Dead Band Control ★
ZONE 258 Zone control ★
SCL 259 Scaling (Coordinate by Point Data) ★
SCL2 269 Scaling 2 (Coordinate by X/Y Data) ★
SORT 69 Sort Tabulated Data ★
SORT2 149 Sort Tabulated Data 2 ★
SER 61 Search a Data Stack ★
FDEL 210 Deleting Data from Tables ★
FINS 211 Inserting Data to Tables ★
10. String processing instruction
Mnemonic FNC No. Function Support
ESTR 116 Floating Point to Character String Conversion ★
EVAL 117 Character String to Floating Point Conversion ★Coolmay L02 Series PLC Programming Manual
25 https://en.coolmay.com/
STR 200 BIN to Character String Conversion ★
VAL 201 Character String to BIN Conversion ★
DABIN 260 Decimal ASCII to BIN Conversion ★
BINDA 261 BIN to Decimal ASCII Conversion ★
ASCI 82 Hexadecimal to ASCII Conversion ★
HEX 83 ASCII to Hexadecimal Conversion ★
$MOV 209 Character String Transfer ★
$+ 202 Link Character Strings ★
LEN 203 Character String Length Detection ★
RIGH 204 Extracting Character String Data From the
Right ★
LEFT 205 Extracting Character String Data from the Left ★
MIDR 206 Random Selection of Character Strings ★
MIDW 207 Random Replacement of Character Strings ★
INSTR 208 Character string search ★
COMRD 182 Read Device Comment Data ★
11. Program flow control instructions
Mnemonic FNC No. Function Support
CJ 00 Conditional Jump ★
CALL 01 Call Subroutine ★
SRET 02 Subroutine Return ★
IRET 03 Interrupt Return ★
EI 04 Enable Interrupt ★
DI 05 Disable Interrupt ★
FEND 06 Main Routine Program End ★
FOR 08 Start a FOR/NEXT Loop ★
NEXT 09 End a FOR/NEXT Loop ★
12. I/O refresh instructions
Mnemonic FNC No. Function Support
REF 50 Refresh ★
REFF 51 Refresh and Filter Adjust ★
13. Real time clock control instructions
Mnemonic FNC No. Function Support
TCMP 160 RTC Data Compare ★
TZCP 161 RTC Data Zone Compare ★
TADD 162 RTC Data Addition ★
TSUB 163 RTC Data Subtraction ★
TRD 166 Read RTC data ★
TWR 167 Set RTC data ★
HTOS 164 Hour to Second Conversion ★
STOH 165 Second to Hour Conversion ★Coolmay L02 Series PLC Programming Manual
26 https://en.coolmay.com/
14. Pulse output/positioning control instruction
Mnemonic FNC No. Function Support
ABS 155 Absolute Current Value Read ★
DSZR 150 DOG Search Zero Return ★
ZRN 156 Zero Return ★
TBL 152 Batch Data Positioning Mode ★
DVIT 151 Interrupt Positioning ★
DRVI 158 Drive to Increment ★
DRVA 159 Drive to Absolute ★
PLSV 157 Variable Speed Pulse Output ★
PLSY 57 Pulse Y Output ★
PLSR 59 Acceleration/Deceleration Setup ★
15. Serial communication instructions
Mnemonic FNC No. Function Support
RS 80 Serial Communication ★
R(S2) 87 Serial Communication 2 ★
IVCK 270 Inverter Status Check
IVDR 271 Inverter Drive
IVRD 272 Inverter Parameter Read
IVWR 273 Inverter Parameter Write
IVBWR 274 Inverter Parameter Block Write
IVMC 275 Inverter multiple command
ADPRW 276 MODBUS read and write ★
16. Special block/unit control instructions
Mnemonic FNC No. Function Support
FROM 78 Read From a Special Function Block ★
TO 79 Write To a Special Function Block ★
RD3A 176 Read form Dedicated Analog Block ★
WR3A 177 Write to Dedicated Analog Block ★
RBFM 278 Divided BFM Read
WBFM 279 Divided BFM Write
17. Extension register/extension file register control instructions
Mnemonic FNC No. Function Support
LOADR 290 Load From ER
SAVER 291 Save to ER
RWER 294 Rewrite to ER
INITR 292 Initialize R and ER
INITER 295 Initialize ER
LOGR 293 Logging R and ERCoolmay L02 Series PLC Programming Manual
18. Other handy instructions
Mnemonic FNC No. Function Support
WDT 07 Watchdog Timer Refresh ★
ALT 66 Alternate State ★
ANS 46 Timed Annunciator Set ★
ANR 47 Annunciator Reset ★
HOUR 169 Hour Meter ★
RAMP 67 Ramp Variable Value ★
SPD 56 Speed Detection ★
PWM 58 Pulse Width Modulation ★
DUTY 186 Timing Pulse Generation ★
PID 88 PID Control Loop ★
ZPUSH 102 Batch Store of Index Register ★
ZPOP 103 Batch POP of Index Register ★
TTMR 64 Teaching timer ★
STMR 65 Special timer ★
ABSD 62 Absolute Drum Sequencer ★
INCD 63 Incremental Drum Sequencer ★
ROTC 68 Rotary Table Control ★
IST 60 Initial state ★
MTR 52 Input Matrix ★
TKY 70 Ten Key Input ★
HKY 71 Hexadecimal Input ★
DSW 72 Digital switch (thumbwheel input) ★
SEGD 73 Seven Segment Decoder ★
SEGL 74 Seven Segment With Latch ★
ARWS 75 Arrow Switch ★
ASC 76 ASCII code data input ★
PR 77 Print (ASCII Code) ★
VRRD 85 Volume Read ★
VRSC 86 Volume Scale ★Coolmay L02
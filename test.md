D8000 Watchdog timer 
D8186 Z3 Register contents
D8001 PLC type and system version Main version number 
D8187 V3 Register contents
D8002 PLC memory capacity 2...2K steps; 4...4K steps; 8...8K steps; When 16K steps and above, D8002=8,D8102 is corresponded to 16,32,64
D8188 Z4 Register contents
D8003 Memory type 10H:Programmabl e controller builtin memory
D8189 V4 Register contents
D8010 Scan current value 
D8190 Z5 Register contents
D8011 Scan time minimum 
D8191 V5 Register contents
D8012 Scan time maximum 
D8192 Z6 Register contents
D8013 Second 
D8193 V6 Register contents
D8014 Minute 
D8194 Z7 Register contents
D8015 Hour 
D8195 V7 Register contents
D8016 Date 
D8268 Customize the frequency of PWM0~3 Value range:840~16800000
D8017 Month 
D8269 Customize the frequency of PWM0~3 Value range:840~16800000
D8018 Year 
D8278 Customize the frequency of PWM4~7 Value range:840~16800000
D8019 Week 
D8279 Customize the frequency of PWM4~7 Value range:840~16800000
D8020 Input filter adjustment 
D8340 1st position pulse amount Low
D8030 AD0 analog input value 
D8341 1st position pulse amount High
D8031 AD1 analog input value 
D8342 Y0 deviation speed Initial value:0
D8032 AD2 analog input value 
D8343 1st pulse maximum speed Low
D8033 AD3 analog input value 
D8344 1st pulse maximum speed High
D8050 DA0 analog output value 
D8345 Y0 crawling speed Initial value: 1000
D8051 DA1 analog output value 
D8346 Y0 Origin return speed Initial value:50000 Low
D8052 DA2 analog output value 
D8347 Y0 Origin return speed Initial value:50000 High
D8053 DA3 analog output value 
D8348 1st pulse acceleration time
D8054 Module digital input bytes 
D8349 1st pulse deceleration time
D8055 Module analog input words 
D8350 2nd position pulse amount Low
D8056 Module digital output bytes 
D8351 2nd position pulse amount High
D8057 Module analog output words 
D8352 Y1 deviation speed Initial value:0
D8058 When DA is current, Bit setting 
D8353 2nd pulse maximum speed Low
D8059 Constant scan time 
D8354 Y1 crawling speed Initial value: 1000 High
D8074 X0 Rising edge ring counter value [1/6μs unit] Low 
D8355 Y1 crawling speed Initial value: 1000 High
D8075 X0 Rising edge ring counter value [1/6μs unit] High 
D8356 Y1 Origin return speed LowCoolmay L02 Series PLC Programming Manual Initial value:50000
D8076 X0 falling edge ring counter value [1/6μs unit] Low 
D8357 High
D8077 High D8358 2nd pulse acceleration time
D8078 X0 pulse width / pulse period
[10μs unit]
Low D8359 2nd pulse deceleration time
D8079 High D8360
3rd position pulse amount Low
D8080 X1 Rising edge ring counter
value
[1/6μs unit]
Low D8361 High
D8081 High D8362 Y2 deviation speed
Initial value:0
D8082 X1 falling edge ring counter
value
[1/6μs unit]
Low D8363 3rd pulse maximum speed Low
D8083 High D8364 Y2 crawling speed
Initial value: 1000
High
D8084 X1 pulse width / pulse period
[10μs unit]
Low D8365
D8085 High D8366
Y2 Origin return speed
Initial value:50000
Low
D8086 X3 Rising edge ring counter
value
[1/6μs unit]
Low D8367 High
D8087 High D8368 3rd pulse acceleration time
D8088 X3 falling edge ring counter
value
[1/6μs unit]
Low D8369 3rd pulse deceleration time
D8089 High D8370
4th position pulse amount
Low
D8090
X3 pulse width / pulse period
[10μs unit]
Low D8371 High
D8091 High D8372 Y3 deviation speed
Initial value:0
D8092 X4 Rising edge ring counter
value
[1/6μs unit]
Low D8373
4th pulse maximum speed
Low
D8093 High D8374 High
D8094 X4 falling edge ring counter
value
[1/6μs unit]
Low D8375 Y3 crawling speed
Initial value:1000
D8095 High D8376 Y3 Origin return speed
Initial value:50000
Low
D8096 X4 pulse width / pulse period
[10μs unit]
Low D8377 High
D8097 High D8378 4th pulse acceleration time
D8101 PLC type and system version D8379 4th pulse deceleration time
D8102 PLC memory capacity 16...16K Steps D8395 ADPRW command serial port
positionNetwork setting
function
refer to chapter 8.6
D8108 Number of connected special
modules D8397 refer to chapter 8.2
D8109 Y number where the output
refresh error occurred D8398 0~2147483647(1ms) Ring
count for incremental actions
D8120 Modbus RTU protocol
Communication parameters
Serial Port 2, refer
to chapter 8.2
D8399
D8121 Master/Slave station number D8400 Modbus RTU protocol
Communication parameters
Serial Port 3, refer
to chapter 8.3
D8122 RS command to receive points
monitoring RS command to
send data remaining points
D8401 Communication mode
D8123 D8406
overtime timeNumber of
D8124 RS header <initial value: STX> D8409 interval period
D8125 RS trailer <initial value:
ETX> D8410 RS2 header 1, 2 <initial value:
STX>
D8126 Serial port 2 interval period
number
D8411 RS2 header 3, 4
D8412 RS2 trailer 1, 2 <initial value:Coolmay L02 Series PLC Programming Manual
19 https://en.coolmay.com/
Num Content Remarks Num Content Remarks
ETX>
D8127
Specify the number of data
requested by the lower computer
communication
Serial Port 2, refer
to chapter 8.2
D8413 RS2 trailer 3, 4
D8128
Specify the starting number of
the communication request of
the lower computer
D8414 Master / slave station number
D8129 Set timeout D8415 RS2 receives the summation
calculation result
D8140
5th position pulse amount
Low D8416 RS2 sends summation
D8141 High D8420 Communication parameters
CAN
communication
Refer to chapter
8.6
D8142
6th position pulse amount Low D8421 Communication mode
D8143 High D8426 Number of interval period
D8144
7th position pulse amount
Low D8429 overtime time
D8145 High D8430 RS2 header 1, 2 <initial value:
STX>
D8146
5th -8th pulse max speed
Low D8431 RS2 header 3, 4
D8147 High D8432 RS2 trailer 1, 2 <initial value:
ETX>
D8148 5th- 8th pulse acceleration and
deceleration time D8433 RS2 trailer 3, 4
D8160
8th position pulse amount
Low D8434 RS2 receives the summation
receive data
D8161 High D8435 RS2 receives the summation
calculation result
D8169 Restrict access status D8436 RS2 sends summation
D8182 Z1 Register contents
D8183 V1 Register contents
D8184 Z2 Register contents
D8185 V2 Register contents
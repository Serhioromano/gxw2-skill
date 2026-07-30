#!/usr/bin/env python3
"""Generate all GX Works 2 CSV example files in the correct format:
   UTF-16 LE with BOM, tab-separated, all values quoted."""

import os

def write_csv(path, rows):
    """Write a CSV file in GX Works 2 format: UTF-16 LE, BOM, tab-separated, all values quoted."""
    os.makedirs(os.path.dirname(path), exist_ok=True)
    lines = []
    for row in rows:
        lines.append('\t'.join(f'"{cell}"' for cell in row))
    content = '\n'.join(lines) + '\n'
    with open(path, 'wb') as f:
        f.write(b'\xff\xfe')  # BOM
        f.write(content.encode('utf-16-le'))

# ============================================================
# Standalone CSVs
# ============================================================

# IO.csv — 11 columns: Class, Label Name, Data Type, Constant, Device, Address, Comment, Remark, Relation with System Label, System Label Name, Attribute
write_csv('examples/io.csv', [
    ['GXW2-ST Examples'],
    ['Class', 'Label Name', 'Data Type', 'Constant', 'Device', 'Address', 'Comment', 'Remark', 'Relation with System Label', 'System Label Name', 'Attribute'],
    ['VAR_GLOBAL', 'DI_Start', 'BOOL', '', 'X0', '%IX0.0', 'Start pushbutton (NO)', '', '', '', ''],
    ['VAR_GLOBAL', 'DI_Stop', 'BOOL', '', 'X1', '%IX0.1', 'Stop pushbutton (NC)', '', '', '', ''],
    ['VAR_GLOBAL', 'DI_EmergencyStop', 'BOOL', '', 'X2', '%IX0.2', 'Emergency stop (NC)', '', '', '', ''],
    ['VAR_GLOBAL', 'DI_PhotoEye', 'BOOL', '', 'X3', '%IX0.3', 'Part present sensor', '', '', '', ''],
    ['VAR_GLOBAL', 'DI_LowLevel', 'BOOL', '', 'X4', '%IX0.4', 'Low level float switch', '', '', '', ''],
    ['VAR_GLOBAL', 'DI_HighLevel', 'BOOL', '', 'X5', '%IX0.5', 'High level float switch', '', '', '', ''],
    ['VAR_GLOBAL', 'DO_Pump', 'BOOL', '', 'Y0', '%QX0.0', 'Pump contactor output', '', '', '', ''],
    ['VAR_GLOBAL', 'DO_Motor', 'BOOL', '', 'Y1', '%QX0.1', 'Motor run output', '', '', '', ''],
    ['VAR_GLOBAL', 'DO_Valve', 'BOOL', '', 'Y2', '%QX0.2', 'Valve solenoid output', '', '', '', ''],
    ['VAR_GLOBAL', 'DO_GreenLight', 'BOOL', '', 'Y3', '%QX0.3', 'Green indicator lamp', '', '', '', ''],
    ['VAR_GLOBAL', 'DO_RedLight', 'BOOL', '', 'Y4', '%QX0.4', 'Red indicator lamp', '', '', '', ''],
    ['VAR_GLOBAL', 'DO_Buzzer', 'BOOL', '', 'Y5', '%QX0.5', 'Alarm buzzer', '', '', '', ''],
    ['VAR_GLOBAL', 'AI_Pressure', 'INT', '', 'D10', '%MW10', 'Pressure sensor (4-20mA scaled 0-1000)', '', '', '', ''],
    ['VAR_GLOBAL', 'AI_Temperature', 'INT', '', 'D11', '%MW11', 'Temperature sensor (4-20mA scaled 0-1000)', '', '', '', ''],
    ['VAR_GLOBAL', 'AI_FlowRate', 'INT', '', 'D12', '%MW12', 'Flow rate sensor (4-20mA scaled 0-1000)', '', '', '', ''],
    ['VAR_GLOBAL', 'AO_SpeedRef', 'INT', '', 'D20', '%MW20', 'Speed reference to VFD (0-1000)', '', '', '', ''],
    ['VAR_GLOBAL', 'AO_ValvePosition', 'INT', '', 'D21', '%MW21', 'Valve position command (0-1000)', '', '', '', ''],
])

# GVL.csv — 11 columns
write_csv('examples/gvl.csv', [
    ['GXW2-ST Examples'],
    ['Class', 'Label Name', 'Data Type', 'Constant', 'Device', 'Address', 'Comment', 'Remark', 'Relation with System Label', 'System Label Name', 'Attribute'],
    ['VAR_GLOBAL', 'g_xSystemReady', 'BOOL', '', 'M0', '', 'System ready flag', '', '', '', ''],
    ['VAR_GLOBAL', 'g_xAlarmActive', 'BOOL', '', 'M1', '', 'Alarm active flag', '', '', '', ''],
    ['VAR_GLOBAL', 'g_xAutoMode', 'BOOL', '', 'M2', '', 'Auto mode selected', '', '', '', ''],
    ['VAR_GLOBAL', 'g_xManualMode', 'BOOL', '', 'M3', '', 'Manual mode selected', '', '', '', ''],
    ['VAR_GLOBAL', 'g_xHMI_Start', 'BOOL', '', 'M10', '', 'HMI start command', '', '', '', ''],
    ['VAR_GLOBAL', 'g_xHMI_Stop', 'BOOL', '', 'M11', '', 'HMI stop command', '', '', '', ''],
    ['VAR_GLOBAL', 'g_xHMI_Reset', 'BOOL', '', 'M12', '', 'HMI reset command', '', '', '', ''],
    ['VAR_GLOBAL', 'g_iCycleCount', 'INT', '', 'D100', '%MW100', 'Total cycle counter', '', '', '', ''],
    ['VAR_GLOBAL', 'g_iFaultCount', 'INT', '', 'D101', '%MW101', 'Fault counter', '', '', '', ''],
    ['VAR_GLOBAL', 'g_iTargetCycles', 'INT', '', 'D102', '%MW102', 'Target cycles from HMI', '', '', '', ''],
    ['VAR_GLOBAL', 'g_rTemperatureSP', 'REAL', '', 'D104', '%MW104', 'Temperature setpoint (REAL, 2 registers)', '', '', '', ''],
    ['VAR_GLOBAL', 'g_rPressureSP', 'REAL', '', 'D106', '%MW106', 'Pressure setpoint (REAL, 2 registers)', '', '', '', ''],
    ['VAR_GLOBAL', 'g_tCycleTimeout', 'TIME', '', 'D108', '%MW108', 'Cycle timeout duration (TIME, 2 registers)', '', '', '', ''],
])

# pou-local.csv — 7 columns: Class, Label Name, Data Type, Constant, Device, Address, Comment
write_csv('examples/pou-local.csv', [
    ['GXW2-ST Examples'],
    ['Class', 'Label Name', 'Data Type', 'Constant', 'Device', 'Address', 'Comment'],
    ['VAR', 'iIndex', 'INT', '', '', '', 'Loop index'],
    ['VAR', 'iCounter', 'INT', '', '', '', 'General counter'],
    ['VAR', 'iState', 'INT', '', '', '', 'State machine state'],
    ['VAR', 'xDone', 'BOOL', '', '', '', 'Operation complete flag'],
    ['VAR', 'xRunning', 'BOOL', '', '', '', 'Operation running flag'],
    ['VAR', 'rSetpoint', 'REAL', '', '', '', 'Target setpoint'],
    ['VAR', 'rMeasured', 'REAL', '', '', '', 'Measured value'],
    ['VAR', 'tDelay', 'TIME', '', '', '', 'Delay duration'],
    ['VAR', 'sMessage', 'STRING', '', '', '', 'Display message buffer'],
    ['VAR', 'wStatusWord', 'WORD', '', '', '', 'Status register'],
    ['VAR', 'dwEncoder', 'DWORD', '', '', '', 'Encoder position'],
    ['VAR', 'tonDebounce', 'TON', '', '', '', 'Debounce timer instance'],
    ['VAR', 'ctPartCount', 'CTU', '', '', '', 'Part counter instance'],
    ['VAR', 'rtStartEdge', 'R_TRIG', '', '', '', 'Start button edge detector'],
    ['VAR', 'iInputValue', 'INT', '', '', '', 'Raw input value from sensor'],
    ['VAR', 'rScaledValue', 'REAL', '', '', '', 'Scaled output value'],
    ['VAR_CONSTANT', 'iMaxRetries', 'INT', '', '', '', 'Maximum retry attempts (constant)'],
])

# structure.csv — 4 columns: Label Name, Data Type, Constant, Comment
write_csv('examples/structure.csv', [
    ['GXW2-ST Examples'],
    ['Label Name', 'Data Type', 'Constant', 'Comment'],
    ['iID', 'INT', '', 'Recipe ID number'],
    ['sName', 'STRING', '', 'Recipe name (max 32 chars)'],
    ['rTargetTemp', 'REAL', '', 'Target temperature in degrees C'],
    ['rTargetPressure', 'REAL', '', 'Target pressure in bar'],
    ['rCycleTime', 'REAL', '', 'Cycle time in seconds'],
    ['iMixerSpeed', 'INT', '', 'Mixer speed setpoint (0-1000)'],
    ['xHeaterEnable', 'BOOL', '', 'Heater enabled flag'],
    ['xMixerEnable', 'BOOL', '', 'Mixer enabled flag'],
])

# ============================================================
# Program examples — 7 columns each (local POU format)
# ============================================================

# 01-io-assignment.csv
write_csv('examples/01-io-assignment.csv', [
    ['GXW2-ST Examples'],
    ['Class', 'Label Name', 'Data Type', 'Constant', 'Device', 'Address', 'Comment'],
    ['VAR', 'xStartPulse', 'BOOL', '', '', '', 'One-shot on start press'],
    ['VAR', 'xStopPulse', 'BOOL', '', '', '', 'One-shot on stop press'],
    ['VAR', 'rtStart', 'R_TRIG', '', '', '', 'Start button edge detector'],
    ['VAR', 'rtStop', 'R_TRIG', '', '', '', 'Stop button edge detector'],
    ['VAR', 'xPumpRun', 'BOOL', '', '', '', 'Pump running state'],
    ['VAR', 'xMotorRun', 'BOOL', '', '', '', 'Motor running state'],
])

# 02-conditionals.csv
write_csv('examples/02-conditionals.csv', [
    ['GXW2-ST Examples'],
    ['Class', 'Label Name', 'Data Type', 'Constant', 'Device', 'Address', 'Comment'],
    ['VAR', 'rMeasuredTemp', 'REAL', '', '', '', 'Measured temperature from sensor'],
    ['VAR', 'rMeasuredPressure', 'REAL', '', '', '', 'Measured pressure from sensor'],
    ['VAR', 'rScaledTemp', 'REAL', '', '', '', 'Scaled temperature in engineering units'],
    ['VAR', 'rScaledPressure', 'REAL', '', '', '', 'Scaled pressure in engineering units'],
    ['VAR', 'xTempOK', 'BOOL', '', '', '', 'Temperature within range'],
    ['VAR', 'xPressureOK', 'BOOL', '', '', '', 'Pressure within range'],
    ['VAR', 'xAnyFault', 'BOOL', '', '', '', 'Any fault condition active'],
    ['VAR', 'xHeaterEnable', 'BOOL', '', '', '', 'Heater enabled output'],
    ['VAR', 'xValveEnable', 'BOOL', '', '', '', 'Valve enabled output'],
])

# 03-case-state-machine.csv
write_csv('examples/03-case-state-machine.csv', [
    ['GXW2-ST Examples'],
    ['Class', 'Label Name', 'Data Type', 'Constant', 'Device', 'Address', 'Comment'],
    ['VAR', 'iState', 'INT', '', '', '', 'Current state machine state'],
    ['VAR', 'iPrevState', 'INT', '', '', '', 'Previous state (for edge detection)'],
    ['VAR', 'tStateTimer', 'TIME', '', '', '', 'Time spent in current state'],
    ['VAR', 'tonState', 'TON', '', '', '', 'State timer instance'],
    ['VAR', 'iCycleStep', 'INT', '', '', '', 'Current cycle step counter'],
    ['VAR', 'xMotorRun', 'BOOL', '', '', '', 'Motor running output'],
    ['VAR', 'xValveOpen', 'BOOL', '', '', '', 'Valve open output'],
    ['VAR', 'xCycleComplete', 'BOOL', '', '', '', 'Cycle complete flag'],
])

# 04-loops.csv
write_csv('examples/04-loops.csv', [
    ['GXW2-ST Examples'],
    ['Class', 'Label Name', 'Data Type', 'Constant', 'Device', 'Address', 'Comment'],
    ['VAR', 'iIndex', 'INT', '', '', '', 'FOR loop index'],
    ['VAR', 'iSum', 'INT', '', '', '', 'Accumulated sum'],
    ['VAR', 'iFound', 'INT', '', '', '', 'Search result index'],
    ['VAR', 'xFound', 'BOOL', '', '', '', 'Search result flag'],
    ['VAR', 'iSearchTarget', 'INT', '', '', '', 'Value to search for'],
    ['VAR', 'iTableSize', 'INT', '', '', '', 'Size of lookup table'],
    ['VAR', 'wBitMask', 'WORD', '', '', '', 'Bit mask for shifting'],
    ['VAR', 'iBitPos', 'INT', '', '', '', 'Current bit position'],
    ['VAR', 'xBitSet', 'BOOL', '', '', '', 'Flag: bit found set'],
    ['VAR', 'iResult', 'INT', '', '', '', 'Computed result'],
])

# 05-timers.csv
write_csv('examples/05-timers.csv', [
    ['GXW2-ST Examples'],
    ['Class', 'Label Name', 'Data Type', 'Constant', 'Device', 'Address', 'Comment'],
    ['VAR', 'tonStartDelay', 'TON', '', '', '', 'On-delay: motor start delay'],
    ['VAR', 'tofStopDelay', 'TOF', '', '', '', 'Off-delay: cooling fan run-on'],
    ['VAR', 'tpPulse', 'TP', '', '', '', 'Pulse: one-shot output pulse'],
    ['VAR', 'xMotorReady', 'BOOL', '', '', '', 'Output: motor ready after delay'],
    ['VAR', 'xFanRunning', 'BOOL', '', '', '', 'Output: cooling fan running'],
    ['VAR', 'xPulseOut', 'BOOL', '', '', '', 'Output: pulse signal'],
    ['VAR', 'tMotorElapsed', 'TIME', '', '', '', 'Elapsed time for motor delay'],
    ['VAR', 'tFanElapsed', 'TIME', '', '', '', 'Elapsed time for fan delay'],
    ['VAR', 'tPulseElapsed', 'TIME', '', '', '', 'Elapsed time for pulse'],
    ['VAR', 'xMotorOutput', 'BOOL', '', '', '', 'Final motor output'],
])

# 06-counters.csv
write_csv('examples/06-counters.csv', [
    ['GXW2-ST Examples'],
    ['Class', 'Label Name', 'Data Type', 'Constant', 'Device', 'Address', 'Comment'],
    ['VAR', 'ctParts', 'CTU', '', '', '', 'Count-up: part counter'],
    ['VAR', 'ctBatches', 'CTD', '', '', '', 'Count-down: batch remaining'],
    ['VAR', 'ctTotal', 'CTUD', '', '', '', 'Count up/down: net total'],
    ['VAR', 'xPartsFull', 'BOOL', '', '', '', 'Output: parts batch complete'],
    ['VAR', 'xBatchesDone', 'BOOL', '', '', '', 'Output: all batches done'],
    ['VAR', 'xTotalUp', 'BOOL', '', '', '', 'Output: CTUD up output'],
    ['VAR', 'xTotalDown', 'BOOL', '', '', '', 'Output: CTUD down output'],
    ['VAR', 'iPartsCount', 'INT', '', '', '', 'Current parts count (CV)'],
    ['VAR', 'iBatchesLeft', 'INT', '', '', '', 'Batches remaining (CV)'],
    ['VAR', 'iTotalCount', 'INT', '', '', '', 'Net total count (CV)'],
    ['VAR', 'xBatchComplete', 'BOOL', '', '', '', 'Batch complete signal'],
])

# 07-math.csv
write_csv('examples/07-math.csv', [
    ['GXW2-ST Examples'],
    ['Class', 'Label Name', 'Data Type', 'Constant', 'Device', 'Address', 'Comment'],
    ['VAR', 'rA', 'REAL', '', '', '', 'Operand A'],
    ['VAR', 'rB', 'REAL', '', '', '', 'Operand B'],
    ['VAR', 'rResultA', 'REAL', '', '', '', 'Result value (REAL)'],
    ['VAR', 'iA', 'INT', '', '', '', 'Operand A (INT)'],
    ['VAR', 'iB', 'INT', '', '', '', 'Operand B (INT)'],
    ['VAR', 'iResultA', 'INT', '', '', '', 'Result value (INT)'],
    ['VAR', 'wA', 'WORD', '', '', '', 'Operand A (WORD)'],
    ['VAR', 'wB', 'WORD', '', '', '', 'Operand B (WORD)'],
    ['VAR', 'wResultA', 'WORD', '', '', '', 'Result value (WORD)'],
    ['VAR', 'dwA', 'DWORD', '', '', '', 'Operand A (DWORD)'],
    ['VAR', 'dwB', 'DWORD', '', '', '', 'Operand B (DWORD)'],
    ['VAR', 'dwResultA', 'DWORD', '', '', '', 'Result value (DWORD)'],
    ['VAR', 'iChoice', 'INT', '', '', '', 'Selection index'],
    ['VAR', 'rScaledOutput', 'REAL', '', '', '', 'Final scaled output'],
])

# 08-strings.csv
write_csv('examples/08-strings.csv', [
    ['GXW2-ST Examples'],
    ['Class', 'Label Name', 'Data Type', 'Constant', 'Device', 'Address', 'Comment'],
    ['VAR', 'sFirst', 'STRING', '', '', '', 'First string operand'],
    ['VAR', 'sLast', 'STRING', '', '', '', 'Last string operand'],
    ['VAR', 'sFull', 'STRING', '', '', '', 'Concatenated result'],
    ['VAR', 'sBase', 'STRING', '', '', '', 'Base string for manipulation'],
    ['VAR', 'sInsert', 'STRING', '', '', '', 'String to insert'],
    ['VAR', 'sSearch', 'STRING', '', '', '', 'Search substring'],
    ['VAR', 'sResult', 'STRING', '', '', '', 'Result string buffer'],
    ['VAR', 'iLength', 'INT', '', '', '', 'String length result'],
    ['VAR', 'iPosition', 'INT', '', '', '', 'Character position (1-based)'],
    ['VAR', 'iCount', 'INT', '', '', '', 'Character count'],
    ['VAR', 'sDisplay', 'STRING', '', '', '', 'Display string output'],
])

# 09-bit-operations.csv
write_csv('examples/09-bit-operations.csv', [
    ['GXW2-ST Examples'],
    ['Class', 'Label Name', 'Data Type', 'Constant', 'Device', 'Address', 'Comment'],
    ['VAR', 'wInput', 'WORD', '', '', '', 'Input word for bit manipulation'],
    ['VAR', 'wResult', 'WORD', '', '', '', 'Result word after shift/mask'],
    ['VAR', 'dwInput', 'DWORD', '', '', '', 'Input double-word'],
    ['VAR', 'dwResult', 'DWORD', '', '', '', 'Result double-word'],
    ['VAR', 'xLatchFlag', 'BOOL', '', '', '', 'Latched flag using SET/RST'],
    ['VAR', 'xPulseFlag', 'BOOL', '', '', '', 'Pulse output flag'],
    ['VAR', 'xCombined', 'BOOL', '', '', '', 'Combined logic result'],
    ['VAR', 'xBitOutput', 'BOOL', '', '', '', 'Bit operation output'],
])

# 10-type-casting.csv
write_csv('examples/10-type-casting.csv', [
    ['GXW2-ST Examples'],
    ['Class', 'Label Name', 'Data Type', 'Constant', 'Device', 'Address', 'Comment'],
    ['VAR', 'iVal', 'INT', '', '', '', 'INT value for casting'],
    ['VAR', 'diVal', 'DINT', '', '', '', 'DINT value for casting'],
    ['VAR', 'wVal', 'WORD', '', '', '', 'WORD value for casting'],
    ['VAR', 'dwVal', 'DWORD', '', '', '', 'DWORD value for casting'],
    ['VAR', 'rVal', 'REAL', '', '', '', 'REAL value for casting'],
    ['VAR', 'sVal', 'STRING', '', '', '', 'STRING value for casting'],
    ['VAR', 'xFlag', 'BOOL', '', '', '', 'BOOL flag for casting'],
    ['VAR', 'tDuration', 'TIME', '', '', '', 'TIME value for casting'],
    ['VAR', 'iResult', 'INT', '', '', '', 'INT result'],
    ['VAR', 'diResult', 'DINT', '', '', '', 'DINT result'],
    ['VAR', 'wResult', 'WORD', '', '', '', 'WORD result'],
    ['VAR', 'dwResult', 'DWORD', '', '', '', 'DWORD result'],
    ['VAR', 'rResult', 'REAL', '', '', '', 'REAL result'],
    ['VAR', 'sResult', 'STRING', '', '', '', 'STRING result'],
    ['VAR', 'tResult', 'TIME', '', '', '', 'TIME result'],
    ['VAR', 'rFinalOutput', 'REAL', '', '', '', 'Final converted output'],
])

# 11-edge-detection.csv
write_csv('examples/11-edge-detection.csv', [
    ['GXW2-ST Examples'],
    ['Class', 'Label Name', 'Data Type', 'Constant', 'Device', 'Address', 'Comment'],
    ['VAR', 'rtStart', 'R_TRIG', '', '', '', 'R_TRIG: rising edge on start'],
    ['VAR', 'ftStop', 'F_TRIG', '', '', '', 'F_TRIG: falling edge on stop'],
    ['VAR', 'xStartEdge', 'BOOL', '', '', '', 'Output: start rising edge pulse'],
    ['VAR', 'xStopEdge', 'BOOL', '', '', '', 'Output: stop falling edge pulse'],
    ['VAR', 'xMEP_Pulse', 'BOOL', '', '', '', 'MEP inline result'],
    ['VAR', 'xMEF_Pulse', 'BOOL', '', '', '', 'MEF inline result'],
    ['VAR', 'iEdgeCount', 'INT', '', '', '', 'Edge-triggered counter'],
    ['VAR', 'xToggle', 'BOOL', '', '', '', 'Toggle flag'],
    ['VAR', 'xEdgeTriggered', 'BOOL', '', '', '', 'Edge-triggered output'],
])

# 12-function-block/MotorControl.csv — 7 columns (local FB format)
write_csv('examples/12-function-block/MotorControl.csv', [
    ['GXW2-ST Examples'],
    ['Class', 'Label Name', 'Data Type', 'Constant', 'Device', 'Address', 'Comment'],
    ['VAR_INPUT', 'xStart', 'BOOL', '', '', '', 'Start command (rising edge)'],
    ['VAR_INPUT', 'xStop', 'BOOL', '', '', '', 'Stop command (level)'],
    ['VAR_INPUT', 'xFeedback', 'BOOL', '', '', '', 'Contactor feedback signal'],
    ['VAR_INPUT', 'xFaultReset', 'BOOL', '', '', '', 'Fault reset command'],
    ['VAR_INPUT', 'tStartDelay', 'TIME', '', '', '', 'Start delay before checking feedback'],
    ['VAR_INPUT', 'tFaultTimeout', 'TIME', '', '', '', 'Max time to wait for feedback'],
    ['VAR_OUTPUT', 'xMotor', 'BOOL', '', '', '', 'Motor output command'],
    ['VAR_OUTPUT', 'xFault', 'BOOL', '', '', '', 'Fault indication'],
    ['VAR_OUTPUT', 'xRunning', 'BOOL', '', '', '', 'Motor confirmed running'],
    ['VAR_OUTPUT', 'xReady', 'BOOL', '', '', '', 'Motor ready to start'],
    ['VAR', 'rtStart', 'R_TRIG', '', '', '', 'Start edge detector'],
    ['VAR', 'tonStart', 'TON', '', '', '', 'Start delay timer'],
    ['VAR', 'tonFault', 'TON', '', '', '', 'Fault timeout timer'],
    ['VAR', 'xStartCmd', 'BOOL', '', '', '', 'Latched start command'],
])

# 13-function/ScaleValue.csv — 7 columns (FUN format: VAR_INPUT only)
write_csv('examples/13-function/ScaleValue.csv', [
    ['GXW2-ST Examples'],
    ['Class', 'Label Name', 'Data Type', 'Constant', 'Device', 'Address', 'Comment'],
    ['VAR_INPUT', 'iRaw', 'INT', '', '', '', 'Raw input value (e.g. 0-4000 from ADC)'],
    ['VAR_INPUT', 'iRawMin', 'INT', '', '', '', 'Raw minimum (e.g. 0)'],
    ['VAR_INPUT', 'iRawMax', 'INT', '', '', '', 'Raw maximum (e.g. 4000)'],
    ['VAR_INPUT', 'rEngMin', 'REAL', '', '', '', 'Engineering minimum (e.g. 0.0)'],
    ['VAR_INPUT', 'rEngMax', 'REAL', '', '', '', 'Engineering maximum (e.g. 100.0)'],
])

print("All 30 CSV files written successfully.")

(*
  Function Block: FB_MOTOR
  Purpose: Motor control with feedback monitoring, start delay,
           fault detection on feedback timeout, and fault reset.
           Demonstrates a complete FB pattern for GX Works 2.
  Files:   FB_MOTOR.st (this file — code body only)
           FB_MOTOR.csv (VAR_INPUT, VAR_OUTPUT, VAR declarations)
  Rules:   FB file/POU name uses the FB_ prefix in ALL CAPS (FB_MOTOR);
           instances are declared in CamelCase (fbMotor : FB_MOTOR).
           No inline VAR...END_VAR. All variables declared in CSV.
           All FB parameters use := including outputs.
           No VAR_IN_OUT on FX — use separate VAR_INPUT + VAR_OUTPUT.
*)

(* Rising edge detection on start command *)
rtStart(CLK := xStart, Q := xStartCmd);

(* Reset fault on rising edge of fault reset *)
IF MEP(xFaultReset) THEN
    xFault := FALSE;
END_IF;

(* Ready when no fault and feedback is off *)
xReady := NOT xFault AND NOT xFeedback;

(* Motor control logic *)
IF xStartCmd AND xReady AND NOT xStop THEN
    xMotor := TRUE;
END_IF;

IF xStop OR xFault THEN
    xMotor := FALSE;
END_IF;

(* Start delay timer — wait before checking feedback *)
tonStart(IN := xMotor, PT := tStartDelay, Q := , ET := );

(* Fault timeout timer — starts after start delay *)
tonFault(IN := xMotor AND tonStart.Q, PT := tFaultTimeout, Q := , ET := );

(* Fault detection: motor commanded ON but feedback not received in time *)
IF tonFault.Q AND NOT xFeedback THEN
    xFault := TRUE;
    xMotor := FALSE;
END_IF;

(* Running confirmed: motor commanded AND feedback received *)
xRunning := xMotor AND xFeedback;

# Phase 6 Validation — Test Prompts

## Test 1: Simple IO Assignment
**Prompt:** "Read X0 start button and control Y0 pump output in ST for FX3U"

**Expected behavior:**
- Generate IO.csv with DI_Start (X0) and DO_Pump (Y0)
- Generate ST code using labels, not direct device access
- No inline VAR...END_VAR

**Validation:** ✅ common-rules.md §"Always-Generate Rules", csv-variables.md §"IO.csv Format"

---

## Test 2: Timer with _E Variant
**Prompt:** "Use TON_E for a 3-second start delay on FX3U"

**Expected behavior:**
- Declare TON instance as VAR in CSV (not inline)
- Use `:=` for all params including Q and ET
- _E form: TON_E(xEnable, IN, PT, Q, ET)
- TIME literal: T#3s

**Validation:** ✅ functions.md §"Timer Function Blocks", SKILL.md §"FB Parameter Assignment"

---

## Test 3: String on FX3G (should warn)
**Prompt:** "Concatenate alarm strings on FX3G"

**Expected behavior:**
- Check compatibility.md → FX3G has no STRING
- Warn user: STRING not available on FX3G, use WORD arrays or upgrade to FX3U
- Offer alternative approach

**Validation:** ✅ compatibility.md §"Feature Matrix" shows STRING ❌ for FX3G

---

## Test 4: MAX/ROUND naming trap
**Prompt:** "Use MAX and ROUND in ST for GX Works 2"

**Expected behavior:**
- Correct names: MAXIMUM (not MAX), RND (not ROUND)
- Show both direct and _E forms
- RND has P variant: RNDP

**Validation:** ✅ functions.md §"Selection Functions", data-types.md §"Type Casting"

---

## Test 5: CONTINUE in loop (should reject)
**Prompt:** "Write a FOR loop with CONTINUE to skip even numbers"

**Expected behavior:**
- common-rules.md §2: "No CONTINUE"
- Generate IF/ELSE restructure instead
- Match 04-loops.st example pattern

**Validation:** ✅ common-rules.md constraint #2, 04-loops.st Example 5

---

## Test 6: SR flip-flop (should reject)
**Prompt:** "Use SR bistable for motor latching"

**Expected behavior:**
- functions.md: SR/RS FBs not available
- Use SET/RST instructions instead
- Show pattern: IF condition THEN SET(xOutput); IF reset THEN RST(xOutput);

**Validation:** ✅ common-rules.md constraint #5, 09-bit-operations.st example

---

## Test 7: FB with VAR_IN_OUT (should reject)
**Prompt:** "Create FB with VAR_IN_OUT parameter"

**Expected behavior:**
- common-rules.md constraint #4: no VAR_IN_OUT on FX
- Use separate VAR_INPUT + VAR_OUTPUT
- Reference MotorControl FB pattern

**Validation:** ✅ common-rules.md, 12-function-block/MotorControl.csv

---

## Test 8: CASE with named labels (should reject)
**Prompt:** "CASE state OF Init: ... Reset: ..."

**Expected behavior:**
- instructions.md: integer labels only
- Use 0/10/20 with comments
- Match 03-case-state-machine.st pattern

**Validation:** ✅ instructions.md §"CASE Statement", 03-case-state-machine.st

---

## Test 9: Direct D-register access
**Prompt:** "Set D100 to 500 in ST"

**Expected behavior:**
- devices.md: "Do not use direct device access"
- Generate GVL.csv with g_iVariable at D100
- ST code uses g_iVariable, not D100

**Validation:** ✅ devices.md §"Device Access Policy"

---

## Test 10: Postfix correctness
**Prompt:** "Use ADD with pulse execution on rising edge"

**Expected behavior:**
- ADDP (not ADD_P — P attaches directly without underscore)
- First param is trigger: ADDP(xTrig, wA, wB, wResult)
- Contrast with _E: ADD_E(xTrig, wA, wB, wResult)
- D prefix: DADD, DADDP

**Validation:** ✅ functions.md §"Postfix Patterns", instructions.md §"WORD/DWORD Arithmetic"

---

## Test 11: Trigonometry (should reject)
**Prompt:** "Calculate SIN of an angle in ST for FX3U"

**Expected behavior:**
- functions.md §"Arithmetic & Math Functions": SIN/COS/TAN NOT supported
- Warn user and suggest lookup table or external calculation

**Validation:** ✅ functions.md notes, 07-math.st header comment

---

## Test 12: Full project generation
**Prompt:** "Create complete project for 2-pump alternating duty with HMI"

**Expected behavior:**
- 3 programs: INIT.st/INIT.csv, ROUTINE.st/ROUTINE.csv, MAIN.st/MAIN.csv
- IO.csv with DI/DO/AI/AO prefixes
- GVL.csv with g_ prefix, sequential D-register allocation
- REAL types consume 2 D registers
- State machine with Init(0)/Reset(10)/Idle(20)
- Timer instances declared in CSV
- MEP for edge detection on HMI buttons

**Validation:** ✅ All references, all examples

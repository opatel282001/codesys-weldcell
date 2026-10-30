PROGRAM WeldCell
VAR
    bStart  : BOOL;        // start button
    nStep   : INT := 0;    // 0 Idle, 10 Clamp, 20 Weld, 30 Cool, 40 Release
    bClamp  : BOOL;        // output: clamp closed
    bWeld   : BOOL;        // output: welding current on
    tonStep : TON;         // timer for the steps
    nParts  : INT;         // finished parts
END_VAR

CASE nStep OF
    0:  // IDLE
        bClamp := FALSE;
        bWeld  := FALSE;
        IF bStart THEN
            bStart := FALSE;
            nStep  := 10;
        END_IF

    10: // CLAMP - 1 s
        bClamp := TRUE;
        tonStep(IN := TRUE, PT := T#1S);
        IF tonStep.Q THEN
            tonStep(IN := FALSE);
            nStep := 20;
        END_IF

    20: // WELD - 3 s
        bWeld := TRUE;
        tonStep(IN := TRUE, PT := T#3S);
        IF tonStep.Q THEN
            tonStep(IN := FALSE);
            bWeld := FALSE;
            nStep := 30;
        END_IF

    30: // COOL - 2 s
        tonStep(IN := TRUE, PT := T#2S);
        IF tonStep.Q THEN
            tonStep(IN := FALSE);
            nStep := 40;
        END_IF

    40: // RELEASE
        bClamp := FALSE;
        nParts := nParts + 1;
        nStep  := 0;
END_CASE

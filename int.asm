        .ORIG x1200            ; Start of interrupt service routine

        ; Save R0 and R1 to the stack to preserve them
        STW R0, R6, #-2        ; Push R0 onto the stack
        ADD R6, R6, #-2
        STW R1, R6, #-2        ; Push R1 onto the stack
        ADD R6, R6, #-2

        ; Load the address x4000 into R0
        LEA R0, TIMERADDRESS   ; Load address of x4000 into R0
        LDW R0, R0, #0

        ; Load the value at memory location x4000 into R1
        LDW R1, R0, #0         ; Load the current value at x4000 into R1

        ; Increment the value in R1 by 1
        ADD R1, R1, #1         ; Increment the value

        ; Store the incremented value back into memory location x4000
        STW R1, R0, #0         ; Store the updated value back into x4000

        ; Restore R1 and R0 from the stack
        LDW R1, R6, #0         ; Pop R1 from the stack
        ADD R6, R6, #2
        LDW R0, R6, #0         ; Pop R0 from the stack
        ADD R6, R6, #2

        ; Return from interrupt
        RTI                    ; Return from interrupt

TIMERADDRESS .FILL x4000       ; Memory location holding address x4000
        .END

;
;  THUNDERBOLT_LIGHTS.ASM (p.11)
;  2014/7/19
;  Leon_Huang
;

    ORG    000H
    MOV    A, #11111110B

; Main Loop
;==================================================
LOOP:

    MOV    R0, #7
SHIFT_LEFT:
    MOV    P1, A
    CALL   DELAY
    RL     A
    DJNZ   R0, SHIFT_LEFT

    MOV    R0, #7
SHIFT_RIGHT:
    MOV    P1, A
    CALL   DELAY
    RR     A
    DJNZ   R0, SHIFT_RIGHT

    JMP LOOP
;==================================================
; end of Main Loop


; Function: Delay 1 Second
;==================================================
DELAY:
    MOV    R3,   #20             ; 20 * 0.05s = 1s
    MOV    TMOD, #00000001B
D1:
    MOV    TH0,  #60            ; TH0 * 256 + TL0 = 15536
    MOV    TL0,  #176           ; 65535 - 15536 + 1 = 50000us = 0.05s

    SETB   TR0                  ; Start Timer
    JNB    TF0,  $              ; Wait for Interrupt
    CLR    TF0
    DJNZ   R3,   D1
    RET
;==================================================
; end of DELAY Function

    END

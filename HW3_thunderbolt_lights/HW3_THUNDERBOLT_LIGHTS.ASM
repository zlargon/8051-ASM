;
;  HW3_THUNDERBOLT_LIGHTS.ASM
;  2014/7/20
;  Leon_Huang
;
;  1. change the delay to 0.025sec
;  2. change to use 8051 Timer 1
;  3. change to 16 LED Thunderbolt Lights
;

    ORG    000H
    MOV    A, #01111111B

; Main Loop
;==================================================
LOOP:

    MOV    R0, #7
P0_SHIFT_RIGHT:
    MOV    P0, A
    CALL   DELAY
    RR     A
    DJNZ   R0, P0_SHIFT_RIGHT

    MOV    R0, #7
P0_SHIFT_LEFT:
    MOV    P0, A
    CALL   DELAY
    RL     A
    DJNZ   R0, P0_SHIFT_LEFT

    MOV    P0, A
    CALL   DELAY
    MOV    P0, #11111111B        ; Reset P0 Lights

    MOV    R0, #7
P2_SHIFT_RIGHT:
    MOV    P2, A
    CALL   DELAY
    RR     A
    DJNZ   R0, P2_SHIFT_RIGHT

    MOV    R0, #7
P2_SHIFT_LEFT:
    MOV    P2, A
    CALL   DELAY
    RL     A
    DJNZ   R0, P2_SHIFT_LEFT

    MOV    P2, A
    CALL   DELAY
    MOV    P2, #11111111B        ; Reset P2 Lights

    JMP LOOP
;==================================================
; end of Main Loop


; Function: Delay 0.025 Second
;==================================================
DELAY:
    MOV    TMOD, #00010000B      ; Timer 1
    MOV    TH1,  #158            ; TH1 * 256 + TL1 = 40536
    MOV    TL1,  #88             ; 65535 - 40536 + 1 = 25000us = 0.025s

    SETB   TR1                   ; Start Timer
    JNB    TF1,  $               ; Wait for Interrupt
    CLR    TF1
    RET
;==================================================
; end of DELAY Function

    END

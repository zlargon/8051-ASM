;
;  HW2_TRAFFIC_LIGHTS.ASM
;  2014/7/20
;  Leon_Huang
;
;  Flash the Green Lights before turn to Yellow
;

    ORG    000H
                                ; Define Green, Yellow, Red Light to R0 ~ R2
    MOV    R0, #11111110B       ; Green
    MOV    R1, #11111101B       ; Yellow
    MOV    R2, #11111011B       ; Red

; Main Loop
;==================================================
LOOP:
    MOV    P0, R0               ; P0 -> Green
    MOV    P1, R2               ; P1 -> Red
    MOV    R3, #32              ; wait 8 seconds (32 * 0.25)
    CALL   WAIT

    MOV    R4, #4
P0_FLASH:                       ; Flash Green Lights 4 times during 2 seconds
    MOV    P0, #11111111B       ; P0 -> X
    CALL   DELAY
    MOV    P0, R0               ; P0 -> Green
    CALL   DELAY
    DJNZ   R4, P0_FLASH

    MOV    P0, R1               ; P0 -> Yellow
    MOV    R3, #8               ; wait 2 seconds (8 * 0.25)
    CALL   WAIT

    MOV    P0, R2               ; P0 -> Red
    MOV    P1, R0               ; P1 -> Green
    MOV    R3, #32              ; wait 8 seconds (32 * 0.25)
    CALL   WAIT

    MOV    R4, #4
P1_FLASH:                       ; Flash Green Lights 4 times during 2 seconds
    MOV    P1, #11111111B       ; P1 -> X
    CALL   DELAY
    MOV    P1, R0               ; P1 -> Green
    CALL   DELAY
    DJNZ   R4, P1_FLASH

    MOV    P1, R1               ; P1 -> Yellow
    MOV    R3, #8               ; wait 2 second (8 * 0.25)
    CALL   WAIT

    JMP LOOP
;==================================================
; end of Main Loop


; Function: WAIT 'R3' Second
;==================================================
WAIT:
    CALL   DELAY
    DJNZ   R3, WAIT
    RET
;==================================================
; End of WAIT Function


; Function: Delay 0.25 Second
;==================================================
DELAY:
    MOV    R5,   #5             ; 5 * 0.05s = 0.25s
    MOV    TMOD, #00000001B
D1:
    MOV    TH0,  #60            ; TH0 * 256 + TL0 = 15536
    MOV    TL0,  #176           ; 65535 - 15536 + 1 = 50000us = 0.05s

    SETB   TR0                  ; Start Timer
    JNB    TF0,  $              ; Wait for Interrupt
    CLR    TF0
    DJNZ   R5,   D1
    RET
;==================================================
; end of DELAY Function

    END

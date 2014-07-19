;
;  TRAFFIC_LIGHTS.ASM (p.9)
;  2014/7/19
;  Leon_Huang
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
    MOV    R3, #10              ; wait 10 seconds
    CALL   WAIT

    MOV    P0, R1               ; P0 -> Yellow
    CALL   DELAY                ; wait 1 second

    MOV    P0, R2               ; P0 -> Red
    MOV    P1, R0               ; P1 -> Green
    MOV    R3, #10              ; wait 10 seconds
    CALL   WAIT

    MOV    P1, R1               ; P1 -> Yellow
    CALL   DELAY                ; wait 1 second

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


; Function: delay 1.007533 seconds
;==================================================
DELAY:
    MOV   R5, #10
D1:
    MOV   R6, #250
D2:
    MOV   R7, #200
D3:
    DJNZ  R7, D3
    DJNZ  R6, D2
    DJNZ  R5, D1
    RET
;==================================================
; end of DELAY Function

    END

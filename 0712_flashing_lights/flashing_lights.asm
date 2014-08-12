;
;  flashing_lights.asm (p.7)
;  2014/7/12
;  Leon_Huang
;

    ORG 000H
    MOV A, #00000000B

; Main Loop
;==================================================
; Delay 1 second, and invert A
LOOP:
    MOV    P1, A
    CALL   DELAY
    CPL    A        ; 00000000 <-> 11111111
    JMP    LOOP
;==================================================
; end of Main Loop


; Function: delay 1.007533 seconds
;==================================================
DELAY:
    MOV    R5, #10
D1:
    MOV    R6, #250
D2:
    MOV    R7, #200
D3:
    DJNZ   R7, D3
    DJNZ   R6, D2
    DJNZ   R5, D1
    RET
;==================================================
; end of DELAY Function

    END

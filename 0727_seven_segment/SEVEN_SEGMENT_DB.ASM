;
;  SEVEN_SEGMENT_DB.ASM (p.13)
;  2014/7/27
;  Leon_Huang
;
;  show seven segment with 0 ~ 9
;  use DB
;

;                   gfedc ab
zero        EQU     10000100B
one         EQU     11110110B
two         EQU     01001100B
three       EQU     01100100B
four        EQU     00110110B
five        EQU     00100101B
six         EQU     00000101B
seven       EQU     11110100B
eight       EQU     00000100B
nine        EQU     00100100B

    ORG     0x0000
seven_segment_table:
    DB  zero, one, two, three, four, five, six, seven, eight, nine

    MOV     DPTR,   #seven_segment_table
main:
    MOV     R0,     #0
main_loop:
    MOV     A,      R0
    MOVC    A,      @A + DPTR
    MOV     P2,     A
    CALL    delay_1s
    INC     R0
    CJNE    R0,     #10,    main_loop
    JMP     main

; Function: Delay 1 Second
;************************************************************
delay_1s:
    MOV     R3,     #20             ; 20 * 0.05s = 1s
    MOV     TMOD,   #00000001B
delay_1s_loop:
    MOV     TH0,    #60             ; TH0 * 256 + TL0 = 15536
    MOV     TL0,    #176            ; 65535 - 15536 + 1 = 50000us = 0.05s

    SETB    TR0                     ; Start Timer
    JNB     TF0,    $               ; Wait for Interrupt
    CLR     TF0
    DJNZ    R3,     delay_1s_loop
    RET
;************************************************************

    END

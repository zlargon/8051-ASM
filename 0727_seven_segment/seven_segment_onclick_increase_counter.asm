;
;  seven_segment_onclick_increase_counter.asm (p.16)
;  2014/7/27
;  Leon_Huang
;
;  when button onclick, increase the counter
;

;                   gfedc.ab
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
display:
    MOV     A,      R0
    MOVC    A,      @A + DPTR
    MOV     P2,     A

onclick_listener:
    JB      P1.0,   onclick_listener    ; click down start
    CALL    delay_100ms
    JB      P1.0,   onclick_listener    ; button has been clicked down over than 100ms
    JNB     P1.0,   $                   ; wait for click up

    INC     R0                          ; button onclick, increase R0
    CJNE    R0,     #10,    display     ; if R0 != 10, goto display
    JMP     main                        ; if R0 == 10, goto main


; Delay 0.1 Second
;************************************************************
delay_100ms:
    MOV     R3,     #2                  ; 2 * 0.05s = 0.1s
    MOV     TMOD,   #00000001B
delay_100ms_loop:
    MOV     TH0,    #60                 ; TH0 * 256 + TL0 = 15536
    MOV     TL0,    #176                ; 65535 - 15536 + 1 = 50000us = 0.05s

    SETB    TR0                         ; Start Timer
    JNB     TF0,    $                   ; Wait for Interrupt
    CLR     TF0
    DJNZ    R3,     delay_100ms_loop
    RET
;************************************************************

    END

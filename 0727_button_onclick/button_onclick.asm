;
;  button_onclick.asm
;  2014/7/27
;  Leon_Huang
;
;  when button clicked, turn on the light 1 second
;

    ORG     0x0000

onclick_listener:
    JB      P1.0,   onclick_listener    ; click down start
    CALL    delay_100ms
    JB      P1.0,   onclick_listener    ; button has been clicked down over than 100ms
    JNB     P1.0,   $                   ; wait for click up
    CALL    onclick_callback            ; invoke onclick callback function
    JMP     onclick_listener            ; onclick callback done, wait for next click


; onclick callback function
;************************************************************
onclick_callback:
    MOV     P0,     #0
    MOV     R1,     #10
delay_1s:
    CALL    delay_100ms
    DJNZ    R1,     delay_1s
    MOV     P0,     #1
    RET
;************************************************************


; Delay 0.1 Second
;************************************************************
delay_100ms:
    MOV     R3,     #2              ; 2 * 0.05s = 0.1s
    MOV     TMOD,   #00000001B
delay_100ms_loop:
    MOV     TH0,    #60             ; TH0 * 256 + TL0 = 15536
    MOV     TL0,    #176            ; 65535 - 15536 + 1 = 50000us = 0.05s

    SETB    TR0                     ; Start Timer
    JNB     TF0,    $               ; Wait for Interrupt
    CLR     TF0
    DJNZ    R3,     delay_100ms_loop
    RET
;************************************************************

    END

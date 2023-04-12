    SECTION demo,CODE_C

    INCDIR      "include"
    INCLUDE     "hardware/custom.i"
    INCLUDE     "hardware/cia.i"
    INCLudE     "hw.i"

CIAA = $00bfe001

init:
    move       #$ac,d7                  ; start y position
    move       #1,d6                    ; y add
mainloop:

waitframe:
    cmp.b      #$ff,CUSTOM+VHPOSR
    bne        waitframe

; ------ frame loop start ------
    
    add        d6,d7                    ; move y position

    cmp        #$f0,d7                  ; bottom check
    blo        ok1
    neg        d6                       ; change direction
ok1:
    cmp        #$40,d7                  ; top check
    bhi        ok2
    neg        d6                       ; change direction
ok2:

waitras1:
    cmp.b      CUSTOM+VHPOSR,d7
    bne        waitras1
    move.w     #$fff,CUSTOM+COLOR00

waitras2:
    cmp.b      CUSTOM+VHPOSR,d7
    beq        waitras2
    move.w     #$000,CUSTOM+COLOR00

; ------ frame loop end ------

.checkmouse:
    btst       #CIAB_GAMEPORT0,CIAA
    bne.b      mainloop
    
    rts

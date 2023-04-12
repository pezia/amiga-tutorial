    SECTION demo,CODE_C

    INCDIR      "include"
    INCLUDE     "hardware/custom.i"
    INCLUDE     "hardware/cia.i"
    INCLudE     "hw.i"

CIAA = $00bfe001

mainloop:
    move.b #$ac,d0
waitras1:
    cmp.b      #$ac,CUSTOM+VHPOSR
    bne        waitras1
    move.w     #$fff,CUSTOM+COLOR00

waitras2:
    cmp.b      #$ac,CUSTOM+VHPOSR
    beq        waitras2
    move.w     #$000,CUSTOM+COLOR00

.checkmouse:
    btst       #CIAB_GAMEPORT0,CIAA
    bne.b      mainloop
    
    rts

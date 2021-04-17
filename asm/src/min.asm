.feature force_range
.debuginfo +
.setcpu "65c02"
.macpack longbranch
.list on

ACIA1           =   $8000       ; Base address of 6551 ACIA uart chip
A1_DATA         =   ACIA1       ; Transmit/Recieve buffer and data register
A1_STATUS       =   ACIA1+1     ; Status register or reset if write
A1_COMMAND      =   ACIA1+2     ; Command register
A1_CONTROL      =   ACIA1+3     ; Control register

.feature org_per_seg
.segment "ZEROPAGE"
.zeropage
.org $0000

.segment "CODE"
.org $C000

Main:
    LDA	A1_STATUS		    ; Read 6551 status
	AND	#$10			    ; Is tx buffer full?
	BEQ	Main	            ; if not, loop back
    LDA #'J'                ; Load and sent out ASCII 'J'
    STA A1_DATA
    JMP Main

SetupACIA1:
    STA A1_STATUS           ; Software reset
    LDA #%00001011          ; Enable DTR, disable receive IRQ, disable transmit IRQ
    STA A1_COMMAND          ; Disable echo mode, disable parity
    LDA #%00011111          ; Setup intenal divider Baud control @ 19,200 Baud
    STA A1_CONTROL          ; 1 Stop Bit, 8 Data Bits
    RTS

Reset:
    LDX #$FF
    TXS
    JSR SetupACIA1
    CLI                     ; enable interupts
    JMP Main

IRQ:
NMI:
    RTI

.segment "MONITOR"
.org $FF00

.segment "VECTORS"
.org $FFFA
	.word	NMI
	.word	Reset
	.word	IRQ
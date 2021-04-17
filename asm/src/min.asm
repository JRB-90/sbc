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
    JMP Main

Reset:
    LDX #$FF
    TXS
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
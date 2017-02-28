; 	ahf's first assembly test program.
;------------------------------------------------------------------------------
;	Assembler directives:
;------------------------------------------------------------------------------
;
;
;
	.directives;
	;
	.equ	constOne	 0x12;
	.equ	constTwo	 0x2;
	;
	.enddirectives;
;------------------------------------------------------------------------------
;	Constant segment:
;------------------------------------------------------------------------------
; These values are initialized in the locations at the end of the code segment.
; For now, .word is the only constant initialization assembly directive.
; After assembling the code, during the final run, the constant name is 
;   replaced with its location address in the program memory.
	.constants;
;
	.word	firstConstWord	0xFFFF;
    .word   secondConstWord 0xEEEE;
	;
	.endconstants;
;------------------------------------------------------------------------------
;	Code segment:
;------------------------------------------------------------------------------
;   first ST/LD var as info, 2nd as storing/loading to register
	.code;
			SUBC	R2, 0x02;
            SUBC    0x02, R5;
			ST		-20(R3), R2;
			LD		0x04, R5;
			ADDC	R5, 0x19;
			ADD		R16, R15;
            ADDC	R18, 0x12;
			SUB		R5, R5;
			JMPC 	downloop;
			OR		R5, R6;
@uploop:
			NOT		R5;
			CPY		R7, R5;
			SWAP	R7, R5;
            NOT     R7;
			SHRA	R5, 0x3;
			ROTR	R6, 0x1;
            ROTR    R6, 0x1;
			CPY		R8, R7;
@downloop:
			SUB		R5, R5;
            SUB		R18, R18;
            ADDC    R4, 0xF;
			JMPC	uploop;		
            
	.endcode;

.global _start
_start:
	MOV  R0, #0xFFFFFFFF
	MOV  R1, #0x00000005
	ADDS R2, R1, R0  // R2 = R1 + R0, can set CPSR 'C' (carry) flag

.global _start
_start:
	MOV  R0, #1
	MOV  R1, #2
	SUBS R2, R0, R1  // R2 = R0 - R1

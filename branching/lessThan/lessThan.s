.global _start
_start:
	MOV R0, #5
	MOV R1, #2

	CMP R0, R1

	BLT b_lessThan
	BAL b_always

b_lessThan:
	MOV R2, #3

b_always:
	MOV R3, #4

.global _start
_start:
	MOV R0, #5
	MOV R1, #2

	CMP R1, R0

	BGT b_greaterThan
	BAL b_always

b_greaterThan:
	MOV R2, #3

b_always:
	MOV R3, #4

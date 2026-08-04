.global _start
_start:
	MOV R0, #5
	MOV R1, #2

	CMP R1, R0

	BEQ b_equal
	BAL b_always  // prevents `b_equal` from running if it is False

b_equal:
	MOV R2, #3

b_always:
	MOV R3, #4

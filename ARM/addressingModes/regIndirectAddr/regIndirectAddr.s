// loading the 1st value of variable
// `list` to a register

.global _start
_start:
	LDR R0, =list
	LDR R1, [R0]

.data
list:
	.word 4, -9, 5, 6, 9

// loading the 2nd value of variable
// `list` to a register by using
// Post Increment Addressing

.global _start
_start:
	LDR R0, =list
	LDR R1, [R0, #4]!  // value of `R0` is updated, and then loaded to `R1`

.data
list:
	.word 4, -9, 5, 6, 9

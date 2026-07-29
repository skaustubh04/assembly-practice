// loading the address of 1st element
// of variable `list` to a register

.global _start
_start:
	LDR R0, =list	// loads address of first element in `list`

.data
list:
	.word 4, -9, 5, 6, 9

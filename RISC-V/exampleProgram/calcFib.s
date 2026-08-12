# 
# ============================== 
#      FACTORIAL FUNCTION 
# ============================== 
#  
# int calcFib (int n) {
#   if (n <= 1) {
#     return n;
#   }
# return calcFib(n-1) + calcFib(n-2);
# }

.globl calcFib

calcFib:
  li  a1, 1           # loads '1' into a1
  bgt a0, a1, ELSE    # if (a0 >= a1) goto ELSE
  ret                 # return

ELSE:
  addi sp, sp, -24    # allocate stack frame
  sd   s1, 0(sp)      # save s1
  sd   s2, 8(sp)      # save s2
  sd   ra, 16(sp)     # save ra
  addi s2, a0, -2     # s2 = a0 - 2 ... (a0 = n)
  addi s1, a0, -1     # s1 = a0 - 1

  call calcFib        # a0 = calcFib(a0)

  mv s1, a0           # s1 = a0
  mv a0, s2           # a0 = s2

  call calcFib        # a0 = calcFib(a0)

  ld   s1, 0(sp)        # Restore s1
  ld   s2, 8(sp)        # Restore s2
  ld   ra, 16(sp)       # Restore ra
  addi sp, sp, 24       # pop stack frame (deallocate)
  ret                   # return a0

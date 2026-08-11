# Options & Extension in RISC-V
Shakti processor implements (abridged versions of) instruction sets I, M, A, E, D, C.

### Multiplication
 - At most, double the number of bits will be required to store the resulting product of the bits being multiplied. Two 4-bit numbers can at most result in a 8-bit product.
 - In RV32, the size of register is 32 bits. Multiplying two 32-bit numbers may yield a 64-bit result. The result is, therefore, stored in parts.
 - The following instructions can be used:
   ```
   1. mul    rd, rs1, rs2    # rd = rs1 * rs2 ... (computes lower part)
   2. mulh   rd, rs1, rs2    # rd = rs1 * rs2 ... (computes upper part - signed)
   3. mulhu  rd, rs1, rs2    # rd = rs1 * rs2 ... (computes upper part - unsigned)
   4. mulhsu rd, rs1, rs2    # rd = rs1 * rs2 ... (computes upper part - multiplying signed with unsigned)
   5. mulw   rd, rs1, rs2    # rd = rs1 * rs2 ... (only for RV64 - computes the 64-bit value in 32-bit parts)
   ```

### Division
 - The 'M' option include `div` and `rem` instructions.
 - Result is always same size as the operands.
 - The basic instructions:
   ```
   1. div  rd, rs1, rs2    # rd = rs1 / rs2 
   2. rem  rd, rs1, rs2    # rd = rs1 % rs2
   3. divu rd, rs1, rs2    # rd = rs1 / rs2 ... (unsigned)
   4. remu rd, rs1, rs2    # rd = rs1 % rs2 ... (unsigned)

   Only for RV64:
   5. divw  rd, rs1, rs2    # rd = rs1 / rs2 ... (32-bit parts)
   6. remw  rd, rs1, rs2    # rd = rs1 % rs2 ... (32-bit parts)
   7. divuw rd, rs1, rs2    # rd = rs1 / rs2 ... (32-bit parts - unsigned)
   8. remuw rd, rs1, rs2    # rd = rs1 % rs2 ... (32-bit parts - unsigned)
   ```
 - There's 2 problems: overflow, zero-divide. RISC-V specifications mandate the result:
   ```
   Number / 0  -> quotient = 0xfff...fff, rem = a
   MaxNeg / -1 -> quotient = MaxNeg, rem = 0
 - RISC-V mandates Truncated Division.


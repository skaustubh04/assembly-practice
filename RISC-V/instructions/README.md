# Instructions in RISC-V (RV32I Base Integer Instruction Set)
There are a few alternate/common notations used for operands in place of actual registers when writing the pseudocode:
 - Destination Register -> rd
 - Source Registers     -> rs1, rs2
 - Immediate Values     -> imm, imm12 (imm12 indicates size is restricted to 12 bits)
 - Any address          -> address

### Arithmetic & Logic Instructions
 - The following contain only registers:
 ``` 
 1.  add  rd, rs1, rs2    # rd = rs1 + rs2
 2.  sub  rd, rs1, rs2    # rd = rs1 - rs2
 3.  and  rd, rs1, rs2    # rd = rs1 & rs2
 4.  or   rd, rs1, rs2    # rd = rs1 | rs2
 5.  xor  rd, rs1, rs2    # rd = rs1 ^ rs2
 6.  sll  rd, rs1, rs2    # rd = rs1 << rs2  ... sll = shift left logical
 7.  srl  rd, rs1, rs2    # rd = rs1 >> rs2  ... srl = shift right logical
 8.  sra  rd, rs1, rs2    # rd = rs1 >>> rs2 ... sra = shift right arithmetic
 9.  slt  rd, rs1, rs2    # rd = (rs1 < rs2) ? 1 : 0 ... slt = set if less than
 10. sltu rd, rs1, rs2    # rd = (rs1 < rs2) ? 1 : 0 (unsigned)
 ```
 - The following contains immediate values:
 ``` 
 1. addi  rd, rs1, imm12    # rd = rs1 + imm12
 2. andi  rd, rs1, imm12    # rd = rs1 & imm12
 3. ori   rd, rs1, imm12    # rd = rs1 | imm12
 4. xori  rd, rs1, imm12    # rd = rs1 ^ imm12
 5. slli  rd, rs1, imm12    # rd = rs1 << imm12
 6. srli  rd, rs1, imm12    # rd = rs1 >> imm12 
 7. srai  rd, rs1, imm12    # rd = rs1 >>> imm12 
 8. slti  rd, rs1, imm12    # rd = (rs1 < imm12) ? 1 : 0
 9. sltui rd, rs1, imm12    # rd = (rs1 < imm12) ? 1 : 0 (unsigned)
 ```

 - Following are load and store instructions:
 ```
 1. lb  rd,  imm12(rs1)    # rd = MEM[rs1 + imm12]
 2. lh  rd,  imm12(rs1)    # rd = MEM[rs1 + imm12]
 3. lw  rd,  imm12(rs1)    # rd = MEM[rs1 + imm12]
 4. lbu rd,  imm12(rs1)    # rd = MEM[rs1 + imm12]
 5. lhu rd,  imm12(rs1)    # rd = MEM[rs1 + imm12]
 6. sb  rs2, imm12(rs1)    # MEM[rs1 + imm12] = rs2
 7. sh  rs2, imm12(rs1)    # MEM[rs1 + imm12] = rs2
 8. sw  rs2, imm12(rs1)    # MEM[rs1 + imm12] = rs2
 ```

 - Further Notes
   - All instructions in RISC-V must be word aligned because the Base Instruction Set RV32I has 32-bit wide instructions (so 4 bytes), though for load and store instructions it may not always be required but it is suggested that they be aligned, otherwise there is a chance of unpredictable behaviour from the hardware's side.
   - In the instruction `myInstr: add t0, a0, a1`, the label `myInstr` is a symbolic name for a value. Value is address of the next thing in file:
     - Same line as opcode: address of that instruction.
     - Same line as assembler directive (.byte, .word, etc): address of data item.
     - Alone on a line: Address of next instruction or data.

   - An example code for a loop:
   ```
    myLoop:                 # LOOP
        lw   t1, 0(t3)      # t1 = MEM [t3]
        beq t1, x0, exit    # if (t1 == 0) break
        addi t1, t1, 1      # t1++
        addi t3, t3, 4      # t3 = t3 + 4
        sw   t1, 0(t3)      # MEM[t3] = t1
        jal  x0, myLoop     # ENDLOOP
    exit:                   # .
    ```

# Conditional Branching & Jumping Instructions (Flow Control)
The common way these can be written (pseudo-instruction):
 ```assembly
 beq rs1, rs2, imm12    # if (rs1 == rs2) goto MEM[PC + imm12]
 ```

The address, in-case branching to a label, is PC relative. It is calculated internally by the processor.
 ```assembly
 myLabel:
     add t0, t1,   a0
     bne t0, zero, myLabel    # Some offset w.r.t. the PC is calculated in-order to jump to 'myLabel'
 ```

### Basic Usage (Branching Instructions)
 - The following are the mandatorily included commands for branching:
 ```
 1. beq  rs1, rs2, imm12    # if (rs1==rs2) goto MEM[PC+imm12]
 2. bne  rs1, rs2, imm12    # if (rs1!=rs2) goto MEM[PC+imm12]
 3. blt  rs1, rs2, imm12    # if (rs1<rs2)  goto MEM[PC+imm12]
 4. bge  rs1, rs2, imm12    # if (rs1>=rs2) goto MEM[PC+imm12]
 5. bltu rs1, rs2, imm12    # if (rs1<rs2)  goto MEM[PC+imm12] (unsigned)
 6. bgeu rs1, rs2, imm12    # if (rs1>=rs2) goto MEM[PC+imm12] (unsigned)
 ```

### System Calls
 - System calls are also known as environment calls in RISC-V.
 - A system call is a special instruction that notifies the operating system to complete a task for the user.
 - For a variety of reasons, (security, resource management) certain computer resources are not directly accessible to a user program. For example, most input/output devices like the keyboard and monitor are independently managed by the computer's operating system.
 - A RISC-V assembly program must call on the OS to access them on the RISC-V program's behalf. This is what is known as a system call.
 - Important information is stored in `a0` and `a7` registers , and then the instruction `ecall` is run to perform the system call.
   - `a0` -> This register holds the value
   - `a7` -> This register holds the system call number (each system call has a number associated with it)
- Example - Printing character 'a' to the screen:
 ```assembly
 # Print 'a' to the screen
 addi a7, zero, 11    # a7 <- 11, specifies the 'PrintChar' system call
 addi a0, zero, 97    # a0 <- 97, ASCII value of 'a'

 # Make the system call
 ecall 
 ```
 - Some common system calls:
      | System Call | a0 | a7 |
      |:-----------:|:--:|:--:|
      | PrintInt | Integer to Print | 1 |
      | PrintString | Address of null-terminated string | 4 |
      | ReadInt | N/A, returns int read in a0 | 5 |
      | PrintChar | Char to print, in lowest 8 bits | 11 |
      | Write | String to be written | 64 |
      | Exit (simulators) | N/A, exits the program with code 0 | 10 |
      | Exit (Linux) | N/A, exits the program with code 0 | 93 |
 - An alternate way to write the "Printing 'a' to screen program" (the pseudo-instructions are automatically converted to instructions from the instruction set):
 ```assembly
 # Print the character 'a' to console
 li    a0, 97    # Alternative to addi a0, zero, 97
 li    a7, 11    # PrintChar system call
 ecall           # makes the system call
 ```
 - Some more examples:
 ```assembly
 # Print the integer 12500
 li    a0, 12500
 li    a7, 1
 ecall
 ```
 ```assembly
 .data
 # String to print later. Strings that you print must be null-terminated
 cool_str:
     .asciz "I use Arch, btw."    # .ascii vs .asciz -> .asciz implies null-terminated string
 
 .text
 # Print the string in the data section
 la    a0, cool_str    # Loads the address of a label
 li    a7, 4
 ecall
 ```
 ```assembly
 # Exit the program
 li    a7, 10    # Exit (system call code)
 ecall 
 ```

 ### Basic Usage (Jumping Instructions)
 - The following instructions are included:
 ```
 1. jal   rd, imm20         # rd = return address; PC = PC + imm20
 2. jalr  rd, imm12(rs1)    # rd = return address; PC = rs1 + imm12
 3. lui   rd, imm20         # rd = imm20 << 12
 4. auipc rd, imm20         # rd = PC + (imm20 << 12)
 ```

 - Uses of `jal` instruction:
   - **CALL**: `jal ra,   address`
   - **JUMP**: `jal zero, address`

 - Uses of `jalr` instruction:
   - **Indirect CALL**:   `jalr ra,   imm12(rs1)    # The address isn't known, but instead computed`
   - **Indirect JUMP**:   `jalr zero, imm12(rs1)`
   - **Indirect RETURN**: `jalr zero, imm12(ra)`

 - Uses of `lui` instruction:
   - **Long JUMPs**:
     `jal` itself won't work when target address requires 32 bits. Instead, 2 instructions are used.
     ```assembly
     lui  t0,   upper20        # t0 = upper20 << 12
     jalr zero, lower12(t0)    # no return address; PC = t0 + lower12
     ```
   - **Long CALLs**:
     ```assembly
     lui  t0, upper20        # t0 = upper20 << 12
     jalr ra, lower12(t0)    # ra = return address; PC = t0 + lower12
     ```

 - Uses of `auipc` instruction:
   - Difference between `lui` and `auipc` is that `auipc` is PC-relative: `rd = PC + offset`.
   - It works well when the difference between 2 desired addresses is known.
   - **Long JUMPs (PC-relative)**:
   ```assembly
   auipc t0,   upper20        # t0 = PC + (upper20 << 12)
   jalr  zero, lower12(t0)    # no return address; PC = t0 + lower12
   ```
   - **Long CALLs (PC-relative)**:
   ```assembly
   auipc t0, upper20        # t0 = PC + (upper20 << 12)
   jalr  ra, lower12(t0)    # ra = return address; PC = t0 + lower12
   ```

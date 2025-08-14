# C to MIPS Assembly Translation

**Author:** Sushrut Chandra  

This repository contains several C programs and their corresponding MIPS assembly translations, demonstrating a strong understanding of low-level programming, stack management, function calls, recursion, and arithmetic operations.

## Programs

### 1. Prism Area Calculator
- **C:** `prog1.c`  
- **Assembly:** `prog1.s`  
- **Description:** Calculates the surface area of a rectangular prism:  
area = 2 * (lengthwidth + lengthheight + width*height)

markdown
Copy
Edit
Returns `-1` if any dimension is non-positive. Demonstrates arithmetic, conditional statements, and basic I/O in MIPS.

### 2. Jacobsthal Number – Iterative
- **C:** `prog2.c`  
- **Assembly:** `prog2.s`  
- **Description:** Computes the nth Jacobsthal number using an iterative approach with a helper function:  
helper(x, y) = 2*x + y

markdown
Copy
Edit
Handles n ≥ 0; returns -1 for negative input. Illustrates loop control, stack usage, and function calls.

### 3. Jacobsthal Number – Recursive
- **C:** `prog3.c`  
- **Assembly:** `prog3.s`  
- **Description:** Computes the nth Jacobsthal number recursively:  
jacobsthal(n) = jacobsthal(n-1) + 2*jacobsthal(n-2)

markdown
Copy
Edit
Demonstrates recursion, stack frame management, and parameter passing in MIPS.

## Testing
- Each program includes input files (`test1.inputdata`, `test2.inputdata`, etc.) and expected outputs (`test1.output`, `test2.output`).  
- Run using SPIM or QtSpim:
```bash
spim -file prog1.s < test1.inputdata
spim -file prog2.s < test2.inputdata
spim -file prog3.s
Skills Demonstrated
Translating C logic to MIPS assembly.

Stack frame and memory management for iterative and recursive functions.

Control flow and arithmetic operations in low-level code.

Syscall-based I/O and global/local variable handling.

vbnet
Copy
Edit

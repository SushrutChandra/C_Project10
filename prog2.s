# -*- mode: text -*-
# name: Sushrut Chandra

# this program caluclates the Jacobsthal
# inputs: the number n  as inputs from stdin
# output: the Jacobsthal
# The main gets input from the user. an int is expected and no validation
# is done. It calls the jocobsthal function and prints the return value 
# The jacobsthal function uses a for loop to itteratively calculate 
# the jacobsthal as j(n-1) + 2(j(n-2))
       
       .text
main:  li      $sp, 0x7ffffffc  # set up stack ptr

                                # Input number whose jacobsthal is needed
       li      $v0, 5           # scanf("%d", &number)
       syscall
       move    $t0, $v0         # keep in register $t0
       sw      $t0, number

       sw      $t0, ($sp)       # push number as arguement onto stack
       sub     $sp, $sp, 4      # Move stack pointer

       jal     jacobsthal       # call jacobsthal

       add     $sp, $sp, 4      # pop arg. from stack

       move    $t1, $v0         # store fns return value in result
       sw      $t1, result

       li      $v0, 1		# printf("%d", result);
       move    $a0, $t1
       syscall

       li      $v0, 11		# printf("\n"s);
       li      $a0, 10
       syscall

       li      $v0, 10		# return 0
       syscall
	 

# jacobsthal function takes a number as input and calculates the jacobsthal
# Uses a itterative logic and a helper function. In case the number is less 
# than zero, it returns -1.
                                 # prologue
jacobsthal:
       sub     $sp, $sp, 24      # set new stack ptr
       sw      $ra, 24($sp)      # save ret addr in stack
       sw      $fp, 20($sp)      # save old frame ptr in stack
       add     $fp, $sp, 24      # set new frame ptr

       li      $t1, -1	         # ans = -1
       sw      $t1, 16($sp)

       lw      $t0, 4($fp)       # get arg. n in caller's frame
       bltz    $t0, endfn        # if (n >= 0)
	    
       beq     $t0, 0, if        #  if (n == 0 || n == 1)
       beq     $t0, 1, if
       j       else

if:    lw      $t1, 4($fp)       # ans = n
       sw      $t1, 16($sp)
       j       endfn

else:  li      $t1, 1            # ans = 1
       sw      $t1, 16($sp)

       li      $t2, 0            # prev = 0
       sw      $t2, 12($sp)

                                 # for (i= 2; i <= n; i++)
       li      $t4, 2		 # i = 2
       sw      $t4, 4($sp)

loop:  lw      $t0, 4($fp)       # get arg. n in caller's frame
       lw      $t4, 4($sp)       # get i value
       bgt     $t4, $t0, endfn   # if i > n, end loop

       lw      $t2, 12($sp)      # prev onto stack
       sw      $t2, ($sp)        
       sub     $sp, $sp, 4

       sw      $t1, 16($sp)      # ans onto stack  
       sw      $t1, ($sp)        
       sub     $sp, $sp, 4
	    
       jal     helper            # temp= helper(prev, ans)

       add     $sp, $sp, 8       # pop stack args

       sw      $v0, 8($sp)       
       lw      $t3, 8($sp)

       lw      $t2, 16($sp)      # prev = ans;
       sw      $t2, 12($sp)

       lw      $t1, 8($sp)       # ans = temp
       sw      $t1, 16($sp)

       lw      $t4, 4($sp)       # i++
       add     $t4, $t4, 1
       sw      $t4, 4($sp)
	    
       j       loop

endfn: lw      $t1, 16($sp)      # ret value ans to $v0 before exiting
       move    $v0, $t1         

               	                 # epilogue
       lw      $ra, 24($sp)      # load ret addr from stack
       lw      $fp, 20($sp)      # restore old frame ptr from stack
       add     $sp, $sp, 24      # reset stack ptr
       jr      $ra               # ret to caller using saved ret addr


# helper function takes 2 parameters and returns 2x + y 
                                 # prologue
helper:sub     $sp, $sp, 8       # set new stack ptr
       sw      $ra, 8($sp)       # save ret addr in stack
       sw      $fp, 4($sp)       # save old frame ptr in stack
       add     $fp, $sp, 8       # set new frame ptr

       lw      $t0, 8($fp)       # get arg. prev in caller's frame
       lw      $t1, 4($fp)       # get arg. ans in caller's frame

       mul     $t2, $t0, 2       #  2 * x
       add     $t2, $t2, $t1     # 2(2 * x) + y

       move    $v0, $t2          # copy ret value to $v0 before exiting

                                 # epilogue
       lw      $ra, 8($sp)       # load ret addr from stack
       lw      $fp, 4($sp)       # restore old frame ptr from stack
       add     $sp, $sp, 8       # reset stack ptr
       jr      $ra               # ret to caller using saved ret addr

# declaration of global variables in the data segment
        .data
number: .word 0 		 # int number= 0
result: .word 0			 # int result= 0

# -*- mode: text -*-
# name: Sushrut Chandra

# this program caluclates the Jacobsthal recursively 
# inputs: the number n  as inputs from stdin
# output: the Jacobsthal
# The main gets input from the user. an int is expected and no validation
# is done. It calls the jocobsthal function and prints the return value 
# The jacobsthal function uses a recursive function call to calculate 
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
# Uses a recursive logic. In case the number is less 
# than zero, it returns -1.
                                 # prologue
jacobsthal:
       sub     $sp, $sp, 20      # set new stack ptr
       sw      $ra, 20($sp)      # save ret addr in stack
       sw      $fp, 16($sp)      # save old frame ptr in stack
       add     $fp, $sp, 20      # set new frame ptr

       li      $t1, -1	         # ans = -1
       sw      $t1, 12($sp)

       lw      $t0, 4($fp)       # get arg. n in caller's frame
       bltz    $t0, endfn        # if (n >= 0)
	    
       beq     $t0, 0, if        #  if (n == 0 || n == 1)
       beq     $t0, 1, if
       j       else

if:    lw      $t1, 4($fp)       # ans = n
       sw      $t1, 12($sp)
       j       endfn

else:  lw      $t1, 4($fp)       # temp1= 2 * jacobsthal(n - 2)
       sub     $t1, $t1, 2
       sw      $t1, ($sp)        # (n-2) onto stack  
       sub     $sp, $sp, 4
	    
       jal     jacobsthal        # temp= helper(prev, ans)

       add     $sp, $sp, 4       # pop stack args

       move    $t0, $v0         
       mul     $t0, $t0, 2
       sw      $t0, 8($sp)      
      
       lw      $t1, 4($fp)       # temp2= jacobsthal(n - 1)
       sub     $t1, $t1, 1
       sw      $t1, ($sp)        # (n-1) onto stack  
       sub     $sp, $sp, 4
	    
       jal     jacobsthal        

       add     $sp, $sp, 4       # pop stack args

       move    $t0, $v0         
       sw      $t0, 4($sp)      
 
       lw      $t0, 4($sp)       # ans = temp1 + temp2
       lw      $t1, 8($sp)      
       add     $t1, $t1, $t0
       sw      $t1, 12($sp)

endfn: lw      $t1, 12($sp)      # ret value ans to $v0 before exiting
       move    $v0, $t1         

               	                 # epilogue
       lw      $ra, 20($sp)      # load ret addr from stack
       lw      $fp, 16($sp)      # restore old frame ptr from stack
       add     $sp, $sp, 20      # reset stack ptr
       jr      $ra               # ret to caller using saved ret addr


# declaration of global variables in the data segment
        .data
number: .word 0 		 # int number= 0
result: .word 0			 # int result= 0

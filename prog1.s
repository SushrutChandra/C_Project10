# -*- mode: text -*-
# name: Sushrut Chandra

# this program caluclates the area of a prism
# inputs: the length, width, height as inputs from stdin
# output: the area
# area is calc as 2 * (width * length + length * height + width * height)
# incase of error, -1 is given as area


  	 .text

main:	 li	   $t0, -1		# ans = -1
	 sw	   $t0, ans

	 li	   $v0, 5               # scanf("%d", &lenght)
	 syscall
	 move	   $t0, $v0		# keep in register $t0
	 sw	   $t0, length

	 li	   $v0, 5               # scanf("%d", &width)
	 syscall
	 move	   $t1, $v0		# keep in register $t1
	 sw	   $t1, width

	 li	   $v0, 5               # scanf("%d", &height)
	 syscall
	 move	   $t2, $v0		# keep in register $t2
	 sw	   $t2, height


	 blez	   $t0, endif		# lenght <= 0

	 blez	   $t1, endif		# width <= 0

	 blez	   $t2, endif		# height <= 0

	 mul	   $t4, $t0, $t1	# ans = 2 * (w . l + l . h + w. h)
	 mul	   $t5, $t0, $t2
	 add 	   $t4, $t4, $t5
	 mul	   $t5, $t1, $t2
	 add 	   $t4, $t4, $t5
	 mul	   $t4, $t4, 2
	 sw	   $t4, ans

endif:	 li	   $v0, 1		# printf("%d", ans);
	 move	   $a0, $t4
	 syscall

	 li	   $v0, 11		# printf("\n"s);
	 li	   $a0, 10
	 syscall

	 li	   $v0, 10		# return 0
	 syscall
	
  	 .data
length:	 .word 0			# int length= 0
width:	 .word 0			# int width= 0
height:	 .word 0			# int height= 0
ans:	 .word 0			# int ans= 0


.text

main:
	li $v0, 5 # read keyboard into $v0 (number x is number to test) 
	syscall 
	move $t0,$v0 # number of iterations

	mul $t6, $t0, 4
	li $t7, 0
	
	jal fun

	li $v0, 5 # read keyboard into $v0 (number x is number to test) 
	syscall 
	move $t1,$v0 # check_num

	li $t4, 0 # count
	
	la $t2, myarray
	# move $a1, $t2 # prt to first element
	# move $a2, $t1 # element
	# move $a3, $t4 # count
	move $a0, $t0 # number of elements
	jal rec_check
	
	move $t3, $v0

	la      $a0,msg
	li      $v0,4                   # puts
	syscall
	# add $t6, $t6, -4
	# lw $t3, myarray($t6)
	move    $a0,$t3                 # get number to print
	li      $v0,1                   # prtint
	syscall


	li      $v0,10   # end
	syscall

fun:        
    bge $t7,$t6,exit
    li $v0,5
    syscall
    sw $v0,myarray($t7)
    add $t7,$t7,4
    j fun

exit:
	jr $ra


rec_check:

	addi $sp, -8
	sw $ra, 4($sp)
	sw $a0, 0($sp)

	bgt $t0, 0, not_eq
	
	move $v0, $t4
	lw $a0, 0($sp)
	lw $ra, 4($sp)
	addi $sp, 8
	jr $ra

not_eq:

	lw $t5, ($t2)
	add $t2, $t2, 4
	
	bne $t5, $t1, not_eq1
	add $v0, $v0, $t4
	add $t0, $t0, -1
	
	

	# jal rec_check

	 
	# addi $sp, $sp, 8


not_eq1:
	add $t0, $t0, -1

	jal rec_check
	
	# lw $a0, 0($sp)
	# lw $ra, 4($sp) 
	# addi $sp, $sp, 8


	# lw $a3, 0($sp)
	# lw $ra, 4($sp) 
	# lw $a1, 8($sp)
	# addi $sp, $sp, 12

	# add $a0, $a0, -1
	# jal rec_check

# lw $t5, ($a1)
# add $a1, $a1, 4
# bne $t5, $a2, rec_check
# add $a3, $a3, 1
		
	# lw $a3, 0($sp)
	# lw $ra, 4($sp) 
	# lw $a1, 8($sp)
	# addi $sp, $sp, 12

	# add $v0, $v0, $a3
	# jr $ra

.data
.align 2
	myarray:.space 40 

	msg:     .asciiz     "Ans:\n"
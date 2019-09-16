.text
.globl main

main:
	li $v0, 5 
	syscall 
	move $t9, $v0

	mul $t6, $t9, 4
	li $s0, 0

	jal fun

	sub $sp, $sp, 4
	sw $ra, 0($sp) 
	la $a0, array_zero 
	la $a1, array_input
	add $a2, $t9, 0
	li $a3, 0
	move $t0, $a1
	move $t3, $a2
	li $t4, 0

	sub $sp, $sp, 16 
	sw $ra, 0($sp) 
	sw $a1, 8($sp) 
	sub $a2, $a2, 1 
	sw $a2, 4($sp) 
	sw $a3, 0($sp) 
	jal MergeSort 
	
	li $t7, 0 
	jal Print 

Print:
	slt $t6, $t7, $t9 
	beq $t6, 0, EndProgram
	sll $t0, $t7, 2 
	add $t6, $a1, $t0 
	li $v0, 1 
	lw $a0, 0($t6)
	syscall 
	li $v0, 4 
	la $a0, newline
	syscall
	add $t7, $t7, 1 
	jal Print 

EndProgram:
	add $sp, $sp, 20 
	li $v0, 10
	syscall

fun:        
    bge $s0, $t6, exit
    li $v0, 5
    syscall
    sw $v0, array_input($s0)
    add $s0, $s0, 4
    j fun

exit:
	li $t6, 0
	jr $ra
	
MergeSort:
	sub $sp, $sp, 20 
	sw $ra, 16($sp) 
	sw $s1, 12($sp) 
	sw $s2, 8($sp) 
	sw $s3, 4($sp) 
	sw $s4, 0($sp) 
	move $s1, $a1 
	move $s2, $a2 
	move $s3, $a3 
	slt $t3, $s3, $s2 
	beq $t3, 0, Done 
	add $s4, $s3, $s2 
	div $s4, $s4, 2 
	move $a2, $s4 
	move $a3, $s3 
	jal MergeSort

	add $t4, $s4, 1 
	move $a3, $t4 
	move $a2, $s2 
	jal MergeSort 

	move $a1, $s1 
	move $a2, $s2 
	move $a3, $s3 
	move $a0, $s4 
	jal Merge 

Done:
	lw $ra, 16($sp) 
	lw $s1, 12($sp) 
	lw $s2, 8($sp) 
	lw $s3, 4($sp) 
	lw $s4, 0($sp) 
	add $sp, $sp, 20 
	jr $ra 

Merge:
	sub $sp, $sp, 20 
	sw $ra, 16($sp) 
	sw $s1, 12($sp) 
	sw $s2, 8($sp) 
	sw $s3, 4($sp) 
	sw $s4, 0($sp) 
	move $s1, $a1 
	move $s2, $a2 
	move $s3, $a3 
	move $s4, $a0 
	move $t1, $s3 
	move $t2, $s4 
	add $t2, $t2, 1 
	move $t3, $a3 

While:
	slt $t4, $s4, $t1 
	bne $t4, 0, while2 
	slt $t5, $s2, $t2 
	bne $t5, 0, while2 
	sll $t6, $t1, 2 
	add $t6, $s1, $t6 
	lw $s5, 0($t6) 
	sll $t7, $t2, 2 
	add $t7, $s1, $t7 
	lw $s6, 0($t7) 
	slt $t4, $s5, $s6 
	beq $t4, 0, Else
	sll $t8, $t3, 2 
	la $a0, array_zero 
	add $t8, $a0, $t8
	sw $s5, 0($t8) 
	add $t3, $t3, 1 
	add $t1, $t1, 1 
	j While

Else:
	sll $t8, $t3, 2 
	la $a0, array_zero 
	add $t8, $a0, $t8
	sw $s6, 0($t8) 
	add $t3, $t3, 1 
	add $t2, $t2, 1 
	j While

while2:
	slt $t4, $s4, $t1 
	bne $t4, 0, while3 
	sll $t6, $t1, 2 
	add $t6, $s1, $t6
	lw $s5, 0($t6) 
	sll $t8, $t3, 2 
	la $a0, array_zero 
	add $t8, $a0, $t8
	sw $s5, 0($t8) 
	add $t3, $t3, 1
	add $t1, $t1, 1
	j while2

while3:
	slt $t5, $s2, $t2 
	bne $t5, 0, start 
	sll $t7, $t2, 2 
	add $t7, $s1, $t7 
	lw $s6, 0($t7) 
	sll $t8, $t3, 2
	la $a0, array_zero 
	add $t8, $a0, $t8 
	sw $s6, 0($t8) 
	add $t3, $t3, 1 
	add $t2, $t2, 1 
	j while3

start:
	move $t1, $s3 

forloop:
	slt $t5, $t1, $t3 
	beq $t5, 0, Done 
	sll $t6, $t1, 2 
	add $t6, $s1, $t6
	sll $t8, $t1, 2 
	la $a0, array_zero 
	add $t8, $a0, $t8 
	lw $s7, 0($t8) 
	sw $s7, 0($t6) 
	add $t1, $t1, 1 
	j forloop

.data
.align 2
	array_input: .space 40
	array_zero: .space 40
	newline: .asciiz "\n"


## took idea from slideshare.com
.text
.globl main
main:
	li $v0,4
	la $a0,geta
	syscall
	
	li $v0,5
	syscall
	add $s0,$v0,$zero


	#print array 

	add $a0,$s0,$zero
	jal fibanocci

	# add $s3,$v0,$zero
	# li $v0,1
	# add $a0,$s3,$zero
	# syscall


	la $a0,array
	add $a1,$s0,$zero
	jal print_array

	li $v0,4
	la $a0,newline
	syscall
	li $v0,10
	syscall

fibanocci:
	beqz $a0,zero
	beq $a0,1,one
	
	#calling fib(n-1)
	addi $sp,$sp,-4
	sw $ra,0($sp)
	addi $a0,$a0,-1
	jal fibanocci
	addi $a0,$a0,1
	#restore return value
	lw $ra,0($sp)
	addi $sp,$sp,4
	#save return value on stack
	addi $sp,$sp,-4
	la $t0,array
	addi $t1,$a0,-1
	sll $t1,$t1,2
	add $t0,$t0,$t1
	sw $v0,0($t0)
	sw $v0,0($sp)
	#calling fib(n-2)
	addi $sp,$sp,-4
	sw $ra,0($sp)
	addi $a0,$a0,-2
	jal fibanocci
	addi $a0,$a0,2
	#restore return value
	lw $ra,0($sp)
	addi $sp,$sp,4
	
	la $t0,array
	addi $t1,$a0,-2
	sll $t1,$t1,2
	add $t0,$t0,$t1
	sw $v0,0($t0)

	#get fib(n-1)
	lw $s7,0($sp)
	addi $sp,$sp,4

	add $v0,$v0,$s7
	

	jr $ra



	zero:
	li $v0,0
	jr $ra
	one:
	li $v0,1
	jr $ra





print_array:
	addi $sp,$sp,-12
	sw $s0,0($sp)
	sw $s1,4($sp)
	sw $s2,8($sp)
	move $s0,$a0
	add $s2,$zero,$a1
	add $s1,$zero,$zero
	print_loop:
		li $v0,1
		lw $a0,0($s0)
		syscall
		li $v0,4
		la $a0,space
		syscall
		addi $s1,$s1,1
		sll $t0,$s1,2
		add $s0,$s0,4
		beq $s1,$s2,print_ret
		j print_loop
	print_ret:
		lw $s0,0($sp)
		lw $s1,4($sp)
		lw $s2,8($sp)
		addi $sp,$sp,12
		jr $ra


.data
	geta: .asciiz "Enter the range of fibanocci numbers to be printed : "
	newline: .asciiz "\n"
	space: .asciiz " "
	array: .word -1:50
	length: .word 50
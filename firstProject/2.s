.text 
.globl main
main:
    #get first number 
    li $v0,4
    la $a0,geta
    syscall
    li $v0,5
    syscall
    add $s0,$zero,$v0
    #get second number
    li $v0,4
    la $a0,getb
    syscall
    li $v0,5
    syscall
    add $s1,$zero,$v0
    #call prime seive with arguments a and b stored in $s0 and $s1
    add $a0,$s0,$zero
    add $a1,$s1,$zero
    jal primeseive
    # add $a0,$s0,$zero
    # add $a1,$s1,$zero
    # jal print_primes

    # print the array
    la $a0,array1
	add $a1,$s0,$zero
    add $a2,$s1,$zero
	jal print_array
    #newline
    li $v0,4
	la $a0,newline
	syscall
    #exit
    li $v0,10
    syscall

primeseive:
    #initialize the array
    la $t0,array1
    add $t1,$zero,2
    add $t0,$t0,8
    init_loop:
        sw $t1,0($t0)
        addi $t0,$t0,4
        addi $t1,$t1,1
        blt $t1,$a1,init_loop
    la $t0,array1
    add $t1,$zero,2
    add $t0,$t0,8
    outer_loop:
        lw $t2,0($t0)
        beq $t2,$zero,cont_outer
        mul $t4,$t1,$t1
        inner_loop:
            sll $t5,$t4,2
            la $t6,array1
            add $t6,$t6,$t5
            sw $zero,0($t6)
            add $t4,$t4,$t1
            blt $t4,$a1,inner_loop
        cont_outer:
            addi $t0,$t0,4
            addi $t1,$t1,1
            mul $t3,$t1,$t1
            blt $t3,$a1,outer_loop
    ret:
        jr $ra
    
    
    
# print_primes:
#     la $t0,array1
#     add $t1,$zero,$a0
#     sll $t0,$t1,2
#     prime_loop:
#         lw $t2,0($t0)
#         beq $t2,$zero,continue_loop
#         li $v0,1
#         add $a0,$t2,$zero
#         syscall
#     continue_loop:
#         addi $t0,$t0,4
#         addi $t1,$t1,1
#         blt $t1,$a1,prime_loop
#     jr $ra

print_array:
	addi $sp,$sp,-12
	sw $s0,0($sp)
	sw $s1,4($sp)
	sw $s2,8($sp)
	move $s0,$a0
	add $s2,$zero,$a2
	add $s1,$zero,$a1
    sll $t5,$s1,2
    add $s0,$s0,$t5
	print_loop:
        lw $t7,0($s0)
        beq $t7,$zero,continue_loop
		li $v0,1
		lw $a0,0($s0)
		syscall
		li $v0,4
		la $a0,newline
		syscall
        continue_loop:
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
    geta: .asciiz "Enter the first number : "
    getb: .asciiz "Enter the second number : "
    array1: .word 0:1000
    space: .asciiz " "
    newline: .asciiz "\n"
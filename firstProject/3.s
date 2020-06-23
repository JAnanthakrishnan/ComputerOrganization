.text 
.globl main
main:
    #prompt for getting the first number 
    li $v0,4
    la $a0,getn
    syscall 
    li $v0,5
    syscall
    add $s0,$v0,$zero
    #logic for checking
    add $a0,$s0,$zero
    jal isnarcistic
    #newline
    li $v0,4
    la $a0,newline
    syscall
    #exit
    li $v0,10
    syscall

isnarcistic:
    addi $sp,$sp,-8
    sw $s0,0($sp)
    sw $s1,4($sp)
    add $s1,$zero,$zero
    add $s0,$a0,$zero
    addi $t0,$zero,10
    add $t1,$a0,$zero
    add $t7,$zero,$zero
    div_loop:
        div $t1,$t0
        mfhi $t2
        mflo $t3
        move $t1,$t3
        addi $t7,$t7,1
        addi $sp,$sp,-4
        sw $t2,0($sp)
        bne $t1,$zero,div_loop
    add $t5,$t7,$zero
    prn_loop:
        add $t6,$t7,$zero
        # addi $t6,$t6,-1
        addi $t4,$zero,1
        lw $t2,0($sp)
        addi $sp,$sp,4
        power_loop:
            mul $t4,$t4,$t2
            addi $t6,$t6,-1
            bne $t6,$zero,power_loop
        add $s1,$s1,$t4
        addi $t5,$t5,-1
        bne $t5,$zero,prn_loop
    beq $s1,$s0,ret_t
    li $v0,4
    la $a0,nonnar
    syscall
    lw $s0,0($sp)
    lw $s1,4($sp)
    addi $sp,$sp,8
    jr $ra
    ret_t:
        li $v0,4
        la $a0,nar
        syscall
        lw $s0,0($sp)
        lw $s1,4($sp)
        addi $sp,$sp,8
        jr $ra

.data
    getn: .asciiz "Enter the number to be checked : "
    nonnar: .asciiz "The entered number is not narcistic \n"
    nar: .asciiz "The entered number is narcistic\n"
    space: .asciiz " "
    newline: .asciiz "\n"
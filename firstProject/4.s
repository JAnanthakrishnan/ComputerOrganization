.text 
.globl main
main:
    #get first string
    li $v0,4
    la $a0,get1
    syscall
    li $v0,8
    la $a0,string1
    li $a1,20
    syscall #get first string
    li $v0,4
    la $a0,get2
    syscall
    li $v0,8
    la $a0,string2
    li $a1,20
    syscall #get second string
    jal strcmp
    #exit
    li $v0,10
    syscall
strcmp:
    la $t2,string1
    la $t3,string2
    loop_str:
        lb $t0,0($t2)
        lb $t1,0($t3)
        bne $t0,$t1,ret_f
        beq $t0,$zero,ret_t
        addi $t2,$t2,1
        addi $t3,$t3,1
        j loop_str
    ret_t:
        li $v0,4
        la $a0,same
        syscall
        jr $ra
    ret_f:
        li $v0,4
        la $a0,notSame
        syscall
        jr $ra

.data
    get1: .asciiz "Enter the first string : "
    get2: .asciiz "Enter the second string :"
    same: .asciiz "Same \n"
    notSame: .asciiz "Not Same \n"
    string1: .space 20
    string2: .space 20
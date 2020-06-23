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
    la $t4,string1
    la $t5,string2
    add $t0,$zero,$zero
    add $t1,$zero,$zero
    lengthLoop1  : 
        lb $t6,0($t4)
        addi $t0,$t0,1
        addi $t4,$t4,1
        bne $t6,$zero,lengthLoop1
    addi $t0,$t0,-2
    lengthLoop2  : 
        lb $t6,0($t5)
        addi $t1,$t1,1
        addi $t5,$t5,1
        bne $t6,$zero,lengthLoop2
    addi $t1,$t1,-2
    move $s5,$t1
    bgt	$t1, $t0, ret_f	 # if $t1 > $t0 then return false
    sub $s0,$t0,$t1
    addi $s0, $s0,1
    add $s1,$zero,$zero   
    la $t1,string1
    masterLoop   : 
        move $t3,$t1
        la $t2,string2
        add $t7,$zero,$zero
        slaveLoop: 
            lb $t4,0($t3)
            lb $t5,0($t2)
            # li $v0,1
            # add $a0,$t4,$zero
            # syscall
            # li $v0,4
            # la $a0,space
            # syscall
            # li $v0,1
            # add $a0,$t5,$zero
            # syscall
            # li $v0,4
            # la $a0,newline
            # syscall
            bne $t4,$t5,cont
            addi $t3,$t3,1
            addi $t2,$t2,1
            addi $t7,$t7,1
            blt $t7,$s5,slaveLoop
            j ret_t
        cont     : 
            addi $t1,$t1,1
            add $s1, $s1, 1
            blt	$s1, $s0, masterLoop
            j ret_f
    ret_t: 
    li $v0,4
    la $a0,substr
    syscall
    jr $ra
    ret_f: 
        li $v0,4
        la $a0,notSub
        syscall
        jr $ra
    

.data
    get1         : .asciiz "Enter the first string : "
    get2         : .asciiz "Enter the second string :"
    substr       : .asciiz "It is a substring \n"
    notSub       : .asciiz "Not a sub string \n"
    string1      : .space 20
    string2      : .space 20
    newline      : .asciiz "\n"
    space        : .asciiz " "
	.data
	Temp: .space 24
	Final: .space 28
	.globl validate_checksum
	.text


# -- validate_checksum --
# Arguments:
# a0 : Address of a string containing a german IBAN (22 characters)
# Return:
# v0 : the checksum of the IBAN
validate_checksum:
	
	move $t7 $a0 
	lb $t8 ($t7)
	addiu $t8 $t8 -0x37
	addi $t7 $t7 1
	
	move $t9 $t8
	li $t6 100
	mul $t9 $t9 $t6
	lb $t8 ($t7)
	addiu $t8 $t8 -0x37
	addu $t9 $t9 $t8
	

numToChar:
	li $t0 4
	li $t1 0
	li $t2 1000
	la $t6 Temp
loopCountry:
	div $t8 $t9 $t2
	div $t2 $t2 10
	rem $t8 $t8 10
	
	addi $t1 $t1 1
	addi $t8 $t8 0x30
	sb $t8 ($t6)
	addi $t6 $t6 1
	bne $t0 $t1 loopCountry
	
	move $t9 $a0
	addi $t9 $t9 2
	la $t8 Temp
	addi $t8 $t8 4
#first 4 digits in Temp

		
	lb $t7 ($t9)
	addi $t9 $t9 1
	sb $t7 ($t8)
	addi $t8 $t8 1
	
	lb $t7 ($t9)
	sb $t7 ($t8)	
	

	
	move $t7 $a0
	move $t2 $a0
	li $t0 4
	li $t1 22
	la $t9 Final
#$t9 with final address, $t8 with temp bit, $t7 with IBAN
#t0 with loop start, $t1 loop end, $t2 with start address

loopx1:
	addu $t7 $t2 $t0
	addiu $t0 $t0 1
	lb $t8 ($t7)
	sb $t8 ($t9)
	addiu $t9 $t9 1
	bne $t1 $t0  loopx1
	
	la $t7 Temp
	la $t2 Temp
	li $t0 0
	li $t1 6
	la $t9 Final
	addi $t9 $t9 18

#$t9 with final address, $t8 with temp bit, $t7 with IBAN
#t0 with loop start, $t1 loop end, $t2 with start address

loopx2:
	addu $t7 $t2 $t0
	addiu $t0 $t0 1
	lb $t8 ($t7)
	sb $t8 ($t9)
	addiu $t9 $t9 1
	bne $t1 $t0  loopx2
	
	move $t5 $a0
	
	la $a0 Final
	li $a1 24
	li $a2 97
	
	
	#modulo string
	
li $t0 0
	li $t9 0
	move $t2 $a0
	li $t3 10
	
	
loop:
	beq $t0 $a1 endloop
	addu $t2 $a0 $t0
	addiu $t0 $t0 1
	lb $t8 ($t2)
	andi $t8 $t8 0x0f
	
	mulu $t9 $t9 $t3
	rem $t9 $t9 $a2
	addu $t9 $t9 $t8
	rem $t9 $t9 $a2
	j loop
	
	
	
	
endloop:
	move $v0 $t9
	move $a0 $t5
	
	
	jr $ra
	
	
#$t9 with final address, $t8 with temp bit, $t7 with IBAN
#t0 with loop start, $t1 loop end, $t2 with start address

loopx:
	addu $t7 $t2 $t0
	addiu $t0 $t0 1
	lb $t8 ($t7)
	sb $t8 ($t9)
	addiu $t9 $t9 1
	bne $t1 $t0  loopx


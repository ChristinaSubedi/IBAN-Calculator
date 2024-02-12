	.data
	Start: .asciiz "DE00"

	.globl knr2iban
	.text
# -- knr2iban
# Arguments:
# a0: IBAN buffer (22 bytes)
# a1: BLZ buffer (8 bytes)
# a2: KNR buffer (10 bytes)
knr2iban:

	
	addiu $sp $sp -4
	sw $ra ($sp)
	# TODO
	move $t9 $a0
	li $t0 0
	li $t1 4
	la $t2 Start
	jal extract
	
	#for BLZ buffer
	move $t9 $a0
	addiu $t9 $t9 4 
	li $t0 0
	li $t1 8
	move $t2 $a1
	jal extract
	
	#for KNR buffer
	move $t9 $a0
	addiu $t9 $t9 12
	li $t0 0
	li $t1 10
	move $t2 $a2
	jal extract
	
	jal validate_checksum
	li $t0 98
	subu $t0 $t0 $v0
	
	div $t1 $t0 10
	rem $t2  $t0 10
	
	addi $t1 $t1 0x30
	addi $t2 $t2 0x30
	
	move $t0 $a0
	addiu $t0 $t0 2
	sb $t1 ($t0)
	addiu $t0 $t0 1
	sb $t2 ($t0)
	
	lw $ra ($sp)
	addi $sp $sp 4
	
		jr	$ra

	
	
#$t9 with final address, $t8 with temp bit
#t0 with loop start, $t1 loop end, $t2 with start address
extract:
	
loop:
	addu $t7 $t2 $t0
	addiu $t0 $t0 1
	lb $t8 ($t7)
	sb $t8 ($t9)
	addiu $t9 $t9 1
	bne $t1 $t0  loop
	jr $ra
	
	

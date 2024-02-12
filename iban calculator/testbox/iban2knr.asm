	.data
	KNR: .space 12
	BLZ: .space 12
	.globl iban2knr
	.text
# -- iban2knr
# Arguments:
# a0: IBAN buffer (22 bytes)
# a1: BLZ buffer (8 bytes)
# a2: KNR buffer (10 bytes)
iban2knr:
	# TODO
	#$t0=start address, $t1= end address, $t2=counter, $t3=index $s1=copy, $s2=stores
	
	addiu $sp $sp -12
	sw $ra 0($sp)
	sw $s1 4($sp)
	sw $s2 8($sp)
	
	#for BLZ
	li $t0 4
	li $t1 12
	la $s2 BLZ
	li $t2 4
	jal extractor
	la $a1 BLZ
	
	
	#for KNR
	li $t0 12
	li $t1 22
	la $s2 KNR
	li $t2 12
	jal extractor
	la $a2 KNR
	
	lw $s2 8($sp)
	lw $s2 4($sp)
	lw    $ra ($sp)   # restore $ra 
	addiu $sp $sp 12    # deallocate frame
	j return
	
extractor:
	addu $s1 $a0 $t0	#get start address to extract
	li $t2 4
loop:
	lb $t3 0($s1)		#copy from index
	sb $t3 0($s2)
	
	addi $s1 $s1 1		#increase counter
	addi $s2 $s2 1
	addi $t2 $t2 1
	bne $t1 $t2 loop
	
	jr $ra
	
		
			
return:	
	jr	$ra

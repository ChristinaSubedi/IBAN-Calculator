	.data
	.globl modulo_str
	.text

# --- modulo_str ---
# Arguments:
# a0: start address of the buffer
# a1: number of bytes in the buffer
# a2: divisor
# Return:
# v0: the decimal number (encoded using ASCII digits '0' to '9') in the buffer [$a0 to $a0 + $a1 - 1] modulo $a2 
modulo_str:
#t0 counter, t2 address +counter, t8 temp storage, t9 final storage
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
	jr	$ra

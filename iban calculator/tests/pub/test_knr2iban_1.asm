	.data
	.globl main
testblz:
	.asciiz "99999999"
testknr:
	.asciiz "1111111117"
ibanbuf:
	.space 23
	.text
main:	
	la	$a0 ibanbuf
	la	$a1 testblz
	la	$a2 testknr
	jal	knr2iban
	li	$v0 10
	la	$a0 ibanbuf
	li	$a1 22
	jal	println_range
	syscall
	li	$v0 10
	syscall

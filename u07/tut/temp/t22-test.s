.data
a:	50

.text
	lw	$t0, a
	bltz	$t0, true
	li	$t1, 99
	bgt	$t0, $t1, true
	
	sub	$t0, $t0, 1
	b	exit

true:	sub	$t0, $t0, 10

exit:	li	$v0, 10
	syscall
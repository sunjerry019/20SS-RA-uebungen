	.data
str1:	.ascii "Geben Sie beliebig viele Zahlen ein.\n"	
	.asciiz "Eingabe von 0 beendet die Eingabe und gibt das Ergebnis aus.\n"
askstr:	.asciiz "\n?-> "
errstr:	.asciiz "Die Eingegebene Zahl ist ungültig. Bitte probieren Sie es erneut\n"
answstr:.asciiz "Das Ergebnis lautet: "
str2:	.asciiz "\n\n"

	.text
main:	li	$s0, 0
	li	$s1, 0
    	li 	$s2, 3

	li	$v0, 4		
	la	$a0, str1       
	syscall
	
loop:	li	$v0, 4		
	la	$a0, askstr   
	syscall

	li	$v0, 5		
	syscall
	beqz	$v0, exit
	li	$t2, 103
	bgt	$v0, $t2, error
	li	$t2, 5
	blt	$v0, $t2, error
    	addi    $s1, $s1, 1
	rem	$t2, $v0, $s2 
	mul 	$t2, $t2, $s1
	add	$s0, $s0, $t2

	j	loop

error:	li	$v0, 4
	la	$a0, errstr	
	syscall
	j	loop

exit:	li	$v0, 4		
	la	$a0, answstr    
	syscall

	li	$v0, 1
	move	$a0, $s0
	syscall

	li	$v0, 4		
	la	$a0, str2       
	syscall
	
	li	$v0, 10
	syscall


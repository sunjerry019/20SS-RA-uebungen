	.data
line1:	.asciiz "Geben Sie die 1. Zahl ein: "
line2:	.asciiz "Geben Sie die 2. Zahl ein: "
erg:	.asciiz "Das Ergebnis lautet: "
komma:	.asciiz ","

	# Registerbelegungen
	# $t0 = A
	# $t1 = B
	# $t2 = Summe (von A und B)
	# $t3 = 2
	# $t4 = Rest der Division
	# $t5 = 10
	# $s0 = Vorkommazahl
	# $s1 = Nachkommazahl

	.text
main:	
	##############################################
	# Einlesen der 2 Werte
	##############################################

	li 	$v0, 4		# 4: print_str:
	la 	$a0, line1	# Adresse der 1. auszugebende Zeile nach $a0
	syscall			# ausgeben

	li 	$v0, 5		# 5: read_int
	syscall			# integer einlesen
	move	$t0, $v0	# eingelesenen Wert in Register $t0 verschieben (A)

	li 	$v0, 4		# 4: print_str:
	la 	$a0, line2	# Adresse der 2. auszugebende Zeile nach $a0
	syscall			# ausgeben

	li 	$v0, 5		# 5: read_int
	syscall			# integer einlesen
	move	$t1, $v0	# eingelesenen Wert in Register $t1 verschieben (B)

	##############################################
	# Berechnung des Durchschnitts
	##############################################

	add	$t2, $t0, $t1	# t2/Summe = $t0/A + $t1/B
	li 	$t3, 2		# Den Wert 2 in Register $t0 laden
	div 	$s0, $t2, $t3	# $s0/Vorkomma  = $t2/Summe DIV $t3/2
	rem	$t4, $t2, $t3	# $t4/Rest = $t2/Summe MOD $t3/2

	li 	$t5, 10		# Den Wert 10 in Register $t5 laden
	mul	$t6, $t4, $t5	# Eine Null an den Rest haegen (= x 10)

	div 	$s1, $t6, $t3	# den mit 0 erweiterten Rest wieder durch 2 teilen

	##############################################
	# Ausgabe des Ergebnisses
	##############################################

	li 	$v0, 4		# 4: print_str

	la 	$a0, erg 	# Adresse des Ergebnis-Texts nach $a0
	syscall 		# ausgeben

	li 	$v0, 1		# 1: print_int
	move 	$a0, $s0	# Vorkommastelle nach $a0
	syscall

	li 	$v0, 4		# 4: print_str
	la 	$a0, komma	# Adresse des Komma-Texts nach $a0
	syscall

	li 	$v0, 1		# 1: print_int
	move 	$a0, $s1	# Nachkommastelle nach $a0
	syscall 	

	li 	$v0, 10		# Systemaufrufnr. 10 = EXIT
	syscall

# Beschreibung: Berechnet (n über k), Binomial koeffizienten
# Funktion:     (n über k) = (n!)/((n-k)!k!)
#
# Eingabe:      n, k
# Ausgabe:      Binomialkoeffizient oder Fehlermeldung
#
# Register:
#               $s0 = n
#               $s1 = k


        .data
prmpt0: .asciiz "\nEs wird binom(n,k) berechnet.\nn = "
prmpt1: .asciiz "\nk = "
prmpt2: .asciiz "\nErgebnis = "

err0:   .asciiz "\nSie haben n < k eingeben. Abbruch."
        
        .text
main:
        # load "IMMEDIATE" not "INTERMEDIATE"
        li      $v0, 4
        la      $a0, prmpt0
        syscall

        li      $v0, 5                  # read_int
        syscall
        move    $s0, $v0                # n

        li      $v0, 4
        la      $a0, prmpt1
        syscall

        li      $v0, 5                  # read_int
        syscall
        move    $s1, $v0                # k

        blt     $s0, $s1, n_kleiner_k   # n < k

        li      $t1, 1                  # zaehler = 1
        li      $t2, 1                  # nenner  = 1
        li      $t3, 1                  # $t3 = 1  (als referenz)

        # Top    = (n - (k - 1))
        # Bottom = (k - (k - 1))
        # SO THEY REPEAT THE SAME NUMBER OF TIMES

        # This code also covers k = 0 => 1/1 = 1

loop:   blt     $s1, $t3, end_loop      # WHILE k >= 1 DO
        mul     $t1, $t1, $s0           # zaehler := zaehler * n
        addi    $s0, $s0, -1            # n --
        mul     $t2, $t2, $s1           # nenner  := nenner  * k
        addi    $s1, $s1, -1            # k --
        j       loop                    # LOOP

end_loop:
        li      $v0, 4
        la      $a0, prmpt2
        syscall                         # The ergebnis is

        li      $v0, 1                  # 1: print_int
        div     $a0, $t1, $t2           # Divide and put result directly in $a0
        syscall

exit:   li      $v0, 10
        syscall                         # Programm beenden

n_kleiner_k:
        li      $v0, 4
        la      $a0, err0
        syscall

        j       exit
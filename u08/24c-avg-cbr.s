# Das Programm berechnet den Durchschnitt der Werte eines Feldes

       .data
array: .word   8 2 3 7 9 1
size:  .word   6

# We want to use ONLY ADDRESSES in this case.
# We can use $a0 - $a3 for the passing of addresses
# and return the result using $v0

# NB: We use the $a stuff cus a for ADDRESS
#     the $t stuff for TEMP

# Das Hauptprogramm übergibt dem Unterprogramm die Startaddresse
# und die Länge des Feldes. Das Unterprogramm gibt das Ergebnis 
# der Berechnung züruck.

# Verwendung der Register:
# $a0: Startadresse des Feldes
# $a1: Anzahl der Worte im Feld
# $v0: Ergebnis des Unterprogrammaufrufs

        .text
main:   la      $a0, array      # Staradresse des FEldes
        la      $a1, size       # Anzahl der Worte im Feld
        jal     cbr             # Jump to subroutine

        move    $a0, $v0        # Sichere das Ergebnis

        li      $v0, 1          # 1: print_int
        syscall

        li      $v0, 10         
        syscall                 # Exit

# Unterprogramm

# Das Unterprogramm holt sich die Feldlänge und alle Feldelemente
# über die übergebenen Adressen direkt aus der Spreicher. Es 
# berechnet den Durchschnitt der Werte im Feld und legt das Ergebnis
# der Berechnung im Register $v0 ab.

# Verwendung der Register
# $v0: Ergebnis des Unterprogrammaufrufs
# $t0: Zeiger auf aktuelles Feldelement
# $t1: Anzahl der Worte im Feld
# $t2: Zeiger auf Adresse nach dem letzten Feldelement
# $t3: Aktuelles Feldelement

#  +0   +4   +8   +12  +16  +20  +24
#   8    2    3    7    9    1   <empty>
#   ^-$t0                         ^-$t2

cbr:    move    $v0, $zero      # Initialize the Result variable
        move    $t0, $a0        # Sichere die Startadresse des Felds
        lw      $t1, ($a1)      # Sichere die Anzahl der Worte im Feld
        mul     $t2, $t1, 4     # Berechne Anzahl der Bytes im Feld
        add     $t2, $t0, $t2   # Berechne die Endadresse des Feldes

loop2:  bge     $t0, $t2, avg   # we have reached past the end address
        lw      $t3, ($t0)      # Get next element
        add     $v0, $v0, $t3   # Addiere Feldelement zum Ergebnis
        add     $t0, $t0, 4     # Erhöhe Feldindex, add or addi both can add intermediate
        j       loop2           # Go to next element

avg:    div     $v0, $v0, $t1   # Berechnne Durchschnitt
        jr      $ra             # Jump back to Hauptprogramm

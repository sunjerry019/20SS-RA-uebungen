# Das Programm berechnet den Durchschnitt der Werte eines Feldes

       .data
array: .word   8 2 3 7 9 1
size:  .word   6

# Das Hauptprogramm legt das Feld und dessen Länge auf dem Stack ab
# und ruft das Unterprogramm auf. Kehr das Unterprogramm züruck, so
# lädt das Hauptprogramm das Ergebnis der Berechnung vom Stack und 
# gibt es aus.

# Verwendung der Register:
# $s0: Startadresse des Feldes
# $s1: Anzahl der Worte im Feld
# $s2: Anzahl der Bytes im Feld
# $t0: Feldindex
# $t1: Aktuelles Feldelement
# $a0: Ergebnis des Unterprogrammaufrufs

        .text
main:   la      $s0, array      # Staradresse des FEldes
        lw      $s1, size       # Anzahl der Worte im Feld
        mul     $s2, $s1, 4     # Berechnet Anzahl der Bytes im Feld
        move    $t0, $zero      # Initialisere Feldindex

        # Call by Value, parameter bereitstellen
        # We make a copy of (array) and (length) on the stack

loop:   addi    $sp, sp, -4     # Schaffe Platz auf dem Stack
        lw      $t1, array($t0) # Lade das nächste Feldselement
        sw      $t1, 4($sp)     # Speichere Feldelement auf dem Stack
        addi    $t0, $t0, 4     # Increment Feldindex
        blt     $t0, $s2, loop  # If there are still elements, loop

        addi    $sp, $sp, -4    # Schaffe Platz auf dem Stack
        sw      $s1, 4($sp)     # Speichere Feldlänge auf dem Stack
        jal     cbv             # Springe ins Unterprogramm

        # Unterprogramm runs here

        lw      $a0, 4($sp)     # Hole Ergebnis vom Stack frei
        addi    $sp, $sp, 4     # Gib Platz auf dem Stack frei
        li      $v0, 1          # 1: print_int
        syscall                 # Gib Ergebnis aus

        li      $v0, 10
        syscall                 # Exit

# Unterprogramm

# Das Unterprogramm holt sich die Feldlänge und alle Feldelemente vom 
# Stack, berechnet den Durchschnitt der Wert im Feld und legt das 
# Ergebnis der Berechnung wieder auf dem Stack ab. 

# Verwendung der Register:
# $t0: Ergebnis des Unterprogrammaufrufs
# $t1: Anzahl der Worte im Feld
# $t2: Anzahl der Bytes im Feld
# $t3: Aktuelles Feldelement

cbv:    move    $t0, $zero      # Initialize the result
        lw      $t1, 4($sp)     # Hole Anzahl der Wrote vom Stack
        mul     $t2, $t1, 4     # Berechne Anzahl der Bytes im Feld
        addi    $sp, $sp, 4     # We don't need the length anyway, free space

loop2:  ble     $t2, $zero, avg # If no more elements in arr, leave the loop
        lw      $t3 4($sp)      # Get next array element
        addi    $sp, $sp, 4     # free space from space
        add     $t0, $t0, $t3   # Add current array element to the Ergebnis
        addi    $t2, $t2, -4    # We processed one element, reduce num_bytes_left = $t0
        j       loop2           # Go to next element

avg:    div     $t0, $t0, $t1   # Calculate Avg
        addi    $sp, $sp, -4    # Allocate space on stack
        sw      $t0, 4($sp)     # Save result on the stack
        jr      $ra             # Springe zurück ins Hauptprogramm

        .data
values: .word 128 64 32 16 8 4 2 1
input:  .space 9                        # Reserve 9 Bytes (ASCII = 8 Bit/Char und \0)
result: .word 0                         # Useless
ans:    .asciiz "Der Wert ist "
endl:   .asciiz "\n"
                
        # t0 - Zum Zwischenspeichern eines Zeichens
        # a1 - Zum Zwischenspeichern der aktuellen String-Position
        # a0 - Pointer to address of input string
        # t5 - 0 and t6 - 1
        # t1 - current power of 2
        # t4 - value of current power of 2

        .text
main:
        li      $v0, 8          # 8: read_str
        la      $a0, input      # Zieladresse des einzugebenden Textes
        li      $a1, 9          # maximale Länge
        syscall

        li      $t5, 48         # ASCII("0") = 48
        li      $t6, 49         # ASCII("1") = 49

        la      $t1, values     # t1 enthält Zeiger auf Stellenwert
        li      $t7, 0          # Initialisiere Ergebnis

nextCh: # ==============================
        # Fügen Sie hier Ihre Lösung ein
        # ==============================
                                # a0 stores the address, 
                                # so we want to load the value at that address

        lb      $t0, ($a0)      # Load Zeichen into t0
        beqz    $t0, strEnd     # Jump to strEnd if end of string detected
      # beq     $t0, $t5, null  # Jump if its zero
        beq     $t0, $t6, eins  # Jump if its one

        # ==============================
        # Ende Ihrer Lösung
        # ==============================
null:                           # Bit war 0
        addi    $t1, $t1, 4     # Verschiebe Zeiger um ein Wort
        addi    $a0, $a0, 1     # Verschiebe Zeiger um ein Zeichen
        j       nextCh

eins:                           # Bit war 1
        # ==============================
        # Fügen Sie hier Ihre Lösung ein
        # ==============================
        
        lw      $t4, ($t1)      # load value of current power of 2 into $t4 (or ML = $t2)
        add     $t7, $t7, $t4   # Add t7 + t4 and store into t7
      # j       null            # Do what the null have to do 
      # LMAO IT IS BELOW

        # ==============================
        # Ende Ihrer Lösung
        # ==============================

        addi    $t1, $t1, 4     # Verschiebe Zeiger um ein Wort
        addi    $a0, $a0, 1     # Verschiebe Zeiger um ein Zeichen
        j       nextCh

strEnd: li      $v0, 4          # 4: print_str
        la      $a0, endl       # Übergebe Adresse des Strings
        syscall                 # Gebe Newline aus
        
        li      $v0, 4          # 4: print_str 
                              #   ^ EIGENTLICH not necessary because 4 is already loaded
        la      $a0, ans        # Übergebe Adresse des Strings
        syscall                 # Gebe Ergebnis-String aus

        li      $v0, 1          # 4: print_int
        move    $a0, $t7        # Verschiebe Ergebnis 
                              #   ^ NOT lw -> It takes from some add
        syscall                 # Gebe Ergebnis aus

        li      $v0, 4          # 4: print_str
        la      $a0, endl       # Übergebe Adresse des Strings
        syscall                 # Gebe Newline aus

        li      $v0, 10
        syscall                 # au revoir...

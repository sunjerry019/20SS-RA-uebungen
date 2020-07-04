.data

shift_text:     .asciiz "Um wieviele Stellen soll der Text verschoben werden: "
string1:        .asciiz "Der verschluesselte Text lautet: "
secret:         .asciiz "GEHEIMNIS"
string_a:       .asciiz "A"
string_z:       .asciiz "Z"

result:         .space 9

.text
main:
        # t0 - Zum Zwischenspeichern der Position des aktuell betrachteten Buchstabens
        # t1 - Gibt die Laenge des Geheimworts an
        # t2 - ASCII Wert des Buchstaben A (65)
        # t3 - ASCII - WERT des Buchstaben Z (90)
        li      $t0, 0
        li      $t1, 9
        lb      $t2, string_a
        lb      $t3, string_z

        la      $a0, shift_text
        li      $v0, 4
        syscall

        li      $v0, 5
        syscall

        move    $s1, $v0

loop:   bge     $t0, $t1, end
        lb      $t4, secret($t0)

caesar: ####################################
        # Fuegen Sie hier Ihre Loesung ein #
        ####################################

        add     $t4, $t4, $s1   # Nur positive Zahlen, $t4 += SHIFT

        ######################
        # Ende Ihrer Loesung #
        ######################
        bgt     $t4, $t3, cadd

save:
        ####################################
        # Fuegen Sie hier Ihre Loesung ein #
        ####################################
        
        sb      $t4, result($t0)  # Speichere $t4 im Position $t0 in result
        addi    $t0, $t0, 1       # nächste Buchstaben 
        

        ######################
        # Ende Ihrer Loesung #
        ######################
        j       loop

cadd:   ####################################
        # Fuegen Sie hier Ihre Loesung ein #
        ####################################

        sub     $t4, $t4, $t2
        rem     $t4, $t4, 26
        add     $t4, $t4, $t2



        ######################
        # Ende Ihrer Loesung #
        ######################
        j       save


end:    la      $a0, string1
        li      $v0, 4
        syscall

        la      $a0, result
        li      $v0, 4
        syscall

        li      $v0, 10
        syscall

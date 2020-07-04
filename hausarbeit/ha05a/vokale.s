.data
needle:         .asciiz "Rechnerarchitektur"
result:         .space  18
ascii_vocals:   .asciiz "aeiouAEIOU"
string1:        .asciiz "Rechnerarchitektur enthaelt: "
string2:        .asciiz " Vokale."
string3:        .asciiz "\nRechnerarchitektur ohne Vokale ist: "
nline:          .asciiz "\n"

.text
main:   li      $t0, 0          # Zaehler fuer die Anzahl der Vokale
        li      $t1, 0          # Index des aktuell betrachteten Zeichens von needle
        li      $t2, 0          # Index des aktuell betrachteten Vokals in ascii_vocals
        li      $t3, 0          # Index des naechsten freien Speicherplatzes in result


n_loop: lb      $t4, needle($t1)
        beqz    $t4, end

vocs:   ####################################
        # Fuegen Sie hier Ihre Loesung ein #
        ####################################

        lb      $t5, ascii_vocals($t2)  # aktueller Vokal
        beqz    $t5, save               # Ende des Vokal-Strings, Zeichen ist kein Vokal
        beq     $t4, $t5, vocal         # Vokal gefunden
        addi    $t2, $t2, 1             # nächster Vokal




        ######################
        # Ende Ihrer Loesung #
        ######################
        j       vocs

vocal:  addi    $t0, $t0, 1
        li      $t2, 0
        addi    $t1, $t1, 1
        j       n_loop


# Der Coderahmen geht auf der folgenden Seite weiter!

save:   ####################################
        # Fuegen Sie hier Ihre Loesung ein #
        ####################################

        sb      $t4, result($t3)        # Speichere Konsonant in result
        addi    $t3, $t3, 1             # nächster Zeichen in result





        ######################
        # Ende Ihrer Loesung #
        ######################
reset:  add     $t1, $t1, 1
        li      $t2, 0
        j       n_loop




end:    li      $v0, 4
        la      $a0, string1
        syscall

        li      $v0, 1
        move    $a0, $t0
        syscall

        li      $v0, 4
        la      $a0, string2
        syscall

        li      $v0, 4
        la      $a0, string3
        syscall

        li      $v0, 4
        la      $a0, result
        syscall

        li      $v0, 10
        syscall

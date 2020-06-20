# Reading an int using read_int($v0 := 5) will read the 
# int and store it in 2s complement in memory, so we only
# have to read it bitwise and output the result.

# Working principle
#      num = 1000 1010
#            └--------┐
# rol      ┌-0001 0101┘ Rotate Left
# AND with | 0000 0001  Bitmask
#          | |||| ||||
# result   | 0000 0001 ---------> Store 1
#          └----------┐
# rol        0010 1010┘ Rotate Left
# AND with   0000 0001  Bitmask
#            |||| ||||
# result     0000 0000 ---------> Store 0

# https://coolsymbol.com/corner-symbols.html

.data
prmpt:  .asciiz "Bitte geben Sie eine Zahl ein: "
erg2k:  .asciiz "Ihre Zahl als Dualzahl in 2er-Komplement-Darstellung: "
nl:     .asciiz "\n"
res:    .space  33      # We want to output a 32 bit integer + \0

.text
main:   li      $v0, 4          # 4: print_str
        la      $a0, prmpt
        syscall                 # Eingabeaufforderung ausgeben

        li      $v0, 5          # 5: read_int
        syscall                 # Zahl von Konsole einlesen
        move    $t0, $v0        # Eingelesen Zahl in $t0
        
        li      $t2, 32         # Counter1 := 32 (decreasing/abst. Counter)
        li      $t3, 0          # Counter2 := 0  (increasing/aufst. Counter)
        li      $t4, 1          # $t4: 1 (const) (BITMASK)
        li      $t5, 48         # ASCII("0") = 48
        li      $t5, 49         # ASCII("1") = 49
        li      $t7, 00         # Nullterminierung

loop:   rol     $t0, $t0, 1     # Beginn mit Bit ganz links
        and     $t1, t0, $t4    # Bit-weiser Vergleich
        addi    $t2, $t2, -1    # Counter1 --
        beqz    $t1, null       # Bit = 0, jump to null

eins:   sb      $t6, res($t3)   # Bit (1) als String speichern (res is the space we allocated)
        addi    $t3, $t3, 1     # Counter2 ++ 
        beqz    $t2, end        # Alle 32 Bits abgearbeitet?
        j       loop 

null:   sb      $t5, res($t3)   # Bit (0) als String speichern (res is the space we allocated)
        addi    $t3, $t3, 1     # Counter2 ++ 
        beqz    $t2, end        # Alle 32 Bits abgearbeitet?
        j       loop 

end:    sb      $t7, res($t3)   # Nullterminierung ans Ende 
        
        la      $a0, erg2k      # Print erg2k
        li      $v0, 4          # |
        syscall                 # |

        la      $a0, res        # Print result
        li      $v0, 4          # |
        syscall                 # |

        la      $a0, nl         # Print newline
        li      $v0, 4          # |
        syscall                 # |

        li      $v0, 10         # Exit
        syscall



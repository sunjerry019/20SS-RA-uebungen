#  Calculates the binomial coefficient

        .data
pn:     .asciiz "n: "
pk:     .asciiz "k: "
erg:    .asciiz "nCk = "
fehler: .asciiz "Fehler: k groesser als n"

# $t0 = n
# $t1 = k
# $t2 = ergebnis
# $t3 = stopping condition

        .text
main:   li      $t2, 1          # Default value of ergebnis is 1
        
        li      $v0, 4          # 4: print_str
        la      $a0, pn         # Print prompt
        syscall

        li      $v0, 5          # 5: read_int
        syscall                 # Zahl von Konsole einlesen
        move    $t0, $v0        # Eingelesen Zahl in $t0 = n
        
        li      $v0, 4          # 4: print_str
        la      $a0, pk         # Print prompt
        syscall

        li      $v0, 5          # 5: read_int
        syscall                 # Zahl von Konsole einlesen
        move    $t1, $v0        # Eingelesen Zahl in $t1 = k
        
        bgt     $t1, $t0, err   # k > n
        beqz    $t1, result     # Print result directly if k = 0 # actually not necessary
        
        sub     $t3, $t0, $t1   # $t3 = n - k, determine stopping condition
        
muln:   ble     $t0, $t3, divk  # Stop if n = n - k
        mul     $t2, $t2, $t0   # Multiply by current_n
        sub     $t0, $t0, 1     # decrease n by 1
        j       muln            # loop
        
divk:   beqz    $t1, result     # stop if k reaches 0 (BUT ASSUMES K IS POSITIVE!!!)
        div     $t2, $t2, $t1   # divide by current_k
        sub     $t1, $t1, 1     # decrease k by 1       
        j       divk            # loop

        ##### OOPS should have divided at the last step
        
err:    li      $v0, 4          # 4: print_str
        la      $a0, fehler     # Print error
        syscall
        j       exit            # Exit after error
        
result: li      $v0, 4          # 4: print_str
        la      $a0, erg        # Print ergebnis string
        syscall
        
        li      $v0, 1          # 1: print_int
        move    $a0, $t2        # Move result to $a0
        syscall
        
exit:   li      $v0, 10         # Exit
        syscall
        
        
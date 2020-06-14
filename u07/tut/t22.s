# a bereits in $t0 geladen

# if ( a < 0 || a > 90 )
        bltz    $t0, true
        li      $t1, 99
        bgt     $t0, $t1, true
# else-case: a --
        sub     $t0, $t0, 1
        b       exit

# if-case  : a - 10
true:   sub     $t0, $t0, 10

exit:   # To be continued, since pseudocode no exit
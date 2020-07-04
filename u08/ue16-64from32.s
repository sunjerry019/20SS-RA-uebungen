#          MSW:LSW
# Number 1 $t4:$t5
# Number 2 $t6:$t7
# Result   $t2:$t3

# Im zweierkomplement already
# So we use addition without overflow

        .text
main:   # Load 2147483647 into $s1
        # lui   $s0, 32767
        lui     $s0, 65535
        ori     $s1, $s0, 65535
        
        move    $t5, $s0
        li      $t4, 0
        li      $t7, 1
        li      $t6, 0
        
        # https://stackoverflow.com/a/23237078/3211506
        # addiu $s2, $s1, 1
        
        # Actual answer here
        addu    $t3, $t5, $t7
        



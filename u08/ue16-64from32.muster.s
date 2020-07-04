# Nochmal hier den Tipp: 
# Wenn man sich spielerisch in Assembler-Logik einfinden möchte kann
# ich das Spiel "Human Resource Machine" empfehlen. 

# Einfacher Genauigkeit
#   [32 Bit]
# + [32 Bit]
# -----------
#   [32 Bit]

# Doppelte Genauigkeit                       MSW:LSW
#   [32 Bit][32 Bit]  = 64 Bit      Number 1 $t4:$t5
# + [32 Bit][32 Bit]  = 64 Bit      Number 2 $t6:$t7
# -------------------
#   [32 Bit][32 Bit]  = 64 Bit      Result   $t2:$t3

# IDEA: 
# LSW can just be added together
# MSW add together with eventuell ein CarryIn

# add  = add normal    (WILL catch overflow! -> Known as overflow traps)
#                                            -> Sends to OS
# addu = add-unsigned  (overflows ignored)

# But in our case, we want the CarryOut to go back as CarryIn

# Ohne Overflow Behandlung

        addu    $t3, $t5, $t7   # Inteprets everything as normal binary numbers
        sltu    $t2, $t3, $t5   # set on less than unsigned
        # Look at 2 unsigned integer, 
        # When one is less than the other, set $t2
        # $t3 (erg) <  $t5 (first zahl) -> $t2 = 1
        # $t3 (erg) >= $t5 (first zahl) -> $t2 = 0
        # When the result is the less than one of the parts
        #   then there is a CarryOver
        
        # why?

        addu    $t2, $t2, $t4   # $t2 = $t2 + $t4
        addu    $t2, $t2, $t6   # Then add $t6

# Mit Overflow Behandlung

        addu    $t3, $t5, $t7
        sltu    $t2, $t3, $t5
        add     $t2, $t2, $t4   # an overflow can already happen here!
        add     $t2, $t2, $t6   # We have to use `add` for both!

# TIL vorführeffekt
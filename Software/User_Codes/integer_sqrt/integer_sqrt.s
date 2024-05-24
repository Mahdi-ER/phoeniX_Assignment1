    # Load the value of n into register t1
    li t1, 39

    # Initialize registers
    li t2, 0        # t2 = i (current guess for sqrt)
    li t3, 0        # t3 = square of t2

sqrt_loop:
    addi t2, t2, 1  # Increment t2
    mul t3, t2, t2  # t3 = t2 * t2

    bge t3, t1, sqrt_done  # If t3 >= n, we found the sqrt
    j sqrt_loop           # Else, continue loop

sqrt_done:
    addi t2, t2, -1 # Adjust t2 since last t2^2 was not < n

#the result is stored in t2
ebreak
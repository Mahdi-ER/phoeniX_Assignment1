Computer Organization - Spring 2024
==============================================================
## Iran Univeristy of Science and Technology
## Assignment 1: Assembly code execution on phoeniX RISC-V core

- Name: Mahdi EbrahimiRavesh
- Team Members: Amirmohammad Salek
- Student ID: 400411009
- Date: 5/24/2024

## Report

# Quicksort Algorithm 

## Introduction to Quicksort
This document provides a detailed explanation of the RISC-V assembly code implementing the quicksort algorithm. Quicksort is a highly efficient sorting algorithm that operates using a divide-and-conquer strategy. The time complexity of quicksort is amortized \(O(n \log n)\) and worst case \(O(n^2)\). The space complexity is \(O(\log n)\) due to the recursion stack.

![Quicksort GIF](./Images/Sorting_quicksort_anim.gif)

## Code Overview

The quicksort algorithm is implemented in the following steps:
1. **Main(Initialization)**: Store array values in contiguous memory.
2. **Quicksort Function**: Recursive sorting function.
3. **Partition Function**: Helper function to partition the array around a pivot.
4. **End**: Save the result and end the program.

### Main Program

The `MAIN` section initializes an array with five integer values and stores them in contiguous memory starting at address `0x0`. The array is then sorted using the quicksort algorithm.

```assembly
Main:
    # Store array values in contiguous memory at mem address 0x0:
    addi a0, x0, 0
    # array = {94, 45, 73, 12, 32}
    addi t0, x0, 94
    sw t0, 0(a0) 
    addi t0, x0, 45
    sw t0, 4(a0)
    addi t0, x0, 73
    sw t0, 8(a0)
    addi t0, x0, 12
    sw t0, 12(a0)
    addi t0, x0, 32
    sw t0, 16(a0)

    addi a1, x0, 0 # start
    addi a2, x0, 4 # end

    jal ra, QUICKSORT
    jal ra, EXIT
```

### Quicksort Function

The `QUICKSORT` function is the core of the algorithm, which recursively sorts subarrays defined by `start` and `end` indices. The base case of the recursion is when `start` is not less than `end`.

```assembly
QUICKSORT:
    addi sp, sp, -20
    sw ra, 16(sp)
    sw s3, 12(sp)
    sw s2, 8(sp)
    sw s1, 4(sp)
    sw s0, 0(sp)

    addi s0, a0, 0
    addi s1, a1, 0
    addi s2, a2, 0
    BLT a2, a1, START_GT_END

    jal ra, PARTITION

    addi s3, a0, 0   # pivot

    addi a0, s0, 0
    addi a1, s1, 0
    addi a2, s3, -1
    jal ra, QUICKSORT  # quicksort(arr, start, pivot - 1);

    addi a0, s0, 0
    addi a1, s3, 1
    addi a2, s2, 0
    jal ra, QUICKSORT  # quicksort(arr, pivot + 1, end);

START_GT_END:
    lw s0, 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    lw s3, 12(sp)
    lw ra, 16(sp)
    addi sp, sp, 20
    jalr x0, ra, 0
```

### Partition Function

The `PARTITION` function rearranges the elements in the array so that all elements less than the `pivot` are on the left of the `pivot` and all elements greater than the `pivot` are on the right.

```assembly
PARTITION:
    addi sp, sp, -4
    sw ra, 0(sp)

    slli t0, a2, 2   # end * sizeof(int)
    add t0, t0, a0  
    lw t0, 0(t0)     # pivot = arr[end]
    addi t1, a1, -1  # i = (start - 1)

    addi t2, a1, 0   # j = start
    LOOP:
    BEQ t2, a2, LOOP_DONE   # while (j < end)

    slli t3, t2, 2   # j * sizeof(int)
    add a6, t3, a0   # (arr + j)
    lw t3, 0(a6)     # arr[j]

    addi t0, t0, 1   # pivot + 1
    BLT t0, t3, CURR_ELEMENT_GTE_PIVOT  # if (pivot <= arr[j])
    addi t1, t1, 1   # i++

    slli t5, t1, 2   # i * sizeof(int)
    add a7, t5, a0   # (arr + i)
    lw t5, 0(a7)     # arr[i]

    sw t5, 0(a6)
    sw t3, 0(a7)     # swap(&arr[i], &arr[j])

CURR_ELEMENT_GTE_PIVOT:
    addi t2, t2, 1   # j++
    beq x0, x0, LOOP
    LOOP_DONE:

    addi t5, t1, 1   # i + 1
    addi a5, t5, 0   # Save for return value.
    slli t5, t5, 2   # (i + 1) * sizeof(int)
    add a7, t5, a0   # (arr + (i + 1))
    lw t5, 0(a7)     # arr[i + 1]

    slli t3, a2, 2   # end * sizeof(int)
    add a6, t3, a0   # (arr + end)
    lw t3, 0(a6)     # arr[end]

    sw t5, 0(a6)
    sw t3, 0(a7)     # swap(&arr[i + 1], &arr[end])

    addi a0, a5, 0   # return i + 1

    lw ra, 0(sp)
    addi sp, sp, 4
    jalr x0, ra, 0
```

### End

The `End` section is used to loading sorted array in `s2-s6` registers and terminating the program.

```assembly
End:
    # Load sorted array into s2-s6
    lw s2, 0(a0)
    lw s3, 4(a0)
    lw s4, 8(a0)
    lw s5, 12(a0)
    lw s6, 16(a0)
    ebreak
```
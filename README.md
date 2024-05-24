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



### Quicksort Function

The `QUICKSORT` function is the core of the algorithm, which recursively sorts subarrays defined by `start` and `end` indices. The base case of the recursion is when `start` is not less than `end`.



### Partition Function

The `PARTITION` function rearranges the elements in the array so that all elements less than the `pivot` are on the left of the `pivot` and all elements greater than the `pivot` are on the right.




The `End` section is used to loading sorted array in `s2-s6` registers and terminating the program.


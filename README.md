# Assembly Programs Collection

This repository contains two assembly programs demonstrating different algorithms implemented in x86_64 assembly language.

## Programs

### 1. Bit Manipulation Program (1.s)
A program that performs bit manipulation operations:
- Takes a number and a string as input
- Extracts bits 14-17 and 20-23 from the number
- Performs conditional operations based on string input
- Outputs three numbers based on the calculations

#### Input Format
- First argument: An integer number
- Second argument: A string that can contain '-' and 's' characters

#### Implementation Details
- Extracts and isolates bits 14-17 and 20-23 from the input number
- Performs sign extension operations based on string conditions
- Outputs three numbers: the extracted bit sequences and their sum

### 2. Combination Calculator (2.s)
A program that calculates combinations (nCr) using recursive implementation:
- Takes two integers n and r as input
- Calculates the combination C(n,r) recursively
- Handles error cases and input validation

#### Input Format
- First argument: Integer n (total items)
- Second argument: Integer r (items to choose)

#### Implementation Details
- Uses recursive formula: C(n,r) = C(n-1,r) + C(n-1,r-1)
- Base cases:
  - C(n,0) = 1
  - C(n,n) = 1
  - C(n,r) = 0 when r > n
- Provides error handling for invalid inputs

## Building and Running

The project includes a Makefile for easy compilation and execution:

```bash
make run
```
Change the `ASM_NAME` in the Makefile to run the other program.

## Requirements
- NASM assembler
- GCC compiler
- Linux x86_64 environment

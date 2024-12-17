global asm_main
extern printf
extern scanf

section .text
asm_main:
    sub rsp, 8 ; Align stack to 16 bytes (required for function calls)

    ; Read input with scanf
    mov rdi, scanf_format ; Address of scanf format string
    mov rsi, rsp ; Address to store input
    call scanf

    ; Load the input number
    mov rax, [rsp] ; Load the input number into eax

    ; Extract 14th-17th bits
    mov rsi, rax ; Copy number to rsi
    and rsi, 0x3C000 ; Mask 14th-17th bits (0x3C000 = 245760)
    shr rsi, 14 ; Shift to get the value (14th bit = LSB)

    ; Extract 20th-23rd bits
    mov rdx, rax ; Copy number to rdx
    and rdx, 0xF00000 ; Mask 20th-23rd bits (0xF00000 = 15728640)
    shr rdx, 20 ; Shift to get the value (20th bit = LSB)

    ; Addition
    mov rcx, rsi ; Copy number to rcx
    add rcx, rdx ; Adding rdx

    ; Print the results
    mov rdi, printf_format ; Address of printf format string
    call printf 

    add rsp, 8 ; Restore stack alignment
    ret ; Return from main

section .data
scanf_format: db "%d", 0 ; Format string for scanf
printf_format: db "%d", 10, "%d", 10, "%d", 10, 0 ; Format string for printf

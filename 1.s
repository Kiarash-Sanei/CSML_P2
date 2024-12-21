global asm_main
extern printf
extern scanf

section .text
asm_main:
    sub rsp, 8 ; Align stack to 16 bytes (required for function calls)

    ; Read input with scanf
    lea rdx, [rsp + 4] ; Address to store the string
    lea rsi, [rsp] ; Address to store the number
    mov rdi, scanf_format ; Address of scanf format string
    call scanf

    ; Load the inputs
    mov rbx, [rsp + 4] ; Load the string into rbx
    mov eax, [rsp] ; Load the number into eax

    ; Extract 14th-17th bits
    mov esi, eax ; Copy number to rsi
    and esi, 0x3C000 ; Mask 14th-17th bits (0x3C000 = 245760)
    shr esi, 14 ; Shift to get the value (14th bit = LSB)

    ; Extract 20th-23rd bits
    mov edx, eax ; Copy number to rdx
    and edx, 0xF00000 ; Mask 20th-23rd bits (0xF00000 = 15728640)
    shr edx, 20 ; Shift to get the value (20th bit = LSB)

    ; Check the condition
    cmp bl, '-' ; Comparing the first character
    je first_ok

back:
    ; Addition
    mov ecx, esi ; Copy number to rcx
    add ecx, edx ; Adding rdx

    ; Print the results
    mov rdi, printf_format ; Address of printf format string
    call printf 

    add rsp, 8 ; Restore stack alignment
    mov rax, 0 ; The non-error exit code
    ret ; Return from main

second_ok:
    ; The condition is met
    mov rax, 8 ; Sign extetion based on the number's sign
    and rax, rsi
    jne first
continue:
    mov rax, 8
    and rax, rdi
end:
    jmp back
first:
    add rsi, 0xFFFFFFFFFFFFFFF0
    jmp continue
second:
    add rdi, 0xFFFFFFFFFFFFFFF0
    jmp end
        
first_ok:
    cmp bh, 's' ; Comparing the second character
    je second_ok 

section .data
scanf_format: db "%d %s", 0 ; Format string for scanf
printf_format: db "%d %d %d", 10, 0 ; Format string for printf
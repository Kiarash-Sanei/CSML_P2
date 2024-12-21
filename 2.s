global asm_main
extern printf
extern scanf

section .text
asm_main:
    sub rsp, 8 ; Align stack to 16 bytes (required for function calls)

section .data
scanf_format: db "%d %d", 0 ; Format string for scanf
printf_format: db "%d", 10, 0 ; Format string for printf
error: db "input is invalid" ; Format string for error
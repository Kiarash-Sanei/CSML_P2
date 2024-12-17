global asm_main
extern printf 
extern scanf
section .text
asm_main:
    sub rsp, 8 ; fix allignments

    mov rdi, scanf_format ; scanf format
    mov rsi, rsp ; load the number to top of stack
    ; add rsp, 4 ; make the stack ready
    ; mov rdx, rsp ; load the others to top of stack

    call scanf

    ; mov rdx, [rsp] ; load the others from stack
    ; sub rsp, 4 ; make stack ready
    mov rsi, [rsp] ; load the number from stack
    mov rax, rsi ; put the number to other place
    and rax, 1E000h ; get 14th to 17th bit
    ; mov rbx, rsi ; put the number to other place
    ; and rbx, 0x780000 ; get 20th to 23rd bit
    ; mov rdi, printf_format ; setting the first argument
    ; mov rcx, rax ; put the first number in place
    ; add rcx, rbx ; adding the second number
    ; mov rsi, rax ; setting the second argument
    ; mov rdi, rbx ; setting the third argument

    ; call printf

    add rsp, 8
    ret
    
section .data
scanf_format: db "%d", 0,
printf_format: db "%d\n%d\n%d" , 10 , 0,
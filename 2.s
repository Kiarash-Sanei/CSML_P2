global asm_main
extern printf
extern scanf

section .text
asm_main:
    sub rsp, 8 ; Align stack to 16 bytes (required for function calls)

    ; Read input with scanf
    mov rdi, scanf_format ; Address of scanf format string
    lea rsi, [rsp + 4] ; Address to store n
    lea rdx, [rsp] ; Address to store r
    call scanf
    
    ; Validate the inputs
    cmp rax, 2 ; Checking the return value of scanf (that shows number of matchings)
    jl invalid
    xor rcx, rcx ; I want to save the result in rcx so we should reset it
    jmp function ; Go to the function
print:
    mov rdi, printf_format 
    mov rsi, rcx ; Ready to print
end:    
    call printf
    add rsp, 8
    mov rax, 0 ; The non-error exit code
    ret

invalid:
    mov rdi, error ; Ready to print
    jmp end

function:
    mov rax, [rsp + 4] ; Load n
    mov rbx, [rsp] ; Load r
    cmp rax, rbx ; n ? r
    jne function_normal
    je equal ; C(n,n) = 1
    jl less ; C(n,r>n) = 0
    cmp rbx, 0 ; C(n,r<0) = 0
back:
    jmp print

function_normal:
    dec rax ; n - 1
    push rax
    push rbx
    jmp function
    pop rbx
    dec rbx ; r - 1
    push rbx 
    jmp function
    pop rbx
    pop rax
    jmp back

equal:
    inc rcx ; C(n,n) = 1
    jmp back
less:
    ; C(n,r>n) = 0
    jmp back
zero:
    ; C(n,r<0) = 0
    jmp back



section .data
scanf_format: db "%d %d", 0 ; Format string for scanf
printf_format: db "%d", 10, 0 ; Format string for printf
error: db "invalid input", 10, 0 ; Format string for error
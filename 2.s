global asm_main
extern printf
extern scanf

section .text
asm_main:
    sub rsp, 8 ; Align stack to 8 bytes (required for function calls)

    ; Read input with scanf
    mov rdi, scanf_format ; Address of scanf format string
    lea rsi, [rsp + 4] ; Address to store n
    lea rdx, [rsp] ; Address to store r
    call scanf

    ; Validate the inputs
    cmp rax, 2 ; Check the return value of scanf
    jl invalid
    xor rcx, rcx ; Reset rcx to store the result
    mov rax, [rsp + 4] ; Load n
    mov rbx, [rsp] ; Load r
    push rax
    push rbx
    call function ; Go to the function
    pop rbx
    pop rax

print:
    mov rdi, printf_format ; Ready to print
    mov rsi, rcx
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
    cmp rbx, 0
    jl zero ; C(n, r < 0) = 0
    cmp rax, rbx
    jl less ; C(n, r > n) = 0
    je equal ; C(n, n) = 1
    ; Recursive case: C(n, r) = C(n - 1, r) + C(n - 1, r - 1)
    dec rax ; n - 1
    push rax
    push rbx
    call recurse ; Compute C(n - 1, r)
    pop rbx
    pop rax

    dec rbx ; r - 1
    push rax
    push rbx
    call recurse ; Compute C(n - 1, r - 1)
    pop rbx
    pop rax

back:
    ret

recurse:
    call function
    ret

equal:
    inc rcx ; C(n, n) = 1
    jmp back

less:
    ; C(n, r > n) = 0
    jmp back

zero:
    ; C(n, r < 0) = 0
    jmp back



section .data
scanf_format: db "%d %d", 0 ; Format string for scanf
printf_format: db "%d", 10, 0 ; Format string for printf
error: db "invalid input", 10, 0 ; Format string for error

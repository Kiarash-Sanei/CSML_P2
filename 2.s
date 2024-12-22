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
    ; mov rsi, rax
    ; cmp rax, 0 ; Checking the return value of scanf (that shows number of matchings)
    ; jne invalid

    mov rdi, non
    mov rsi, [rsp + 4]
    mov rdx, [rsp]
    call printf

    ; add rsp, 4 ; It should point to the last number in stack
    ; mov rbp, rsp ; We will work with rsp from this part and we want to save where it was!
    xor rsi, rsi ; I want to save the result in rsi so we should reset it
    jmp function ; Go to the function

back:
    mov rdi, printf_format ; Ready to print
    call printf
    add rsp, 8
    ret


invalid:
    ; Print the error
    mov rdi, error ; Address of error message
    call printf 
    add rsp, 8
    ret

function:
    ; Load the inputs of function
    mov ebx, [rbp] ; Load the r into ebx
    add rbp, 4
    mov eax, [rbp] ; Load the n into eax
    add rbp, 4

    mov rdi, non
    mov esi, eax
    mov edx, ebx
    call printf

    cmp eax, ebx ; Checking if n = r or n < r
    je equal
    jl less
    cmp ebx, 0 ; Checking if r < 0
    jl less

    dec eax ; n - 1
    sub rbp, 4
    mov [rbp], eax ; C(n - 1,r)
    sub rbp, 4
    mov [rbp], ebx ; C(n - 1,r)
    dec ebx ; r - 1
    sub rbp, 4
    mov [rbp], eax ; C(n - 1,r - 1)
    sub rbp, 4
    mov [rbp], ebx ; C(n - 1,r - 1)

    jmp end ; Going to the end

equal:
    inc rsi ; C(n,n) = 1
    add rbp, 4
    add rbp, 4
    jmp end
less:
    add rbp, 4
    add rbp, 4

end:
    cmp rbp, rsp ; If the stack is empty then we have finished
    jne function ; Recursive call
    jmp back

section .data
scanf_format: db "%d %d", 0 ; Format string for scanf
printf_format: db "%d", 10, 0 ; Format string for printf
error: db "input is invalid %d", 10, 0 ; Format string for error
non: db "%d %d",10,0
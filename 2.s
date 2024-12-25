global asm_main
extern printf
extern scanf

section .text
asm_main:
    push rbp
    mov rbp, rsp
    sub rsp, 32      ; Reserve stack space for local variables and alignment

    ; Read input with scanf
    mov rdi, scanf_format
    lea rsi, [rbp-8]  ; Address to store n
    lea rdx, [rbp-16] ; Address to store r
    call scanf

    ; Validate the inputs
    cmp rax, 2        ; Check if scanf read 2 values
    jl invalid_input

    ; Initialize parameters for combination calculation
    mov rax, [rbp-8]  ; Load n
    mov rbx, [rbp-16] ; Load r
    xor rcx, rcx      ; Initialize result to 0
    
    ; Call recursive function
    call calculate_combination
    
    ; Print result
    mov rdi, printf_format
    mov rsi, rcx      ; Move result to second argument
    call printf
    jmp end

invalid_input:
    mov rdi, error_msg
    call printf

end:
    mov rsp, rbp
    pop rbp
    xor rax, rax      ; Return 0
    ret

calculate_combination:
    ; Preserve registers
    push rbp
    mov rbp, rsp
    push rax
    push rbx
    
    ; Handle base cases
    cmp rbx, 0        ; Check if r = 0
    jl zero_case
    cmp rax, rbx      ; Compare n and r
    jl zero_case      ; If n < r, return 0
    je one_case       ; If n = r, return 1
    
    ; Recursive case: C(n,r) = C(n-1,r) + C(n-1,r-1)
    dec rax           ; n-1
    
    ; Calculate C(n-1,r)
    call calculate_combination
    push rcx          ; Save first result
    
    ; Restore n and r, then calculate C(n-1,r-1)
    mov rax, [rbp-8]  ; Restore original n
    mov rbx, [rbp-16] ; Restore original r
    dec rax           ; n-1
    dec rbx           ; r-1
    call calculate_combination
    
    ; Add results
    pop rdx           ; Restore first result
    add rcx, rdx      ; Add both results
    
    jmp combination_return

zero_case:
    xor rcx, rcx      ; Return 0
    jmp combination_return

one_case:
    mov rcx, 1        ; Return 1

combination_return:
    ; Restore registers
    pop rbx
    pop rax
    pop rbp
    ret

section .data
scanf_format: db "%d %d", 0
printf_format: db "%d", 10, 0
error_msg: db "input is invalid", 10, 0
%include "../include/io.mac"

section .text
    global simple
    extern printf

simple:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     ecx, [ebp + 8]  ; len
    mov     esi, [ebp + 12] ; plain
    mov     edi, [ebp + 16] ; enc_string
    mov     edx, [ebp + 20] ; step

    ;; DO NOT MODIFY
   
    ;; Your code starts here
label:
    mov eax, [esi] ;; fiecare caracter
    mov [edi], eax

    add [edi], dl ;; adaug pasul
    cmp [edi], byte 90
    jle letter

    sub [edi], byte 26 ;; scad daca trece de 'Z'

    letter:
    add esi, 1
    add edi, 1

loop label

    ;; Your code ends here
    
    ;; DO NOT MODIFY

    popa
    leave
    ret
    
    ;; DO NOT MODIFY

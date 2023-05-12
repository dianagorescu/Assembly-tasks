%include "../include/io.mac"

struc proc
    .pid: resw 1
    .prio: resb 1
    .time: resw 1
endstruc

section .text
    global sort_procs
    ;extern printf

sort_procs:
    ;; DO NOT MODIFY
    enter 0,0
    pusha

    mov edx, [ebp + 8]      ; processes
    mov eax, [ebp + 12]     ; length
    ;; DO NOT MODIFY

    ;; Your code starts here

while_1:
    xor ebx, ebx
    xor ecx, ecx
    mov ebx, 0 ;; contor pt existenta unui swap

    mov eax, [ebp + 12] ;; initializez lungime
    xor edi, edi
    mov edi, 0 ;; iterator prin vector

    xor esi, esi
    mov esi, eax ;; folosesc registrul esi pt lungime
    xor eax, eax ;; golesc eax pt a lucra mai departe cu el

    sub esi, 1 ;; sunt posibile lungime - 1 swap-uri
    

while_2:
    mov cl, [edx + edi + proc.prio]
    mov al, [edx + edi + 5 + proc.prio]

    cmp cl, al
    jl no_prob ;; daca termenii sunt in ordine cresc => nu exista probleme
    je case_time ;; daca termenii au aceeasi prioritate, verificam timpul

    swap:
    ;; interschimb toate campurile structurii

    mov cl, [edx + edi + proc.prio]
    mov al, [edx + edi + 5 + proc.prio]
    xchg cl, al
    mov [edx + edi + proc.prio], cl
    mov [edx + edi + 5 + proc.prio], al

    mov cx, [edx + edi + proc.time]
    mov ax, [edx + edi + 5 + proc.time]
    xchg cx, ax
    mov [edx + edi + proc.time], cx
    mov [edx + edi + 5 + proc.time], ax

    xor ecx, ecx
    xor eax, eax

    mov cx, [edx + edi + proc.pid]
    mov ax, [edx + edi + 5 + proc.pid]
    xchg cx, ax
    mov [edx + edi + proc.pid], cx
    mov [edx + edi + 5 + proc.pid], ax

    mov ebx, 1 ;; cresc contorul daca s-a produs vreun swap

    jmp no_prob ;; nu mai este nevoie sa verific alte cazuri

    case_time:
    mov cx, [edx + edi + proc.time]
    mov ax, [edx + edi + 5 + proc.time]

    cmp cx, ax
    jl no_prob
    jg swap

    ;; ajunge aici daca termenii au si campul timp la fel
    xor ecx, ecx
    xor eax, eax
    mov cx, [edx + edi + proc.pid]
    mov ax, [edx + edi + 5 + proc.pid]

    cmp cx, ax
    jl no_prob
    jg swap
    
    no_prob:
    add edi, 5 ;; structura are 5 octeti
    sub esi, 1 ;; iteram prin vector
    jnz while_2

    cmp ebx, 1 ;; s-a produs minim un swap
    je while_1 ;; e necesar sa parcurg inca o data

    ;; Your code ends here
    
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
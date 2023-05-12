%include "../include/io.mac"

;; declarare structura 'avg'
struc avg
    .quo: resw 1
    .remain: resw 1         ;; ambele sunt pe maxim 2 octeti (enunt)
endstruc

struc proc
    .pid: resw 1
    .prio: resb 1
    .time: resw 1
endstruc

    ;; Hint: you can use these global arrays
section .data
    prio_result dd 0, 0, 0, 0, 0
    time_result dd 0, 0, 0, 0, 0

section .text
    global run_procs
    ;extern printf

run_procs:
    ;; DO NOT MODIFY

    push ebp
    mov ebp, esp
    pusha

    xor ecx, ecx

clean_results:
    mov dword [time_result + 4 * ecx], dword 0
    mov dword [prio_result + 4 * ecx],  0

    inc ecx
    cmp ecx, 5
    jne clean_results

    mov ecx, [ebp + 8]      ; processes
    mov ebx, [ebp + 12]     ; length
    mov eax, [ebp + 16]     ; proc_avg
    ;; DO NOT MODIFY
   
    ;; Your code starts here

    xor edx, edx                            ;; contor de iteratie

    xor esi, esi                            ;; lucrez cu lungimea in esi
    mov esi, ebx

parcurgere1:

    add edx, 1
    
    mov ecx, [ebp + 8]                      ;; initializez procesele de fiecare data
    mov esi, [ebp + 12]                     ;; lucrez cu lungimea in esi

    xor edi, edi

    mov word [time_result + edx * 4], 0     ;; structura are 4 octeti
    mov word [prio_result + edx * 4], 0
    
    parcurgere2:

    ;; completez cei 2 vectori pentru fiecare prioritate

    xor ebx, ebx
    mov bl, [ecx + edi + proc.prio]
    cmp ebx, edx
    jne not_equal

    xor ebx, ebx
    mov bx, [ecx + edi + proc.time]
    add word [time_result + edx * 4], bx    ;; contruiesc suma de timp per prio
    add word [prio_result + edx * 4], 1     ;; pun nr de aparitii per prio

    not_equal:
    
    add edi, 5                              ;; structura are 5 octeti
    sub esi, 1                              ;; iteram prin procese
    jnz parcurgere2

    cmp edx, 5                              ;; continui cat timp nu a ajums la
    jl parcurgere1                          ;; 5, valoarea maxima de prioritate

    xor esi, esi                            ;; golesc registrele
    xor ecx, ecx
    xor edi, edi

    ;; mut vectorul de structuri avg in ecx pentru a efectua impartirea
    ;; cu registrele eax si edx

    mov ecx, [ebp + 16]

final:
    add esi, 1                              ;; contor de iteratie
    xor eax, eax
    xor ebx, ebx
    xor edx, edx
    
    mov ax, [time_result + esi * 4]         ;; deimpartitul = suma de timp
    mov bx, [prio_result + esi * 4]         ;; impartitorul = nr de procese per prio
    
    ;; tratez cazul cu impartitorul = 0, intrucat nu este posibila
    ;; impartirea la zero

    cmp ebx, 0
    je div_la_zero                          ;; omit instructiunea cu div

    div bx

div_la_zero:

    mov word [ecx + edi + avg.quo], ax      ;; catul se afla in ax
    mov word [ecx + edi + avg.remain], dx   ;; restul se afla in dx
    
    add edi, 4                              ;; struct avg are 4 octeti
    cmp esi, 5                              ;; 5 este val maxima de prioritate
    jl final

    ;; Your code ends here
    
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
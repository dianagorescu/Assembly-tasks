
section .data

section .text
	global checkers
    extern printf

checkers:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]	; x
    mov ebx, [ebp + 12]	; y
    mov ecx, [ebp + 16] ; table

    ;; DO NOT MODIFY
    ;; FREESTYLE STARTS HERE

    xor edi, edi
    mov edi, eax

    xor edx, edx
    mov edx, 8
    mul edx                             ;; inmultesc x cu 8

    ;; rezultatul inmultirii se afla in eax

    add eax, ebx                        ;; adun y
case_x_0:
    cmp edi, 0                          ;; cazul cand x = 0
    jne case_x_7                        ;; altfel dau jump la urm cazuri

    cmp ebx, 0                          ;; x=0 si y=0 colt stanga jos
    jne jos_sari_1
    mov byte [ecx + 8 + 1], 1           ;; solutia e vecinul din colt sus dreapta
    jmp exit

    jos_sari_1:

    cmp ebx, 7                          ;; x=0 si y=7 colt dreapta jos
    jne jos_sari_2
    mov byte [ecx + eax + 8 - 1], 1     ;; solutia e vecinul din colt sus stanga
    jmp exit

    jos_sari_2:

    mov byte [ecx + ebx + 8 + 1], 1     ;; caz cand se afla pe marginea de jos
    mov byte [ecx + ebx + 8 - 1], 1     ;; are solutia cele 2 colturi sus
    jmp exit

case_x_7:
    cmp edi, 7                          ;; cazul cand x = 7
    jne case_margini_st_dr              ;; altfel dau jump la urm cazuri

    cmp ebx, 0                          ;; x=7 si y=0 colt stanga sus
    jne sus_sari_1
    mov byte [ecx + eax - 8 + 1], 1     ;; solutia e vecinul din colt jos dreapta
    jmp exit

    sus_sari_1:

    cmp ebx, 7                          ;; x=7 si y=7 colt dreapta sus
    jne sus_sari_2
    mov byte [ecx + eax - 8 - 1], 1     ;; solutia e vecinul din colt jos stanga
    jmp exit

    sus_sari_2:

    mov byte [ecx + eax - 8 + 1], 1     ;; caz cand se afla pe marginea de sus
    mov byte [ecx + eax - 8 - 1], 1     ;; are solutia cele 2 colturi jos
    jmp exit

case_margini_st_dr:

    cmp ebx, 0                          ;; marginea din stanga
    jne margine_dr
    mov byte [ecx + eax + 8 + 1], 1
    mov byte [ecx + eax - 8 + 1], 1
    jmp exit

    margine_dr:

    cmp ebx, 7                          ;; marginea din dreapta
    jne case_normal
    mov byte [ecx + eax + 8 - 1], 1
    mov byte [ecx + eax - 8 - 1], 1
    jmp exit

case_normal:

    ;; acum in eax se afla pozitia piesei

    sub eax, 8                          ;; mut pozitia pe linia de sub

    mov byte [ecx + eax - 1], 1         ;; jos stanga
    mov byte [ecx + eax + 1], 1         ;; jos dreapta

    add eax, 16                         ;; mut pozitia pe linia de deasupra

    mov byte [ecx + eax - 1], 1         ;; sus stanga
    mov byte [ecx + eax + 1], 1         ;; sus dreapta

exit:
    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
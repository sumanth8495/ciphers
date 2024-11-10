

extern Enc_flag
extern val_1
extern val_2
extern val_3
extern val_4


section .data
    welcome   db "Hello this is spectre club Challenge!",0ah,0h
    noflag    db "Sorry no flag for you :-(",0ah,0h
    alldone   db "All Done!",0ah,0h
    baddata   db "Baad Data!",0ah,0h
    congrats  db "Congrats!! You found the flag!!", 0ah, 0h


section .bss
    buffer resb 64

section .text
    global _start

_start:

    mov r9, 0h      ; exit status

    mov rax, welcome
    call _printString

    xor rcx, rcx    ; init counter for the character number
_flagLoop:
    mov rdi, rcx

    call _Step1
    call _Step2
    call _Step3
    call _Step4
    mov [buffer+rdi], BYTE al

    mov [buffer+rdi+1], BYTE 0ah
    mov [buffer+rdi+2], BYTE 0h

    mov rax, buffer
    call _printString

    inc rcx
    cmp rcx, 30
    jb _flagLoop

    jmp _alldone

;   rdi contains the position of the letter in the flag
;   intermediate value is returned in rax
_Step1:
;#####################################################################
;   To solve the challenge modify this subroutine as follows:
;   Examine the registers changed by the subroutine and add or remove push/pop to
;   preserve the registers correctly.
;#####################################################################

    ; val_4 uses rdi as the offset into data used to decode the flag
    ;call val_4
    ;mov rcx, rax

    ;Enc_flag uses rdi as the offset into data used to decode the flag
   ; call Enc_flag

    ; return value in rax
   ; sub rax, rcx

   ; ret
   
   
       ; Save registers that will be modified
    push rdi           ; Preserve rdi, which is used as the index
    push rcx           ; Preserve rcx, which will store the result of val_4

    ; val_4 uses rdi as the offset into data used to decode the flag
    call val_4
    mov rcx, rax       ; Save the result of val_4 in rcx

    ;Enc_flag also uses rdi as the offset into data used to decode the flag
    call Enc_flag      ; Call Enc_flag with the same rdi value

    ; return value in rax
    sub rax, rcx       ; Subtract the result of val_4 (stored in rcx) from rax (Enc_flag result)

    ; Restore preserved registers
    pop rcx            ; Restore the original value of rcx
    pop rdi            ; Restore the original value of rdi

    ret                ; Return from the subroutine

   
   
   

;   current value of encrypted flag char is stored in rax
;   rdi contains the position of the letter in the flag
;   intermediate value is returned in rax
_Step2:
;#####################################################################
;   To solve the challenge modify this subroutine as follows:
;   Examine the registers changed by the subroutine and add or remove push/pop to
;   preserve the registers correctly.
;#####################################################################

   ; push rcx
   ; mov rdx, rax
    ; val_3 uses rdi as the offset into data used to decode the flag
   ; call val_3
   ; mov rcx, rax
   ; mov rax, rdx
   ; xor rax, rcx

   ; pop rdi
   ; ret


    ; Preserve the necessary registers
    push rcx           ; Preserve rcx as it will hold the result of val_3
    push rdi           ; Preserve rdi as it’s used as an offset/index

    mov rdx, rax       ; Store the initial value of rax in rdx

    ; val_3 uses rdi as the offset into data used to decode the flag
    call val_3         ; Call val_3, which returns a value in rax
    mov rcx, rax       ; Save the result of val_3 in rcx

    mov rax, rdx       ; Restore the original value of rax (initial input)
    xor rax, rcx       ; XOR rax with the result of val_3 (stored in rcx)

    ; Restore registers before returning
    pop rdi            ; Restore the original value of rdi
    pop rcx            ; Restore the original value of rcx

    ret                ; Return with the intermediate result in rax




;   rdi contains the position of the letter in the flag
;   intermediate value is returned in rax



_Step3:
;#####################################################################
;   To solve the challenge modify this subroutine as follows:
;   Examine the registers changed by the subroutine and add or remove push/pop to
;   preserve the registers correctly.
;#####################################################################

   ; push rcx
   ; mov rdx, rax
    ; val_2 uses rdi as the offset into data used to decode the flag
   ; call val_2
   ; mov rcx, rax
   ; mov rax, rdx
   ; sub rax, rcx
   ; ret

;   rdi contains the position of the letter in the flag
;   intermediate value is returned in rax



    ; Preserve the necessary registers
    push rcx            ; Preserve rcx since it's overwritten by the result of val_2
    push rdi            ; Preserve rdi as it is used as an index/offset, though not modified here
    push rdx            ; Preserve rdx as it is used to hold the original value of rax

    mov rdx, rax        ; Store the original value of rax in rdx

    ; val_2 uses rdi as the offset into data used to decode the flag
    call val_2          ; Call val_2, which returns a value in rax
    mov rcx, rax        ; Save the result of val_2 in rcx

    mov rax, rdx        ; Restore the original value of rax (from rdx)
    sub rax, rcx        ; Subtract the result of val_2 (stored in rcx) from the original value of rax

    ; Restore the preserved registers
    pop rdx             ; Restore rdx, which stored the original value of rax
    pop rdi             ; Restore rdi (not modified here, but it was pushed)
    pop rcx             ; Restore rcx, which stored the result of val_2

    ret                 ; Return with the intermediate result in rax



_Step4:
;#####################################################################
;   To solve the challenge modify this subroutine as follows:
;   Examine the registers changed by the subroutine and add or remove push/pop to
;   preserve the registers correctly.
;#####################################################################

  ;  push rcx
  ;  mov rdx, rax
    ; val_1 uses rdi as the offset into data used to decode the flag
  ;  call val_1
  ;  mov rcx, rax
  ;  mov rax, rdx
  ;  xor rax, rcx
  ;  pop rcx
  ;  pop rcx
  ;  ret


    ; Preserve necessary registers
    push rcx           ; Preserve rcx, as it will hold the result of val_1
    push rdi           ; Preserve rdi, which is used as an index

    mov rdx, rax       ; Store the initial value of rax in rdx

    ; val_1 uses rdi as the offset into data used to decode the flag
    call val_1         ; Call val_1, which returns a value in rax
    mov rcx, rax       ; Save the result of val_1 in rcx

    mov rax, rdx       ; Restore the original value of rax (initial input)
    xor rax, rcx       ; XOR rax with the result of val_1 (stored in rcx)

    ; Restore registers before returning
    pop rdi            ; Restore the original value of rdi
    pop rcx            ; Restore the original value of rcx

    ret                ; Return with the intermediate result in rax




_alldone:
    mov rax, 60     ; exit system call
    mov rdi, r9     ; return code saved in register r9
    syscall

; rax is the address of the string to write to stdout
; output - write string to stdout
_printString:
    push rax       ; note that rax is pushed twice
    push rdx
    push rcx
    push rbx
    push rax        ; save rax on the stack
    xor  rbx, rbx   ; rbx is the counter for the string length
    xor  rcx, rcx
_printStringLoop:
    inc rax
    inc rbx
    mov cl, [rax]
    cmp cl, 0h
    jne _printStringLoop

    ; system call to write to stdout
    mov rax, 1      ; sys_write system call
    mov rdi, 1      ; stdout (write to screen)
    pop rsi         ; memory location of string to write, pop rax off the stack directly to rsi
    mov rdx, rbx     ; number of characters in string to write
    syscall

    pop rbx
    pop rcx
    pop rdx
    pop rax
    ret
;   end _printString subroutine

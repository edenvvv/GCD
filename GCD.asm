data segment
n1 dw 37
n2 dw 14
data ends
;------------------------
sta segment stack
db 10 dup(?)
sta ends
;------------------------
code segment
assume ds:data,cs:code,ss:sta
start:  mov ax,data
        mov ds,ax
        ;-----29.05.2019-CW2----------------
        ;-----initializing------------------
        push ax
        push n1
        push n2
        call GCD
        pop ax
        mov ah,4ch
        int 21h   
        ;-----proc--------------------------
        GCD proc
            mov bp,sp
            mov ax,[bp+2] ;n2
            mov bx,[bp+4] ;n1
            cmp ax,bx
            ja L1
            xchg ax,bx
     L1:call mydiv
        mydiv proc
            xor dx,dx
         L4:cmp ax,bx
            jb L3
            sub ax,bx
            inc dx
            jmp L4
         L3:ret
            mydiv endp
        cmp ax,0
        je L2
        xchg ax,bx
        jmp L1
     L2:mov ax,bx
        ret 4                                                             
code ends
end start
                
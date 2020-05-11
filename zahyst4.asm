.model small
.386
 
.data
s1 db 53,0,53 dup(?)
s2 db 53*3 dup(?)
endlen db 10,13,'$'
 
.stack 100h
 
.code
start:
mov ax,@data
mov ds,ax
mov es,ax
 
mov ah,0Ah
lea dx,s1
int 21h
 
call endline
 
lea di,s2
lea bx,s1
inc bx
xor cx,cx
mov cl,byte ptr [bx]
sycle:
    inc bx
 
    mov al,byte ptr [bx]
    
    cmp al,' '
    jz nexstep
    
    mov byte ptr [di],al
    inc di
loop sycle
 
mov byte ptr [di],'$'
 
jmp show
 
nexstep:
    mov byte ptr [di],'.'
    inc di
   
loop sycle
 
show:
lea dx,s2
call printline
 
mov ah,01h
int 21h
 
mov ah,4Ch
mov al,00h
int 21h
    
printline proc
push ax
push bx
push dx
 
mov ah,09h
int 21h
 
pop dx
pop bx
pop ax
 
ret
printline endp
 
endline proc
push ax
push dx
 
mov ah,09h
lea dx,endlen
int 21h
 
pop dx
pop ax
 
ret
endline endp
end start
org 100h

mov dx, text
mov ah, 9
int 21h

xor ax, ax
int 16h

mov ah, 4Ch
int 21h

text db 'Hola Baby!', 0Dh, 0Ah, '$'

org 100h

main:
	mov ax, 0x13	; 320x200 @ 256 color mode
	int 10h 		; call BIOS interrupt

	mov ax, 0xA000	; pointer to screen buffer
	mov es, ax		; 
	xor di, di		; index 0

	xor ax, ax		; initialize ax to 0
	mov al, 40		; start with color 40 to avoid jmp
	xor bx, bx		; initialize bx to 0

loopy1:
	sub al, 40		; substract 40 from the color (see above)

loopy2:
	xor dx, dx		; initialize row to index 0

loopx:
	mov cx, 8		; initialize counter with 8
	rep stosb		; draw 8 pixels with the current color and inc di
	inc al			; increment color

	inc dx			; increment column index
	cmp dx, 40		; if didn't reach the end of row (320 / 8 = 40)
	jl loopx		; continue

	inc ah			; increment height
	cmp ah, 8		; if we didn't draw 8 pixels
	jl loopy1		; continue

	xor ah, ah		; reset height

	inc bx			; increment row index
	cmp bx, 25		; if we reached rows 25 then we are done
	jl loopy2		; start a new row

done:
	mov ax, 0		; get key hit function (will block)
	int 16h 		; call BIOS interrupt

	mov ax, 0x3		; 80x25 @ 16 color mode
	int 10h 		; call BIOS interrupt

	xor ax, ax		; exit ...
	int 20h 		; call BIOS interrupt

	ret				; fin

;
; Floppy Bird is a `clone` of the infamous Flappy Bird
; written in 16 bit (x86) assembly.
;
; Copyright (c) 2014-2017, Mihail Szabolcs
;
; Floppy Bird is provided **as-is** under the **MIT** license.
; For more information see LICENSE.
;
; How to play?
;
; Press <F9> to compile and run then <Space> to start and flap
; and <Q> to quit.
;
; Other useful editor keys:
;
; F4 - open
; F2 - save
; F9 - run (and compile)
; Alt + N - new
; Alt + X - close (or abort current operation)
;
org 100h
IMAGE_SIZE equ 32 * 1024

main:
	call set_vga_mode
	call randomize

.start:
	call new_highscore
	call center_bird

.intro:
	call animate_bird

	call draw_background
	call draw_ground
	call draw_flats
	call draw_bushes
	call draw_clouds
	call draw_bird
	call draw_highscore

	call vsync
	call flpscr

	mov dx, 2
	call sleep
	
	call kbhit

	test al, al
	jz .intro

	cmp al, 113		; q
	je .quit		; quit :P

	cmp al, 8		; backspace
	je .rndbg		; randomize background

	cmp al, 9		; tab
	je .rndbrd		; randomize bird

	call reset_pipes
	call randomize_pipes

	call reset_bird

.loop:
	call draw

	call update_bird
	jc .end

	call update_pipes
	call collide_pipe
	jc .end

	call vsync
	call flpscr

	mov dx, 1
	call sleep

	jmp .loop
	ret

.end:
	call draw

	call vsync
	call flpscr

	mov dx, 15
	call sleep

	jmp .start
	ret

.rndbg:
	call randomize_backgroundcolor
	jmp .intro
	ret

.rndbrd:
	call randomize_birdcolor
	jmp .intro
	ret

.quit:
	call set_text_mode
	ret

draw:
	call draw_background
	call draw_flats
	call draw_bushes
	call draw_clouds
	call draw_pipes
	call draw_bird
	call draw_score
	ret

; mixin sys and game
include 'sys\txt.asm'
include 'sys\tmr.asm'
include 'sys\rnd.asm'
include 'sys\snd.asm'
include 'sys\vga.asm'
include 'game\backgrnd.asm'
include 'game\score.asm'
include 'game\ground.asm'
include 'game\flats.asm'
include 'game\bushes.asm'
include 'game\clouds.asm'
include 'game\pipes.asm'
include 'game\bird.asm'
include 'game\data.asm'

times IMAGE_SIZE - ($ - $$) db 0 ; pad to IMAGE_SIZE

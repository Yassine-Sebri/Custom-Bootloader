bits 16
org 0x7c00

; Change background/foreground color
mov ah, 0x06 ; Clear/Scroll Screen Up 
mov al, 0x00 ; Number of lines by which to scroll up (0x00 = clear entire window)
mov cx, 0x0000 ; row, column of window's upper left corner
mov dx, 0x184f ; row, column of window's lower right corner
mov bh, 0x02 ; Background, foreground color (refer to BIOS color attributes)
int 0x10
mov si, art ; Moving the string to an index register 
mov ah, 0x0e

print:
    lodsb ; Load byte at address SI into al
    test al, al ; Check if al is 0
    jz end ; if al is 0 halt the program till the next interrupt
    int 0x10
    jmp print

end:
    hlt

art: db " _                _            _",13,10,"| |              | |          | |",13,10,"| |__   __ _  ___| | _____  __| |",13,10,"| '_ \ / _` |/ __| |/ / _ \/ _` |",13,10,"| | | | (_| | (__|   <  __/ (_| |",13,10,"|_| |_|\__,_|\___|_|\_\___|\__,_|",0

times 510 - ($ - $$) db 0
dw 0xaa55
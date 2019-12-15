;主引导程序
;------------------------------------------
SECTION MBR vstart=0x7c00
    mov ax,cs
    mov ds,ax
    mov es,ax
    mov ss,ax
    mov fs,ax
    mov sp,0x7c00

;清屏:0x06号功能，上卷全部行
;------------------------------------------
    mov ax, 0x600
    mov bx, 0x700
    mov cx, 0          ;左上角:(0,0)
    mov dx, 0x184f     ;右下角:(80,25)
    int 0x10

;获取光标位置
;------------------------------------------
    mov ah, 3
    mov bh, 0
    int 0x10           ;结果输出:ch=光标开始行,cl=光标结束行，
		       ;         dh=光标所在行,dl=光标所在列。

;打印字符串
;------------------------------------------
    mov ax, message
    mov bp, ax
    mov cx, 5
    mov ax, 0x1301
    mov bx, 0x2
    int 0x10

;死循环
    jmp $

    message db "1 MBR"
    times 510-($-$$) db 0
    db 0x55,0xaa


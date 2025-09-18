[bits 16]
[org 0x7C00]
mov [boot_drive],dl
kernel_loc equ 0x1000

entry:
  
  cli
  xor ax,ax
  mov ss,ax
  ;mov dx,ax 
  mov ds,ax
  mov es,ax
  mov bp,0x8000
  mov sp,bp
  sti

  mov bx,kernel_loc
  mov dh,20 
  ;mov [boot_drive],dl

  mov ah,0x02 
  mov al,dh 
  mov ch,0x00 
  mov cl,0x02 
  mov dh,0x00
  mov dl,[boot_drive]
  int 0x13
  jc L02

  mov si,L2 
  call print

  jmp kernel_loc

  jmp halt

L02:
  
  mov si,L1
  call print

  mov ax,0x2000
  mov dx,0x604
  out dx,ax
  sti

  jmp halt

print:

  lodsb
  or al,al
  jz .L0X
  mov ah,0x0E 
  int 0x10 
  jmp print 

.L0X:

  ret

halt:

  hlt 
  jmp halt



L1 db "[INFO] : error jmp sector",0x0D,0x0A,0
L2 db "[INFO] : success jmp sector",0x0D,0x0A,0
L3 db "[INFO] : search boot sector",0x0D,0x0A,0

boot_drive: db 0

times 510 - ($ - $$) db 0 
dw 0xAA55


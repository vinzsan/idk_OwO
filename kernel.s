[bits 16]
[org 0x1000]  

kernel_entry:

  ; cli
  ;
  ; mov ax,0x2000
  ; mov dx,0x604
  ; out dx,ax
  ; sti

  cli
  mov ax,0x1000
  mov ds,ax
  mov es,ax
  mov ss,ax
  mov bp,0x8000
  mov sp,bp
  sti

  mov ax,0x0003
  int 0x10

  mov ah,0x00 
  mov al,0x03 
  int 0x10

  mov si,L1
  call print

  mov al,'A'
  mov ah,0x0E 
  int 0x10

  jmp L01

L01:

  hlt
  jmp L01

print:

  lodsb
  or al,al
  jz L0X
  mov ah,0x0E 
  int 0x10 
  jmp print
  
L0X:
  
  ret

L1 db "[INFO] : sector 2 Hello world",0x0D,0x0A,0
;times 510 - ($ - $$) db 0 

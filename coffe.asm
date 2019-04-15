; multi-segment executable file template.

data segment
    ; add your data here!                                                 
    message db "Enter your choice:$"                                      
    message1 db "*********************************************************$"
    message2 db " 1.TEA-20 2.COFFEE-60 3.HOT CHOCOLATE-30 4.MILKSHAKE-40$" 
    message3 db "*********************************************************$"
    askqnt db "Enter quantity:$"
    askmoney db "Insert Money in the form of Rs.10, Rs.20, Rs.50$"
    qnt db ?
    money db ? 
    choice db ?
ends
macro neline  
    ;newline character
 mov dx, 10
 mov ah,2
 int 21h
 ;carriage return
 mov dx,13
 mov ah,2
 int 21h 
endm

macro printmsg p1
         lea dx, p1
         mov ah, 9
         int 21h
         neline
endm 
macro input p2
    mov ah, 1
  int 21h
  mov p2, al
  neline
 endm
 

code segment
start:
     include 'emu8086.inc'                    
     
; set segment registers:
  mov ax, data
  mov ds, ax
  mov es, ax
;asking for choice
            
 printmsg message 
 

;display items available
 
  printmsg message1
  printmsg message2
  printmsg message3
; taking input choice    
  input choice
;ask for quantity
  printmsg askqnt
 ; taking input quantity    
  input qnt
;ask to insert money
    printmsg askmoney
 ; taking input money   
  input money
   
  
 ;;   
 ;   mov ax, 4c00h ; exit to operating system.
   ; int 21h    
ends

end start ; set entry point and stop the assembler.

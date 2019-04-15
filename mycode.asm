; multi-segment executable file template.

data segment
    ; add your data here!                                                 
    message db "Enter your choice:$"                                      
    message1 db "*********************************************************$"
    message2 db " 1.TEA-20 2.COFFEE-60 3.HOT CHOCOLATE-30 4.MILKSHAKE-40$" 
    message3 db "*********************************************************$"
    printtea db "Heree is your tea$" 
    printcoffee db "here is your coffee$"
    printmilk db "here is your milk$"
    askqnt db "Enter quantity:$"
    askmoney db "Insert Money in the form of Rs.10, Rs.20, Rs.50$"
    qnt db ?
    money db ? 
    hello db "Thankyou for shopping$"
    choice db ?  
    mynumber1 db ?
    mynumber2 db ?
    
ends
macro newline  
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
         newline
endm 
macro input2 
print "Enter Denomination"
mov ah, 01h
int 21h
sub al,30h
mov bl, 0Ah
mul bl
mov mynumber1,al
mov ah, 01h     ;0011 1100
int 21h
sub al, 30h
add mynumber1,al

  newline 
  print "ENter notes and coins"
  mov ah, 01h
  int 21h
  sub al,30h
  mov bl,0Ah
  mul bl
  mov mynumber2, al
  mov ah, 01h
  int 21h
  sub al, 30h
  add mynumber2, al
  
endm
macro input p2
    mov ah, 1
    int 21h
    mov dl,al
    mov choice,dl
    newline
endm

macro multiply
    mov al, mynumber1
    mov bl, mynumber2
    mul bl
    
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
  
;taking input choice    
  input choice
  
 
  
                            
  cmp choice, 31h
  je tea
  
  cmp choice, 32h
  je coffee
  
  cmp choice, 33h
  je milk

  
  tea: 
  newline
  printmsg printtea
  newline
  jmp end1
  
  coffee:
  newline
  printmsg printcoffee
  newline
  jmp end1
  
  milk:
  newline
  printmsg printmilk
  newline
  jmp end1
            
 
                
  
  
  
  
 end1:
 ;ask for quantity
  printmsg askqnt
  
;taking input quantity    
  input qnt
  
  cmp choice, 31h
  je teaqt
  cmp choice, 32h
  je coffeeqt
  cmp choice, 33h
  je milkqt
  
  teaqt:
  mov al,dl
  sub al, 30h
  mov bl, 20
  mul bl
  jmp part3 
  
  coffeeqt:
  mov al,dl
  sub al, 30h
  mov bl, 60
  mul bl
  jmp part3
  
  milkqt:
  mov al,dl
  sub al, 30h
  mov bl, 30
  mul bl
  jmp part3
  
  part3:
  newline
  ;ask to insert money
  printmsg askmoney
    newline
  ;taking input money   
  input2 
  multiply
   
 ;   mov ax, 4c00h ; exit to operating system.
   ; int 21h    
ends

end start ; set entry point and stop the assembler.

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
macro input2 p2
    mov     ah, 1
int     21h           
mov     cl, 0Ah
sub     al, 30h
mul     cl
mov     bl, al
mov     ah, 1
int     21h     
sub     al, 30h
add     bl, al
mov p2, bl
  newline
endm
macro input p2
    mov ah, 1
    int 21h
    mov dl,al
    mov choice,dl
    newline
endm

macro amount
    cmp choice, 31h
    je teaa
    cmp choice, 32h
    je coffeea
    cmp choice, 33h
    je milka
   
   teaa:
   mov al, qnt
   mov cl, 20
   mul cl
   print "You have to pay: "
   jmp enda
   
   coffeea: 
   mov al, qnt
   mov cl, 60
   mul cl 
   jmp enda
   
   milka:
   mov al, qnt
   mov cl, 30
   mul cl
   jmp enda
   
   enda:
   hlt 
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
  
;ask for quantity
  printmsg askqnt
  
;taking input quantity    
  input qnt 
  
;ask to insert money
  printmsg askmoney
  
;taking input money   
  input2 money
                                           
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
 amount 
 printmsg hello   
 ;   mov ax, 4c00h ; exit to operating system.
   ; int 21h    
ends

end start ; set entry point and stop the assembler.

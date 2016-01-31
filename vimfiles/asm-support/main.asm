;  Author:         Anemone
;  Filename:       <FILENAME>
;  Last modified:  <DATE>
;  E-mail:         anemone@82flex.com

data segment
        ;input data segment code here
data ends

stack segment
        ;input stack segment code here
stack ends

code segment
    assume cs:code,ds:data,ss:stack
start:
    mov ax,data
    mov ds,ax
 <CURSOR>   
    mov ah,4ch
    int 21h
code ends
end start

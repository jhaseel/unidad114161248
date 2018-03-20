SYS_PRINT equ 4
STDOUT equ 1

section .data
;Mensajes
msg1		db		10,'  EXAMEN UNIDAD 1 Y 2',10,0
lmsg1		equ		$ - msg1

msg2		db		10,'  ecuancion : $$\int_02 (4+3x-3x2) \,dx$$',10,0
lmsg2		equ		$ - msg2

msg3		db		10,'  4(x) + 3 (x)²/2 - x³  limite 2,0   ',10,0
lmsg3		equ		$ - msg3

msg4		db		10,'  Resultado :   ',0
lmsg4		equ		$ - msg4

msg5		db		10,'',10,0
lmsg5		equ		$ - msg5
;operacion : 4(x) + 3 (x)²/2 - x³  limite 2,0


section .bss
;espacios de memoria
vala:       resb    2
valb:       resb    2
valc:       resb    2
temp:       resb    2
resSuperor  resb    2
resInferior resb    2
resultado:  resb    2


section .text

  global _start

_start:

;imprimir mensajes iniciales

 ;mensaje inicial
  mov eax,  SYS_PRINT
  mov ebx,  STDOUT
  mov ecx,  msg1
  mov edx, lmsg1
  int 80h

;mensaje ecuacion
  mov eax,  SYS_PRINT
  mov ebx,  STDOUT
  mov ecx,  msg2
  mov edx,  lmsg2
  int 80h

; mensaje Operacion
  mov eax,  SYS_PRINT
  mov ebx,  STDOUT
  mov ecx,  msg3
  mov edx,  lmsg3
  int 80h

 ;-------------------SECCION SUPEROR------------------------------------
;primera Operacion 4(x) cuando x vale 2
;se mueven los valorea a eax y ebx
  mov eax,   4
  mov ebx,   2
  ;Multiplicamos
  mul   ebx
  ;convertimos a ascii y movemos resultado a memoria
  mov [vala], eax


;segunda Operacion 3(x)²/2 cuando x vale 2
  mov eax,    2
  mul eax ;multiplica 2 por si miismo pare reprecentar 2²

;ahora multiplicamos por 3
  mov ebx,    3
  mul ebx

;ahora dividimos sobre dos
  mov ebx,    2
  div ebx

  mov [valb], eax

  ;tercera operacion x² cunado x vale 2

  mov eax,    2
  mov ebx,    2

  mul eax
  mul ebx
  mov [valc],eax

  ;optenemos resultado de limite superor vala + valb - valc

  mov eax,   [vala]
  mov ebx,   [valb]
  mov ecx,   [valc]

  add eax, ebx
  sub eax, ecx

	add eax, '0'
  mov [resSuperor], eax
;----------------------FIN SECCION SUPEROR----------------------------------


;-------------------------SECCCION INFERIOR---------------------------------

;primera Operacion 4(x) cuando x vale 0
;se mueven los valorea a eax y ebx
  mov eax,   4
  mov ebx,   0
  ;Multiplicamos
  mul   ebx
  ;convertimos a ascii y movemos resultado a memoria
  mov [vala], eax

;segunda Operacion 3(x)²/2 cuando x vale 0
	mov eax,    0
	mul eax ;multiplica 2 por si miismo pare reprecentar 2²

  ;ahora multiplicamos por 3
	mov ebx,    3
	mul ebx

;ahora dividimos sobre dos
  mov ebx,    2
  div ebx
  mov [valb], eax

;tercera operacion x² cunado x vale 0
 mov eax,    0
 mov ebx,    0

 mul eax
 mul ebx

 mov [vala], eax

 ;optenemos resultado de limite superor vala + valb - valc

 mov eax,   [vala]
 mov ebx,   [valb]
 mov ecx,   [valc]

 add eax, ebx
 sub eax, ecx

 add eax, '0'
 mov [resInferior], eax

;----------------------------FIN SECCION INFERIOR---------------------------

;---------------resultado---------------------
; resSuperor - resInferior
  mov eax,   [resSuperor]
  mov ebx,   [resInferior]

  sub eax, ebx

  add eax, '0'
  mov [resultado], eax



  ;extra
  ;imrimimos en pantalla vala

  mov eax, SYS_PRINT
  mov ebx, 1
  mov ecx, msg4
  mov edx, lmsg4
  int 80h

  mov eax, SYS_PRINT
	mov ebx, 1
	mov ecx, resultado
	mov edx, 1
	int 80h

  mov eax, SYS_PRINT
  mov ebx, 1
  mov ecx, msg5
  mov edx, 1
  int 80h


;finaliza programa
  mov eax,  1
  mov ebx,  0
  int 80h

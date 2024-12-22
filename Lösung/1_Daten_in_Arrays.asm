.data				#data section
N:	.word 10
n:	.word 6
	.align 5	
A:	.word 1,2,3,4,5,6,7,8,9,10

.text				#code section
.globl main
main:

lw	$s0, N			#Lade die maximale Arraygroesse	
lw	$s1, n			#Laden der Iterationsgenze
la	$s2 A			#Adresse des Arrays in a1 laden

loop:
beq	$t1, $s1, continue	#If t1 == s2 -> continue
lw	$t0, 0($s2)		#l�dt das zu pr�fende word
add	$v0, $v0, $t0		#addiert das word auf das R�ckgabe-Register
addi	$t1, $t1, 1		#erh�ht den Iterationsz�hler
addi	$s2, $s2, 4		#erh�ht die Adresse zum Auslesen des n�chsten Element
j	loop
continue:

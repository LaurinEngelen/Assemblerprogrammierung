.data				#data section
N:	.word 6
n:	.word 6
	.align 5		
A:	.word 3,4,6,8,11,13
	.align 5
B:	.word 0,0,0,0,0,0

.text				#code section
.globl main
main:

lw	$s0, n			#Lade die Iterationsgrenze
la	$s1, A			#Laden der Adresse des A-Array
la	$s2, B			#Ladne der Adresse des B-Array
jal	EVENELEM
move	$s3, $v0		#Sichert die Anzahl �bertragener Elemente
jal	end			#Springt zum Programmende

EVENELEM:
#-------------------------------R�cksprungadresse sichern
addi	$sp, $sp, -4		#Dekremiert den Stackpointer
sw	$ra, 0($sp)		#sichert die R�cksprungadresse ins Main
#-------------------------------Z�hler initalisieren
addi 	$t0, $t0, 0		#Initalisiert i mit 0
addi	$t1, $t1, 0		#Initalisiert j mit 0
#-------------------------------While Schleife
loop:
#blt	$s0, $t0, return	#while i < n [t1 < s0]/ bge: springt zu return wenn n < i
bge	$t0, $s0, return	#while i < n [t1 < s0]/ bge: springt zu return wenn i >= n
lw	$a0, 0($s1)		#�bergabeparameter: Element an i-ter Stelle im A-Array
jal	ISEVEN			#PROZEDURAUFRUF
#-------------------------------If-Abfrage
bne	$v0, 1, continue	#If v0 != 1 (v1 = ungerade) -> continue 	
	sw	$a0, 0($s2)		#Schreibt den Inhalt i A-Array in j B-Array
	addi	$t1, $t1, 1		#Erh�ht den �bertragungsz�hler j um 1
	addi	$s2, $s2, 4		#Erh�ht die Adresse des B-Array (++j)
#-------------------------------End-If
continue:
addi	$t0, $t0, 1		#Erh�ht Iterationsz�hler ++i
addi	$s1, $s1, 4		#Erh�ht die Adresse des A-Array
j	loop
#-------------------------------Prozedur beenden
return:
move 	$v0, $t1		#Schreibt die Anzahl an �bertragenen Elementen (t1 = j) ins R�ckgaberegister				
lw	$ra, 0($sp)		#L�dt die Stackpointeradresse
jr	$ra			#Springt zur�ck in die Zukunft 

ISEVEN:				#ISOOD R�ckgabe 1 = gerade / 0 = ungerade
andi	$v0, $a0, 1		#Pr�ft das letzte Bit der Zahl (ist bei geraden Zaheln immer 0)
xori	$v0, $v0,1		#Invertiert den R�ckgabewert (siehe Skript Kap. 2 S.2-15
jr	$ra			#Springt zur�ck in loop

end:
#HIER K�NNTE IHRE PRINTANWEISUNG STEHEN

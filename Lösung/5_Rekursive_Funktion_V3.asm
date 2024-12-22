.data				#data section
n:	.word 2
k:	.word 5

.text				#code section

.macro print_int($arg)
	move $a0, $arg
	addi	$v0, $zero, 1
	syscall 
.end_macro 

.globl main
main:

lw	$a0, k
lw	$a1, n

jal f
print_int($v0)
jal exit

f:
#-------------------------------Registerinhalte sichern
addi	$sp, $sp, -12		#Dekremiert den Stackpointer
sw	$ra, 8($sp)		#sichert die Rücksprungadresse ins Main
sw	$a0, 4($sp)		#sichert das Aufrufargument-k
sw	$a1, 0($sp)		#sichert das Aufrufargument-n
#-------------------------------If-Bedinung prüfen
sub	$t0, $a0, $a1		#t0 = n - k
addi	$t1, $zero, 7		#t1 = 7
slt 	$t1, $t1, $t0		#if 7 < n-k => true
bne	$t1, 0, else		#wenn 7 < n-k erfüllt, rekursion beenden
	add	$v0, $a1, $a0		#Summiert n + k (a1 + a0)
	addi	$v0, $v0, 5		#Addiert 5 auf n+k (n+k+5)
	addi	$sp, $sp, 12		#Erhöht den Stackpointer um 12 (nächster Bereich)
	jr	$ra			#Springt zurück zur Aufrufstelle
#-------------------------------Return wenn If erfüllt	
else:
jal G				#else: ruft die Funktion g(k) auf [g($a0)]
addi 	$a1, $zero, 8		#Schreibt die 8 in Übergabe für max(8,g(k))
move	$a0, $v0		#Schreibt den Rückgabewert der g(k) Funktion in Übergabe für max
jal max				#Aufruf Max-Funktion
move	$a0, $v0		#Schreibt den Rückgabewert der Max. Funktion in die Übergabe des rekrusiven Funktionsaufruf
lw	$a1, 0($sp)		#Liest den ursprünglich gesicherten n-Wert aus
addi	$a1, $a1, -1		#Dekerementiert den n-Wert und stellt in dem rekursiven Funktionsaufruf bereit
jal f				#Rekursiver Aufruf von f
#-------------------------------Return an Aufrufstelle (Main
lw	$a1, 0($sp)		#Lädt ursprünglichen n-Wert
lw	$a0, 4($sp)		#Lädt ursprünglichen k-Wert
lw	$ra, 8($sp)		#Lädt die Rücksprungadresse
addi	$sp, $sp, 12		#Erhöht den Stackpointer um 12 (nächster Bereich)
jr	$ra			#Springt zurück in die Zukunft 


#------------------- Funktion g(k) ------------------------------------------------------------------------------------------------------------------
# willkürliche Prozedur G (überschreibt alle "ungesicherten" Register mit dem Wert $a0+200, liefert auch $a0+200 zurück)
G:	addi $a0,$a0,200
	addi $a1,$a0,200
	addi $a2,$a0,200
	addi $a3,$a0,200
	addi $t0,$a0,200
	addi $t1,$a0,200
	addi $t2,$a0,200
	addi $t3,$a0,200
	addi $t4,$a0,200
	addi $t5,$a0,200
	addi $t6,$a0,200
	addi $t7,$a0,200
	addi $t8,$a0,200
	addi $t9,$a0,200
	addi $v0,$a0,200
	addi $v1,$a0,200
	jr $ra

#------------------- Funktion max -------------------------------------------------------------------------------------------------------------------
max: 	slt  $t1, $a1, $a0	#if 8 < g(k) => true (g(k) also > 8)
	beq  $t1, 1, retmax	#wenn g(k) größer als 8 dann Jump zu retmax
	move $v0, $a1		#else Gibt 8 als max zurück
	jr   $ra		#Springt zurück zum Methodenaufruf
retmax:	move $v0, $a0		#Gibt g(k) als max zurück
	jr   $ra		#Springt zurück zum Methodenaufruf

#------------------- Programm Ende ------------------------------------------------------------------------------------------------------------------
exit:
#Hier könnte Ihre Werbung stehen

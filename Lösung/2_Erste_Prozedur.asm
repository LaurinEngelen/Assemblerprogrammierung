.data				#data section

.text				#code section
.globl main
main:

addi	$s0, $zero, 4		#schreibt das Funktionsargument in das Argumenten Register (MOVE als Core Instruction)
move	$a0, $s0		#schreibt das �bergebene Argument zur bearbeitung in ein register (MOVE als Pseudo-Instruction)

jal	ISODD
move	$s1, $v0
jal	ISEVEN
move	$s2, $v0
jal	end

ISODD:				#ISOOD Returns 1 if X%2>0 (1 if x ungerade) and returns 0 if X%2=0 (0 if x gerade)
#-------------------------------Registerinhalte sichern
addi	$sp, $sp, -4		#setzt den Stack-Pointer eine Adresse weiter um Platz f�r die Variabel in $s0 zu schaffen
sw	$s0, 0($sp)		#schreibt (sichert) den Inhalt des Saved-Register $s0
#-------------------------------Prozeduranweisung
move	$s0, $a0		#schreibt die Argumenten-Register in Save-Register
andi	$s0, $s0, 1		#Pr�ft das letzte Bit der Zahl (ist bei geraden Zaheln immer 0),INFO: bewusst in s0 geschrieben um Sicherung/R�ckschreiben der Register sichtbar zu machen
move	$v0, $s0		#Schreiben des R�ckgabewert auf das Register s1
#-------------------------------Registerinhalte wiederhestellen
lw	$s0, 0($sp)		#Wiederherstellen des Speicherinhaltes in s0
addi	$sp, $sp, 4		#Anpssen des Stackpointer aus urspr�ngliche Adresse
jr	$ra			#Springt zur�ck zum Aufruf

ISEVEN:				#ISOOD Returns 0 if X%2>0 (0 if x ungerade) and returns 1 if X%2=0 (1 if x gerade)
#-------------------------------Registerinhalte sichern
addi	$sp, $sp, -4		#Dekremiert den Stackpointer
sw	$ra, 0($sp)		#sichert die R�cksprungadresse ins Main
#-------------------------------Aufruf ISOD
jal	ISODD
#-------------------------------R�cksprung ISOD
xori	$v0, $v0,1		#Invertiert den R�ckgabewert (siehe Skript Kap. 2 S.2-15
#-------------------------------Registerinhalte wiederhestellen	
lw	$ra, 0($sp)		#L�dt die Stackpointeradresse
jr	$ra			#Springt zur�ck ins Main

end:
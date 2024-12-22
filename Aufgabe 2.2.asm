.text
START:	
	li $a0, 2 #Argument für Prozeduren

	jal ISODD #ruft die Prozedur ISODD auf
	move $s1, $v0 #speichert den Ausgabewert der Prozedur von $v0 in $s1
	jal ISEVEN #ruft die Prozedur ISEVEN auf
	move $s2, $v0 #speichert den Ausgabewert der Prozedur von $v0 in $s2
	j END

ISODD:	andi $v0, $a0, 1 #Kontrolliert das letzte Bit ob 1 / 0 -> gerade / ungerade
	jr $ra #springt zurück zum Hauptprogramm
ISEVEN:
	add $sp, $sp, -4		#Reserviert Platz auf dem Stackpointer
	sw $ra, 0($sp)		#sichert die Rücksprungadresse ins Hauptprogramm
	jal ISODD #ruft die Prozedur ISODD auf
	nor $v0 $v0 $zero #Invertiert $v0
	andi $v0, $v0, 1 #Dreht alle Werte nochmal um, bis auf den letzten
	lw $ra, 0($sp)
	add $sp, $sp, 4		#Reserviert Platz auf dem Stackpointer
	jr $ra #springt zurück zum Hauptprogramm
END:

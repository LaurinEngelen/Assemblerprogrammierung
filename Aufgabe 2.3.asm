.data
array_a: .word 3, 4, 6, 8, 11, 13, 10
int_n : .word 7
array_b: .word 0, 0, 0, 0, 0, 0, 0

.text

	li $t0, 0 #i-Zähler
	li $t1, 0 #i-Index für array_a
	li $t4, 0 #j-Zähler (aka wie viele Gerade)
	li $t2, 0 #j-Index für array_b
	lw $t3, int_n

loop:
	beq  $t0, $t3, END #Solange der Zähler kleiner als int_n ist bleibt man in der Schleife
	lw $s0, array_a($t1) #Laden des Words im Array mit dem Index $t1
	move $a0, $s0 #Wert aus $t1 wird in auch in $a0 als Übergabeelement gespeichert
	
	jal ISEVEN #ruft die Prozedur ISEVEN auf
	move $s2, $v0 #speichert den Ausgabewert der Prozedur von $v0 in $s ($s2 = 1 wenn das Argument Gerade ist)
	
	beqz $s2, iCounterPlusOne #Branched wenn $s2=0 (aka ungerade)
	sw $s0, array_b($t2) #speichert $s0 in Array mit dem Index von $t2
	addi $t2, $t2, 4 #j-Index geht um eins hoch (aka 4 Bytes)
	addi $t4, $t4, 1 #j-Zähler plus 1
	j iCounterPlusOne
	
iCounterPlusOne:
	addi $t1, $t1, 4 #i-Index geht um eins hoch (aka 4 Bytes)
	addi $t0, $t0, 1 #i-Zähler plus 1
	j loop
	
ISODD:	
	andi $v0, $a0, 1 #Kontrolliert das letzte Bit ob 1 / 0 -> gerade / ungerade
	jr $ra #springt zurück zum Hauptprogramm
	
ISEVEN:
	add $sp, $sp, -4		#Reserviert Platz auf dem Stackpointer
	sw $ra, 0($sp)		#sichert die Rücksprungadresse ins Hauptprogram
	jal ISODD #ruft die Prozedur ISODD auf
	nor $v0 $v0 $zero #Invertiert $v0
	andi $v0, $v0, 1 #Dreht alle Werte nochmal um, bis auf den letzten
	lw $ra, 0($sp)
	add $sp, $sp, 4		#Reserviert Platz auf dem Stackpointer
	jr $ra #springt zurück zum Hauptprogramm
END:
	move $s3, $t4

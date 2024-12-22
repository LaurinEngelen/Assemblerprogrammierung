.data
array_a: .word 1, 2, 3, 4, 5, 6
int_n : .word 6
.text

la $s0, array_a #Speichert die erste Adresse des Arrays in $s0
addi $t1, $zero, 0
addi $v0, $zero, 0
lw $t2, int_n

loop:
	beq  $t0, $t2, continue #Solange der Zähler kleiner als int_n ist bleibt man in der Schleife
	lw $s1, array_a($t1) #Laden des Words im Array mit dem Index $t1
	addi $t1, $t1, 4 #Index geht um eins hoch (aka 4 Bytes)
	add  $v0,$v0,$s1 #Addiert den Wert von $s1 (aktuellen Arraywert) zu $v0 (Gesamtsumme)
	addi $t0, $t0, 1 #Zähler
	j loop
continue:

 

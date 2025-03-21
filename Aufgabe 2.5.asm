.data
int_k : .word 5
int_n : .word 5

.text
lw	$a0, int_k
lw	$a1, int_n

jal f
jal END

f:
	add $sp, $sp, -12	#Reserviert Platz auf dem Stackpointer
	sw $ra, 8($sp)		#sichert die R�cksprungadresse ins Hauptprogramm
	sw $a0, 4($sp)		#sichert das Aufrufargument-k
	sw $a1, 0($sp)		#sichert das Aufrufargument-n

	sub $t0, $a0, $a1	#$t0 = k-n
	addi $t1, $zero, 7	#$t1 = 7
	slt $t2, $t1, $t0	#wenn (k-n > 7) dann $t2 = 1
	beq $t2, $zero, else	#wenn $t2 = 1 -> rekursion beendet, $t2 = 0 -> else
	add $v0, $a0, $a1	#$v0 = k+n
	addi $v0, $v0, 5		#$v0 = $v0+5
	addi $sp, $sp, 12	#Erh�ht den Stackpointer um 12 (gibt Platz frei)
	jr $ra	

else:
	jal G
	addi $a0, $zero, 8	#$a0 = 8 (Argument0 f�r max)
	move $a1, $v0		#$v0 (Returnwert aus g(k)) wird in $a1 geschrieben
	jal max
	move $a0, $v0		#$a1 = R�ckgabewert aus max(8, g(k))
	lw $a1, 0($sp)		#Speichern von n aus Stackpointer in $t0
	addi $a1, $a1, -1		#$a0 = $t0(n) -1		
	jal f			#Rekursionsaufruf von f
	
	lw $a1, 0($sp)		#L�dt urspr�nglichen n-Wert
	lw $a0, 4($sp)		#L�dt urspr�nglichen k-Wert
	lw $ra, 8($sp)		#L�dt die R�cksprungadresse
	addi $sp, $sp, 12	#Gibt Platz auf Stackpointer frei
	jr $ra

max:
	slt $t0, $a0, $a1	#wenn $a0 (8) kleiner ist als $a1 (g(k)), dann $t0 = 1
	bne $t0, $zero, biggerThanEight #wenn $t0 = 0 -> 8 ist  Gr��er, else $t0 = 1 -> biggerThanEight
	move $v0, $a0
	jr $ra
	
biggerThanEight:
	move $v1, $a1
	jr $ra

G:	
	addi $a0,$a0,100
	addi $a1,$a0,100
	addi $a2,$a0,100
	addi $a3,$a0,100
	addi $t0,$a0,100
	addi $t1,$a0,100
	addi $t2,$a0,100
	addi $t3,$a0,100
	addi $t4,$a0,100
	addi $t5,$a0,100
	addi $t6,$a0,100
	addi $t7,$a0,100
	addi $t8,$a0,100
	addi $t9,$a0,100
	addi $v0,$a0,100
	addi $v1,$a0,100
	jr $ra

END:

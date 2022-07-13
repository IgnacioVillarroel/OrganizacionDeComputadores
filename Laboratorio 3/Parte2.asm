# Parte 3
# Autor: Ignacio Villarroel
# Versi�n: 1.0
# Fecha: 26/07/2021
#Programa que se encarga de calcular N-�simo termino de la sucesi�n de fibonacci mediante la Memoizaci�n
.data
	#VALOR A CAMBIAR
	tama�o: .word 8 # Variar el tama�o de calcular� el el N-�simo t�rmino
	
	#Se crea un espacio 
	lista: .space 100

.text
	#se inicializa el arreglo que contendr� los datos por direccionamiento de memoria.
	lw $s0, tama�o
	la $s1, lista
	#Se crea un contador que permitir� ir a�adiendo t�rminos a la memoria.
	li $a0, 0 
	jal memoria
	add $a0, $zero, $s0
	jal fibonacci
	add $a0, $zero, $v0
	li $v0, 1
	syscall
	jal exit

#Subrutina de memorizaci�n, que por recursi�n ir� a�adiendo los n�meros hasta que el contador iguale al Tama�o. 	
memoria:
	li $t0,0
	beq $s0, $a0, finMemoria
	sw $t0, ($s1)
	addi $a0, $a0, 1
	j memoria

#Se hace el salto incondicional 
finMemoria:
	jr $ra

#Se realiza el proceso de memoizaci�n por subrutinas.
memoizacion:
	add $t4, $zero, $a0
	#Se realiza la multiplicaci�n sin cosas designadas en un principio, esto pues se necesitar� mas adelante.
	mulu $t5, $t4, 4
	subi $t5, $t5, 4
	add $s1, $s1, $t5
	#Se van cargando los datos al arreglo.
	lw $t7, ($s1)
	sub $s1, $s1, $t5
	beq $t7, 0, memF
	add $v0, $zero, $t7
	li $v1, 1
	jr $ra
#Se finaliza el proceso para cargar los datos.
memF:
	li $v0, 0
	li $v1, 0
	jr $ra

#Se realiza el Funci�n para el c�lculo de Fibonacci en base a lo hecho en la Parte 2, se hacen ajustes para que la lista "array"
#pueda ajustarse, ya que los datos se deben ir sacando del arreglo para ejecutarlos.

fibonacci:
	#Se ve en primer lugar si el t�rmino solicitaod corresponde a 0 o 1.
	add $t0, $zero, $a0
	blez $t0, resultado0
	beq $t0, 1, resultado1
	#Se comienzan a guardar los t�rminos que se van procesando en la memoria.
	addi $sp, $sp, -12
	sw $ra, 0($sp)
	sw $t0, 4($sp)
	sw $t1, 8($sp)
	#Se llama a la subrutina de memoizaci�n con la Indicaci�n de optimizar el proceso.
	jal memoizacion
	beq $v1, 1, resultado
	subi $a0, $t0, 1
	jal fibonacci #fibonacci(n-1) 
	add $t1, $zero, $v0
	lw $t0, 4($sp)
	subi $a0, $t0, 2
	sw $t0, 4($sp)
	sw $t1, 8($sp)
	jal fibonacci  #Fibonacci(n-2)
	add $t2, $zero, $v0
	lw $ra, 0($sp)
	lw $t0, 4($sp)
	lw $t1, 8($sp)
	# Se distribuyen una asignaci�n para cada t�rmino el cual ser� calculado.
	mulu $t3, $t0, 4
	subi $t3, $t3, 4
	add $s1, $s1, $t3
	add $v0, $t1, $t2
	sw $v0, ($s1)
	sub $s1, $s1, $t3
	addi $sp, $sp, 12
	jr $ra

#Cuando el valor llega a 0
resultado0: 
	add $v0, $zero, $zero
	jr $ra
#Cuando el valor llega a 1
resultado1:
	addi $v0, $zero, 1
	jr $ra
#Despu�s del c�lculo se Cargan el dato obtenido.
resultado:
	lw $ra, 0($sp)
	lw $t0, 4($sp)
	lw $t1, 8($sp)
# Se libera el espacio en la memoria.
	addi $sp, $sp, 12
	jr $ra
exit:
	li $v0, 10
	syscall

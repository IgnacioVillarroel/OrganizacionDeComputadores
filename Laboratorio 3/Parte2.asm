# Parte 3
# Autor: Ignacio Villarroel
# Versión: 1.0
# Fecha: 26/07/2021
#Programa que se encarga de calcular N-ésimo termino de la sucesión de fibonacci mediante la Memoización
.data
	#VALOR A CAMBIAR
	tamaño: .word 8 # Variar el tamaño de calculará el el N-ésimo término
	
	#Se crea un espacio 
	lista: .space 100

.text
	#se inicializa el arreglo que contendrá los datos por direccionamiento de memoria.
	lw $s0, tamaño
	la $s1, lista
	#Se crea un contador que permitirá ir añadiendo términos a la memoria.
	li $a0, 0 
	jal memoria
	add $a0, $zero, $s0
	jal fibonacci
	add $a0, $zero, $v0
	li $v0, 1
	syscall
	jal exit

#Subrutina de memorización, que por recursión irá añadiendo los números hasta que el contador iguale al Tamaño. 	
memoria:
	li $t0,0
	beq $s0, $a0, finMemoria
	sw $t0, ($s1)
	addi $a0, $a0, 1
	j memoria

#Se hace el salto incondicional 
finMemoria:
	jr $ra

#Se realiza el proceso de memoización por subrutinas.
memoizacion:
	add $t4, $zero, $a0
	#Se realiza la multiplicación sin cosas designadas en un principio, esto pues se necesitará mas adelante.
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

#Se realiza el Función para el cálculo de Fibonacci en base a lo hecho en la Parte 2, se hacen ajustes para que la lista "array"
#pueda ajustarse, ya que los datos se deben ir sacando del arreglo para ejecutarlos.

fibonacci:
	#Se ve en primer lugar si el término solicitaod corresponde a 0 o 1.
	add $t0, $zero, $a0
	blez $t0, resultado0
	beq $t0, 1, resultado1
	#Se comienzan a guardar los términos que se van procesando en la memoria.
	addi $sp, $sp, -12
	sw $ra, 0($sp)
	sw $t0, 4($sp)
	sw $t1, 8($sp)
	#Se llama a la subrutina de memoización con la Indicación de optimizar el proceso.
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
	# Se distribuyen una asignación para cada término el cual será calculado.
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
#Después del cálculo se Cargan el dato obtenido.
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

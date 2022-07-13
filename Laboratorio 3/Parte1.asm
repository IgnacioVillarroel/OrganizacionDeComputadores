# Parte 3
# Autor: Ignacio Villarroel
# Versión: 1.0
# Fecha: 20/07/2021
#Programa que calcula un elemento N-ésimo de la secuencia de Fibonacci mediante Recursión, 
#se basa en la utilización de Stacks.
#Vale decir que comienza desde la Posición 0.

.data
	mensaje1:.asciiz "Ingresa posición a encontrar:"
.text
	#Se solicita ingresar un número.
	li $v0,4
	la $a0,mensaje1
	syscall
	
	#Se lee el número ingresado y se pasa a #a0
	li $v0,5
	syscall
	add $a0,$v0,$zero
	
	#Salto a la función de "Fibonacci
	jal fibonacci 
	
	add $a0,$v0,$zero
	li $v0,1
	syscall

	li $v0,10
	syscall

fibonacci:
#Se comienza a llenar a guardar en el Stack los elementos a necesitar.

	addi $sp,$sp,-12      #se guarda en el stack.
	sw $ra,0($sp)	      # Dirección de memoria
	sw $s0,4($sp)
	sw $s1,8($sp)
	add $s0,$a0,$zero
	addi $t1,$zero,1
	beq $s0,$zero,resultado0  
	beq $s0,$t1,resultado1
	addi $a0,$s0,-1
	jal fibonacci         #fibonacci(n-1)
	add $s1,$zero,$v0     
	addi $a0,$s0,-2
	jal fibonacci         #fibonacci(n-2)
	add $v0,$v0,$s1       
	
exitfib:
	#Para finalizar se leen los registros desde los stacks
	lw $ra,0($sp)
	lw $s0,4($sp)
	lw $s1,8($sp)
	addi $sp,$sp,12       #Se vuelve a dejar como estaba el stack 
	jr $ra

#Para cuando el número es 0
resultado0 :     
	li $v0,0
 	j exitfib
#Para cuando el número es 1
resultado1:
	li $v0,1
	j exitfib

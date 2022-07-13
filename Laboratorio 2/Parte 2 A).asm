# Parte 2
# Autor: Ignacio Villarroel
# Versi�n: 1.0
# Fecha: 18/05/2021
# Programa que realizar� la multiplicaci�n de 2 n�meros sin usar la multiplicaci�n como tal. El RESULTADO FINAL de toda multiplicaci�n 
# ser� mostrada en el registro $s0.
#------------------------------------------------------------------------------------------------------
# Se a�aden los n�meros en los registros a usar
# Los registros "$s1" y "$s2" representan a los factores de la multiplicaci�n, el usuario puede cambiarlos a gusto.
addi $s1, $zero, 12
addi $s2, $zero, 3
#-------------------------------------------------------------------------------------------------------
# Para los n�meros negativos hay que tener lo contenido en $s2 como positivo siempre, para luego traspasarlo a negativo al resultado final.
bgez $s2, condicional # Va a la etiqueta cuando el n�mero es positvo
bltz $s1, dosNegativos # Va a la etiqueta cuando el n�mero es negativo

# Se intercambia la posici�n de los n�meros para la ejecuci�n de la multiplicaci�n
move $t1, $s2
move $t2, $s1
move $s1, $t1
move $s2, $t2

condicional: # Se crea la recursi�n mediante un condicional.
	# Se utiliza el registro "$s3" como un acumulador que ir� sumando 1 cada vez que pase por sumador partiendo del 0.
	bne $s2, $s3, sumador1
	# Si llegan a ser igual, termina el programa.
	j exit

sumador1: # Se hace la suma de lo acumulado en "$s0" hasta que "$s3" deje de ser menor que "$s2".
	add $s0, $s0, $s1
	add $s3, $s3, 1
	# Vuelve a llamar la condic�n inicial.
	j condicional

# Ac� se har� una muestra de multiplicaci�n diferente, puesto que no la estructuras anteriores no sirven para la implementaci�n para cuando
# son 2 n�meros negativos
dosNegativos:
	bne $s2, $s3, sumador2
	move $s4, $s0
	j pasarApositivo
	
sumador2:
	add $s0, $s0, $s1
	add $s3, $s3, -1
	j dosNegativos

pasarApositivo:
	bltz $s4, positividad
	j exit
		
positividad:
	add $s0, $s0, 2
	add $s4, $s4, 1
	j pasarApositivo


exit:

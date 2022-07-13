# Parte 2
# Autor: Ignacio Villarroel
# Versión: 1.0
# Fecha: 18/05/2021
# Programa que realizará la multiplicación de 2 números sin usar la multiplicación como tal. El RESULTADO FINAL de toda multiplicación 
# será mostrada en el registro $s0.
#------------------------------------------------------------------------------------------------------
# Se añaden los números en los registros a usar
# Los registros "$s1" y "$s2" representan a los factores de la multiplicación, el usuario puede cambiarlos a gusto.
addi $s1, $zero, 12
addi $s2, $zero, 3
#-------------------------------------------------------------------------------------------------------
# Para los números negativos hay que tener lo contenido en $s2 como positivo siempre, para luego traspasarlo a negativo al resultado final.
bgez $s2, condicional # Va a la etiqueta cuando el número es positvo
bltz $s1, dosNegativos # Va a la etiqueta cuando el número es negativo

# Se intercambia la posición de los números para la ejecución de la multiplicación
move $t1, $s2
move $t2, $s1
move $s1, $t1
move $s2, $t2

condicional: # Se crea la recursión mediante un condicional.
	# Se utiliza el registro "$s3" como un acumulador que irá sumando 1 cada vez que pase por sumador partiendo del 0.
	bne $s2, $s3, sumador1
	# Si llegan a ser igual, termina el programa.
	j exit

sumador1: # Se hace la suma de lo acumulado en "$s0" hasta que "$s3" deje de ser menor que "$s2".
	add $s0, $s0, $s1
	add $s3, $s3, 1
	# Vuelve a llamar la condicón inicial.
	j condicional

# Acá se hará una muestra de multiplicación diferente, puesto que no la estructuras anteriores no sirven para la implementación para cuando
# son 2 números negativos
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

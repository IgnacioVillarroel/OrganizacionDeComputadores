# Parte 2 B)
# Autor: Ignacio Villarroel
# Versión: 1.0
# Fecha: 18/05/2021
# Programa que calculará el factorial de un número entero. Es importante destacar que se utilizó la parte de la multiplicación de la parte 2a) 
# para números positivos, ya que el factorial solo es para números enteros mayores que cero (0).
#EL RESULTADO SE VERÁ REFLEJADO EN EL REGISTRO $s1

# Se elige el número factorial a calcular, solamente debe cambiar el valor de $s1.
addi $s1, $zero, 5
# Para el proceso de multiplicación se le restará el número antecesor al colocado y se guardará en $s2
addi $s2, $s1, -1
# Se harán excepciones con respecto al cálculo de factoriales para los factoriales de 0 y 1

# En primer lugar cuando el número es negativo no tiene factorial. Por lo que se hace incapié en eso. 
bltz $s1, exit
# Si el número solicitado es 0, no se harán cálculos puesto que se sabe de por si el resultado de este manualmente.
beq $s1, 0, factorialcomun
beq $s1, 1, factorialcomun

condicional: # Se crea la recursión mediante un condicional.
	
	# Se utiliza el registro "$s3" como un acumulador que irá sumando 1 cada vez que pase por sumador partiendo del 0.
	bne $s2, $s3, sumador
	# Si llegan a ser iguales, se llamará al regulador que moverá todas las piezas para repetir el proceso de multiplicación
	j regulador

sumador: # Se hace la suma de lo acumulado en "$s0" hasta que "$s3" deje de ser menor que "$s2".
	add $s0, $s0, $s1
	add $s3, $s3, 1
	# Vuelve a llamar la condicón inicial.
	j condicional

# Lo que permitirá este proceso es repetir el proceso anterior o si el segundo número que multiplica ("$s2") llega a 0, lo que significaría
# que ya no hay nada que multiplicar.

regulador:
	move $s1, $s0
	addi $s0, $zero, 0
	add $s2, $s2, -1
	addi $s3, $zero , 0
	beqz $s2, exit 
	j condicional

#Se utiliza cuando se pregunta el factorial es uno (1) o cero (0).
factorialcomun:
	addi $s1, $zero, 1
#EL RESULTADO FINAL ESTÁ GUARDADO EN EL REGISTRO: "$s1".
exit:

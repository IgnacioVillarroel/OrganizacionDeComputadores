# Parte 2 B)
# Autor: Ignacio Villarroel
# Versi�n: 1.0
# Fecha: 18/05/2021
# Programa que calcular� el factorial de un n�mero entero. Es importante destacar que se utiliz� la parte de la multiplicaci�n de la parte 2a) 
# para n�meros positivos, ya que el factorial solo es para n�meros enteros mayores que cero (0).
#EL RESULTADO SE VER� REFLEJADO EN EL REGISTRO $s1

# Se elige el n�mero factorial a calcular, solamente debe cambiar el valor de $s1.
addi $s1, $zero, 5
# Para el proceso de multiplicaci�n se le restar� el n�mero antecesor al colocado y se guardar� en $s2
addi $s2, $s1, -1
# Se har�n excepciones con respecto al c�lculo de factoriales para los factoriales de 0 y 1

# En primer lugar cuando el n�mero es negativo no tiene factorial. Por lo que se hace incapi� en eso. 
bltz $s1, exit
# Si el n�mero solicitado es 0, no se har�n c�lculos puesto que se sabe de por si el resultado de este manualmente.
beq $s1, 0, factorialcomun
beq $s1, 1, factorialcomun

condicional: # Se crea la recursi�n mediante un condicional.
	
	# Se utiliza el registro "$s3" como un acumulador que ir� sumando 1 cada vez que pase por sumador partiendo del 0.
	bne $s2, $s3, sumador
	# Si llegan a ser iguales, se llamar� al regulador que mover� todas las piezas para repetir el proceso de multiplicaci�n
	j regulador

sumador: # Se hace la suma de lo acumulado en "$s0" hasta que "$s3" deje de ser menor que "$s2".
	add $s0, $s0, $s1
	add $s3, $s3, 1
	# Vuelve a llamar la condic�n inicial.
	j condicional

# Lo que permitir� este proceso es repetir el proceso anterior o si el segundo n�mero que multiplica ("$s2") llega a 0, lo que significar�a
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
#EL RESULTADO FINAL EST� GUARDADO EN EL REGISTRO: "$s1".
exit:

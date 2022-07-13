# Parte 2 C)
# Autor: Ignacio Villarroel
# Versión: 1.0
# Fecha: 28/05/2021 Finalización
# Este programa realizará la división a partir de sumas y restas entre dos números enteros 
#EL RESULTADO FINAL ESTARÁ EN EL REGISTRO "$f0"

.data
	# Acá están los números auxiliares
	numero0: .double 1.00
	numero1: .double 0.10
	numero2: .double 0.01
	numero3: .double 2.00
	numero4: .double 0.20
	numero5: .double 0.02
	

.text

ldc1 $f4, numero0
ldc1 $f6, numero1
ldc1 $f8, numero2
#-----------------------------------------------------------------------------------------
# VALORES A MODIFICAR
addi $s1, $zero, -521     #DIVIDENDO
addi $s2, $zero, 4        #DIVISOR
#-----------------------------------------------------------------------------------------
addi $s3, $zero, 10

# Si el divisor es 0, no existe por lo que termina el programa inmediatamente.
beqz $s2, exit

# Comprueba que ambos números deben estar en formato POSITIVO para que pueda dividirte 
rectificador:
	bltz $s1, movedorS1
	bltz $s2, movedorS2

# Aca se inicia el proceso de la división para la generación del número ENTERO.
Enteros:
# Se comparará si el divisor es menor o igual al dividendo
	ble  $s2, $s1, divisorEnteros
	bnez $s1, multiDecimal #Se ve el "resto" de la división, si no es 0, es porque va a tener decimal.
	j comparadorS1
	
# Función que sumará 1.0 al registro $f0 por cada vez el divisor sea menor que el dividendo
divisorEnteros:
	add.d $f0, $f0, $f4
	sub $s1, $s1, $s2
	add $t3, $t3, 1
	j Enteros
#------------------------------------------------------------------------------------------
# MULTIPLICADOR, el resto obtenido se somete a una multiplicación x 10.
multiDecimal:
	bne $s3, $s4, sumMult1
	j Decimal
	#Hasta acá está correcto
	#Ahora el resultado que está en $s5 lo divido.
		
sumMult1:
	#Multiplicar lo que está en $s1 con $s3 y el resultado queda en $s5
	add $s5, $s5, $s1
	add $s4, $s4, 1
	j multiDecimal
#-----------------------------------------------------------------------------------------
# Aca se inicia el proceso de la división para la generación del número DECIMAL.
Decimal:
	ble $s2, $s5, divisorDecimal
	bnez $s5, multiCentesimal
	j comparadorS1

# Se añadirá al resultado final 0.1 por cada vez que se repita el proceso.
divisorDecimal:
	add.d $f0, $f0, $f6
	sub $s5, $s5, $s2
	add $t4, $t4, 1
	j Decimal
#-----------------------------------------------------------------------------------------
# MULTIPLICADOR, el resto obtenido se somete a una multiplicación x 10.
multiCentesimal:
	bne $s3, $s6, sumMult2
	# J a la division centesimal
	j Centesimal

sumMult2:
	add $s7, $s7, $s5
	add $s6, $s6, 1
	j multiCentesimal
	
#----------------------------------------------------------------------------------------
# Aca se inicia el proceso de la división para la generación del número CENTESIMAL.	
Centesimal:
	ble $s2, $s7, divisorCentesimal
	j comparadorS1
	
divisorCentesimal:
	add.d $f0, $f0, $f8
	sub $s7, $s7, $s2
	add $t5, $t5, 1
	j Centesimal
	
#-----------------------------------------------------------------------------------------
#SUBRUTINAS AUXILIARES.

# Se crea para generar copias del dividendo si es que es negativo.
movedorS1:
	move $t1, $s1
	move $s4, $s1
# Se pasa a positivo el dividendo para la implementación del división
transformadorS1:
	add $s1, $s1, 2
	add $s4, $s4, 1
	beqz $s4, rectificador #Se devuelve para comprobar que es positivo.
	j transformadorS1

# Se crea para generar copias del divisor si es que es negativo.
movedorS2:
	move $t2, $s2
	move $s5, $s2

# Se pasa a positivo el divisor para la implementación de la división 
transformadorS2:
	add $s2, $s2, 2
	add, $s5, $s5, 1
	beqz $s5, rectificador #Se devuelve para comprobar que es positivo.
	j transformadorS2

#------------------------------------------------------------------------------------------

#FASE FINAL
#Se comprueba para las copias creadas de los números iniciales.
#Viendo si son positivas o negativas para la creación del resultado final
comparadorS1:
	bltz $t1, comparadorS2
	# Se veo si pasa, ahora veo si el dividendo es negativo
	bltz $t2, pasadorAnegativo #Si va a la etiqueta desde acá significa que el divisor 
	j exit

#Se ve que el divisor proveniente de que si el dividendo 
comparadorS2:
	bltz $t2, exit
	j pasadorAnegativo

#Se carga la segunda serie de números, para la formación de los números negativos.
pasadorAnegativo:
	ldc1 $f4, numero3
	ldc1 $f6, numero4
	ldc1 $f8, numero5
	
#--------------------------------------------------------------------------------------------------------
#CAMBIADORES DE SIGNO.
#Crea una recursividad de la cantidad de iteraciones guardadas en $t3, hasta que sea 0, mientras no lo sea, resta 2.0 al registro $f0
negativoEntero:
	beqz  $t3, negativoDecimal
	sub.d $f0, $f0, $f4
	sub $t3, $t3, 1
	j negativoEntero
	
#Crea una recursividad de la cantidad de iteraciones guardadas en $t4, hasta que sea 0, mientras no lo sea, resta 0.2 al registro $f0
negativoDecimal:
	beqz $t4, negativoCentesimal
	sub.d $f0, $f0, $f6
	sub $t4, $t4, 1
	j negativoDecimal

#Crea una recursividad de la cantidad de iteraciones guardadas en $t3, hasta que sea 0, mientras no lo sea, resta 0.02 al registro $f0
negativoCentesimal:
	beqz $t5, exit
	sub.d $f0, $f0, $f8
	sub $t5, $t5, 1
	j negativoDecimal

exit:

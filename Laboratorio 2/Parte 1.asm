# Parte 1
# Autor Ignacio Villarroel E.
# Versión. 1.0
# Fecha: 15/12/2021
#Programa que se encargará de llamar a 2 números y obtener su diferencia, además encontrar si el número obtenido es par o impar y mostrarlo por pantalla
.data
     mensaje1:  .asciiz "Introduce un número entero: "
     mensaje2:  .asciiz "Introduce otro número entero "
     mensaje3:  .asciiz "La diferencia es: "
     mensaje4:  .asciiz " (par)"
     mensaje5:  .asciiz " (impar)"
.text
	
        # Se llama a pedir el primer número
	li $v0, 4
       	la $a0, mensaje1
       	syscall

        # Solicitar al usuario que introduzca un entero. El entero se almacenará en el registro $v0
       	li $v0, 5
       	syscall

        # Movemos el contenido del registro $v0 a un registro temporal $t0
       	move $t0, $v0

        # Mostrar mensaje que solicita introducir el segundo entero
       	li $v0, 4
       	la $a0, mensaje2
       	syscall

        # Solicitar al usuario que introduzca otro entero. El entero se almacenará en el registro $v0
       	li $v0, 5
       	syscall
       	# Movemos el contenido del registro $v0 a un registro temporal $t1
       	move $t1, $v0
       	#Se guarda un en el registro $t4 para ver si es par o impar.
  	li $t4, 2
    
#Se crea la subrutina que será el encargado de ver el número mayor y enviar los datos a una siguiente sub rutina.
comparador:
    	#Acá se ve si lo que está en $t0 es mayor o igual a lo que está en $t1
    	bge $t0, $t1, L2
    	
    	#Acá se ve si lo que está en $t1 es mayor a lo que está en $t0
    	bgt $t1, $t0, L3
    	
	L2: 
		# Si lo que está en $t0 es mayor a $t1, se restan.
		sub $t2, $t0, $t1
		# Se divide el resultado por 2
		div $t2, $t4
		mfhi $t3
		#Se pone por pantalla el mensaje para colocar el resultado.
		li $v0, 4
		la $a0, mensaje3
		syscall
		#Se llama al resultado contenido de la diferencia y se muestra por pantalla.
		li $v0, 1
		la $a0, ($t2)
		syscall
		# Se ve si es par o impar con lo contenido en la division de $t3
		beq $t3, 0, par
		j impar
		j exit

	L3: 
		# Si lo que está en $t1 es mayor a t0, se restan en ese orden.
		sub $t2, $t1, $t0
		# Se divide el resultado por 2
		div $t2, $t4
		mfhi $t3
		#Se pone por pantalla el mensaje para colocar el resultado.
		li $v0, 4
		la $a0, mensaje3
		#Se llama al resultado contenido de la diferencia y se muestra por pantalla.
		syscall
		li $v0, 1
		la $a0, ($t2)
		syscall
		# Se ve si es par o impar con lo contenido en la division de $t3
		beq $t3, 0, par
		#Si no es par, va a impar.
		j impar
		j exit
		
	par: 
		li $v0, 4
		la $a0, mensaje4
		syscall
		j exit
	
	impar:
		li $v0, 4
		la $a0, mensaje5
		syscall
		
		
#TERMINA EL PROGRAMA
 exit:

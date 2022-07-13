#Se guardarán las variables representada por "x" e "y" del ejercicio.
add $t3, $zero, 1
add $t4, $zero, -1
add $t5, $t3, $t4
#Ahora si se quieren comparar ambos si el primer valor es 0.
beqz $t5, L # Si se cumple que lo que hay en $t5 es 0, por lo que te manda a L
	L: add $t4, $t4, 1
	j exit
beq $t5, $t3, R # Si cumple que lo que hay en $t3 es x = 1, es decir que si cumpliría por lo que te manda a R
	R: add $t4, $t4, -1
	j exit
# Si no se cumple ninguna de las 2.
addi $t4, $zero, 100
exit : 
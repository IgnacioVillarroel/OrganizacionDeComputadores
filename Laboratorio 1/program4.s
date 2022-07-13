#Se colocan las variables.
addi $t6, $zero, 2
addi $t7, $zero, 10
addi $t0, $zero, 0
#Se coloca el while iniciando el "loop" con la ayuda del condicional "si es mayor" (bgt)
while:
     bgt $t6, 0 , exit # Si cumple, el programa irá al termino.
     #Hace la suma del ejercicio, haciendo que el valor "m" aumente en la cantidad de "b"
     add $t0, $t0 , $t7
     #Hace la resta haciendo que "a" disminuya en 1 por cada ciclo
     sub $t6, $t6 , 1
     #La expresión "j" llama a seleccionar la próxima acción, haciendo que se repita el loop
     j while
#Fin del programa
     
exit:

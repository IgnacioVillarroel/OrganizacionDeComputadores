#Se tiene que crear el espacio para alojar los datos
.data
     arreglo: .space 4
#Se crean las variables que se guardarán en el arreglo.
.text
     addi $s0, $zero, 3
     addi $s3, $s0, -1
#Ahora aplica Store ward "sw" para indicarle donde alojar el primero dato de nuestro arreglo, indicandole donde inicia.
     sw $s0, arreglo($t0)
#Ahora vemos la cuarta posición del arreglo, como se indica.
     sw $s3, arreglo($t0)
     

#Se coloca en $t0 y $t1
add $t0, $zero, 20
add $t1, $t0, 5
#Se calculan x+4 y y-9
add $t0, $t0, 4
sub $t1, $t1, 9
sub $t2, $t0, $t1
#Con esto se verifica bit por bit comparando en $t1.
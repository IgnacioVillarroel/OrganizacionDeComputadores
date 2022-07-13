addiu $t0, $zero, 0x10010000
addi $t1, $zero, 5
sw $t1, 0($t0)
lw $t2, 0($t0)
addiu $t0, $t0, 4
sw $t2, 0($t0)
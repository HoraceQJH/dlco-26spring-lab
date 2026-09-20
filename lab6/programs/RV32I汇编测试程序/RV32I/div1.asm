.text
.globl main
main:
lw t0,a
lw t1,b
li t2,0
loop:
blt t0,t1,end
sub t0,t0,t1
addi t2,t2,1
j loop
end:
li a7,4
la a0,tip
ecall
li a7,1
mv a0,t2
ecall
li a7,4
la a0,comma
ecall
li a7,1
mv a0,t0
ecall
li a7,10
ecall
.data
a: .word 100
b: .word 7
tip: .string "Q,R="
comma: .string ", "


.text
.globl main
main:
lw t0,x
lw t1,y
li t2,0
loop:
beq t1,zero,out
andi t3,t1,1
beq t3,zero,shift
add t2,t2,t0
shift:
slli t0,t0,1
srli t1,t1,1
j loop
out:
li a7,4
la a0,s
ecall
li a7,1
mv a0,t2
ecall
li a7,10
ecall
.data
x: .word 123
y: .word 456
s: .string "Mul="
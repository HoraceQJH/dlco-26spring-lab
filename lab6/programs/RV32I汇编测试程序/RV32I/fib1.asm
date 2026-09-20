.text
.globl main
main:
    # 加载n
    la   t0, n
    lw   a0, 0(t0)      # a0 = n
    
    # 处理特殊情况
    li   t1, 0          # t1 = F(0) = 0
    li   t2, 1          # t2 = F(1) = 1
    
    # 如果n=0，结果是0
    beq  a0, zero, n_is_zero
    # 如果n=1，结果是1
    li   t3, 1
    beq  a0, t3, n_is_one
    
    # 循环计算斐波那契数
    # 初始：t1 = F(0)=0, t2 = F(1)=1, 要计算到F(n)
    # 循环从i=2开始到i=n
    li   t3, 2          # t3 = i = 2
    
fib_loop:
    # 检查是否达到n
    bgt  t3, a0, fib_done  # 如果 i > n，结束
    
    # 计算下一个斐波那契数: F(i) = F(i-1) + F(i-2)
    add  t4, t1, t2     # t4 = F(i-2) + F(i-1)
    
    # 更新值：F(i-2) = F(i-1), F(i-1) = F(i)
    mv   t1, t2         # t1 = 原来的F(i-1)
    mv   t2, t4         # t2 = 新的F(i) = t4
    
    # i++
    addi t3, t3, 1
    j    fib_loop

fib_done:
    # 此时t2中是F(n)的结果
    mv   a1, t2         # 将结果保存到a1
    j    store_result

n_is_zero:
    li   a1, 0          # F(0) = 0
    j    store_result

n_is_one:
    li   a1, 1          # F(1) = 1
    # 继续执行store_result

store_result:
    # 存储结果到内存
    la   t0, result
    sw   a1, 0(t0)
    
    # 程序结束
    li   a7, 10
    ecall

#数据段起始地址0x2000
.data
n:        .word 10      # 计算第10个斐波那契数
result:   .word 0       # 存储结果

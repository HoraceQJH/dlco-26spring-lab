# 函数：vector_add
# 描述：执行 C[i] = A[i] + B[i]
# 输入参数：
#   a0 = 数组 A 的起始地址
#   a1 = 数组 B 的起始地址
#   a2 = 数组 C 的起始地址
#   a3 = 数组的元素个数 (N)

   addi a0, x0, 0
   addi a1, x0, 256
   addi a2, x0, 512
   addi a3, x0, 10
   
vector_add:
    beqz a3, end_loop    # 如果 N == 0，直接结束
    slli a3, a3, 2       # 将元素个数乘以 4，计算总字节数
    add  a3, a0, a3      # a3 = 数组 A 的结束地址 (A_end)

loop:
    # --- 循环体开始 ---
    lb   t0, 0(a0)       # 1. 内存读取：加载 A[i] 到 t0
    lb   t1, 0(a1)       # 2. 内存读取：加载 B[i] 到 t1
    
    add  t2, t0, t1      # 3. 算术运算：t2 = A[i] + B[i] 
                         #    [注意此处对 t1 有 Load-Use 数据依赖]
                         
    sw   t2, 0(a2)       # 4. 内存写入：将 t2 存入 C[i]

    addi a0, a0, 4       # 5. 指针更新：A_ptr += 4
    addi a1, a1, 4       # 6. 指针更新：B_ptr += 4
    addi a2, a2, 4       # 7. 指针更新：C_ptr += 4

    bltu a0, a3, loop    # 8. 条件分支：如果 A_ptr < A_end，继续循环 
                         #    [触发控制冒险]
    # --- 循环体结束 ---

end_loop:
    ecall                  # 返回调用者
    
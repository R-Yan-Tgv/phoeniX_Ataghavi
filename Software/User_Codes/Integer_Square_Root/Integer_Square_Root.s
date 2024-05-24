# Integer square root function for RISC-V

# Arguments:
# a0 - Input: unsigned 32-bit integer (n)
# Return:
# a0 - Output: integer square root of n

integer_sqrt:
    li a0, 0              # Initialize return to 0
    mv t1, a0             # Move a0 to t1

    li t0, 1
    slli t0, t0, 30       # Shift to second-to-top bit

isqrt_bit:
    slt t2, t1, t0        # num < bit
    beqz t2, isqrt_loop

    srli t0, t0, 2        # bit >> 2
    j isqrt_bit

isqrt_loop:
    beqz t0, isqrt_return

    add t3, a0, t0        # t3 = return + bit
    slt t2, t1, t3
    beqz t2, isqrt_else

    srli a0, a0, 1        # return >> 1
    j isqrt_loop_end

isqrt_else:
    sub t1, t1, t3        # num -= return + bit
    srli a0, a0, 1        # return >> 1
    add a0, a0, t0        # return + bit

isqrt_loop_end:
    srli t0, t0, 2        # bit >> 2
    j isqrt_loop

isqrt_return:
    jr ra

ebreak
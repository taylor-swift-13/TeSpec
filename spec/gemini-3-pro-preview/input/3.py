def below_zero_spec(operations, result):
    exists_n = False
    current_sum = 0
    for op in operations:
        current_sum += op
        if current_sum < 0:
            exists_n = True
            break
    return result == exists_n

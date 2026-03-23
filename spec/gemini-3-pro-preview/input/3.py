def _orig_below_zero_spec(operations, output):
    exists_n = False
    current_sum = 0
    for op in operations:
        current_sum += op
        if current_sum < 0:
            exists_n = True
            break
    return output == exists_n

def below_zero_spec(operations, output):
    return bool(_orig_below_zero_spec(operations, output))

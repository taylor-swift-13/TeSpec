def _orig_eat_spec(number, need, remaining, output):
    if not 0 <= number <= 1000:
        return False
    if not 0 <= need <= 1000:
        return False
    if not 0 <= remaining <= 1000:
        return False
    if need <= remaining:
        expected_res = [number + need, remaining - need]
    else:
        expected_res = [number + remaining, 0]
    return output == expected_res

def eat_spec(number, need, remaining, output):
    return bool(_orig_eat_spec(number, need, remaining, output))

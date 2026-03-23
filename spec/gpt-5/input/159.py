def eat_spec(number, need, remaining, res):
    if not (0 <= number <= 1000):
        return False
    if not (0 <= need <= 1000):
        return False
    if not (0 <= remaining <= 1000):
        return False
    
    if need <= remaining:
        expected_res = [number + need, remaining - need]
    else:
        expected_res = [number + remaining, 0]
        
    return res == expected_res

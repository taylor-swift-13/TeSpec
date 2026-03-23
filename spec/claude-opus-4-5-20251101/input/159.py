def eat_spec(number, need, remaining, result):
    if not (0 <= number <= 1000):
        return False
    if not (0 <= need <= 1000):
        return False
    if not (0 <= remaining <= 1000):
        return False
    
    if need <= remaining:
        return result == [number + need, remaining - need]
    else:
        return result == [number + remaining, 0]

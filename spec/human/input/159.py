def problem_159_pre(number, need, remaining):
    return (0 <= number <= 1000) and (0 <= need <= 1000) and (0 <= remaining <= 1000)

def problem_159_spec(number, need, remaining, result):
    if remaining >= need:
        return result == [number + need, remaining - need]
    else:
        return result == [number + remaining, 0]

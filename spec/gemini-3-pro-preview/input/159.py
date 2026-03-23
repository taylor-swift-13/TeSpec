def eat_spec(number, need, remaining, result):
    if need <= remaining:
        return result == [number + need, remaining - need]
    else:
        return result == [number + remaining, 0]

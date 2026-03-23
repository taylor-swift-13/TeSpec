def _orig_eat_spec(number, need, remaining, output):
    if need <= remaining:
        return output == [number + need, remaining - need]
    else:
        return output == [number + remaining, 0]

def eat_spec(number, need, remaining, output):
    return bool(_orig_eat_spec(number, need, remaining, output))

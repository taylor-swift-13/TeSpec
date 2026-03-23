def closest_integer_spec(val, result):
    dist = abs(val - result)
    return (dist < 0.5) or (dist == 0.5 and abs(result) > abs(val))

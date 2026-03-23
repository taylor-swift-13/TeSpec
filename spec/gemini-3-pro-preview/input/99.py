def _orig_closest_integer_spec(val, output):
    dist = abs(val - output)
    return dist < 0.5 or (dist == 0.5 and abs(output) > abs(val))

def closest_integer_spec(value, output):
    return bool(_orig_closest_integer_spec(value, output))

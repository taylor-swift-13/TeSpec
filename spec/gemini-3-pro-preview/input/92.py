def _orig_any_int_spec(x, y, z, output):
    return output == (x == y + z or y == x + z or z == x + y)

def any_int_spec(x, y, z, output):
    return bool(_orig_any_int_spec(x, y, z, output))

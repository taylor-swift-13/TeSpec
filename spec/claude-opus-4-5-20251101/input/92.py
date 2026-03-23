def _orig_any_int_spec(x, y, z, output):
    return output == (x == y + z or y == x + z or z == y + x)

def any_int_spec(x, y, z, output):
    return bool(_orig_any_int_spec(x, y, z, output))

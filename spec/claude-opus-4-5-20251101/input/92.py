def any_int_spec(x, y, z, result):
    return result == (x == y + z or y == x + z or z == y + x)

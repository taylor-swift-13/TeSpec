def any_int_spec(x, y, z, res):
    return res == ((x == y + z) or (y == x + z) or (z == x + y))

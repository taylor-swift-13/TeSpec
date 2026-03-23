class NumInt:
    def __init__(self, z: int):
        self.z = z

class NumOther:
    pass

def any_int_spec(x, y, z, res: bool) -> bool:
    if isinstance(x, NumInt) and isinstance(y, NumInt) and isinstance(z, NumInt):
        xi = x.z
        yi = y.z
        zi = z.z
        expected = (xi == yi + zi) or (yi == xi + zi) or (zi == yi + xi)
        return res == expected
    else:
        return res == False

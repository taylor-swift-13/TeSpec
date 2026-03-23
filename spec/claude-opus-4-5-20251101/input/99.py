import math

# def up(r: float) -> int:
#     # In Coq, `up r` is the unique integer z such that z - 1 <= r < z.
#     # This is mathematically equivalent to math.floor(r) + 1.
#     return math.floor(r) + 1

def up(r: float) -> int:
    return math.ceil(r)

def Z_abs_nat(z: int) -> int:
    return abs(z)

def S(n: int) -> int:
    return n + 1

def Z_of_nat(n: int) -> int:
    return n

def IZR(z: int) -> float:
    return float(z)

def Rabs(r: float) -> float:
    return abs(r)

def truncate(r: float) -> int:
    if r < 0:
        return Z_of_nat(S(Z_abs_nat(up(r) - 1)))
    else:
        return Z_of_nat(Z_abs_nat(up(r) - 1))

def is_equidistant(r: float) -> bool:
    return Rabs(r - IZR(truncate(r))) == 0.5

def round_away_from_zero(r: float) -> int:
    if r < 0:
        return truncate(r) - 1
    else:
        return truncate(r) + 1

def standard_round(r: float) -> int:
    if (r - IZR(truncate(r))) <= 0.5:
        return truncate(r)
    elif r < 0:
        return truncate(r) - 1
    else:
        return truncate(r) + 1

def closest_integer_spec(value: float, result: int) -> bool:
    if is_equidistant(value):
        return result == round_away_from_zero(value)
    else:
        return result == standard_round(value)

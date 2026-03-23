import math

from fractions import Fraction

class value:
    pass

class VInt(value):
    def __init__(self, z: int):
        self.z = z

    def __eq__(self, other):
        return isinstance(other, VInt) and self.z == other.z

class VFloat(value):
    def __init__(self, r: float):
        self.r = r

    def __eq__(self, other):
        if not isinstance(other, VFloat):
            return False
        if self.r == other.r:
            return True
        if math.isnan(self.r) and math.isnan(other.r):
            return True
        return False

class VStr(value):
    def __init__(self, s: str):
        self.s = s

    def __eq__(self, other):
        return isinstance(other, VStr) and self.s == other.s

class Some:
    def __init__(self, v):
        self.v = v

    def __eq__(self, other):
        return isinstance(other, Some) and self.v == other.v

def replace_commas_with_dots(s: str) -> str:
    return s.replace(',', '.')

def R_of_string(s: str) -> Fraction:
    try:
        return Fraction(s)
    except (ValueError, OverflowError):
        try:
            # Handle scientific notation or other float formats
            return Fraction(str(float(s)))
        except (ValueError, OverflowError):
            return Fraction(0)

def num_of(v: value) -> Fraction:
    if isinstance(v, VInt):
        return Fraction(v.z)
    elif isinstance(v, VFloat):
        # try:
        #     # Use str() to get the decimal representation intended by the literal
        #     # This ensures VFloat(0.1) matches VStr("0.1")
        #     return Fraction(str(v.r))
        # except (ValueError, OverflowError):
        #     return Fraction(0)
        try:
            return Fraction(v.r)
        except (ValueError, OverflowError):
            return Fraction(0)
    elif isinstance(v, VStr):
        return R_of_string(replace_commas_with_dots(v.s))
    return Fraction(0)

def _orig_compare_one_spec(a: value, b: value, output) -> bool:
    ra = num_of(a)
    rb = num_of(b)
    if ra == rb:
        return output is None
    elif rb < ra:
        return output == Some(a)
    elif ra < rb:
        return output == Some(b)
    return False

def compare_one_spec(a, b, output):
    return bool(_orig_compare_one_spec(a, b, output))

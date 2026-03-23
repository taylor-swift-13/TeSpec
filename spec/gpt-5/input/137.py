import math

from fractions import Fraction

# 旧版本用包装类和 Some(...) 来模拟值与 option。
# class value: ...
# class VInt(value): ...
# class VFloat(value): ...
# class VStr(value): ...
# class Some: ...

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

def num_of(v) -> Fraction | None:
    if isinstance(v, bool):
        return None
    if isinstance(v, int):
        return Fraction(v)
    if isinstance(v, float):
        try:
            return Fraction(v)
        except (ValueError, OverflowError):
            return None
    if isinstance(v, str):
        return R_of_string(replace_commas_with_dots(v))
    return None

def _orig_compare_one_spec(a, b, output) -> bool:
    ra = num_of(a)
    rb = num_of(b)
    if ra is None or rb is None:
        return output is None
    if ra == rb:
        return output is None
    elif rb < ra:
        return output == a
    elif ra < rb:
        return output == b
    return False

def compare_one_spec(a, b, output):
    return bool(_orig_compare_one_spec(a, b, output))

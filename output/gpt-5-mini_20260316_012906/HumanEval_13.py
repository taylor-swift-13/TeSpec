
import math

def precondition(input):
    try:
        if not isinstance(input, (tuple, list)):
            return False
        if len(input) != 2:
            return False
        a, b = input
        return isinstance(a, int) and isinstance(b, int)
    except Exception:
        return False

def postcondition(input, output):
    try:
        if not precondition(input):
            return False
        a, b = input
        if not isinstance(output, int):
            return False
        g = math.gcd(a, b)
        return abs(output) == g
    except Exception:
        return False

def _impl(a: int, b: int) -> int:
    """Return a greatest common divisor of two integers a and b
    1
    5"""
    def query_gcd(a: int, b: int) -> int:
        return a if b == 0 else query_gcd(b, a % b)
    return query_gcd(a, b)    

def greatest_common_divisor(a: int, b: int) -> int:
    _input = (a, b)
    assert precondition(_input)
    _output = _impl(a, b)
    assert postcondition(_input, _output)
    return _output

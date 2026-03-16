
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    a, b = input
    return isinstance(a, int) and isinstance(b, int)

def postcondition(input, output):
    import math
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    a, b = input
    if not isinstance(a, int) or not isinstance(b, int):
        return False
    if not isinstance(output, int):
        return False
    return output == math.gcd(a, b)

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

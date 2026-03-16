
def precondition(input):
    a, b = input
    return isinstance(a, int) and isinstance(b, int)

def postcondition(input, output):
    a, b = input
    if not isinstance(output, int):
        return False
    if output < 0:
        return False
    if a == 0 and b == 0:
        return output == 0
    if output == 0:
        return a == 0 and b == 0
    return a % output == 0 and b % output == 0

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


def precondition(input) -> bool:
    if len(input) != 2:
        return False
    a, b = input
    if not isinstance(a, int) or not isinstance(b, int):
        return False
    return True


def postcondition(input, output) -> bool:
    a, b = input
    if not isinstance(output, int):
        return False
    # At least one of a, b must be non-zero for gcd to be meaningful
    if a == 0 and b == 0:
        return output == 0
    # output must be non-negative
    if output < 0:
        return False
    # output must divide both a and b
    if a % output != 0:
        return False
    if b % output != 0:
        return False
    # output must be the greatest such divisor
    # check that gcd(a/output, b/output) == 1
    import math
    if output != 0:
        if math.gcd(abs(a // output), abs(b // output)) != 1:
            return False
    return True

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

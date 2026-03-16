
def precondition(input):
    return (
        isinstance(input, tuple)
        and len(input) == 2
        and isinstance(input[0], int)
        and isinstance(input[1], int)
    )

def postcondition(input, output):
    if not (isinstance(input, tuple) and len(input) == 2):
        return False
    a, b = input
    if not (isinstance(a, int) and isinstance(b, int)):
        return False
    if not isinstance(output, int):
        return False
    ga = abs(a)
    gb = abs(b)
    while gb != 0:
        ga, gb = gb, ga % gb
    expected = ga
    return output == expected

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

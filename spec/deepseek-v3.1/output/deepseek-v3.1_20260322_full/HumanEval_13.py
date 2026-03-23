import math

def gcd_spec(a: int, b: int, result: int) -> bool:
    return result == math.gcd(a, b)

def _impl(a: int, b: int) -> int:
    def query_gcd(a: int, b: int) -> int:
        return a if b == 0 else query_gcd(b, a % b)
    return query_gcd(a, b)

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(gcd_spec(*input, output))

def greatest_common_divisor(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output

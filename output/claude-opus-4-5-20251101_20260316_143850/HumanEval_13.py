
def precondition(input):
    if len(input) != 2:
        return False
    a, b = input
    if not isinstance(a, int) or not isinstance(b, int):
        return False
    if isinstance(a, bool) or isinstance(b, bool):
        return False
    return True


def postcondition(input, output):
    a, b = input
    if not isinstance(output, int):
        return False
    if isinstance(output, bool):
        return False
    # GCD should be non-negative
    if output < 0:
        return False
    # If both a and b are zero, GCD is typically defined as 0
    if a == 0 and b == 0:
        return output == 0
    # GCD should be positive when at least one input is non-zero
    if output <= 0:
        return False
    # GCD must divide both a and b
    if a % output != 0 or b % output != 0:
        return False
    # GCD should be the greatest such divisor
    # Check that no larger common divisor exists
    for d in range(output + 1, min(abs(a), abs(b)) + 2 if a != 0 and b != 0 else output + 2):
        if a % d == 0 and b % d == 0:
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

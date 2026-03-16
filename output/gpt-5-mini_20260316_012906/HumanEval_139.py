
import math

def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) < 1:
        return False
    n = input[0]
    if isinstance(n, bool):
        return False
    if not isinstance(n, int):
        return False
    if n <= 0:
        return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return True
    n = input[0]
    if isinstance(output, bool):
        return False
    if not isinstance(output, int):
        return False
    expected = 1
    for i in range(1, n + 1):
        expected *= math.factorial(i)
    return output == expected

def _impl(n):
    """The Brazilian factorial is defined as:
    brazilian_factorial(n) = n! * (n-1)! * (n-2)! * ... * 1!
    where n > 0

    For example:
    288

    The function will receive an integer as input and should return the special
    factorial of this integer."""
    fac, ans = 1, 1
    for i in range(2, n + 1):
        fac *= i
        ans *= fac
    return ans

def special_factorial(n):
    _input = (n,)
    assert precondition(_input)
    _output = _impl(n)
    assert postcondition(_input, _output)
    return _output

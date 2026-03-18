
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    n = input[0]
    if isinstance(n, bool):
        return False
    if not isinstance(n, int):
        return False
    return n > 0

def postcondition(input, output):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    n = input[0]
    if isinstance(n, bool) or not isinstance(n, int) or n <= 0:
        return False
    if not isinstance(output, int):
        return False
    fact = 1
    prod = 1
    for k in range(1, n + 1):
        fact *= k
        prod *= fact
    return prod == output

def _impl(n):
    """
    The Brazilian factorial is defined as:
    brazilian_factorial(n) = n! * (n-1)! * (n-2)! * ... * 1!
    where n > 0

    For example:
    288

    The function will receive an integer as input and should return the special
    factorial of this integer.
    """
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

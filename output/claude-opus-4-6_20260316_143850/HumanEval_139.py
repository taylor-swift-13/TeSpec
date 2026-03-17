
def precondition(input):
    (n,) = input
    # n must be a positive integer
    return isinstance(n, int) and n > 0

def postcondition(input, output):
    (n,) = input
    # output must be a positive integer
    if not isinstance(output, int) or output <= 0:
        return False
    # Verify by computing the brazilian factorial directly
    result = 1
    for i in range(1, n + 1):
        factorial_i = 1
        for j in range(1, i + 1):
            factorial_i *= j
        result *= factorial_i
    return output == result

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

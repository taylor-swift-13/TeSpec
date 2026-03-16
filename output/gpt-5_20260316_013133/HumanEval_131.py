
def precondition(input) -> bool:
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    n = input[0]
    if isinstance(n, bool):
        return False
    if not isinstance(n, int):
        return False
    return n > 0

def postcondition(input, output) -> bool:
    if not precondition(input):
        return True
    n = input[0]
    if isinstance(output, bool) or not isinstance(output, int):
        return False
    m = n
    prod = 1
    found = False
    while m > 0:
        d = m % 10
        if d % 2 == 1:
            prod *= d
            found = True
        m //= 10
    expected = 0 if not found else prod
    return output == expected

def _impl(n):
    """Given a positive integer n, return the product of the odd digits.
    Return 0 if all digits are even.
    For example:
    digits(1)  == 1
    digits(4)  == 0
    digits(235) == 15"""
    has_odd, prod = False, 1
    for ch in str(n):
        if int(ch) % 2 == 1:
            has_odd = True
            prod *= int(ch)
    return 0 if not has_odd else prod

def digits(n):
    _input = (n,)
    assert precondition(_input)
    _output = _impl(n)
    assert postcondition(_input, _output)
    return _output

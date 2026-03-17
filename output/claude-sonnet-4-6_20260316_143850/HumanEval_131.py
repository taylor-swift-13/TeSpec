
def precondition(input) -> bool:
    if len(input) != 1:
        return False
    n = input[0]
    if not isinstance(n, int):
        return False
    if n <= 0:
        return False
    return True


def postcondition(input, output) -> bool:
    if not isinstance(output, int):
        return False
    n = input[0]
    digits = [int(d) for d in str(n)]
    odd_digits = [d for d in digits if d % 2 != 0]
    if len(odd_digits) == 0:
        return output == 0
    product = 1
    for d in odd_digits:
        product *= d
    return output == product

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

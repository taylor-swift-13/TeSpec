
def precondition(args):
    n, = args
    # n must be a positive integer
    if not isinstance(n, int):
        return False
    if isinstance(n, bool):
        return False
    if n <= 0:
        return False
    return True

def postcondition(args, output):
    n, = args
    # output must be a non-negative integer
    if not isinstance(output, int):
        return False
    if isinstance(output, bool):
        return False
    if output < 0:
        return False
    
    # compute expected product of odd digits
    digits_str = str(n)
    odd_digits = [int(d) for d in digits_str if int(d) % 2 == 1]
    
    if len(odd_digits) == 0:
        expected = 0
    else:
        expected = 1
        for d in odd_digits:
            expected *= d
    
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

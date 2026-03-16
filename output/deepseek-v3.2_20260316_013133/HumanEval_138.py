
def precondition(args):
    n = args[0]
    return isinstance(n, int)

def postcondition(args, result):
    n = args[0]
    if not isinstance(result, bool):
        return False
    if not precondition(args):
        return False
    
    # Conservative check: if result is True, n must be at least 8 and even
    if result:
        return n >= 8 and n % 2 == 0
    return True

def _impl(n):
    """Evaluate whether the given number n can be written as the sum of exactly 4 positive even numbers
    Example
    is_equal_to_sum_even(4) == False
    is_equal_to_sum_even(6) == False
    is_equal_to_sum_even(8) == True"""
    return n >= 8 and n % 2 == 0

def is_equal_to_sum_even(n):
    _input = (n,)
    assert precondition(_input)
    _output = _impl(n)
    assert postcondition(_input, _output)
    return _output

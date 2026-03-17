
def precondition(input):
    if len(input) != 1:
        return False
    n = input[0]
    if not isinstance(n, int):
        return False
    return True

def postcondition(input, output):
    if not isinstance(output, bool):
        return False
    n = input[0]
    # The minimum sum of 4 positive even numbers is 2+2+2+2 = 8
    # Any number >= 8 that is even can be written as sum of 4 positive even numbers
    # (e.g., 2+2+2+(n-6) where n-6 is even and positive when n >= 8)
    if n >= 8 and n % 2 == 0:
        if output != True:
            return False
    else:
        if output != False:
            return False
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


def precondition(input):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    x = input[0]
    if not isinstance(x, list):
        return False
    for v in x:
        if isinstance(v, bool) or not isinstance(v, int):
            return False
        if v <= 0:
            return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return True
    x = input[0]
    def has_no_even_digit(n):
        while n > 0:
            d = n % 10
            if d % 2 == 0:
                return False
            n //= 10
        return True
    expected = sorted([v for v in x if has_no_even_digit(v)])
    return isinstance(output, list) and output == expected

def _impl(x):
    """Given a list of positive integers x. return a sorted list of all 
    elements that hasn't any even digit.

    Note: Returned list should be sorted in increasing order.

    For example:
    [1, 15, 33]
    []"""
    def judge(x):
        for ch in str(x):
            if int(ch) % 2 == 0:
                return False
        return True
    return sorted(list(filter(judge, x)))

def unique_digits(x):
    _input = (x,)
    assert precondition(_input)
    _output = _impl(x)
    assert postcondition(_input, _output)
    return _output


def precondition(input):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    x = input[0]
    if not isinstance(x, list):
        return False
    for e in x:
        if not isinstance(e, int):
            return False
        if e <= 0:
            return False
    return True

def postcondition(input, output):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    if not isinstance(output, list):
        return False
    x = input[0]
    if not isinstance(x, list):
        return False
    for e in x:
        if not isinstance(e, int) or e <= 0:
            return False

    def has_no_even_digit(n):
        for ch in str(n):
            if int(ch) % 2 == 0:
                return False
        return True

    expected = sorted([a for a in x if has_no_even_digit(a)])
    return output == expected

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

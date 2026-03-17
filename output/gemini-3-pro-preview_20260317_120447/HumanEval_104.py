
def precondition(args):
    x = args[0]
    if not isinstance(x, list):
        return False
    for i in x:
        if not isinstance(i, int) or i <= 0:
            return False
    return True

def postcondition(args, output):
    x = args[0]
    if not isinstance(output, list):
        return False
    
    def has_no_even_digits(n):
        for char in str(n):
            if int(char) % 2 == 0:
                return False
        return True

    expected = sorted([i for i in x if has_no_even_digits(i)])
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

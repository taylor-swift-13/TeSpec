
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    x = input[0]
    if not isinstance(x, list):
        return False
    for el in x:
        if isinstance(el, bool):
            return False
        if not isinstance(el, int):
            return False
        if el <= 0:
            return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return True
    x = input[0]
    if not isinstance(output, list):
        return False
    for el in output:
        if isinstance(el, bool):
            return False
        if not isinstance(el, int):
            return False
        if el <= 0:
            return False
    def no_even_digits(n):
        s = str(n)
        for ch in s:
            if ch not in '13579':
                return False
        return True
    expected = sorted([n for n in x if no_even_digits(n)])
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

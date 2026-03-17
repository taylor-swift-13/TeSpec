
def precondition(args):
    if len(args) != 1:
        return False
    x = args[0]
    if not isinstance(x, list):
        return False
    return all(type(i) is int and i > 0 for i in x)

def postcondition(args, output):
    if len(args) != 1:
        return False
    x = args[0]
    if not isinstance(output, list):
        return False
    expected = sorted([i for i in x if all(int(d) % 2 != 0 for d in str(i))])
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


def precondition(input):
    x = input[0]
    return isinstance(x, list) and all(isinstance(i, int) and i > 0 for i in x)

def postcondition(input, output):
    x = input[0]
    if not isinstance(output, list):
        return False
    
    def has_no_even_digit(n):
        return all(int(d) % 2 != 0 for d in str(n))
    
    expected = sorted([i for i in x if has_no_even_digit(i)])
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

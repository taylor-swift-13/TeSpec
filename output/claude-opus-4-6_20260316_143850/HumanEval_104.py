
def precondition(input):
    x = input[0]
    if not isinstance(x, list):
        return False
    for elem in x:
        if not isinstance(elem, int):
            return False
        if elem <= 0:
            return False
    return True


def postcondition(input, output):
    x = input[0]
    if not isinstance(output, list):
        return False
    
    def has_even_digit(n):
        for d in str(n):
            if int(d) % 2 == 0:
                return True
        return False
    
    # All elements in output should have no even digit
    for elem in output:
        if has_even_digit(elem):
            return False
    
    # Output should be sorted in increasing order
    for i in range(len(output) - 1):
        if output[i] > output[i + 1]:
            return False
    
    # Every element in x with no even digit should appear in output
    # with the correct count
    expected = sorted([e for e in x if not has_even_digit(e)])
    if output != expected:
        return False
    
    return True

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

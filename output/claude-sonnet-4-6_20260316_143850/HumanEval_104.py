
def precondition(input) -> bool:
    if len(input) != 1:
        return False
    x = input[0]
    if not isinstance(x, list):
        return False
    for item in x:
        if not isinstance(item, int):
            return False
        if item <= 0:
            return False
    return True


def postcondition(input, output) -> bool:
    if not isinstance(output, list):
        return False
    x = input[0]
    # Check all elements in output are integers
    for item in output:
        if not isinstance(item, int):
            return False
    # Check output is sorted in increasing order
    for i in range(len(output) - 1):
        if output[i] > output[i + 1]:
            return False
    # Check all elements in output have no even digits
    for item in output:
        digits = str(item)
        for d in digits:
            if int(d) % 2 == 0:
                return False
    # Check all elements from input that have no even digits are in output
    expected = []
    for item in x:
        digits = str(item)
        has_even = any(int(d) % 2 == 0 for d in digits)
        if not has_even:
            expected.append(item)
    if sorted(expected) != sorted(output):
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

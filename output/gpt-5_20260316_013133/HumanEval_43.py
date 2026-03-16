
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    l = input[0]
    if not isinstance(l, list):
        return False
    for x in l:
        if type(x) is not int:
            return False
    return True

def postcondition(input, output):
    if not isinstance(output, bool):
        return False
    if not isinstance(input, tuple) or len(input) != 1:
        return True
    l = input[0]
    if not isinstance(l, list):
        return True
    if not all(type(x) is int for x in l):
        return True
    n = len(l)
    exists = False
    for i in range(n):
        for j in range(i + 1, n):
            if l[i] + l[j] == 0:
                exists = True
                break
        if exists:
            break
    return output == exists

def _impl(l):
    """pairs_sum_to_zero takes a list of integers as an input.
    it returns True if there are two distinct elements in the list that
    sum to zero, and False otherwise.
    False
    False
    False
    True
    False"""
    for i in range(len(l)):
        for j in range(len(l)):
            if i != j and l[i] + l[j] == 0:
                return True
    return False

def pairs_sum_to_zero(l):
    _input = (l,)
    assert precondition(_input)
    _output = _impl(l)
    assert postcondition(_input, _output)
    return _output

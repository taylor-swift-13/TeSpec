
def precondition(args):
    if not isinstance(args, tuple) or len(args) != 1:
        return False
    l = args[0]
    if not isinstance(l, list):
        return False
    for x in l:
        if not isinstance(x, int):
            return False
    return True

def postcondition(args, result):
    if not isinstance(args, tuple) or len(args) != 1:
        return False
    l = args[0]
    if not isinstance(l, list):
        return False
    for x in l:
        if not isinstance(x, int):
            return False
    if not isinstance(result, bool):
        return False
    n = len(l)
    expected = False
    for i in range(n):
        for j in range(i + 1, n):
            if l[i] + l[j] == 0:
                expected = True
                break
        if expected:
            break
    return result == expected

def _impl(l):
    """
    pairs_sum_to_zero takes a list of integers as an input.
    it returns True if there are two distinct elements in the list that
    sum to zero, and False otherwise.
    False
    False
    False
    True
    False
    """
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
